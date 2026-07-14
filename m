Return-Path: <netdev+bounces-307501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5T2iEZpIVmpI2wAAu9opvQ
	(envelope-from <netdev+bounces-307501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E337755DE3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:32:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=yiRL3cZY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307501-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307501-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E363304E8D4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B747D929;
	Tue, 14 Jul 2026 14:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E546442135
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039421; cv=none; b=GTCHDMmUOkiLOjE99mblwG4Z1e8JxN8G/v1Eg1KNkrIAgD5T+pMVdX+s+ACJK//1zrak0X00jHI735g5A+Q7ZP/lbLdUn/1OABh4OpPzyPPsg/bnazktven/l+T/YmP3/w/wJbMHfPpw4iwqW8zbYKxx9qmzm7zLJtyrKfzxzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039421; c=relaxed/simple;
	bh=vXTVHC8jrIfunzmq69nH+ECf64rA25Ltg6ybB9/xSAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFvR8oJcJQBFg5sDN7fTwSHpUughEfpYjs7L3nVGXoAHbSjtYImWOqGZwqF7FqumwxcyygcR+wNhB7vV63KNVJZ+x6d5uStgl3SXKrKS9Ci1WpNo33gQ0yd8rSgKcCtjEuhh12pFVEsKhLUqs8ShVUfwsQxGns2EwCEmKhbebW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yiRL3cZY; arc=none smtp.client-ip=209.85.208.172
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c95395230so9213651fa.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039416; x=1784644216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=yiRL3cZY7eyG1TxmA7qo4lIGpnJYumz4/n1g5qcE1/Z2loCuguzG4swBu0DViUKfZG
         bX64uFF1VLuOSd3VTkVSTA03Zg5KU0shpHG42LsVvCYC6mUnjx9qMxEMmolc40Gov5++
         nP+gGJ73SBtiyBiGoOYKvH8v8fjXAXwF+hUUwy4O5FNKuvBHGfF6vVXXvCGqPEQyE8sb
         ef9jcwjy89H0cyIu2b9MMAVoR5PH0xKZ0E412v1ErfdMW5dAIZIy+TjWmruWvUgrxClw
         ik9Zf8e5kt3nRppJ8EsmkH/6BHl5Lw4GDvStE0KnYE80UUT9jjCzJFhP+vDAfNe/fTQV
         mMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039416; x=1784644216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=DMBLG7f2wnTDHK+h7XGzvRY8OvG51dNJihwOYzlw9EvDabEPvl5pOLSWA0ycrLy3MI
         zfJ2Inf6Ol3kGuuqxcfez51cWiIC82WhmDH6P8/wC10abRJunoseqPyfhAAcrK6tQreb
         qjV0nxx8Fss8spx/79DKOmPPf2Q441ZjDAatItC3Zerw4fV5OegE0huMAy1QE+zPFDuP
         2REzdKBIXTbHHVvbrTm1UkxtjZH2AWB6gjw163V2zJCPdiVCfmc+0hvDb6VyDs+b/D/J
         Bl+1EGGa8UGx5LpY6Z7wqTPll7kGgwafwkuyzOLtAfRloUpdx9AGshaBfEudbKl3yRW5
         UuAQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7Ple7ePmyvSq8nXdiJLT/haDsPzvXSkmqQqZZv254GJ2Jnoe6ce78I/2lTvEEDLSoop8Y4oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7PfxY6amvtEC8ncmUmayAt7bfq0cG2pn5FI+N9PK/sqV22+q
	3H28ZdqUyrT3oDwZo9iNpfY1bKvKzlmMYDRqrzAK3GnBmg0F+n3KqYBKXdamazIRU8o=
X-Gm-Gg: AfdE7cluO5+z4jxN02UhMcURaBLna3ZODkc5nBt2wI5K7609ruh4SKvV/JqXfSp5Stj
	647r3SqrnZ45BF2nENFdr/EW+Uy3vSJAjoqyB5sHLA3brGk9ysKvX1uNjQxAcN0yrJcLrTeLY/r
	fNhThrdFnInme5gA80ISNM4YMZaH/w04w9S2rbqOACyl+z6KUngXMeN+QMjpZ1EhxpTFUaJk9R5
	NiX6xQm7ITWWFjVPYHKdekE5sD3/DM3xjqT/9lfxIbyv0IL2gr/SegEATw6I25MYRPVX5UPnDRx
	RG+YSujHfOa2x8tgqLJD0vlOb470NZHvIJuBVG8WLcyKcDXYjPKUAXwqzBJ8Hyrf0Q5ex15Nr/Y
	HUHVD45Hoe/fPcIo+f+oZ85BcGFP4IOIdXFE63qzK8SCuM1F9pbF42qjJ1A8WJ2CClZMjbTBf9b
	EhF/RY3tnIH9YpA/knUSyExw==
X-Received: by 2002:a2e:a584:0:b0:39d:ab29:b731 with SMTP id 38308e7fff4ca-39dab29bc4dmr8571781fa.27.1784039415388;
        Tue, 14 Jul 2026 07:30:15 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84bb39fesm34469241fa.42.2026.07.14.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique per net namespace
Date: Tue, 14 Jul 2026 16:29:24 +0200
Message-ID: <20260714142927.1298897-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307501-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:from_mime,resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E337755DE3

From: Jiri Pirko <jiri@nvidia.com>

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index bb02640239d7..4c75078448a3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -129,7 +129,7 @@ static DECLARE_RWSEM(rdma_nets_rwsem);
 bool ib_devices_shared_netns = true;
 module_param_named(netns_mode, ib_devices_shared_netns, bool, 0444);
 MODULE_PARM_DESC(netns_mode,
-		 "Share device among net namespaces; default=1 (shared)");
+		 "Share device among net namespaces; default=1 (shared). In exclusive mode device names are unique per net namespace");
 /**
  * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
@@ -359,7 +359,8 @@ static struct ib_device *__ib_device_get_by_name(const char *name,
 	unsigned long index;
 
 	xa_for_each (&devices, index, device)
-		if (!strcmp(name, dev_name(&device->dev)))
+		if (rdma_dev_access_netns(device, net) &&
+		    !strcmp(name, dev_name(&device->dev)))
 			return device;
 
 	return NULL;
@@ -437,7 +438,11 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-/* Pick a free index for the '%d' style @name pattern. */
+/*
+ * Pick a free index for the '%d' style @name pattern within net namespace
+ * @net. Returns the index on success or a negative errno. The caller builds
+ * the final unique device name from the returned index.
+ */
 static int __alloc_name_id(struct net *net, const char *name,
 			   const struct ib_device *skip)
 {
@@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const char *name,
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
-		if (device == skip)
+		if (device == skip || !rdma_dev_access_netns(device, net))
 			continue;
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
 			continue;
@@ -1233,7 +1238,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1416,8 +1422,9 @@ static void ib_device_notify_register(struct ib_device *device)
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
- * @name: unique string device name. This may include a '%' which will
- * 	  cause a unique index to be added to the passed device name.
+ * @name: device name, unique within the device's net namespace. This may
+ *	  include a '%' which will cause a unique index to be added to the
+ *	  passed device name.
  * @dma_device: pointer to a DMA-capable device. If %NULL, then the IB
  *	        device will be used. In this case the caller should fully
  *		setup the ibdev for DMA. This usually means using dma_virt_ops.
@@ -1708,6 +1715,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0


