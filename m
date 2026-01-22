Return-Path: <netdev+bounces-252250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMmeCC/tcWk/ZwAAu9opvQ
	(envelope-from <netdev+bounces-252250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:26:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D439A64802
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 851205EA729
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346923148A3;
	Thu, 22 Jan 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ciXaTA3M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442E223DC6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073404; cv=none; b=bx7DMjl+JWBjDAaV/+ijaPNNV0rjlUO2Man9sYNemZElF5UY2j17GyRyKmK0+qE3kAZHYf/YlZwGW2wrwsOmYaY0eOWaJLY61kDVqIjVat99mbFzLJ5IDQRX+YXfz+HOWeBoXS+FLlZwbrsDdtVCf8ZFbV1Y67Mhf03qzgG35TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073404; c=relaxed/simple;
	bh=PplpYZG54yCTO5Zvm8cd60PmTtW5IMnM+N/1Ic97wbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GspHdmLmU/JdN94KVrSd6LZAfK2QxungeNiwp1+DXD2b/IYnm4JKCqLVFO3RZHUhCQlVoqgSzKKDROsJ9rYdcl+DJdEOIAyAPGPljQUOv5Awa3S7Yhxu0LsoY87+IcaglEchiIk5VPbZQW3vQF690k7r4nkyMm6+L9bdjLs9B9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ciXaTA3M; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6Wf1P1834067;
	Thu, 22 Jan 2026 01:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RCQPDNXijAeVUWmVf6wLg88
	flEUv6pUUQ7mfKMo2dXI=; b=ciXaTA3MG45HJsi1ie0LtUEPjvzzykCA/86QduX
	29ZMLyvFRP7T9P2cUolN6xVI/E/ik4Pim1cTGCgvHky4Ul5s6enSxHfM+BCZO7MT
	8wHVLPJ+S9W5Tsm8Vq1ZgBm0EQLCtnYMTFKg3dLU5OJjtmahU6KmWi7TRNOHtUwX
	Y0ArJY9FOHu4stHu1lbPJBwy7BGHU9yhGTlhI8kWntBJS8YqCKvMYxJf+ddlzX/A
	hoeKtCHk2tJTrLi1wSvjHNNHy6q2WCLkx81bwW5uSqganWYNpYmdbdTzIBmWBU4s
	ZxvYlY9M1xTJ0/zQEor5laGooZNgJRdgZ+AQkvtizRsVEBA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3nktr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 01:16:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Jan 2026 01:15:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Jan 2026 01:15:32 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 7DB483F70A7;
	Thu, 22 Jan 2026 01:15:28 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next] virtio_net: Increase RSS max key size to match NETDEV_RSS_KEY_LEN
Date: Thu, 22 Jan 2026 14:45:27 +0530
Message-ID: <20260122091527.339180-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2MyBTYWx0ZWRfX9r2h1FS5WQcK
 U/pruugap6TWlwP3coPhDCYguUbRDh15zKgj0LBgC5WNWzdux0TIfqpmxRg7kjZZ0HH5SdB+zk3
 A9o91V7uuU15zfpsbAKy+39zdWeK0kd2r3RPZka/NyQMnsimhUF6ZfzQUFhaact4zZE1vxNpo8G
 iBMhhzy/T/KCIZ5Yaf31z1hsWXlNbUS55jA1lOet84P4fc2NwSdrRh9Syuonv2BjmFjYXbGvFCq
 K+qXc8nHUmt6Qgnc3Gt3ApyozUFrRu8yB5gshNHYMig0kOVdub/hjsTNlnuqdv0lKzmDRThz4JS
 Cpk/CiUdngCc+/BbEQH9ih3rHJ4oKZudW3i+pKPTpmBrovvmjj6v01XONYOuPKobi0SJgJ6KQQD
 AGNi/VOx9R/Jd5ZcIV0EVIJDTsfQZwZjp3FJPLZgy6nuPeVtUNP9ksoXg+hOmi+h2pzOwHNMFPK
 ItN5fpvaOWT0vNDo8Rg==
X-Authority-Analysis: v=2.4 cv=JeSxbEKV c=1 sm=1 tr=0 ts=6971eadd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=tN_10AvwJLKXjGWysDEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lfpShW07b5drNxv4SqoIKUJFJ1sgbB5I
X-Proofpoint-GUID: lfpShW07b5drNxv4SqoIKUJFJ1sgbB5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D439A64802
X-Rspamd-Action: no action

Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.

The virtio specification requires devices to support at least 40 bytes
for the RSS key size. However, devices may support larger key sizes
up to 52 bytes (as reported by the device's rss_max_key_size config
field). This change allows such devices to work properly.
Previously, devices reporting rss_max_key_size > 40 would fail with
an error during initialization.

The driver already handles variable key sizes dynamically through
vi->rss_key_size, so increasing the maximum limit is safe and
maintains backward compatibility with devices that support smaller
key sizes.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..5f06cbc058d7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -381,7 +381,7 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52
 
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
-- 
2.25.1


