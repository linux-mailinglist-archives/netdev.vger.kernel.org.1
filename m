Return-Path: <netdev+bounces-270236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PiwCTTOvmnydAMAu9opvQ
	(envelope-from <netdev+bounces-270236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E52E66BA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505D530055D5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB38318139;
	Sat, 21 Mar 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RiuNOz/0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57230F7FB
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112303; cv=none; b=jiZYhpkt63US8+NmheuLS8DD2yQopFyo8HtvPuQK4H0aavsbUdkkzbi4VwVUwVQpb0P/jD0Wf/w1dDa0+VCPlACnKPsNcMLMntWBHku1rHU4UWpgtsKB+tt4c7oqVAOJ4GVzD6/BPteNA9jZKU22rIp9NTuO1RV8x5MIZacpCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112303; c=relaxed/simple;
	bh=y1tBcmtUkFDSFIB8h93dpatITVDk+d/Go6V0nw+e0Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9t+L9s7+PyfCJqfhbXT1u3DF/b2rSTir2WNDoyQYmN1cfUKaEHTELyu9my7ADOAj5JD8PqI698es0yxDkUIgao1GPM+Qz3YSdTIwbMpDWCqW8O22PJ9qOtkGQBiR7WSb6JiMRmecKA8H4wr2xietQmxK/xlxgcyI2QkTHRWBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RiuNOz/0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LEkgYc2569484;
	Sat, 21 Mar 2026 16:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=C2CRauHL27841fIvnO6Fr3yV2ts/H
	8XeWGn1zmpbKCk=; b=RiuNOz/0Su3LA2U9AVdNXUAAWsQvTvJINnGrszcOR304S
	HR0KSoxrFoQM+IVDvlWFTNjAZ5CkH+jdQBOtjj5elESNtVv2Yt7RcM0D9I+NlMyL
	t3Wf1hrfvOE4BB2KU35uFM1Aia976LssWWgHRWrD8/OX5D8HVxsV/9ywlBE6Ibs0
	0osKNNCKI1g+uADIeMS98kcKaEKQ3gUcNWAK+0M/v05/BS9ilmEK07q2xTMV5ImW
	5KUNHhH8wP73HZJp8T/N+zqnVscprzPY2bVX3H83gpGqsGEGv+rethuGHeRHOC87
	4Yyvw+KKqRAganU4r0SLxqakiPXB3atO+G5O+gjiw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpg9eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62LEUWUo038960;
	Sat, 21 Mar 2026 16:52:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs702rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:52:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62LGqgCm026985;
	Sat, 21 Mar 2026 16:52:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs702ru-1;
	Sat, 21 Mar 2026 16:52:41 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: gongfan1@huawei.com, cai.huoqing@linux.dev, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next 1/2] net: huawei: hinic: correct IPv6 version check in TX checksum path
Date: Sat, 21 Mar 2026 09:52:33 -0700
Message-ID: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210142
X-Proofpoint-GUID: b0xn0eIj4nJiYlFhCmya5IELAe43t68d
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69beccdb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=ih95IPvx0uHJk6_-mHcA:9 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: b0xn0eIj4nJiYlFhCmya5IELAe43t68d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MiBTYWx0ZWRfX6jNKnnrkNZLp
 8p9f4VL+2YelDdys2OqXG5Pu1uDsNQ1QMkFSRFIWLUtM25EewZPwWVNpWn95bOfeisHpd+jWeH2
 5CupGCgPkkph/tgkPnSDtwetyBxL9raj7NQdB8gYZ/m+3utCtebXrFbq4/inggiVYRe9LpGp9nH
 DQ5g0pHTVeSoTk2UwleQPhohKIX80vKVOzleyGhwCr2ys4Ev4WNZRjYFX/YWBP51ddWOJtaCVm3
 xAp10hJQrIcuZ6gQL4W99kGYjBgAGf2JbDNXuh7R1RZ9VEYHgf/9A675pkF0Wh3iBjajkkVji8S
 UC0/qjA7wr8qOySVad/Cw0ZJWNe4fT3VQ1j5R5Zr6E6Hf5sUctNv3iohuovHlNMYck9GFLWVWFe
 3ExzFm3CHdXlQT0EO2Mo0lrihRP3q+hcPyFg9br2ue90QtEpIdFUy/uNCzvnIVK8vEtLbKS5dYs
 jpHCfF1/NFONRpPQ6VlQlGvS9oLXmj9QhbTyC/UE=
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270236-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 302E52E66BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TX checksum/offload code determines whether the network header is
IPv4 or IPv6 by checking the version field. The IPv6 case incorrectly
checked ip->v4->version for a value of 6. Use ip->v6->version instead to
match the header type being parsed.

Use ip->v6->version in the IPv6 case to match intent and improve
readability.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 9b60966736db..e26cdc3fc31b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -209,7 +209,7 @@ static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic_l3 *ip,
 			   IPV4_PKT_NO_CHKSUM_OFFLOAD :
 			   IPV4_PKT_WITH_CHKSUM_OFFLOAD;
 		*l4_proto = ip->v4->protocol;
-	} else if (ip->v4->version == 6) {
+	} else if (ip->v6->version == 6) {
 		*l3_type = IPV6_PKT;
 		exthdr = ip->hdr + sizeof(*ip->v6);
 		*l4_proto = ip->v6->nexthdr;
-- 
2.50.1


