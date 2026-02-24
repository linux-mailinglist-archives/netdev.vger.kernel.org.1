Return-Path: <netdev+bounces-260334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vfsQFsounWn5NAQAu9opvQ
	(envelope-from <netdev+bounces-260334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:53:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D7181BE0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD4AB305DD36
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278D274B2B;
	Tue, 24 Feb 2026 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UYPFOMxr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D813C918
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771908806; cv=none; b=qgdtlZXYPK1HZ7nx44oQNG2ODEOnI7cGLnwVtLDysfjZyIPspSE+6WLzJcSRzmldNQR/cOtbt8PJQtoRRCJO4DZy8qutIN/F17Mak6GgU9yp+uJ3rLgUyPRGC7QFnnrsECpEswk4WoRekdtyvL5UybhJzxXv1sdF4JmzmEo61ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771908806; c=relaxed/simple;
	bh=QHFf1OU6ES7xnOCXlMFAgJ/dg74jYKJ37lAfBLRVn98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xtq9kjskFO/zz7wAXj2En37hirM5XQ1ETQ5AWLBqxr8kQRQcUmH5GDgdpeZw6LUZPGKh77GTFlca/kvgPoak6op2mejaxddvC2ZN3wwQcIPZToL4PGV8looGSMXI7rIxM6pbs/m1B3MaW8nnnSZA2Q/tFTf56pLQO5w/vBu+Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UYPFOMxr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHAEf92086643;
	Mon, 23 Feb 2026 20:52:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	P+0XX82xmHWBkwIZfYhvrX4L2scW1Js6Fybb7XMtuc=; b=UYPFOMxrHK3ZBlFeE
	yZxJiXVGLmkqjCPxr/XQHi2oU0YnpmWBNe1XmYYljvUlBNTQ7+NzSRYfQeO2tEvz
	MqzVC7dpHnoHbrwxZk3h2U1EMmPYaRSUEyrfF4nzODtCd2Upwt1Ear88+BMASrjU
	KWDR6i2zNJU5yg6CYtUCU0uMIKIPWkoiGBT7RGOUQYK6gLvv469mWG/fE8CmD39h
	wLGlJJlz0AwLxfV+pI1lQNYMN/MCUv2dScGiz/PrvanRDMET872lrsPD2Aa4U0DS
	qzKMyiTv3tXyENvaK4Why8l4dmIWtKpC4JlxySGo+8vb1EGGyixtVrRKglPuFlq9
	seAPg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cfd3gvyaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 20:52:59 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Feb 2026 20:52:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Feb 2026 20:52:57 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 913163F70CF;
	Mon, 23 Feb 2026 20:52:54 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Tue, 24 Feb 2026 10:22:49 +0530
Message-ID: <20260224045249.933178-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260224045249.933178-1-schalla@marvell.com>
References: <20260224045249.933178-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JX3T82BzDMseqW1046oOTANVoAhCDXwS
X-Proofpoint-GUID: JX3T82BzDMseqW1046oOTANVoAhCDXwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAzOCBTYWx0ZWRfX2oyqKzfDXfZO
 Q3h5HzrpnxGj+MYfziexYoLwmahKyHcl38WNN89Gozg+Ap+GXb8DpTRDusfMz/IAN4gMIm75s10
 rdMa0U5JXNaYP3upnE+JVfYCSyXKVbf3Zp0W5Wwfs+HmV27i6Tmge3ZKqBm5Uwf8AxniIYM/PyH
 ibotz97y7wVPyn8bqc4bW4WWJmOjojAxGDPQMxa/qhWXMwUxQ10nfoR1rsT5GzALjS8aN4AKv4B
 YoKGLAMsb+UUDjbnmSENX6QpDUIHXo82UgVBcPuVUO/3Jo4duQCZjDsY7xDk6uuBcdJnTE2mKk7
 irLpFMjAkxb7+WLvV4mgc67Xib2SUvOPvcmKrIopUkUyvYYifJQt0lujCJWV6kqniM48dapFzLW
 nX9uNYv0TigFla4Mxk0Ft63QvSpfo5nZ5Jj/+NRL8ecl1lx/TZQtfOjLslwm2QOyED8pvTUEpkH
 84AQFBc+ZRYcGq1akIw==
X-Authority-Analysis: v=2.4 cv=H5XWAuYi c=1 sm=1 tr=0 ts=699d2eab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=BwTn4DStoJ9Fkl0ccMAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A73D7181BE0
X-Rspamd-Action: no action

Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
BUILD_BUG_ON to enforce the limit at compile time and remove the
redundant runtime max check.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/virtio_net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index eeefe8abc122..3092d5d9d3e4 100644
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
+		BUILD_BUG_ON(type_max(vi->rss_key_size) >= NETDEV_RSS_KEY_LEN);
 	}
 
 	return 0;
-- 
2.25.1


