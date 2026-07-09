Return-Path: <netdev+bounces-306032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCHeE4YbT2q2agIAu9opvQ
	(envelope-from <netdev+bounces-306032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:54:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC972C765
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:54:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=GvepRLZ6;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306032-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306032-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B887300AB10
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0043909B1;
	Thu,  9 Jul 2026 03:50:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F242439356;
	Thu,  9 Jul 2026 03:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569046; cv=none; b=t/G9P1Zi3+zrwW5/tpajTYGs2TRiUfnw8a2SDWMPzZCWUuMqOnmLiALWHAdHabfTPjrA2ZEwnuUNHfog+mZo1g+8uJeda+qlzBwlZ2bBtUO9HUR9BHQo9jDnhceTLK4iUft8Ze3vWl80mc+QUNp6cT5iRjsmrFlp/B9kB63wwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569046; c=relaxed/simple;
	bh=/iHvGdnTeRp/LcE0jChmjN05P70awTVS6atAj0gNTxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PdALUtSb7+vazHQkAKf3BPtiECJBPrWyEJHWHkLBCpiYN7ZFrdtDEjoJQUURroOC/Tcjw094XV4d1wSslIcsm84TnOyriukJWINZrgsvytDcco9YQI+YTaDMmAy8P37HsxykpmivrH5+YA64S65dow20TpVvKN1TgYt8l2rwKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GvepRLZ6; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8Del1377871;
	Wed, 8 Jul 2026 20:50:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=M2VAQ+X5i5RfYU/nDi+XBBY
	e3Z613YtCEOx4j+LDmZQ=; b=GvepRLZ6xmeo/bo6CnOoAWUdJO5xubNeX8GjDEH
	ABGpZ6P+5xsixoIpVaomGjD7Zd3gnh1blumU3BtShfy0vH4P7MS1jq6DOqd3BftO
	nYSPNM1Z/m3F5K4OtSaCx+qpY3PjxMmFyMgg2GSFQB7IP1x8iWuKrATr0YMr3Du8
	8AhoK4vEFe1NSSOIij+JewfEvJiLKbe/1ooQLZ5h+coWn13pG9MriwDHNqLMHeLi
	LCB4PyQHkI2QM34kvkhjdn6LpZ6R8hdJ9NXdPUCRxC7VMXjrFfQw8myJNU8Qcm3x
	71nF38uEpQLYII/ykabY/Dv9SP1d5OVFI59CGSnuchS3Q7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f9n39aw8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 20:50:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Jul 2026 20:50:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Jul 2026 20:50:22 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8E0533F7096;
	Wed,  8 Jul 2026 20:50:19 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v5 0/2] devlink: support u64-array devlink parameters
Date: Thu, 9 Jul 2026 09:20:14 +0530
Message-ID: <20260709035016.911607-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kM8Zt_ED8KaR1JydBTdiYNjzp1gcx8Il
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfXzr1WRhMnKo7m
 oR+5J8iUlCCBmilxYC8C0wqt7Dic2gJ33XzgKTs9N94PNVNJv6HZocAbKMxw/Xd6o6/VHI16l29
 JuTN/13+Pl3fuIUDYzMNhmoCMLc6MQ3gYDUryQxRlDYUglOmwk+SZkFFklcNZm1hU74u0lR9T9n
 cPP1YWTX9CKRLBkkKPfR1v42XveeZmf0XU+ik7I9P16Xi4swBgad6YxYnImK3Wv+VLD6dj27vVA
 cyZ1rPRRezjytvbM59BxFL3q5E1H/hGpJBc1qlx7SbNbu0I2oUxwl4JwGVqRHRQRVvxGUnXTBRi
 GQrHhO4k2fO+FLu7HMGCQKl4q+NhV6apdPjqY7frvF+iKW3LeGQVe1uLJIecNzd7jUS4mUdpcK+
 ZporTIXexODBfB7BjDwJydykMYCkWBMCBNEE7ycfrar4BV6BBuLIuiwNxpVIDGNbN7rc7JA/Pbd
 6/ooqz2ZBobZGDLCN7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfX9P2xjzXDviEs
 AnFmYHurs+UMXKQJMt5PKEDKOusV3N7MmYGBGcrE2vjg6I9In9VnO6yRsJvi9wtQsgqvgoJtBin
 qtC5qGwVEWEP06OrGTJb402H9196+dk=
X-Authority-Analysis: v=2.4 cv=eLYjSnp1 c=1 sm=1 tr=0 ts=6a4f1a7f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=snJZ9v3O13RfP-hfMHkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: kM8Zt_ED8KaR1JydBTdiYNjzp1gcx8Il
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306032-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:dkim,marvell.com:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99BC972C765

The kernel gained support for devlink parameters of type
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  These parameters carry a variable-length
list of u64 values encoded as multiple DEVLINK_ATTR_PARAM_VALUE_DATA
attributes.  This is used by drivers that need to expose ordered lists of
configuration values, such as the Marvell CN20K npc_srch_order parameter.

This series updates the devlink tool to handle the new UAPI and adds
show/set support for u64-array parameters on both device and port params.

Patch 1 switches devlink param show/set to use DEVLINK_VAR_ATTR_TYPE_*
constants instead of generic MNL_TYPE_* values when interpreting
DEVLINK_ATTR_PARAM_TYPE.  The kernel now reports param types using
devlink_var_attr_type, so userspace must use the matching symbols.

Patch 2 adds parsing, display, and configuration support for
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  Values are shown as a space-separated
list of u64 elements.  Setting accepts a space- or comma-separated list
and emits one DEVLINK_ATTR_PARAM_VALUE_DATA attribute per element.

Tested on CN20K hardware with npc_srch_order:

  # show search order
  devlink dev param show pci/0002:01:00.0 name npc_srch_order
  pci/0002:01:00.0:
    name npc_srch_order type driver-specific
      values:
        cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

  # set search order
  devlink dev param set pci/0002:01:00.0 name npc_srch_order \
    value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30 \
    cmode runtime

Ratheesh Kannoth (2):
  devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
  devlink: support u64-array values in devlink param show/set

 devlink/devlink.c            | 178 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/devlink.h |   1 +
 2 files changed, 164 insertions(+), 15 deletions(-)

--
v4 -> v5: Addressed David comments
	https://lore.kernel.org/netdev/20260702031359.2392868-1-rkannoth@marvell.com/

v3 -> v4: Addressed David comments
	https://lore.kernel.org/netdev/20260701031359.839221-1-rkannoth@marvell.com/

v2 -> v3: Addressed David comments
	https://lore.kernel.org/netdev/akSCBN0N_7ug1-Fy@rkannoth-OptiPlex-7090/

v1 -> v2: Addressed David comments
	https://lore.kernel.org/netdev/20260615041042.549715-1-rkannoth@marvell.com/

2.43.0

