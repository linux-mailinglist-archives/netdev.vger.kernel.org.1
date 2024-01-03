Return-Path: <netdev+bounces-61308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D882340F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F481C23B79
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA01C2A6;
	Wed,  3 Jan 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AjTn2DS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19621C687
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d3352b525so116932015e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704304957; x=1704909757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHPu6J4DcDsZAVblB5vcDCOMwzt7PgbwtAeU7tZFTGo=;
        b=AjTn2DS7Gba8XFSzH6vpQ333wtZRm9QghbgUt4EqEWoed2uOrzs6dQwuhzpR18V5pm
         aHKHoIb++jT8WoTNLDwsvqyyhkPAKkywetTKrcS5oAG6JLywW9IVtIv8be5ooWYl+tJm
         fToPHNa1Ezder8g2ZKBi08pkDNBW2nX80ku/f6G3+P+JrWH6r7A17Xv7g11zCZ2UlPSs
         kW8uVDJNWLPS6mMp0GkS6/bR02JlgxsreFIbMsrvzM0jOl66C35Ed6kd50ZxrUAb5djz
         gd3ddyU7r1B6CvgPe3bdOQwYrD5VoIW9wLE5ZLq1s2q0SZK0oIgGkt8WDJxQ9sUSW+v1
         jckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704304957; x=1704909757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHPu6J4DcDsZAVblB5vcDCOMwzt7PgbwtAeU7tZFTGo=;
        b=dKezxmZz1EPv6DHa+ovK6rPMq8ib3xUxUhkYc74N/Am1jSCDNqygSEox1p1WxTpHCD
         DNNd5Oi1ACIXaDCRiCQCLkSusNfcBd5lpG3kV0vzczBunZv+wrOR/wEJp9pwe7osSHRm
         LZR2YBn/3fPjiWKqm/KBEMdSR/efLOBvq5hQVp26iky4dZiuRKNJxEfdFM9K8+Fk2p55
         6pi6Aln0cUFN0cMIEsJ3E5PHm8w8cdmxjXa9OXK2JIf6agF8OkRkMuLDFofDALp0IEjX
         iai7m+bhOSEeVic/sjR2w1fy5KA9mQcHK2fBdUnGtEUdwvvuxQ5msXp7Bas2Q6QRoKcq
         qojw==
X-Gm-Message-State: AOJu0Yzd3p/Fi+tZGj8aluAVZzD6TzUR7/rAAngyho7EbcoUPANh3MmI
	i4C5YUV1aX26SAjX0DKXafAm801JdiE/rA==
X-Google-Smtp-Source: AGHT+IELMLsdM7/E1prU2g9rGcYtJRRWYZQ62PsZfKu5ULLNmQpRmiwJSPggJrCqv27142a54ButQA==
X-Received: by 2002:a05:600c:520c:b0:40d:8a04:a134 with SMTP id fb12-20020a05600c520c00b0040d8a04a134mr1768793wmb.79.1704304957478;
        Wed, 03 Jan 2024 10:02:37 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id n4-20020a7bc5c4000000b0040d376ac369sm2945222wmk.40.2024.01.03.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:02:36 -0800 (PST)
Date: Wed, 3 Jan 2024 19:02:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, idosch@idosch.org, mleitner@redhat.com,
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com,
	syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
	syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
	syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add
 appropriate qdiscs blocks to ports' xarray
Message-ID: <ZZWhO01F43-D8DxN@nanopsycho>
References: <ZZQd470J2Q4UEMHv@nanopsycho>
 <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
 <ZZQxmg3QOxzXcrW0@nanopsycho>
 <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>
 <ZZVaIOay_IqSDabg@nanopsycho>
 <CAM0EoMm2Jp6faTOnFxzZi6_bMVZn2dkrkRHNEGpqQvJnWLN8-Q@mail.gmail.com>
 <ZZVuh0N_DVqFG_z3@nanopsycho>
 <CAM0EoMm9MQC_hbzhkVu7+B_VEJpLOeZ-uPNrJJsaNs9YA7gj_g@mail.gmail.com>
 <ZZWGvcizQbK7IRez@nanopsycho>
 <CAM0EoMkwQ+KN5RXTrT=4oH5Zod_8XpQeg0dF5_A5098QGW20iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkwQ+KN5RXTrT=4oH5Zod_8XpQeg0dF5_A5098QGW20iw@mail.gmail.com>

