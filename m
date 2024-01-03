Return-Path: <netdev+bounces-61239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4B822F66
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395E81C23556
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EF1A5A6;
	Wed,  3 Jan 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T2LffUBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22551A59A
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d560818b8so77787415e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704291978; x=1704896778; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPtMxyj/h/CvRIhAlj0ZMHpzqITSIynGEOHrjl5nhS4=;
        b=T2LffUBQXDsrmtu/dOz8HPnLttKPD4QtSqRyC59bWJ2p9hJZoL7CExHB2fjtryOnFn
         XUluiF6+hb+0Y/U0rKGoW0buRTfPF7Kos2Fd3vAmYH/R6B0UxoHO6NZj2/qdw2BNZNT3
         cx1P764fBD1yKXRErbi0cwLhTT8JMLwZQjwEI37sO71oMmWRE4NodelKBqeDsIscyZCs
         QfwDyZRzwTb5BcJqklqE7BHsuNm/PaM4RRO78H427ZjOVe+FjJgRKpnYQjsEdFN/LcMo
         /TXcsExs9Yp3UU1jVppgB+WA/ksMelk4iHABuXmqY0glPmzcMGa0w18UKLR4lkT/ZHQZ
         d+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291978; x=1704896778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPtMxyj/h/CvRIhAlj0ZMHpzqITSIynGEOHrjl5nhS4=;
        b=BPabfdHfw0iFxVD18UxpCX402lgY9NWkomkSbvo6YzDRf+MDFIFrJ8hFLJPNvaE+/y
         XAb613cOp493E2PbJY0ndee5kO5fE+S4OmI7Gkc6LX8usaRwED86LfbD4y1KQtIplM9y
         79jq4iN8UrzhuJzCrc+t6nrK9bDdtRIFfgLlVzoEWuoqHiCsxZmY/qOKTC8RKpe1e7+0
         RG81AAfqqXVZDEv2aIcG146nE4v3wzLSZhjGvSLvWFjKFYdTkzHeuorH9g7I7WEzBQha
         bVnhVK1mQnJQRJNhgiZIPkp7kYq3hLqoG5w86qE6KYZbanShrxsd06ohgyCsyYO7Jxup
         rCGw==
X-Gm-Message-State: AOJu0Yy9ACz9ER7+N1RdMs3XnwEoWVFXxG2fREzALw1mW8ik5N1GiXvZ
	/oLVKTeTL4d40Sc8CQD+WdJae5s3/FQ+Qg==
X-Google-Smtp-Source: AGHT+IEEc709Y+i3WUnjzJpzfYezXj42mj1Cd/IIQ0K3jKEBO5yMqnI2hSudKLa09wk+XCmvZVi3Sg==
X-Received: by 2002:a05:600c:3490:b0:40d:8f0b:cd50 with SMTP id a16-20020a05600c349000b0040d8f0bcd50mr684408wmq.42.1704291977502;
        Wed, 03 Jan 2024 06:26:17 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b00336b8461a5esm24837362wrv.88.2024.01.03.06.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:26:16 -0800 (PST)
Date: Wed, 3 Jan 2024 15:26:15 +0100
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
Message-ID: <ZZVuh0N_DVqFG_z3@nanopsycho>
References: <20231231172320.245375-1-victor@mojatatu.com>
 <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
 <ZZQd470J2Q4UEMHv@nanopsycho>
 <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
 <ZZQxmg3QOxzXcrW0@nanopsycho>
 <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>
 <ZZVaIOay_IqSDabg@nanopsycho>
 <CAM0EoMm2Jp6faTOnFxzZi6_bMVZn2dkrkRHNEGpqQvJnWLN8-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMm2Jp6faTOnFxzZi6_bMVZn2dkrkRHNEGpqQvJnWLN8-Q@mail.gmail.com>

