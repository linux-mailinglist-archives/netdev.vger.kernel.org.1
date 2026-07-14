Return-Path: <netdev+bounces-307494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J0Z3BUhJVmp12wAAu9opvQ
	(envelope-from <netdev+bounces-307494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1435755E79
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=l4XP7SF0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307494-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307494-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D12F30BD04A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574447ECC2;
	Tue, 14 Jul 2026 14:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF47F2E6
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:29:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039390; cv=none; b=OEfAl0IMQ5RmkuQsekv658PJunSivqwgReSt4RY7gjwKiM2onotTLXK4cLFAx3J4smnlPXbN/5h3uCY/3+5dNJ3ey2IRhhfGJZVLHlmw/r2hQppjO4Ljb16DhcLHxmDhTOKaIJAIu3uYlAEq4nysJzzjMdg/6PZtSal0rg8sh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039390; c=relaxed/simple;
	bh=DZOG7H+X305alvcfYyKRY+OmEfAdQKwMydMDvfsKbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk9m6kHQIe45VYqLLnH4TGMV6xxZidp2J0ToUf4M/+TfbmsNj65JygchOjMrVGiKWDdsW8+YDzH9yDHqfu8BbNHgQxbu3v/BHsO9wsx0N9AIBCWRSWfzha+eSWBnE4T3yQB6k/svRH0JfRhzRWYrvf9yMEjJEK3UGSjQIUGa7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=l4XP7SF0; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so739164f8f.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039386; x=1784644186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hvdgg/J5f+MIG37tkYT96k3bKW9qtjOneXBYLVa18U=;
        b=l4XP7SF0IByEVKhGr7Vf7Y1yShSB4+Rs/MFo7ues8QMwl7+WB+50t8kXlqdJq7xZpU
         bEt85JrI/XVLxozq0aUkX/M38HpMMwjMag2E5PA/VmhebAXIaSTohdjPF+Os71Jfa53y
         knbZyRJQxmPfR1FQH9+VmjZTRVj1aULztk+OWV/BkaHEvnfVv66vA9HF7/fexINQuvXH
         Pc5wHQRwsQMduR9cUkKX/XXk+B/IVOt32EIP58t4kVQqHWH9IYQURJ0qhDmxS+Rr7K90
         IFHfGe+EvrjW5MoP84+0y9IBwXt41jRuIHe620DsnY8tAdr8nQg08gVAD6fsDx/alodF
         8+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039386; x=1784644186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hvdgg/J5f+MIG37tkYT96k3bKW9qtjOneXBYLVa18U=;
        b=NZQqJizycLZRFy2bCOeuQ+3uSvTbRJq3GWa3VLEvotxqM/B5qcPsIhcUIVZoH65cDc
         OmCXho7U19A7hOsJZfX25gl8ZgTx5mkqTvNfSZUZNY/uAMk+zvS+LCmkZ3ULaxNsGyfL
         f+QmXGjOX55oM0L0n2qorAvJKRdNnFr/UyyUm/OrQq1DSDtgwsmy3Kzr2VA8RdK6pZ2m
         JAT45xL+LQGGhfT0DQV1JLB3XKwy2MxPBnm52Jlt6JVCi5/0iMm93XPDFQOKeO766o2c
         X04/6v5FmYLecpmbcGQn0lTPp1fkkmLj7Q4/mxg6mttJm3AP5uooX/QPw/PkI4qr08Fm
         ODJw==
X-Forwarded-Encrypted: i=1; AHgh+RpNR2oURNLoSn2hIBtebWGSo9mTlOGVkyp4Gd2eJ+m43S/VmQTbZ9KCNQq4F9IQxjmYYRkmGUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7NXMSDixZR6zqM0OL49ll0nZ4AkAFg1mqeUiHaBvWabi17K/
	WrzuklVKvyqLWVCOZ7YNalTTb8+cxYbSMc5GgdB6kgonLnrwk17T8vDtf3m3r+BVCyk=
X-Gm-Gg: AfdE7cm9mE/BVJdpEC8X+sztUDnpT/VduUEha4Coa5+eHJC4Sk+/87V3JZ6EbhOFV/3
	iF+2Ha92VkasG9Scf8I+9Sr4MCw5a9Jr/R5j3WUmknpP3GoddDNqkcxPpVMaHpNDfezI/CVXHwz
	ZCWKtTXm0lSS+tWOv8/d8sOxf8CgibEF45quJwB44w34cHJ+fKxLlBiJxgAGO4mgTOSaS6g6Ufs
	xCWAdy5aCOoSCudN7kbF0aboMx0anT8C+tJQQ7vYfZxpjSGfeXe+pWsOdw4sZcy6YqfcSZnSH3g
	a0cqyJ8RuBO+I7827f6UcCN0j4WitspSLFARl4vUK9vtcCynSxl95taQomO0gCSBkcngxfG71Ew
	nxZKu0O1TYzs3WiQlJALJZlkrXYaj+P3phGmxus5D7xSpDQgMYWyEQX0wb5vneJEZD3zty3wEGf
	RiJCG20ouzn8mwTQHQyyhh9Q==
X-Received: by 2002:a5d:5d12:0:b0:472:4861:5d4d with SMTP id ffacd0b85a97d-47f2dcc35e6mr14880023f8f.23.1784039385694;
        Tue, 14 Jul 2026 07:29:45 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm9076863f8f.4.2026.07.14.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:45 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 04/14] RDMA/nldev: Report net namespace move errors through extack
