Return-Path: <netdev+bounces-60817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC02821950
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED485281599
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9ECA6B;
	Tue,  2 Jan 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kHOaeOFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F41CA68
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368b1e056eso8452801f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704189587; x=1704794387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y2Oy+nc+aov4s/csYOItRsdNjf1by3kLHZB3CI/+S0=;
        b=kHOaeOFbk8LaADzaOE6rxjB4XFjymfzk2+LaukmfTVxcjJRUUga/P43Y3szDaNuFSu
         XQidtIPlZMVTBhLFWbBW2Bm2JlXsFUdrO0tNaiEZ6dJJHj6zzSjcLotYvACGzYBuuY/U
         W9dzxQWoW76Qo19H0QwL2XIk7pvN3sqDrz/uip3DH0y77dVTPO4DIUCFxWBvj5IaOfgf
         JRXp8rNPaKa3oGls0hDle2BUXi1LYfwcG/RKYNS4gcZ1sbZAJhjq1rJiUg4rSwsuE90y
         RnjnyRl+A+cyQxilFwLk5Gy4XNTLRRmN71sOFSVNSTFEKh/GjpLd5L3l7EGTSXTETAEk
         fJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189587; x=1704794387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y2Oy+nc+aov4s/csYOItRsdNjf1by3kLHZB3CI/+S0=;
        b=eiuZu6VURc5EopPfs0XvoO0bGoJlRjP9C+4sJFiSJUBcEIQXQHHJ6rQr8v8xZbDTH8
         Apq4PEgDSFSresoLI9Y53+8KwiQN6HAHq4gJiyQUVZgvlUHsfuiI4RtO7wuq5DrRNDXa
         s7vMNeJcf2FKJzQRGBXKJ2NtA3kHCiGgMVyzskyg4E+bsjOR2GF/QZCZ/eQET9LYVoBR
         DC/OVK5W61QETErKID3fyp4m8PE/6nswbtosdW3iZ9gDtp3ZZMtLnoIoxkK2hDmKrA3d
         SfNlf/419GfFyMiESnMfWaIrK2RCZD1Z2+4s/xBcADivQe+G0VO1j8iRXx6S3SmTrbBL
         C5Ow==
X-Gm-Message-State: AOJu0YziVapqWAtn6nfCysrYolrOO4XCJqjbI+p4cCu51LASpMTCnDYU
	vr+us8S2+FL1psZ/5cq7HSilzbE91JsHPQ==
X-Google-Smtp-Source: AGHT+IH+HtrX++nloUdbiMUreRdRdQ/gZYC/90zQyeDhEfEx1E/UrMoSqQD2CHPpXUrGGD7z0Fq1gw==
X-Received: by 2002:a05:600c:3f8b:b0:40d:8990:6403 with SMTP id fs11-20020a05600c3f8b00b0040d89906403mr974631wmb.76.1704189586610;
        Tue, 02 Jan 2024 01:59:46 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b0040d83acde28sm11324977wmn.14.2024.01.02.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:59:45 -0800 (PST)
Date: Tue, 2 Jan 2024 10:59:44 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com,
	syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
	syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
	syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add
 appropriate qdiscs blocks to ports' xarray
Message-ID: <ZZPekLXICu2AUxlX@nanopsycho>
References: <20231231172320.245375-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231172320.245375-1-victor@mojatatu.com>

The patch subject should briefly describe the nature of the change. Not
what "we" should or should not do.


Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>We should only add qdiscs to the blocks ports' xarray in ingress that
>support ingress_block_set/get or in egress that support
>egress_block_set/get.

Tell the codebase what to do, be imperative. Please read again:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


>
>Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Reported-by: Ido Schimmel <idosch@nvidia.com>
>Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>Tested-by: Ido Schimmel <idosch@nvidia.com>
>Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>---
>v1 -> v2:
>
>- Remove newline between fixes tag and Signed-off-by tag
>- Add Ido's Reported-by and Tested-by tags
>- Add syzbot's Reported-and-tested-by tags
>
> net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> 1 file changed, 20 insertions(+), 14 deletions(-)
>
>diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>index 299086bb6205..426be81276f1 100644
>--- a/net/sched/sch_api.c
>+++ b/net/sched/sch_api.c
>@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
> 	struct tcf_block *block;
> 	int err;
> 

Why don't you just check cl_ops->tcf_block ?
In fact, there could be a helper to do it for you either call the op or
return NULL in case it is not defined.


>-	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>-	if (block) {
>-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>-		if (err) {
>-			NL_SET_ERR_MSG(extack,
>-				       "ingress block dev insert failed");
>-			return err;
>+	if (sch->ops->ingress_block_get) {
>+		block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>+		if (block) {
>+			err = xa_insert(&block->ports, dev->ifindex, dev,
>+					GFP_KERNEL);
>+			if (err) {
>+				NL_SET_ERR_MSG(extack,
>+					       "ingress block dev insert failed");
>+				return err;
>+			}
> 		}
> 	}
> 
>-	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>-	if (block) {
>-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>-		if (err) {
>-			NL_SET_ERR_MSG(extack,
>-				       "Egress block dev insert failed");
>-			goto err_out;
>+	if (sch->ops->egress_block_get) {
>+		block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>+		if (block) {
>+			err = xa_insert(&block->ports, dev->ifindex, dev,
>+					GFP_KERNEL);
>+			if (err) {
>+				NL_SET_ERR_MSG(extack,
>+					       "Egress block dev insert failed");
>+				goto err_out;
>+			}
> 		}
> 	}
> 
>-- 
>2.25.1
>

