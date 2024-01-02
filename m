Return-Path: <netdev+bounces-60919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6F821DA3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790A81C21601
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6C11708;
	Tue,  2 Jan 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Kr/PUk5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAA11195
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3352b525so105380635e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704205797; x=1704810597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NgrqZMGkG10Fm4JunClgJWfReZnSjrLvxqDOGsja3jo=;
        b=Kr/PUk5Xsp3wSQsC1I+WVqEP0to1s97MoxvqkWmDfMMUl1txLzB/xROhjszkVq+r1H
         nHVkCWFmKH0816NL8kkp83LTyKMXn/HFrMhmM66+XrWrGKpd/LoBwivc8v70oEclrebf
         3hTFvnkxNt2mpp0gpzzBhywfA4dnVk9TIDf3ZFGumnbmu1oqTI6rNm9a+6Pqv0QH7fCI
         gNGzJGVYCnrbj/cMG/3K5ZhyfMw7tnqwMshDDAZVoOV940yuTNmHS7dI9aHHw2R0WeHI
         gozCX0d1qV+tbIqv5Lmyz0uwPBk0A6VyhuojlDxZfV6Ow9b5chF9hagMs4LHGJLEBFj5
         beZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704205797; x=1704810597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgrqZMGkG10Fm4JunClgJWfReZnSjrLvxqDOGsja3jo=;
        b=SARBoHt3KPOqh+kpKIQoEZtO8uA7TnyvSNZStjQxW4zjGl7AU41Dfko1Z1GbMEadye
         9Ad0xR++vC4z9qUsZYLarZdj0nsX8UzzMzGDYXQ5qpf8Wp8JyhzhX/cEUZFEO/2nZVJ2
         shg8o/WctyzdVn2M/6ZQp9XqqPwMNsibUM5FIB3XBCMreTvgVItGTNQXViWvp2swn5co
         Z21TYVADZHiA2qYoq5uVXizGvfwKinm2JPEwgK51IfoDLHRUALfzGAYNAZ4KTyKZS3zy
         gQs8xWgGVgKKj8ruRzimud+OFbHMIDM8T9fBaNbt9+0JFICyB9DsxZSWsrZzdbEOMiAN
         dCmw==
X-Gm-Message-State: AOJu0YwMxvYgVqi8dn8XBI3cXDLUugnqU8iPsyoNb8dKTig1TroDYhP6
	xwETE9e9v3pvW9YWaZyPUq0tvxH+WgcUxg==
X-Google-Smtp-Source: AGHT+IHya1EE5hhP2exf2fXOGaq9yhKTId0p7iLIHbCGI6QlzRKstSKI8siBKUaQcmZ7PG7Lj8zEmA==
X-Received: by 2002:a05:600c:c84:b0:40d:8cca:c637 with SMTP id fj4-20020a05600c0c8400b0040d8ccac637mr503861wmb.71.1704205797263;
        Tue, 02 Jan 2024 06:29:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c471400b0040d77ebd55csm15945461wmo.13.2024.01.02.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:29:56 -0800 (PST)
Date: Tue, 2 Jan 2024 15:29:55 +0100
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
Message-ID: <ZZQd470J2Q4UEMHv@nanopsycho>
References: <20231231172320.245375-1-victor@mojatatu.com>
 <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>

Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
>On Tue, Jan 2, 2024 at 4:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> The patch subject should briefly describe the nature of the change. Not
>> what "we" should or should not do.
>>
>>
>> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>> >We should only add qdiscs to the blocks ports' xarray in ingress that
>> >support ingress_block_set/get or in egress that support
>> >egress_block_set/get.
>>
>> Tell the codebase what to do, be imperative. Please read again:
>> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>>
>
>We need another rule in the doc on nit-picking which states that we
>need to make progress at some point. We made many changes to this
>patchset based on your suggestions for no other reason other that we
>can progress the discussion. This is a patch that fixes a bug of which
>there are multiple syzbot reports and consumers of the API(last one
>just reported from the MTCP people). There's some sense of urgency to
>apply this patch before the original goes into net. More importantly:
>This patch fixes the issue and follows the same common check which was
>already being done in the committed patchset to check if the qdisc
>supports the block set/get operations.
>
>There are about 3 ways to do this check, you objected to the original,
>we picked something that works fine,  and now you are picking a
>different way with tcf_block. I dont see how tcf_block check would
>help or solve this problem at all given this is a qdisc issue not a
>class issue. What am I missing?

Perhaps I got something wrong, but I thought that the issue is
cl_ops->tcf_block being null for some qdiscs, isn't it?


>
>cheers,
>jamal
>
>> >
>> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >Reported-by: Ido Schimmel <idosch@nvidia.com>
>> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> >Tested-by: Ido Schimmel <idosch@nvidia.com>
>> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> >---
>> >v1 -> v2:
>> >
>> >- Remove newline between fixes tag and Signed-off-by tag
>> >- Add Ido's Reported-by and Tested-by tags
>> >- Add syzbot's Reported-and-tested-by tags
>> >
>> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>> > 1 file changed, 20 insertions(+), 14 deletions(-)
>> >
>> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >index 299086bb6205..426be81276f1 100644
>> >--- a/net/sched/sch_api.c
>> >+++ b/net/sched/sch_api.c
>> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >       struct tcf_block *block;
>> >       int err;
>> >
>>
>> Why don't you just check cl_ops->tcf_block ?
>> In fact, there could be a helper to do it for you either call the op or
>> return NULL in case it is not defined.
>>
>>
>> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >-      if (block) {
>> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >-              if (err) {
>> >-                      NL_SET_ERR_MSG(extack,
>> >-                                     "ingress block dev insert failed");
>> >-                      return err;
>> >+      if (sch->ops->ingress_block_get) {
>> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >+              if (block) {
>> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >+                                      GFP_KERNEL);
>> >+                      if (err) {
>> >+                              NL_SET_ERR_MSG(extack,
>> >+                                             "ingress block dev insert failed");
>> >+                              return err;
>> >+                      }
>> >               }
>> >       }
>> >
>> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >-      if (block) {
>> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >-              if (err) {
>> >-                      NL_SET_ERR_MSG(extack,
>> >-                                     "Egress block dev insert failed");
>> >-                      goto err_out;
>> >+      if (sch->ops->egress_block_get) {
>> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >+              if (block) {
>> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >+                                      GFP_KERNEL);
>> >+                      if (err) {
>> >+                              NL_SET_ERR_MSG(extack,
>> >+                                             "Egress block dev insert failed");
>> >+                              goto err_out;
>> >+                      }
>> >               }
>> >       }
>> >
>> >--
>> >2.25.1
>> >

