Return-Path: <netdev+bounces-303449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eA9qJxOGRGoAwQoAu9opvQ
	(envelope-from <netdev+bounces-303449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 892156E9648
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="cW/8xCQH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303449-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17D613011382
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D9367296;
	Wed,  1 Jul 2026 03:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699B36683D;
	Wed,  1 Jul 2026 03:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875660; cv=none; b=E0KiBTQ+V6Due781kJ5narBrynQlvvIxTV+HUZ7S9G4E9TOxX5NQHvrB8RRsiqyZzZIbse0ng9S54GybqroQynMkeeNHbLCLMsESg42ZZiFZDUtcyIYGoYvsxdA6ntxaBfLmtubumxLcwDtH1uXF4WpgQvGk5G0t3DjOP/3cQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875660; c=relaxed/simple;
	bh=mLBRBdn2eVFYhHW5dubjZli7nOaoNSfoT+oxa5Y9w/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wio/qXtGVN21c1PmZLclmxWN4PCN8KKvtGsjN9/TfNGGZbUFrem0TSh3k4QG7NSVOdeYXJKXlLeFZw72Z5lnCrxVFxIGrnzM0z+2vszmeBYf2WdqXfE86YEZ/jEcLUOIoDcz5cunM8FyI2sBdEBTqOaEtLcawlZpfYMXKC7KsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cW/8xCQH; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612vnq32207555;
	Tue, 30 Jun 2026 20:14:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=XCIkOVAOaX4hjihCf83uoeE
	n9rqPncTt15Wnd0o0Kw8=; b=cW/8xCQHNDb7eRdYe9H9TT4N7ul6Q2ZCak4c8WX
	ebxALaQkWRkPL8FGL0OT71HJvqEZW0SNLDeTDjQoAvtcUL6laz4VpyP8JZtqmNoa
	bpInE6QfZ6rZcihbyNR6pFNyJ/20ERorQQBxYsakQom2tclUroQz3sLdp/RhjBiF
	/Iy5G/1A9AkMvhvumF3OpTr6QHIOmynckiSSrVqKKol0HDCgu/OHkDY31wMBr6at
	gU0zz0bPy1gNMOP86Lr3AUrZuydeHmWyonC1osU4Otf7PTFT8BQiphqaKz7tabAb
	kr77VsEguS6qGHHhU7zD1vv9nLsxWaXgFRcYD4XP2FgHycg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f4cty3b4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 20:14:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 30 Jun 2026 20:14:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 30 Jun 2026 20:14:06 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 77A4F3F70B8;
	Tue, 30 Jun 2026 20:14:03 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v3 0/2] devlink: support u64-array devlink parameters
Date: Wed, 1 Jul 2026 08:43:57 +0530
Message-ID: <20260701031359.839221-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=etnvCIpX c=1 sm=1 tr=0 ts=6a448600 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=snJZ9v3O13RfP-hfMHkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfX56sUVhmXeuYG
 cxKIgh6bsd3yFRsnSgZGmeG+7VzuB3caS29KjEh3AN0YhhSFHctNnOs44zNA+L55VhxURfVVQxg
 /USPklFDgUi16x00uJT9l2PcLCGLRas=
X-Proofpoint-GUID: LVY4h-kPwQTEwhNfXC8ra23WnrZuUVSP
X-Proofpoint-ORIG-GUID: LVY4h-kPwQTEwhNfXC8ra23WnrZuUVSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfX4rdQwFm+BIbR
 q8UYPTTVmJJwI85bE6bQBvmGT4CZzs5vEOMBDjmTMfBO7H7udHvAOSXZe1WwbKSj2NbRBlAT+5V
 zA2s8zFSJOt83jYAXzvRuMBD4pTftFK5LnlMMpLG8c3J2bZq9l3I/xpAfhfi42IgpyR4IsJnUPf
 AjuUOYdbvBGfEkdUuW6GK5FlRThClPc6Rnb0NDP6o8DbjXx7idpb4SSNt6RmKvqleRWEINvfU3h
 gfBG6uJbISga9hvbOl05WoG+Nf2w4Ldg+DXCiQQEus3fyXVoYM6/lBijkaAeS27rbq50+Xib2Lu
 8zxnLXeW6nHWcAADfDUnatO+bM4munwgFbEe5Uu+Iw4ePLzza4Gs+6pDuQ1ud243SYvuqYfzEBb
 92grE2UCAytTcSLdN4YLJt4kDtcfPJ7TRIpOKzcBt09nchf4A7B0MsA3IrFtxheg+o9On+MSRIi
 A5Vk1EMm9NI4WxXESng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303449-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:mid,marvell.com:from_mime];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 892156E9648

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
v2 -> v3: Addressed David comments
	https://lore.kernel.org/netdev/akSCBN0N_7ug1-Fy@rkannoth-OptiPlex-7090/

v1 -> v2: Addressed David comments
	https://lore.kernel.org/netdev/20260615041042.549715-1-rkannoth@marvell.com/

2.43.0