Wed, Jan 03, 2024 at 06:08:09PM CET, jhs@mojatatu.com wrote:
>On Wed, Jan 3, 2024 at 11:09 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Jan 03, 2024 at 03:43:00PM CET, jhs@mojatatu.com wrote:
>> >On Wed, Jan 3, 2024 at 9:26 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Wed, Jan 03, 2024 at 03:09:14PM CET, jhs@mojatatu.com wrote:
>> >> >On Wed, Jan 3, 2024 at 7:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Tue, Jan 02, 2024 at 06:06:00PM CET, jhs@mojatatu.com wrote:
>> >> >> >On Tue, Jan 2, 2024 at 10:54 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >>
>> >> >> >> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
>> >> >> >> >On Tue, Jan 2, 2024 at 9:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >> >>
>> >> >> >> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
>> >> >> >> >> >On Tue, Jan 2, 2024 at 4:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >> >> >>
>> >> >> >> >> >> The patch subject should briefly describe the nature of the change. Not
>> >> >> >> >> >> what "we" should or should not do.
>> >> >> >> >> >>
>> >> >> >> >> >>
>> >> >> >> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>> >> >> >> >> >> >We should only add qdiscs to the blocks ports' xarray in ingress that
>> >> >> >> >> >> >support ingress_block_set/get or in egress that support
>> >> >> >> >> >> >egress_block_set/get.
>> >> >> >> >> >>
>> >> >> >> >> >> Tell the codebase what to do, be imperative. Please read again:
>> >> >> >> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>> >> >> >> >> >>
>> >> >> >> >> >
>> >> >> >> >> >We need another rule in the doc on nit-picking which states that we
>> >> >> >> >> >need to make progress at some point. We made many changes to this
>> >> >> >> >> >patchset based on your suggestions for no other reason other that we
>> >> >> >> >> >can progress the discussion. This is a patch that fixes a bug of which
>> >> >> >> >> >there are multiple syzbot reports and consumers of the API(last one
>> >> >> >> >> >just reported from the MTCP people). There's some sense of urgency to
>> >> >> >> >> >apply this patch before the original goes into net. More importantly:
>> >> >> >> >> >This patch fixes the issue and follows the same common check which was
>> >> >> >> >> >already being done in the committed patchset to check if the qdisc
>> >> >> >> >> >supports the block set/get operations.
>> >> >> >> >> >
>> >> >> >> >> >There are about 3 ways to do this check, you objected to the original,
>> >> >> >> >> >we picked something that works fine,  and now you are picking a
>> >> >> >> >> >different way with tcf_block. I dont see how tcf_block check would
>> >> >> >> >> >help or solve this problem at all given this is a qdisc issue not a
>> >> >> >> >> >class issue. What am I missing?
>> >> >> >> >>
>> >> >> >> >> Perhaps I got something wrong, but I thought that the issue is
>> >> >> >> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
>> >> >> >> >>
>> >> >> >> >
>> >> >> >> >We attach these ports/netdevs only on capable qdiscs i.e ones that
>> >> >> >> >have  in/egress_block_set/get() - which happen to be ingress and
>> >> >> >> >clsact only.
>> >> >> >> >The problem was we were blindly assuming that presence of
>> >> >> >> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
>> >> >> >> >earlier patches surrounded this code with attribute checks and so it
>> >> >> >> >worked there.
>> >> >> >>
>> >> >> >> Syskaller report says:
>> >> >> >>
>> >> >> >> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
>> >> >> >> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
>> >> >> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> >> >> >> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>> >> >> >>
>> >> >> >> Line 1190 is:
>> >> >> >> block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >>
>> >> >> >> So the cl_ops->tcf_block == NULL
>> >> >> >>
>> >> >> >> Why can't you just check it? Why do you want to check in/egress_block_set/get()
>> >> >> >> instead? I don't follow :/
>> >> >> >>
>> >> >> >
>> >> >> >Does it make sense to add to the port xarray just because we have
>> >> >> >cl_ops->tcf_block()? There are many qdiscs which have
>> >> >> >cl_ops->tcf_block() (example htb) but cant be used in the block add
>> >> >> >syntax (see question further below on tdc test).
>> >> >>
>> >> >> The whole block usage in qdiscs other than ingress and clsact seems odd
>> >> >> to me to be honest. What's the reason for that?.
>> >> >
>> >> >Well, you added that code so you tell me. Was the original idea to
>> >>
>> >> Well, I added it only for clsact and ingress. The rest is unrelated to
>> >> me.
>> >>
>> >
>> >Well git is blaming you..
>>
>> Yeah, too long ago to remember I guess. It's no functional change,
>> just included new code into existing qdiscs, converting tcf_chain()
>> to tcf_block().
>>
>>
>> >
>> >> >allow grafting other qdiscs on a hierarchy? This is why i was asking
>> >> >for a sample use case to add to tdc.
>> >> >This was why our check is for "if (sch_ops->in/egress_block_get)"
>> >> >because the check for cl_ops->tcf_block() you suggested is not correct
>> >> >(it will match htb just fine for example) whereas this check will only
>> >> >catch cls_act and ingress.
>> >>
>> >> This code went off rails :/
>> >> The point is, mixing sch_ops->in/egress_block_get existence and cl_ops->tcf_block
>> >> looks awfully odd and inviting another bugs in the future.
>> >>
>> >
>> >What bugs? Be explicit so we can add tdc tests.
>> >
>> >> >> >--
>> >> >> >$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
>> >> >> >Error: Egress block sharing is not supported.
>> >> >> >---
>> >> >> >
>> >> >> >Did you look at the other syzbot reports?
>> >> >>
>> >> >> Yeah. The block usage in other qdiscs looks very odd.
>> >> >>
>> >> >
>> >> >And we have checks to catch it as you see.
>> >> >TBH, the idea of having cls_ops->tcf_block for a qdisc like htb is
>> >> >puzzling to me. It seems you are always creating a non-shared block
>> >> >for some but not all qdiscs regardless. What is that used for?
>> >>
>> >> No clue.
>> >>
>> >
>> >Well, if you cant remember a few years later then we'll look at
>> >removing it - it will require a lot more testing like i said.
>>
>> It's actualy part of the conversion to introduce block processing. For
>> the existing other qdiscs, not functional change.
>>
>
>Ok, does that mean we should look at removing it then or you think
>it's functionally needed?

