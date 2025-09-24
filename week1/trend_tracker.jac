node trend{
    has title: str;
    has description: str;
}
walker summarize {
    can visit_trend with trend entry{
        print(f¨{here.title}: {here.description}¨);
        visit [-->];
    }
}
