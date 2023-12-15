Return-Path: <netdev+bounces-57997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FC814C29
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9002528505F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194C39FD5;
	Fri, 15 Dec 2023 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ms6bES8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A43DB8B
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so675754f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702655598; x=1703260398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bOK+qsD6U7d1DzXpYzFvfdZJb+wCLR5anVnqygX/AIs=;
        b=ms6bES8smlf7bjJK6kDt125wk4+dRzuqljoeZ8sWh5GlBynYUaZGJ3w6588DjosAN6
         W+V8HWLe4q1aJ+lQta9jBk7FuTQFRXJGDoq2wmlq6nGhXlHZYarkKwr0h+t60HNMyUrz
         joyD5DAuBN9WlkVfMcmIehy+ZBOMNuDTfkiEmdiiwAHZ2jHcwE4oieIKYhB6ZhFH8GbG
         Ol6SJXiHDo6CF6XAiecELo0nkWit3/6Em3bX9BTg8e97NXjf1Mg/vpNr0NDGb9Sx6G4B
         wYm1sBZQN+XdYPRXnLPvF1D1X5GujlG5uIbUtvR/Tn2BE/8NYIJ8+j0/Bc+3VqLhLCjc
         6vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655598; x=1703260398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOK+qsD6U7d1DzXpYzFvfdZJb+wCLR5anVnqygX/AIs=;
        b=bMrr7MMlG95Avwzzvhnc+yA45tlJFNrhgeN/REc1jaXcDVXTQIIU8OCTnKKXi2ZfqP
         gdiZdFYqqWTvCXEg0RysWyRMELchg8cUE2gCatJczatqhjsAQJFQKd2sg+E/w1Js95zF
         QpGl6dyvmZbHEzhGYRiG2j+vMvn6PwjBKjs30A/X0YrjAiYIUrMNvs8nLiB5sJAlzEtK
         OJpyIl6UOXRx+sbgcw0Ft1fCr6QAP5HJ+SdIMgzeob/vJn4EQv3vGMgaILBMx5UtTv2Q
         fooNzYFVf8a9YFvaHDumBu2q57B/RRW48f2FBpsB3etbLxsKk2TAB6UrPaKhUpWeV4PA
         Twnw==
X-Gm-Message-State: AOJu0Yxfg2bTs+gEwrKDZ1entYzhWQ0+uAvbrvbtsAlxjFZYUJYiVN9I
	c+V0ogsAKlTSBoQIKLXFRxLF9Q==
X-Google-Smtp-Source: AGHT+IGI7L9axCJVxH8roQL2UZxxU4O4ATjHK6yPxH0GfgHoEkvfSm+HKWgQnqkD2nQJ06nIG7PtGg==
X-Received: by 2002:a05:6000:11ca:b0:336:4912:8375 with SMTP id i10-20020a05600011ca00b0033649128375mr1056485wrx.34.1702655598356;
        Fri, 15 Dec 2023 07:53:18 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b0033616ea5a0fsm16123851wrs.45.2023.12.15.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:53:17 -0800 (PST)
Date: Fri, 15 Dec 2023 16:53:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, mleitner@redhat.com,
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to
 block
Message-ID: <ZXx2bEzl1oA92Ew5@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-4-victor@mojatatu.com>
 <ZXxPZoaIQoa7jlJv@nanopsycho>
 <1d08f20e-a363-4405-ad97-1107cd34628a@mojatatu.com>
 <ZXxgUHVzFp4BVZl3@nanopsycho>
 <CAAFAkD8KeMi3z-AArAsp8G8qAYPTv=go0qRvvTguWxAou+fzxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFAkD8KeMi3z-AArAsp8G8qAYPTv=go0qRvvTguWxAou+fzxw@mail.gmail.com>