It's needed. Feel free to make it nicer though.


>
>>
>> >
>> >> >
>> >> >>
>> >> >> >
>> >> >> >> Btw, the checks in __qdisc_destroy() do also look wrong.
>> >> >> >
>> >> >> >Now I am not following, please explain. The same code structure check
>> >> >> >is used in fill_qdisc
>> >> >> >(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c#L940)
>> >> >> >for example to pull the block info, is that wrong?
>> >> >>
>> >> >> There, you don't call tcf_block() at all, so how is that relevant?
>> >> >>
>> >> >
>> >> >Why do we need to call it? We just need it to retrieve the block id.
>> >>
>> >> Uff, that is my point. In the code you are pointing at, you don't use
>> >> tcf_block() at all, therefore it is not related to our discussion, is
>> >> it?
>> >>
>> >
>> >Huh? We are trying to check if it is legit to add a netdev to the
>> >xarray. The only way it is legit is if we have ingress or clsact.
>> >Those are the only two qdiscs with the set/get ops for blocks and the
>> >only potential ones which we can have valid shared blocks attached. It
>> >is related to the discussion.
>> >
>> >> >
>> >> >>
>> >> >>
>> >> >> >
>> >> >> >> >
>> >> >> >> >BTW: Do you have an example of a test case where we can test the class
>> >> >> >> >grafting (eg using htb with tcf_block)? It doesnt have any impact on
>> >> >> >> >this patcheset here but we want to add it as a regression checker on
>> >> >> >> >tdc in the future if someone makes a change.
>> >> >> >
>> >> >> >An answer to this will help.
>> >> >>
>> >> >> Answer is "no".
>> >> >
>> >> >Ok, so we cant test this or this is internal use only?
>> >> >
>> >> >I am going to repeat again here: you are holding back a bug fix (with
>> >> >many reports) with this discussion. We can have the discussion
>> >> >separately but let's make quick progress. If need be we can send fixes
>> >> >after.
>> >>
>> >> I don't mind. Code is a mess as it is already. One more crap won't
>> >> hurt...
>> >>
>> >
>> >Ok, so your code that you added a few years ago is crap then by that
>>
>> True that.
>>
>>
>> >metric. You can't even remember why you added it.
>> >You have provided no legit argument for the approach you are
>> >suggesting and i see nothing wrong with what we did. Let's agree to
>> >disagree in order to make progress and get the bug resolved.
>> >Please ACK the patch and we can discuss if we need to remove the class
>> >ops separately.
>>
>> I looked a bit deeper into the code, looks like the xarray insertion and
>> removal is done in inconvenient place, causing this bug. Moving it into
>> tcf_block_get/put_ext() seems much more suiting. See following untested
>> patch. It should:
>> 1) fix the bug
>> 2) make things nicer and easier to read
>
>Sigh. Your stubbornness is overwhelming. Sure, let's move forward -
>send an official patch but please make sure all tdc tests pass then
>we'll do the testing. Please dont see this as a sign that i think your
>patch is better - i am agreeing to move forward so we can make
>progress.

I'm not stubborn. I'm just trying to find out the best solution. That
should be our common goal, I believe.


