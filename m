Return-Path: <netdev+bounces-15444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6287479A1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 23:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE743280E8F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364F8494;
	Tue,  4 Jul 2023 21:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680A1100
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 21:36:56 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A17E4F
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:36:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57712d00cc1so74521927b3.3
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688506614; x=1691098614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ryaR/GHWKQs1ggpYgYE1d9BpX0RuTeNhYY+HwMoKPE=;
        b=om4doweTlVsbH0UVZ2vnZo4bUcqx0cHCBUFzp/SKfWSsuLAqmTLNGf8Hx7rACBOQHQ
         hQ/smfZjZSzlMbTw6yFp64mXMXW/invh21HSEvWlOO6YNJg2YtCzDC33h8FANbc1FzeQ
         fRCRgh4bCwz+9MrvEeJ/zvUdd0siBGjgB9H7eUtAm3nf1oIX+eyynip3vrL/u1aueC8/
         zJDtQFNrzpx0O6uFvSTNmge/oiEiuNLFFT/Va0/jLIYOxANCpUNtzdnUrln7WabifrBR
         jFJHBo0EozMrPyE7s0bKbPygtDe8G7AIWvjm5AtZn0bg9sAXO0MtjaHhA7QKEX3bM6cO
         mb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688506614; x=1691098614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ryaR/GHWKQs1ggpYgYE1d9BpX0RuTeNhYY+HwMoKPE=;
        b=dBg2PW0GT7WG9dMGRPrHaq+DZHiVlf8d2AhnpJJCETYBSksWFGSdXDrOAa5Z4xd5nY
         b/Xdh042utNy0yhGx52AWCUxu3YiLF/f09gRgK2j4svGQcgOYxC6M21YQxeg6C2sFZve
         w/deJA1ZzGSPpiD+1AY+Dn8j02ZjMOeTtgitMSFDTo1uP/jXHPfBzhUepN+tpWvKprCW
         qDDoHOG6J9vr7PIHV6VkcYTqMpUlCSuieGmNfMu1zNr8Dgz2wTxTG1UvBpCMl0hs67MW
         GPPpYsjMhwBXVmeV6QaBeR7hHFYC0CPMmuLUg5nO1qdGBFM/dgVZQG3VBjIWJJsqcvM5
         7NxA==
X-Gm-Message-State: ABy/qLZmXhCG3OaXdk9nHZIIMwlM57iqnnTSi4CPySgPfYzkijVKKYZM
	UcWS8/JHHc2zajzsMJXmFKcC++u66YKG86NPo93+3w==
X-Google-Smtp-Source: APBJJlFlrwiPwFPyBtwXavXQROZ4AzwKQhHbc+ACyXdUcdr7ljYytec3f8Htfu026xhPKArwL/89XUUtNTgCq9sEhp0=
X-Received: by 2002:a0d:e8c4:0:b0:56f:ff55:2b7d with SMTP id
 r187-20020a0de8c4000000b0056fff552b7dmr15628388ywe.17.1688506614117; Tue, 04
 Jul 2023 14:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607192625.22641-1-daniel@iogearbox.net> <20230607192625.22641-3-daniel@iogearbox.net>
 <CAM0EoMm25tdjxp+7Mq4fowGfCJzFRhbThHhaO7T_46vNJ9y-NQ@mail.gmail.com>
 <fe2e13a6-1fb6-c160-1d6f-31c09264911b@iogearbox.net> <CAM0EoM=FFsTNNKaMbRtuRxc8ieJgDFsBifBmZZ2_67u5=+-3BQ@mail.gmail.com>
 <CAEf4BzbuzNw4gRXSSDoHTwGH82moaSWtaX1nvmUAVx4+OgaEyw@mail.gmail.com>
In-Reply-To: <CAEf4BzbuzNw4gRXSSDoHTwGH82moaSWtaX1nvmUAVx4+OgaEyw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 4 Jul 2023 17:36:42 -0400
Message-ID: <CAM0EoM=SeFagzNMWLHqM7LRXt71pWz7BJax_4rvCnLyARDyWig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, razor@blackwall.org, sdf@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, 
	toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for the late reply, but trying this out now - and have a question:

On Thu, Jun 8, 2023 at 5:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 12:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Hi Daniel,
> >
> > On Thu, Jun 8, 2023 at 6:12=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> > >
> > > Hi Jamal,
> > >
> > > On 6/8/23 3:25 AM, Jamal Hadi Salim wrote:
> > > [...]
> > > > A general question (which i think i asked last time as well): who
> > > > decides what comes after/before what prog in this setup? And would
> > > > that same entity not have been able to make the same decision using=
 tc
