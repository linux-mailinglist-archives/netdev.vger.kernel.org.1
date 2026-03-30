Return-Path: <netdev+bounces-273270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PiqCkSpymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:48:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19E35EFF4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A2F304C113
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401133D1CB1;
	Mon, 30 Mar 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A9cqfDu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66673BFE40
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889163; cv=pass; b=sfwthnW7Q2/hEa+5G7+Oob5vNPwYB1UUOvajTWolJVnOf5lzA8/MoEd+plqIybEv+FYQAj7nXSzM0EUp2ZLf7lequzEdnIkIr224InNrtJOn3CZmwP5DAa/NFQF2WHB5JLDWDvv0lNi4+BrVYih0VGBKuUZrHVSO1I8uENNJ1yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889163; c=relaxed/simple;
	bh=B3EvDjLnK/wEHfgzqh2nAB2JoirFPAokF7aUFZ+zuxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACvXNcCoIR/wujepIpRIc8qQjOJFKik1cg0WQpV+jpHGZicxf6xR79mUs9Krkze5Oz5LX9mNG+EfMYxHUmw/WdDp0ePnkwE4KJy2+YT7PcS9asZnXbGKe1Uc2w3TYUBTCEvSXeE5d/zIbGfLKGFgznWgu+wwMCx4EMS32bEZ+Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=A9cqfDu0; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a7539851fso2133326b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774889159; cv=none;
        d=google.com; s=arc-20240605;
        b=Qj8SAevWnKk9YtdlvoJExh8ROlNvRuCMxJeNCURe5H0RV0l5ScTmb5R7qlfQXHqAK0
         Bk+U/kct5LKAnQA5O1QvoJmX3JcQhd713wK3RdocJq1P2oWgmf+4INyCVCgj1kn01P/V
         y7jXAbdkLpj3Ksa00rQclTOmS9ITQdtydE26GXPbW6P1iyvXmlrchjZfcqDCY0c5TIuU
         vzQelq5xe6or0uD5fUnnfCswUjtZXx19wc4ssHPa4ddNS0xhuGMcO8jWQwcmOsg7U7xe
         hfsNtHGJJJGYN7e6IgSV1UrZpZt2x6yzJqkxpKT5nXpPCqKzfP/x/4xvCLBfX846emqV
         izeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tGKvWSozt1gEdBIkhiFsYunPEPwVM9Nu2archVVh+E=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=VRC4FUwk8cc0FO2ZHH1xmgL7wiQ026rzi5Ksh1fmvcAzFIXa0Q2OkveSiuWOTFrqhZ
         mrGt+KJdVZBaBkbc34mN6ABSbumcIIXTtEFkrMzYfFOXwSk7fXUmXGrlmW4N8LRcbBkf
         Ja4xjfpT3YipMpDdkEdoD8+Z+qthxAbn3FmsFglktoQQhmFXidJVXyH800OcGumyGeAd
         J6ogWxmQQNqmzsu4Yf7pAnHHAvG8j4wW7MUdXMkxssrEl0ZnLPeZMdNj9N3G/OVQUTc2
         RnII9mxqON4XeM/LPXBQsQE8sQp2G8ox6/ZxW4BIfU5Qf5N9Y1uqoRtpPiRbyGmKSFG0
         tVRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774889159; x=1775493959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tGKvWSozt1gEdBIkhiFsYunPEPwVM9Nu2archVVh+E=;
        b=A9cqfDu0kYhEmAiwZOZbDiyc9TjNwSi6Wl22brXK58T0ImTMGPV0E71YuiUYgIO9xn
         oh3A9oejnZOZhosfwRRB3HIc1/lC9nBSsO4aM7dGb/LegZ6q/7675yySa4LbesTiQvFD
         xqdyswTBpJl/l9hYecUZ/J6crQz2gMPXVa1sjj7Fu2iUFW2cr9jo810X6hQnLCcdlYXC
         sjpUo/GBj0zKvoCxh8WxSq2EjYn5ATyGElU94j1aaAPwy/BtZMXn5K+SZ1Xn7YRIW9G0
         X4CO2rpzufYg8ZbA4mrbpY4F7Edkt6JS5qsJzVqM5QeLKZQmfNzd8uuX4p8ACnB5OKtN
         e+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889159; x=1775493959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tGKvWSozt1gEdBIkhiFsYunPEPwVM9Nu2archVVh+E=;
        b=sOP7wvtWmBE2WYgTZwv19i84urx4k2ezuIdpTLsn8tEzonJ1CA1aAgoLjQaQdRaCzf
         Bs+myrJ5QA85yKe5euPNhs1g0CgMuxf8Q4usEZSf+ItAL0pCMQ50mTPymy9JE59n67oI
         lWP8BOh4KDaWQlPGqkiRD/xDFlqibjYf63u79OxE/yEU5fxcfydobxosPms1WKKS6IzY
         ZinDBmZnnmnkbw/UzF3Mfb24DvOFZfTeOqi4/GqIFVXfSH6CRmUOOf6ODVgSWbjA/FiE
         ELVO+0FxR/wlQa4V3dcZN54Fkd8p7apboH2aQNy9vw6ZaTf1yRJ0CHDlKfi0VFiZVBRb
         vJTA==