>
>cheers,
>jamal
>
>
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index adf5de1ff773..253b26f2eddd 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>                       struct tcf_block_ext_info *ei,
>>                       struct netlink_ext_ack *extack)
>>  {
>> +       struct net_device *dev = qdisc_dev(q);
>>         struct net *net = qdisc_net(q);
>>         struct tcf_block *block = NULL;
>>         int err;
>> @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>         if (err)
>>                 goto err_block_offload_bind;
>>
>> +       if (tcf_block_shared(block)) {
>> +               err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> +               if (err) {
>> +                       NL_SET_ERR_MSG(extack, "block dev insert failed");
>> +                       goto err_dev_insert;
>> +               }
>> +       }
>> +
>>         *p_block = block;
>>         return 0;
>>
>> +err_dev_insert:
>>  err_block_offload_bind:
>>         tcf_chain0_head_change_cb_del(block, ei);
>>  err_chain0_head_change_cb_add:
>> @@ -1502,8 +1512,12 @@ EXPORT_SYMBOL(tcf_block_get);
>>  void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
>>                        struct tcf_block_ext_info *ei)
>>  {
>> +       struct net_device *dev = qdisc_dev(q);
>> +
>>         if (!block)
>>                 return;
>> +       if (tcf_block_shared(block))
>> +               xa_erase(&block->ports, dev->ifindex);
>>         tcf_chain0_head_change_cb_del(block, ei);
>>         tcf_block_owner_del(block, q, ei->binder_type);
>>
>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> index 299086bb6205..e9eaf637220e 100644
>> --- a/net/sched/sch_api.c
>> +++ b/net/sched/sch_api.c
>> @@ -1180,43 +1180,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>>         return 0;
>>  }
>>
>> -static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> -                              struct netlink_ext_ack *extack)
>> -{
>> -       const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
>> -       struct tcf_block *block;
>> -       int err;
>> -
>> -       block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> -       if (block) {
>> -               err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> -               if (err) {
>> -                       NL_SET_ERR_MSG(extack,
>> -                                      "ingress block dev insert failed");
>> -                       return err;
>> -               }
>> -       }
>> -
>> -       block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> -       if (block) {
>> -               err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> -               if (err) {
>> -                       NL_SET_ERR_MSG(extack,
>> -                                      "Egress block dev insert failed");
>> -                       goto err_out;
>> -               }
>> -       }
>> -
>> -       return 0;
>> -
>> -err_out:
>> -       block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> -       if (block)
>> -               xa_erase(&block->ports, dev->ifindex);
>> -
>> -       return err;
>> -}
>> -
>>  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>>                                    struct netlink_ext_ack *extack)
>>  {
>> @@ -1387,10 +1350,6 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>>         qdisc_hash_add(sch, false);
>>         trace_qdisc_create(ops, dev, parent);
>>
>> -       err = qdisc_block_add_dev(sch, dev, extack);
>> -       if (err)
>> -               goto err_out4;
>> -
>>         return sch;
>>
>>  err_out4:
>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> index e33568df97a5..9b3e9262040b 100644
>> --- a/net/sched/sch_generic.c
>> +++ b/net/sched/sch_generic.c
>> @@ -1052,8 +1052,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>>  {
>>         const struct Qdisc_ops  *ops = qdisc->ops;
>>         struct net_device *dev = qdisc_dev(qdisc);
>> -       const struct Qdisc_class_ops *cops;
>> -       struct tcf_block *block;
>>
>>  #ifdef CONFIG_NET_SCHED
>>         qdisc_hash_del(qdisc);
>> @@ -1064,18 +1062,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>>
>>         qdisc_reset(qdisc);
>>
>> -       cops = ops->cl_ops;
>> -       if (ops->ingress_block_get) {
>> -               block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>> -               if (block)
>> -                       xa_erase(&block->ports, dev->ifindex);
>> -       }
>> -
>> -       if (ops->egress_block_get) {
>> -               block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
>> -               if (block)
>> -                       xa_erase(&block->ports, dev->ifindex);
>> -       }
>>
>>         if (ops->destroy)
>>                 ops->destroy(qdisc);
>> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
>> index 5fa9eaa79bfc..1770083052cd 100644
>> --- a/net/sched/sch_ingress.c
>> +++ b/net/sched/sch_ingress.c
>> @@ -284,7 +284,8 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
>>         q->egress_block_info.chain_head_change = clsact_chain_head_change;
>>         q->egress_block_info.chain_head_change_priv = &q->miniqp_egress;
>>
>> -       return tcf_block_get_ext(&q->egress_block, sch, &q->egress_block_info, extack);
>> +       return tcf_block_get_ext(&q->egress_block, sch, &q->egress_block_info,
>> +                                extack);
>>  }
>>
>>  static void clsact_destroy(struct Qdisc *sch)
>>
>>
>> If you don't mind, I would test this and send it instead of your fix. If
>> you can test it too, that would be awesome.
>>
>> Thanks!

