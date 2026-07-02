Return-Path: <netdev+bounces-303980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OC/MNdnvRWqoGwsAu9opvQ
	(envelope-from <netdev+bounces-303980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683156F37E7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=KuGEyZUh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303980-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D1FD303BDE4
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA93603C9;
	Thu,  2 Jul 2026 04:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAA35AC09;
	Thu,  2 Jul 2026 04:56:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782968194; cv=none; b=XI+dT9YaX7GRFMgArMZOpXnkh0m+6fOB5QOfJ48VigIDmU0ZubsF6yY76lqFXjR0v76cqcAj+vgg8RFPUkcsgYBVPoPwyZ0W73J4KgyZEOG4hv7euf3entcvuq8ciW/oGDpOFFFVYUcAdMQAnjpIAoswj8/h/sefidI6DQWCJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782968194; c=relaxed/simple;
	bh=afZfY0UDqm9eplEUa4iZoW0ubPmWgtTY1IQfmePapb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kTv4tGbguioOca1v/bHQTTdetD5Yj7wvW8+VNPqGSNujYc++2TFQoylFD8XqlmUjQA8E4baPHeaNpbLThqXHB5VdQBCxDO/O11v1VY0GdFQq4PhtsiQrCdPSLke9N9LKljEgdWy1KqYqD99pC4gwhhWWgWDuTO3A5nW1lckzw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KuGEyZUh; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621Mrb7570199;
	Wed, 1 Jul 2026 21:56:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=hBSlbhTpOPt/eg5KUZ3If7L
	kfHOKryzLRMrT6HWTKEo=; b=KuGEyZUhzSrNsBn9EY8Ib2Rcm7dWgREZoNP/c2d
	s1hBwSEcr1e1i6aMnyv2rymC0uqo6FmaCf8AJjAAaxIC0XVcrxd6JdVqGS3pvG3+
	j3NUgHbeupISgiJXFsueaXfiYDWsaOHZHvanh2GrCgiMWs+7DpFp1mRy/3lEYJ1C
	B6JrzmD6HHqliYmkvvLJjvzWiK/x7yrs+XEoPdIzgJ+FJ391aOzzrtxpXQdqnE/T
	R5P2H1XHDCYHJPHF4gSkOiOltmZkrR9lgCS2QjYEitX8PAJqca6er0mMHOV9BdZs
	LPO6VnsgcioQCrOtcm33VhCmQb7cHlTkHmLs+fP8a7Vftzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f5b991117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:56:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:56:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:56:24 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 275593F708F;
	Wed,  1 Jul 2026 21:56:18 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <naveenm@marvell.com>, <rkannoth@marvell.com>,
        Kiran Kumar K
	<kirankumark@marvell.com>
Subject: [PATCH net v3 0/1] octeontx2-af: Bug fixes for VF RX mode
Date: Thu, 2 Jul 2026 10:26:15 +0530
Message-ID: <20260702045616.3002773-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ro5dY3LEARWrmITmhGzvF2cxL149ZNu6
X-Authority-Analysis: v=2.4 cv=GPk41ONK c=1 sm=1 tr=0 ts=6a45ef79 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=l-zWxDtYv_ntn3NHlfgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ro5dY3LEARWrmITmhGzvF2cxL149ZNu6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NyBTYWx0ZWRfX0u2MOeUprPtQ
 5WHcOPO9A7jfQb5bJkBI9MkMzYZEiySOoYX5bSMieCPTfjZeZbmaFlMJd8vNc7WSMHQZlLP0QCf
 lL69YdqEwKOluvIksyNAbxGDK93KT1kxJem6NivFXaU+dIWYjiUyqWVbpU44ka7ZRoWlQbAh4vY
 TIKNO5g86VZ5komGQpUv9iFfRAZB/s607ofCRrqCwzJh37nLjBYIOHV++O4glJ7sVX4hGusPI2X
 3vjN7Uotnxp2jo+rQnFaeHZZV6DmyR6SMjTAyfY5J+TAnGn0K0rPNmyi8LG9Yekp8iiSSEZ7AwH
 rFCZOrm5h6OjCixf22UJCUaX0oY4iWtETobgSDfzEOE9q6UdX0bP1q51Io4XGnbVna1RcCUbkc7
 kHg3w3GlVsW5fMpVFYt+r1Bqtrd/GwjJguo6BOCuIib32DY4xNA7NRFwZgApxmRG+Mz2ASsVocS
 xV+DG9qeFj9HlFmFu/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NyBTYWx0ZWRfXxj2rYwvbTn2o
 ySXKhNtnr3uUNo2NJyXm2x7AykV7aa7B7bRXRkDRtVgZmREDZ9W8xMlDk6bIJ0V8Z9FdLZGRcNI
 ZU+sO1VZMpVY3TjLel+aYaz3lR9ep1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303980-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:rkannoth@marvell.com,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 683156F37E7

From: Kiran Kumar K <kirankumark@marvell.com>

Hello,

The patch resolves an issue where a VF changing its interface
state could inadvertently delete the RX promiscuous and all-multicast
MCAM rules belonging to the host PF.

Changes in v3:
- Drop patch "octeontx2-af: suppress kpu profile loading warning".
- Drop the change based on the Sashiko review comment that both APIs
  already use FW_OPT_NO_WARN, making the switch from
  request_firmware_direct() to firmware_request_nowarn() unnecessary.

Changes in v2:
- Rebased patch 2/2 to resolve a merge conflict on the net branch.
- Patch 1/2 remains unchanged.

Harman Kalra (1):
  octeontx2-af: fix VF bringup affecting PF promiscuous state

 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1


