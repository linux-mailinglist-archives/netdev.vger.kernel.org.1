Return-Path: <netdev+bounces-260363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONsBIkhMnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69216182A73
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B979F30107A0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22952DCF74;
	Tue, 24 Feb 2026 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gUFS/0qL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF33093C6
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916357; cv=none; b=aoADmLeCCeRf9l+0ZIxkIassLr2eUEIBAek0sqod78+pAtOl1shcTcMh9X/JjXt6vXJ1tst0up7Sh3kDpkNUEoBfu3ZMuGDIfqCmr7+0iTWaULwTiJCmYQrY+LEEiRpu/q9po45S99RTTmTXjdblfjrq2tvNCB2x25/fwRZWsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916357; c=relaxed/simple;
	bh=LJauYpf/v9/z5GfJw1m/YTSkeGJkt9ipUJ1BdFeCrSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5mV2NhPl5B/I4b282G4FDrDLiXLDCI7ictltVZt6sgn3lEoXuGdtgbyDT2TjOWR0qweYwlJckGrd57pd5rNcDCm7lyQQ7X0QGpHvkBF6hZJQiX4ZHaFi/vRlXSyz7ZywtNUiJe2ftb9hk1wZYHJJ03tThduSv1izPMhhsKO1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gUFS/0qL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHpnPQ3270344;
	Mon, 23 Feb 2026 22:59:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	HzW4i1WxFmwvZJxwgii39C+NGLrGJ/JXBmetwbmkbg=; b=gUFS/0qL4WJLE0TN/
	SaPNoU9I0qQR+6IYOXhS26V00o0JFouCKRki8IRZU4kEJ45VjsI/SHAsdamq9x9d
	LbZBVKZufg4khbV+7zSst8bDom77A3qY7680tQ4bXKeoBkMOwL9eUl5gdhEg/G1A
	wT80QbgVl4+Ffrnkw1a8RpY33EpcWbypmEHYByhmxwZn9eM61WYl6kvKJwotViBb
	bJlUOEdVhFT/iBEqQzPdVuy4oKNmrWXCM0jvQzH8i7EvODgDV3/3OwV3+YkTCFN2
	cY8A4iz8gTaBzmu0916dVj+L5a7RujBIypUH0xQqidp7aL/hO8Z247zh9/rt4lMH
	uQk6Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkaeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 22:59:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Feb 2026 22:59:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Feb 2026 22:59:00 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id B95343F709A;
	Mon, 23 Feb 2026 22:58:56 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Tue, 24 Feb 2026 12:28:50 +0530
Message-ID: <20260224065850.962826-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260224065850.962826-1-schalla@marvell.com>
References: <20260224065850.962826-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d4c35 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=BwTn4DStoJ9Fkl0ccMAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZrwsOvpy9Deqx5ej8zAkkhHJKVxXopgd
X-Proofpoint-GUID: ZrwsOvpy9Deqx5ej8zAkkhHJKVxXopgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1OCBTYWx0ZWRfX4D0BqNZgsRAO
 IHCTC4Pba02KiXzOG7H8JX3adSc8XBUfybhje/RsyLoWk1HsQMmDo6SHxkyAe4Dg6FVlj4++SXZ
 Ndn/ACrsdi0CQZ5+WKiTghxIO7VAVmT5yfTzQe3wMHs4vKzOWAvHR2atARNg7pGz4erBB/nGap3
 c5mtiWbMRWVbIs0A5ruiMw39DPnHmdPBbdCOLV7IiJSqW+Awo6myslWZWSQ1JrQkcN79lqBEleM
 FbK73gFmBsGLu2XN7vfaY/ThXqJ3Gh4tyJMUe44SgHmgolPUpLBqCPwUOPa24DFWR20n+y3MpO/
 5Z2VLBfjlIXjZaLhV1mAihEUV1eY8VWYUaP6O0SVEpw61+DzI/pGfSnYflrZMJexG0xwcwKp0ka
 yc+STg/CQcdC8d+3c33WL2WfrkqqkLgbJ2lLtVWfOGKquHOON2ALVzCECcsOiGmnNS7AoE9PyWT
 CtOP56fmUeBDCl0iAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 69216182A73
X-Rspamd-Action: no action

Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
BUILD_BUG_ON to enforce the limit at compile time and remove the
redundant runtime max check.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/virtio_net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index eeefe8abc122..768ad5523dfa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
 			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
 			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
 		}
-		if (key_sz > NETDEV_RSS_KEY_LEN) {
-			dev_warn(&vdev->dev,
-				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
-				 key_sz, NETDEV_RSS_KEY_LEN);
-			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
-			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
-		}
+		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
 	}
 
 	return 0;
-- 
2.25.1


