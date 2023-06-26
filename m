Return-Path: <netdev+bounces-14081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356B73ECF5
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46329280DC3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A31548E;
	Mon, 26 Jun 2023 21:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5014282
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:36:10 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D33C2
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 14:36:08 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53ba38cf091so2657075a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687815368; x=1690407368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1lzvU61bG6lMRlTczgnDa2fmmVi4hggQfmRt7l+8KY=;
        b=M8iBo74fOk1e6ZIaUBhqazd80HThoF9OFs4mIbTFZ7hhVk7jNFXDpHDvpuRoVtGs0a
         5335I/Nf02lzcActUd6ikc6v7D13Samj4UlSRqFZHUSWWGac8lR+z3QkQd/tkDJg6ln9
         2G7hISmFP1E8MBBoGUd2iuyWYZVkOG/d/q6gOmjAlUuAfmoJsEyfTG5lGTyD+ITRj8ll
         Me8ZrOgNBPkuXy2urwpNQgbFK9dOmq0lPOFTgxewfuVDNw+vYzRAy3XuzDopMt3u6QAx
         hp++6+SQAU1LwpVhgwLGXz7GRlyGS96JwG261Uk0Ors5FIVAHnWxhFOEFJTsW6V4Zfy5
         MiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815368; x=1690407368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1lzvU61bG6lMRlTczgnDa2fmmVi4hggQfmRt7l+8KY=;
        b=XOjvqKE+s873LhICdbJBxeTOfELlcs1hlvPcB4Mjcozucn3ZJCfKjUQtcm/IfF30ii
         z07kU6OPXjFGongE2G9063I8YNSPWzRt9FrWTZXjSxIOV5LFqfxzUl8LBaDLzmZETxkI
         GGVfh0hTCIZkZGfftpGj5BbHEIOEOXobTk2qtlHuoZ9x+gdKsVKaf2awaf/cSuXGhqTo
         sOo/gvgdIbCUdV0vfWxyicym+VrAsLGV2JgR1x5iqV8K7XLEIt14+6vGjuFp0XCTmgRB
         avo3k/T7/wxY9YknyHnGq8nb7LlZRFPxP0BL5mAvMehBctjpB9OZo3Dps96p6L8EDeOq
         TEBw==
X-Gm-Message-State: AC+VfDwWnpLjCX0QSNXUsdRY+MoovrjOXijQZVg8ty6i6gmS9w+HtF0u
	x8mK1R5OeG7SNtHAcYpe0g7bEII=
X-Google-Smtp-Source: ACHHUZ6+8/3QpsKv5FpOwqJ9DLviLq6l0UVM9Og5c+s1itko9VlFwq3SOmzRv6N23OFfkexeQ25j6zs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:3d4c:b0:25e:cd8e:e85b with SMTP id
 o12-20020a17090a3d4c00b0025ecd8ee85bmr3992826pjf.1.1687815368351; Mon, 26 Jun
 2023 14:36:08 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:36:07 -0700
In-Reply-To: <ZJeUlv/omsyXdO/R@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
Message-ID: <ZJoExxIaa97JGPqM@google.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/24, Stanislav Fomichev wrote:
> On 06/24, Jakub Kicinski wrote:
> > On Fri, 23 Jun 2023 19:52:03 -0700 Alexei Starovoitov wrote:
> > > That's pretty much what I'm suggesting.
> > > Add two driver specific __weak nop hook points where necessary
> > > with few driver specific kfuncs.
> > > Don't build generic infra when it's too early to generalize.
> > > 
> > > It would mean that bpf progs will be driver specific,
> > > but when something novel like this is being proposed it's better
> > > to start with minimal code change to core kernel (ideally none)
> > > and when common things are found then generalize.
> > > 
> > > Sounds like Stanislav use case is timestamps in TX
> > > while Donald's are checksums on RX, TX. These use cases are too different.
> > > To make HW TX checksum compute checksum driven by AF_XDP
> > > a lot more needs to be done than what Stan is proposing for timestamps.
> > 
> > I'd think HW TX csum is actually simpler than dealing with time,
> > will you change your mind if Stan posts Tx csum within a few days? :)
> > 
> > The set of offloads is barely changing, the lack of clarity 
> > on what is needed seems overstated. IMHO AF_XDP is getting no use
> > today, because everything remotely complex was stripped out of 
> > the implementation to get it merged. Aren't we hand waving the
> > complexity away simply because we don't want to deal with it?
> > 
> > These are the features today's devices support (rx/tx is a mirror):
> >  - L4 csum
> >  - segmentation
> >  - time reporting
> > 
> > Some may also support:
> >  - forwarding md tagging
> >  - Tx launch time
> >  - no fcs
> > Legacy / irrelevant:
> >  - VLAN insertion
> 
> Right, the goal of the series is to lay out the foundation to support
> AF_XDP offloads. I'm starting with tx timestamp because that's more
> pressing. But, as I mentioned in another thread, we do have other
> users that want to adopt AF_XDP, but due to missing tx offloads, they
> aren't able to.
> 
> IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from TX
> timestamp to TX checksum offload, we don't need a lot:
> - define another generic kfunc bpf_request_tx_csum(from, to)
> - drivers implement it
> - af_xdp users call this kfunc from devtx hook
> 
> We seem to be arguing over start-with-my-specific-narrow-use-case vs
> start-with-generic implementation, so maybe time for the office hours?
> I can try to present some cohesive plan of how we start with the framework
> plus tx-timestamp and expand with tx-checksum/etc. There is a lot of
> commonality in these offloads, so I'm probably not communicating it
> properly..

Or, maybe a better suggestion: let me try to implement TX checksum
kfunc in the v3 (to show how to build on top this series).
Having code is better than doing slides :-D