X-Gm-Message-State: AOJu0YynTAYWF3fWHqG7p5EXWqL9p4+QLRB/KZQ/Y/T4VIAm/u6HTp7O
	k/cmOFwa5SJIl6Bv+mnpSZnAbezRral+PZvT8qNgkA0ba7cQBgsnSY8VT9dXgYKqnjNtQ9b9Khk
	TpgyMf5TzHvAYwURdFFqQZv1tPwN9HJIOp3ro9VwL
X-Gm-Gg: ATEYQzx/qB0cMzJ/d+PplIhKPrrO9/QarlYBH2ry9479A8yQIyDu7WbgWaJykFL2NGR
	M6Sv0zU4Tea/zWVS8nUIWFybR10J8JQ9MlEG6yKYGoNuJ/WN/O8hutm/frP29L5cz1+CZBVa/BX
	MFKdCO7cnEFrB42QqhzK6SjNa3BuVGybbEtV2S1aI4ffVIduHu4TZn2t/MZPz9fMMR5vWJ85tfN
	skg5vKbJc8tIOtoLwr4SyVFRftVpNnm+tamFGwVE/JOnikA+SqOLNdAjFg3h3eGX1Cce2stllXk
	3vJYVnGfZeyweayXnAM=
X-Received: by 2002:a05:6a00:1407:b0:827:3ff6:fb72 with SMTP id
 d2e1a72fcca58-82c96081840mr13586802b3a.51.1774889159591; Mon, 30 Mar 2026
 09:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327061300.3066844-1-xmei5@asu.edu> <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
 <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com> <s52rg5clqff6z44qdnjcthqhp3bhyzqn322esxj4caw7tqtkdw@2povbhh5efc7>
In-Reply-To: <s52rg5clqff6z44qdnjcthqhp3bhyzqn322esxj4caw7tqtkdw@2povbhh5efc7>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Mar 2026 12:45:48 -0400
X-Gm-Features: AQROBzC3h-6Q32gNI-qFT94M0cAwNyq2AOpKZGcVG1rdFrD5G_-RqjnkdAAB3eA
Message-ID: <CAM0EoMnNp2tV1Gn7a8KFMhUnQAWs0FDzb6bMUwhHtfPz-Uiqmg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference
 on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273270-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:email,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: 7E19E35EFF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 2:52=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> On Sun, Mar 29, 2026 at 08:15:17AM -0400, Jamal Hadi Salim wrote:
