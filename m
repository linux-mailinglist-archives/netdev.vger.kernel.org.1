Return-Path: <netdev+bounces-62926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3D829E58
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75981C22664
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3B4CB2A;
	Wed, 10 Jan 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eGhCYY3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459334CB59
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2a360dbc11so444102366b.2
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704903472; x=1705508272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9n60t3rM8zq4CGJ75+TVtFWj94yvD21N3xMsxPgPn50=;
        b=eGhCYY3GhB9klPP7M4FUTZS/oS3Nmleo2yjo5uoigW9vLXBFzeKFkxBipWUPexCh3h
         88Lc5oKlAfbkkeIDuL+VV3dS9xzyjdnsdaIOYRFx0vrhGzHURziEVvd9qf7K6lpKdaql
         HPnnbfFeFAh5EVNlqPs3QYZCRNPftUsb52bBj1cIpRg5Rfn36Ri/r6lkM+MnN5ttXNHX
         fu6FaJxgTgCYreKRVd9BjmmOhmtDwsn0A9LVGfiuRV4RxEaf9gydlw+7TW7F1RxJxaXR
         bzUT3yLRGrGuQfy/O4Oi4tDmdVyiQBj03/nxpAqAJYdnuPj4PTrD0PImufS0Hkx16OEQ
         IYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903472; x=1705508272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n60t3rM8zq4CGJ75+TVtFWj94yvD21N3xMsxPgPn50=;
        b=X1kkw3igpC3IrZ5UruiUk5tzpmftV0KkEazbhnX5go9hkD2S/+fp+4o49RzqTdkzcP
         JSi0wZPGy2b8bC4JefRX5Z+uZB24n2J7WPA4ujSY07T90N3TcooiKXYHmcCkKYUczZTb
         mAAO4NhaCAusl4ND6upN8QiE9NVH1b0H5GPMj7dhz7dK7S2LzI0Om0TT9qfCDLlWHDdl
         cdcyrRtA2rLgh1kDQfmKEGFbdl19o/Xg4wu9LgwyY0ztVJkSL+++aukSEem59CAMdPg+
         1S4H8Y4s8sP3Gp3m65lPI0B0vNPDHWNNp3u02lKKWjByBZlrv39d0fm3tP9iRKvR2Yv2
         wT9g==
X-Gm-Message-State: AOJu0YzLQk+ejAPwi3mc9raqtNLyZmqmgHgAaPZr7ikFfHO7u31EA/2H
	AnCfVDerBxOiLWzOfy+g8/qJ1u4zYBDx2g==
X-Google-Smtp-Source: AGHT+IGPxcP6H8/VW/cjDF0wWk06DTjtFFpMae4YI28WEM0KDMz1DyBabE6aGUyR4Tan2YGa/tisdg==
X-Received: by 2002:a17:907:98c:b0:a23:1e0d:565b with SMTP id bf12-20020a170907098c00b00a231e0d565bmr1008464ejc.1.1704903472195;
        Wed, 10 Jan 2024 08:17:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hb21-20020a170906b89500b00a28d438a1b0sm2225041ejb.83.2024.01.10.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:17:51 -0800 (PST)
Date: Wed, 10 Jan 2024 17:17:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZ7DLvAwXcQit3Ar@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ6JE0odnu1lLPtu@shredder>

Wed, Jan 10, 2024 at 01:09:55PM CET, idosch@idosch.org wrote:
>On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index adf5de1ff773..253b26f2eddd 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>  		      struct tcf_block_ext_info *ei,
>>  		      struct netlink_ext_ack *extack)
>>  {
>> +	struct net_device *dev = qdisc_dev(q);
>>  	struct net *net = qdisc_net(q);
>>  	struct tcf_block *block = NULL;
>>  	int err;
>> @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>  	if (err)
>>  		goto err_block_offload_bind;
>>  
>> +	if (tcf_block_shared(block)) {
>> +		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> +		if (err) {
>> +			NL_SET_ERR_MSG(extack, "block dev insert failed");
>> +			goto err_dev_insert;
>> +		}
>> +	}
>
>While this patch fixes the original issue, it creates another one:
>
># ip link add name swp1 type dummy
># tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 4 3 2 1
># tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop block 10
>RED: set bandwidth to 10Mbit
># tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop block 10
>RED: set bandwidth to 10Mbit
>Error: block dev insert failed.

Feel free to text following patch. Since I believe it is not possible
to send fixes to net-next now, I will send it once net-next merges
into net.

net: sched: track device in tcf_block_get/put_ext() only for clsact binder types

Clsact/ingress qdisc is not the only one using shared block,
red is also using it. The device tracking was originally introduced
by commit 913b47d3424e ("net/sched: Introduce tc block netdev
tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
sched: move block device tracking into tcf_block_get/put_ext()")
mistakenly enabled that for red as well.

Fix that by adding a check for the binder type being clsact when adding
device to the block->ports xarray.

Reported-by: Ido Schimmel <idosch@idosch.org>
Closes: https://lore.kernel.org/all/ZZ6JE0odnu1lLPtu@shredder/
Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/sched/cls_api.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index e3236a3169c3..92a12e3d0fe6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1424,6 +1424,14 @@ static void tcf_block_owner_del(struct tcf_block *block,
 	WARN_ON(1);
 }
 
+static bool tcf_block_tracks_dev(struct tcf_block *block,
+				 struct tcf_block_ext_info *ei)
+{
+	return tcf_block_shared(block) &&
+	       (ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS ||
+		ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS);
+}
+
 int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 		      struct tcf_block_ext_info *ei,
 		      struct netlink_ext_ack *extack)
@@ -1462,7 +1470,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 	if (err)
 		goto err_block_offload_bind;
 
-	if (tcf_block_shared(block)) {
+	if (tcf_block_tracks_dev(block, ei)) {
 		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "block dev insert failed");
@@ -1516,7 +1524,7 @@ void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
 
 	if (!block)
 		return;
-	if (tcf_block_shared(block))
+	if (tcf_block_tracks_dev(block, ei))
 		xa_erase(&block->ports, dev->ifindex);
 	tcf_chain0_head_change_cb_del(block, ei);
 	tcf_block_owner_del(block, q, ei->binder_type);
-- 
2.43.0