Date: Tue, 14 Jul 2026 16:29:17 +0200
Message-ID: <20260714142927.1298897-5-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307494-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:from_mime,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1435755E79

From: Jiri Pirko <jiri@nvidia.com>

Thread extack through the existing net namespace move helper and report the
main failure reasons from the core path. Keep the existing move UAPI shape
unchanged.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  3 ++-
 drivers/infiniband/core/device.c    | 24 ++++++++++++++++++++++--
 drivers/infiniband/core/nldev.c     |  6 ++----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3bd5bb7135a3..aaf330b0d333 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -356,7 +356,8 @@ void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
 				     const struct attribute_group **groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name);
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack);
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet);
 void rdma_nl_net_exit(struct rdma_dev_net *rnet);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c0b6613dba4c..366bd8463c07 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1871,18 +1871,22 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 }
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name)
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net;
 	int ret;
 
 	net = get_net_ns_by_fd(ns_fd);
 	if (IS_ERR(net)) {
+		NL_SET_ERR_MSG(extack, "Invalid target net namespace fd");
 		ret = PTR_ERR(net);
 		goto net_err;
 	}
 
 	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG(extack,
+			       "Missing CAP_NET_ADMIN in the target net namespace");
 		ret = -EPERM;
 		goto ns_err;
 	}
@@ -1893,6 +1897,10 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 */
 	if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
 		ret = name ? ib_device_rename(dev, name) : 0;
+
+		if (ret == -EEXIST)
+			NL_SET_ERR_MSG(extack,
+				       "Device name already exists in the target net namespace");
 		goto ns_err;
 	}
 
@@ -1901,7 +1909,16 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 * changed and this cannot be blocked waiting for userspace to do
 	 * something, so disassociation is mandatory.
 	 */
-	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
+	if (ib_devices_shared_netns) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot change net namespace of RDMA device in shared netns mode");
+		ret = -EOPNOTSUPP;
+		goto ns_err;
+	}
+
+	if (!dev->ops.disassociate_ucontext) {
+		NL_SET_ERR_MSG(extack,
+			       "Device does not support namespace changes (no disassociate support)");
 		ret = -EOPNOTSUPP;
 		goto ns_err;
 	}
@@ -1911,6 +1928,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, name,
 				    NULL);
 	put_device(&dev->dev);
+	if (ret == -EEXIST)
+		NL_SET_ERR_MSG(extack,
+			       "Device name already exists in the target net namespace");
 
 	put_net(net);
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 77a758080148..8648e95700bf 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1195,10 +1195,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		u32 ns_fd;
 
 		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
-		if (err == -EEXIST)
-			NL_SET_ERR_MSG(extack,
-				       "Device name already exists in the target net namespace");
+		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
+					      extack);
 		goto put_done;
 	}
 
-- 
2.54.0