> > On Fri, Mar 27, 2026 at 10:11=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Fri, Mar 27, 2026 at 2:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wro=
te:
> > > >
> > > > The old-method path in fw_classify() calls tcf_block_q() and
> > > > dereferences q->handle. Shared blocks leave block->q NULL, causing =
a
> > > > NULL deref when an empty cls_fw filter is attached to a shared bloc=
k
> > > > and a packet with a nonzero major skb mark is classified.
> > > >
> > > > Check tcf_block_shared() before accessing block->q and return -1 (n=
o
> > > > match) for shared blocks, consistent with cls_u32's tc_u_common_ptr=
().
> > > >
> > > > The fixed null-ptr-deref calling stack:
> > > >  KASAN: null-ptr-deref in range [0x0000000000000038-0x0000000000000=
03f]
> > > >  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
> > > >  Call Trace:
> > > >   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:=
1764 net/sched/cls_api.c:1860)
> > > >   tc_run (net/core/dev.c:4401)
> > > >   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
> > > >
> > > > Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_=
q helper to get struct Qdisc")
> > > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > >
> > > Thanks for also providing the tdc tests. Looks like a bizarre bug=E2=
=80=94and
> > > in my mind the question is does fw or flow even factor into tc blocks=
?
> > > Please give me time to review if the approach makes sense - perhaps
> > > this weekend.
> > >
> > Since the fix is exactly as what u32 does - why not move
> > tc_u_common_ptr() to a header file (pkt_cls.h)? then reuse it in u32,
> > fw, and flow.
>
> Thank you for the suggestion, I appreciate the review.
>

Actually on second thought - why dont you fix the fw one so it catches
things at control time? Something like:

--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -247,8 +247,18 @@ static int fw_change(struct net *net, struct
sk_buff *in_skb,
        struct nlattr *tb[TCA_FW_MAX + 1];
        int err;

-       if (!opt)
-               return handle ? -EINVAL : 0; /* Succeed if it is old method=
. */
+       if (!opt) {
+               if (handle)
+                       return -EINVAL;
+
+               if (tcf_block_shared(tp->chain->block)) {
+                       NL_SET_ERR_MSG(extack,
+                                      "Must specify mark when
attaching fw filter to block");
+                       return -EINVAL;
+               }
+
+               return 0; /* Succeed if it is old method. */
+       }

        err =3D nla_parse_nested_deprecated(tb, TCA_FW_MAX, opt, fw_policy,
                                          NULL);

Also for the flow one, can you add an extack like above.
Note: This will change the nature of your tdc test, you dont need to
send an skb marked packet anymore since your config will be reject the
setup..

cheers,
jamal

> I spent some time exploring how to reuse tc_u_common_ptr() in cls_fw and
> cls_flow, but I'm not sure I see a clean way to make it work across all
> three classifiers. The core issue is that they need different things
> when the block is shared:
>
>  - cls_u32 needs a pointer value (block or block->q) as a hash key for
>    tc_u_common lookup
>  - cls_fw and cls_flow need to bail out and return -1 (no match)
>
> If we keep tc_u_common_ptr() as-is (returning void *), the usage in
> fw/flow would be tc_u_common_ptr(tp) =3D=3D block to detect shared blocks=
,
> which is less clear than tcf_block_shared(block) and doesn't save any
> code.
>
> If we rework it to return struct Qdisc * (NULL for shared), it would
> break cls_u32's current usage where it needs the block pointer itself
> as a hash key for the shared case.
>
> I may be misunderstanding your suggestion though =E2=80=94 could you shar=
e
> what you had in mind?
>
> Thank you again for your time,
> Xiang
> >
> > I am still questioning the value of using blocks with these two
> > classifiers and unfortunately the commit message of  1abf272022cf was
> > not helpful.
> > The testcases look good. Please add a letter head, perhaps quote the
> > comment in tc_u_common_ptr() since it gives a good description of this
> > whole dance.
> >
> > cheers,
> > jamal