Fri, Dec 15, 2023 at 03:36:37PM CET, hadi@mojatatu.com wrote:
>On Fri, Dec 15, 2023 at 9:19 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Dec 15, 2023 at 02:56:48PM CET, victor@mojatatu.com wrote:
>> >On 15/12/2023 10:06, Jiri Pirko wrote:
>> >> Fri, Dec 15, 2023 at 12:10:50PM CET, victor@mojatatu.com wrote:
>> >> > So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
>> >> > A matching packet is redirected or mirrored to a target netdev.
>> >> >
>> >> > In this patch we enable mirred to mirror to a tc block as well.
>> >> > IOW, the new syntax looks as follows:
>> >> > ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
>> >> >
>> >> > Examples of mirroring or redirecting to a tc block:
>> >> > $ tc filter add block 22 protocol ip pref 25 \
>> >> >   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
>> >> >
>> >> > $ tc filter add block 22 protocol ip pref 25 \
>> >> >   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
>> >> >
>> >> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> >> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> >> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >> > ---
>> >> > include/net/tc_act/tc_mirred.h        |   1 +
>> >> > include/uapi/linux/tc_act/tc_mirred.h |   1 +
>> >> > net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
>> >> > 3 files changed, 206 insertions(+), 74 deletions(-)
>> >> >
>> >> > diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
>> >> > index 32ce8ea36950..75722d967bf2 100644
>> >> > --- a/include/net/tc_act/tc_mirred.h
>> >> > +++ b/include/net/tc_act/tc_mirred.h
>> >> > @@ -8,6 +8,7 @@
>> >> > struct tcf_mirred {
>> >> >    struct tc_action        common;
>> >> >    int                     tcfm_eaction;
>> >> > +  u32                     tcfm_blockid;
>> >> >    bool                    tcfm_mac_header_xmit;
>> >> >    struct net_device __rcu *tcfm_dev;
>> >> >    netdevice_tracker       tcfm_dev_tracker;
>> >> > diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
>> >> > index 2500a0005d05..54df06658bc8 100644
>> >> > --- a/include/uapi/linux/tc_act/tc_mirred.h
>> >> > +++ b/include/uapi/linux/tc_act/tc_mirred.h
>> >> > @@ -20,6 +20,7 @@ enum {
>> >> >    TCA_MIRRED_UNSPEC,
>> >> >    TCA_MIRRED_TM,
>> >> >    TCA_MIRRED_PARMS,
>> >> > +  TCA_MIRRED_BLOCKID,
>> >>
>> >> You just broke uapi. Make sure to add new attributes to the end.
>> >
>> >My bad, don't know how we missed this one.
>> >Will fix in v8.
>> >
>> >>
>> >> >    TCA_MIRRED_PAD,
>> >> >    __TCA_MIRRED_MAX
>> >> > };
>> >> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>> >> > index 0a711c184c29..8b6d04d26c5a 100644
>> >> > --- a/net/sched/act_mirred.c
>> >> > +++ b/net/sched/act_mirred.c
>> >> > @@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action *a)
>> >> >
>> >> > static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
>> >> >    [TCA_MIRRED_PARMS]      = { .len = sizeof(struct tc_mirred) },
>> >> > +  [TCA_MIRRED_BLOCKID]    = { .type = NLA_U32 },
>> >> > };
>> >> >
>> >> > static struct tc_action_ops act_mirred_ops;
>> >> >
>> >> > +static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net_device *ndev)
>> >> > +{
>> >> > +  struct net_device *odev;
>> >> > +
>> >> > +  odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> >> > +                             lockdep_is_held(&m->tcf_lock));
>> >> > +  netdev_put(odev, &m->tcfm_dev_tracker);
>> >> > +}
>> >> > +
>> >> > static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> >> >                       struct nlattr *est, struct tc_action **a,
>> >> >                       struct tcf_proto *tp,
>> >> > @@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> >> >    if (exists && bind)
>> >> >            return 0;
>> >> >
>> >> > +  if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
>> >> > +          NL_SET_ERR_MSG_MOD(extack,
>> >> > +                             "Mustn't specify Block ID and dev simultaneously");
>> >> > +          err = -EINVAL;
>> >> > +          goto release_idr;
>> >> > +  }
>> >> > +
>> >> >    switch (parm->eaction) {
>> >> >    case TCA_EGRESS_MIRROR:
>> >> >    case TCA_EGRESS_REDIR:
>> >> > @@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> >> >    }
>> >> >
>> >> >    if (!exists) {
>> >> > -          if (!parm->ifindex) {
>> >> > +          if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
>> >> >                    tcf_idr_cleanup(tn, index);
>> >> > -                  NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
>> >> > +                  NL_SET_ERR_MSG_MOD(extack, "Must specify device or block");
>> >> >                    return -EINVAL;
>> >> >            }
>> >> >            ret = tcf_idr_create_from_flags(tn, index, est, a,
>> >> > @@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> >> >    spin_lock_bh(&m->tcf_lock);
>> >> >
>> >> >    if (parm->ifindex) {
>> >> > -          struct net_device *odev, *ndev;
>> >> > +          struct net_device *ndev;
>> >> >
>> >> >            ndev = dev_get_by_index(net, parm->ifindex);
>> >> >            if (!ndev) {
>> >> > @@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> >> >                    goto put_chain;
>> >> >            }
>> >> >            mac_header_xmit = dev_is_mac_header_xmit(ndev);
>> >> > -          odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> >> > -                                    lockdep_is_held(&m->tcf_lock));
>> >> > -          netdev_put(odev, &m->tcfm_dev_tracker);
>> >> > +          tcf_mirred_replace_dev(m, ndev);
>> >>
>> >> This could be a separate patch, for better readability of the patches.
>> >>
>> >> Skimming thought the rest of the patch, this is hard to follow (-ETOOBIG).
>> >> What would help is to cut this patch into multiple ones. Do preparations
>> >> first, then you finally add TCA_MIRRED_BLOCKID processin and blockid
>> >> forwarding. Could you?
>> >
>> >Will transform this one into two separate patches.
>>
>> More please.
>
>I see the first one as preparation and the second as usage. Can you

Preparation should be done in separate patches, one logical change per
patch if possible. Much easier to read and follow.


>make suggestion as to what more/better split is?
>
>cheers,
>jamal
>
>> >
>> >>
>> >> >            netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
>> >> >            m->tcfm_mac_header_xmit = mac_header_xmit;
>> >> > +          m->tcfm_blockid = 0;
>> >> > +  } else if (tb[TCA_MIRRED_BLOCKID]) {
>> >> > +          tcf_mirred_replace_dev(m, NULL);
>> >> > +          m->tcfm_mac_header_xmit = false;
>> >> > +          m->tcfm_blockid = nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
>> >> >    }
>> >> >    goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>> >> >    m->tcfm_eaction = parm->eaction;
>> >>
>> >> [...]