Wed, Jan 03, 2024 at 03:09:14PM CET, jhs@mojatatu.com wrote:
>On Wed, Jan 3, 2024 at 7:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Jan 02, 2024 at 06:06:00PM CET, jhs@mojatatu.com wrote:
>> >On Tue, Jan 2, 2024 at 10:54 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
>> >> >On Tue, Jan 2, 2024 at 9:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
>> >> >> >On Tue, Jan 2, 2024 at 4:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >>
>> >> >> >> The patch subject should briefly describe the nature of the change. Not
>> >> >> >> what "we" should or should not do.
>> >> >> >>
>> >> >> >>
>> >> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>> >> >> >> >We should only add qdiscs to the blocks ports' xarray in ingress that
>> >> >> >> >support ingress_block_set/get or in egress that support
>> >> >> >> >egress_block_set/get.
>> >> >> >>
>> >> >> >> Tell the codebase what to do, be imperative. Please read again:
>> >> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>> >> >> >>
>> >> >> >
>> >> >> >We need another rule in the doc on nit-picking which states that we
>> >> >> >need to make progress at some point. We made many changes to this
>> >> >> >patchset based on your suggestions for no other reason other that we
>> >> >> >can progress the discussion. This is a patch that fixes a bug of which
>> >> >> >there are multiple syzbot reports and consumers of the API(last one
>> >> >> >just reported from the MTCP people). There's some sense of urgency to
>> >> >> >apply this patch before the original goes into net. More importantly:
>> >> >> >This patch fixes the issue and follows the same common check which was
>> >> >> >already being done in the committed patchset to check if the qdisc
>> >> >> >supports the block set/get operations.
>> >> >> >
>> >> >> >There are about 3 ways to do this check, you objected to the original,
>> >> >> >we picked something that works fine,  and now you are picking a
>> >> >> >different way with tcf_block. I dont see how tcf_block check would
>> >> >> >help or solve this problem at all given this is a qdisc issue not a
>> >> >> >class issue. What am I missing?
>> >> >>
>> >> >> Perhaps I got something wrong, but I thought that the issue is
>> >> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
>> >> >>
>> >> >
>> >> >We attach these ports/netdevs only on capable qdiscs i.e ones that
>> >> >have  in/egress_block_set/get() - which happen to be ingress and
>> >> >clsact only.
>> >> >The problem was we were blindly assuming that presence of
>> >> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
>> >> >earlier patches surrounded this code with attribute checks and so it
>> >> >worked there.
>> >>
>> >> Syskaller report says:
>> >>
>> >> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
>> >> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> >> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>> >>
>> >> Line 1190 is:
>> >> block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >>
>> >> So the cl_ops->tcf_block == NULL
>> >>
>> >> Why can't you just check it? Why do you want to check in/egress_block_set/get()
>> >> instead? I don't follow :/
>> >>
>> >
>> >Does it make sense to add to the port xarray just because we have
>> >cl_ops->tcf_block()? There are many qdiscs which have
>> >cl_ops->tcf_block() (example htb) but cant be used in the block add
>> >syntax (see question further below on tdc test).
>>
>> The whole block usage in qdiscs other than ingress and clsact seems odd
>> to me to be honest. What's the reason for that?.
>
>Well, you added that code so you tell me. Was the original idea to

Well, I added it only for clsact and ingress. The rest is unrelated to
me.


>allow grafting other qdiscs on a hierarchy? This is why i was asking
>for a sample use case to add to tdc.
>This was why our check is for "if (sch_ops->in/egress_block_get)"
>because the check for cl_ops->tcf_block() you suggested is not correct
>(it will match htb just fine for example) whereas this check will only
>catch cls_act and ingress.

This code went off rails :/
The point is, mixing sch_ops->in/egress_block_get existence and cl_ops->tcf_block
looks awfully odd and inviting another bugs in the future.


>
>> >--
>> >$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
>> >Error: Egress block sharing is not supported.
>> >---
>> >
>> >Did you look at the other syzbot reports?
>>
>> Yeah. The block usage in other qdiscs looks very odd.
>>
>
>And we have checks to catch it as you see.
>TBH, the idea of having cls_ops->tcf_block for a qdisc like htb is
>puzzling to me. It seems you are always creating a non-shared block
>for some but not all qdiscs regardless. What is that used for?

No clue.

