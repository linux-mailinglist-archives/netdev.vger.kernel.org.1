Return-Path: <netdev+bounces-306142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ixXBOd1wT2oWgwIAu9opvQ
	(envelope-from <netdev+bounces-306142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5872F3A7
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=JZ5i9Tay;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306142-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306142-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93714308E45A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB212403B00;
	Thu,  9 Jul 2026 09:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346C404BCF
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590975; cv=none; b=m/3FznCnPTcaYCTxNRtVefZIqSX44a8shcyp73ceyjOTB4eexzXPtEndA8y6lVoyrzRpBzv+UHAspEV3kgyBxxXkOqem9lNKvFBxeSmNu/ZSCc7llXhhYTsUQiMittjqgOqglDcKcwe1Gr1a65XkRsq6RhapUJUeU8SfRmfL6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590975; c=relaxed/simple;
	bh=y0ueD2HhhO9sYx46zBe6GC0lC01oe7J7EHAcGkoIfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOLhmLipwIQfI8zzUPayN5kzAqzhnEebTNK9kX0WBWb0fC4nBIPrbelh2Dnhygw6b0YdpJp3f/G6kJEAyaxSJ7v/dxeCHfPzliAhrDzhBqbOMGCpsQZFzo9M/meThYp9REXOMx9vGRVi1TMrxvANVwvN/zgoYZi9uVoofSJA7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JZ5i9Tay; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so8774935e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590972; x=1784195772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=JZ5i9TayqfK9QDaV483kelEywHyKCmkriCfBpd7K8DN5YpPk2aQi7z28+jFnMObuRe
         esNGGiSrcNJAVK+8Ex1ueSgOitMpe+rkRHCH3fGfW4eXakRl+fJt8nmMlykYDVFJ95KQ
         faF2515egiE7jA1eALwi3ILuJxd5dWxMHgZPZEPIRbWDFBquVPj5+H9X3EqEHRHboSKu
         9vgq1b78NAK2tHHZimh3SidH+QD0lkaj9iNIDSEEMqOhtX5W/eKM4WHc/6615I7tTbFw
         R1DlBquI+M9bEpkOxLZqqsW71vUrODGTXFejcVORq19VsrehURVcJT1jq7OMgkFuh7+1
         r1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590972; x=1784195772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=OJd/zMf//vTYCqt69qldjvdUzObP0Llkhg88FnediOGSShBNCtOfnweje6NkUMFJ8P
         K3cWjMCMLegduo6VMxlmyp09V3E0H/0JNAinQ+TWQ2f7wzncj6cNRlJB0AbDSnJ0hNTL
         og9e4vaD+lmHiE/UK75If6hscSua2qpxW81FQQuFew01zbCU/wSfB5D0Z/ti/3oLObFw
         Tt1cqvyNTPFXgNNn17CH9PSZZ0yB/OulgjR3TRFJIXMmcwEOC5K+hGs6Qw/vINX32PtD
         gAaHKf/CFoAZrQzWfRsPLGJ5O1pQlrZJs6/J1uCegptJGNO9LO1T/jF0FOw9yBp8+nFL
         Zvvw==
X-Forwarded-Encrypted: i=1; AHgh+Rpzc6oLLFURRHDMs4c2gX7Nuv9U7+jlXZnapH2G11J7NwFio9MjtiStZahI9UVR/rnht9SR7d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIx/69iK4S3x2bfZ9Xz7uDbS0mDLueDqsgINVV2YnHOCVsIvg
	ySIsqtrU8s0Rxv9XtNIrZWt7rI0ZGz8MNgGqkPQd7v/hmp6IoiFMr9Ey5Bn1wa8zhgQ=
X-Gm-Gg: AfdE7cnv5Q+tvvtpB7MiDlKq2UtxP1YAaoAd707g469Tei8nH5qYvX/JrZPph48DiRE
	Nll6Q12PjGRfyi6eCjkYrsWN09XEchpng3/nBY36H6m5sSoNaUGM+s7mAdxk8YREXPZFX4z8MpU
	B6EGtagjf+LqAjGZ3/la+Dj/wF9vgqzEeXjAnkutPHg/CT4RkA5EtcZ3aXrotzGQcWTh9jh24Sg
	hqFOEXxkuDDU21vy8Mc3TYP59zgs+VMd11fS+Yivss34PenQv9NP20mdNBbSizlmyMlgm4l89Dg
	npTw7f/465eu61GxP9cHVt1J4mjfx5NaSKebcNFFSbQLy/hMs0b4I6ystgrqfIvfghO1jGXv502
	/eJ8XOeZrRM62hoThSjNLkANw8BRnEmmOfconrO6t0/hW/UkVrd8rol/8WQqgGk+HDbJdx3R+Hj
	VHHGB3EUSvLeZ1EyG19EkY3Q==
X-Received: by 2002:a05:600d:844f:20b0:493:c77c:108a with SMTP id 5b1f17b1804b1-493e68a1dc1mr47714715e9.36.1783590972300;
        Thu, 09 Jul 2026 02:56:12 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a572c3sm142014615e9.1.2026.07.09.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:11 -0700 (PDT)
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
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 11/13] RDMA/core: Make device names unique per net namespace
Date: Thu,  9 Jul 2026 11:55:30 +0200
Message-ID: <20260709095532.855647-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306142-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:mid,resnulli.us:from_mime,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98D5872F3A7

From: Jiri Pirko <jiri@nvidia.com>

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3ccf4731154a..cffb0de1c001 100644
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
@@ -1240,7 +1245,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1424,8 +1430,9 @@ static void ib_device_notify_register(struct ib_device *device)
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
@@ -1716,6 +1723,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0