> > > > priorities?
> > >
> > > Back in the first version of the series I initially coded up this opt=
ion
> > > that the tc_run() would basically be a fake 'bpf_prog' and it would h=
ave,
> > > say, fixed prio 1000. It would get executed via tcx_run() when iterat=
ing
> > > via bpf_mprog_foreach_prog() where bpf_prog_run() is called, and then=
 users
> > > could pick for native BPF prio before or after that. But then the fee=
dback
> > > was that sticking to prio is a bad user experience which led to the
> > > development of what is in patch 1 of this series (see the details the=
re).
> > >
> >
> > Thanks. I read the commit message in patch 1 and followed the thread
> > back including some of the discussion we had and i am still
> > disagreeing that this couldnt be solved with a smart priority based
> > scheme - but i think we can move on since this is standalone and
> > doesnt affect tc.
> >
> > Daniel - i am still curious in the new scheme of things how would
> > cilium vs datadog food fight get resolved without some arbitration
> > entity?
> >
> > > > The idea of protecting programs from being unloaded is very welcome
> > > > but feels would have made sense to be a separate patchset (we have
> > > > good need for it). Would it be possible to use that feature in tc a=
nd
> > > > xdp?
> > > BPF links are supported for XDP today, just tc BPF is one of the few
> > > remainders where it is not the case, hence the work of this series. W=
hat
> > > XDP lacks today however is multi-prog support. With the bpf_mprog con=
cept
> > > that could be addressed with that common/uniform api (and Andrii expr=
essed
> > > interest in integrating this also for cgroup progs), so yes, various =
hook
> > > points/program types could benefit from it.
> >
> > Is there some sample XDP related i could look at?  Let me describe our
> > use case: lets say we load an ebpf program foo attached to XDP of a
> > netdev  and then something further upstream in the stack is consuming
> > the results of that ebpf XDP program. For some reason someone, at some
> > point, decides to replace the XDP prog with a different one - and the
> > new prog does a very different thing. Could we stop the replacement
> > with the link mechanism you describe? i.e the program is still loaded
> > but is no longer attached to the netdev.
>
> If you initially attached an XDP program using BPF link api
> (LINK_CREATE command in bpf() syscall), then subsequent attachment to
> the same interface (of a new link or program with BPF_PROG_ATTACH)
> will fail until the current BPF link is detached through closing its
> last fd.
>

So this works as advertised. The problem is however not totally solved
because it seems we need a process that's alive to hold the ownership.
If we had a daemon then that would solve it i think (we dont).
Alternatively,  you pin the link. The pinning part can be
circumvented, unless i misunderstood i,e anybody with the right
permissions can remove it.

Am I missing something?

cheers,
jamal

cheers,
jamal

> That is, until we allow multiple attachments of XDP programs to the
> same network interface. But even then, no one will be able to
> accidentally replace attached link, unless they have that link FD and
> replace underlying BPF program.
>
> >
> >
> > > >> +struct tcx_entry {
> > > >> +       struct bpf_mprog_bundle         bundle;
> > > >> +       struct mini_Qdisc __rcu         *miniq;
> > > >> +};
> > > >> +
> > > >
> > > > Can you please move miniq to the front? From where i sit this looks=
:
> > > > struct tcx_entry {
> > > >          struct bpf_mprog_bundle    bundle
> > > > __attribute__((__aligned__(64))); /*     0  3264 */
> > > >
> > > >          /* XXX last struct has 36 bytes of padding */
> > > >
> > > >          /* --- cacheline 51 boundary (3264 bytes) --- */
> > > >          struct mini_Qdisc *        miniq;                /*  3264 =
    8 */
> > > >
> > > >          /* size: 3328, cachelines: 52, members: 2 */
> > > >          /* padding: 56 */
> > > >          /* paddings: 1, sum paddings: 36 */
> > > >          /* forced alignments: 1 */
> > > > } __attribute__((__aligned__(64)));
> > > >
> > > > That is a _lot_ of cachelines - at the expense of the status quo
> > > > clsact/ingress qdiscs which access miniq.
> > >
> > > Ah yes, I'll fix this up.
> >
> > Thanks.
> >
> > cheers,
> > jamal
> > > Thanks,
> > > Daniel