>
>>
>> >
>> >> Btw, the checks in __qdisc_destroy() do also look wrong.
>> >
>> >Now I am not following, please explain. The same code structure check
>> >is used in fill_qdisc
>> >(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c#L940)
>> >for example to pull the block info, is that wrong?
>>
>> There, you don't call tcf_block() at all, so how is that relevant?
>>
>
>Why do we need to call it? We just need it to retrieve the block id.

Uff, that is my point. In the code you are pointing at, you don't use
tcf_block() at all, therefore it is not related to our discussion, is
it?


>
>>
>>
>> >
>> >> >
>> >> >BTW: Do you have an example of a test case where we can test the class
>> >> >grafting (eg using htb with tcf_block)? It doesnt have any impact on
>> >> >this patcheset here but we want to add it as a regression checker on
>> >> >tdc in the future if someone makes a change.
>> >
>> >An answer to this will help.
>>
>> Answer is "no".
>
>Ok, so we cant test this or this is internal use only?
>
>I am going to repeat again here: you are holding back a bug fix (with
>many reports) with this discussion. We can have the discussion
>separately but let's make quick progress. If need be we can send fixes
>after.

I don't mind. Code is a mess as it is already. One more crap won't
hurt...


>
>cheers,
>jamal
>
>
>> >
>> >cheers,
>> >jamal
>> >
>> >
>> >> >cheers,
>> >> >jamal
>> >> >
>> >> >> >
>> >> >> >cheers,
>> >> >> >jamal
>> >> >> >
>> >> >> >> >
>> >> >> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> >> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >> >> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
>> >> >> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> >> >> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
>> >> >> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> >> >> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> >> >> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> >> >> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> >> >> >> >---
>> >> >> >> >v1 -> v2:
>> >> >> >> >
>> >> >> >> >- Remove newline between fixes tag and Signed-off-by tag
>> >> >> >> >- Add Ido's Reported-by and Tested-by tags
>> >> >> >> >- Add syzbot's Reported-and-tested-by tags
>> >> >> >> >
>> >> >> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>> >> >> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
>> >> >> >> >
>> >> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >> >> >> >index 299086bb6205..426be81276f1 100644
>> >> >> >> >--- a/net/sched/sch_api.c
>> >> >> >> >+++ b/net/sched/sch_api.c
>> >> >> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >> >> >> >       struct tcf_block *block;
>> >> >> >> >       int err;
>> >> >> >> >
>> >> >> >>
>> >> >> >> Why don't you just check cl_ops->tcf_block ?
>> >> >> >> In fact, there could be a helper to do it for you either call the op or
>> >> >> >> return NULL in case it is not defined.
>> >> >> >>
>> >> >> >>
>> >> >> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >> >-      if (block) {
>> >> >> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >> >-              if (err) {
>> >> >> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >> >> >-                                     "ingress block dev insert failed");
>> >> >> >> >-                      return err;
>> >> >> >> >+      if (sch->ops->ingress_block_get) {
>> >> >> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >> >+              if (block) {
>> >> >> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >> >> >+                                      GFP_KERNEL);
>> >> >> >> >+                      if (err) {
>> >> >> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >> >> >+                                             "ingress block dev insert failed");
>> >> >> >> >+                              return err;
>> >> >> >> >+                      }
>> >> >> >> >               }
>> >> >> >> >       }
>> >> >> >> >
>> >> >> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >> >> >-      if (block) {
>> >> >> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >> >-              if (err) {
>> >> >> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >> >> >-                                     "Egress block dev insert failed");
>> >> >> >> >-                      goto err_out;
>> >> >> >> >+      if (sch->ops->egress_block_get) {
>> >> >> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >> >> >+              if (block) {
>> >> >> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >> >> >+                                      GFP_KERNEL);
>> >> >> >> >+                      if (err) {
>> >> >> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >> >> >+                                             "Egress block dev insert failed");
>> >> >> >> >+                              goto err_out;
>> >> >> >> >+                      }
>> >> >> >> >               }
>> >> >> >> >       }
>> >> >> >> >
>> >> >> >> >--
>> >> >> >> >2.25.1
>> >> >> >> >

