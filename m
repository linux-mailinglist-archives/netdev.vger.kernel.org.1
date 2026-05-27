Return-Path: <netdev+bounces-292109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrYNieVFmppngcAu9opvQ
	(envelope-from <netdev+bounces-292109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:54:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BB5E00E5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B412C3003719
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40693B5303;
	Wed, 27 May 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kAdjz4eo"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3811A08AF
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864847; cv=none; b=kc6ztxTs7UlWKnTFvq2xC2RLP6nPTqXYT1DNdGyohGITWoeTvqbshOwnRVO2fh/uxd5Af+8Whhe9iFnj6z/EJinGMPmdSA8vadhgc9MXrUTCnbbTQavMRx+quRMOWY8PVgmyzacGIP1LbB2t4WRivzeHlyT6RmxsVDbZu9unvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864847; c=relaxed/simple;
	bh=yEQwL3MUelaw6hKSCMnzIE/HbZBXjhlrn/C4wcCtYKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+z2GtowA3gAhj0PL0+mDPIPF1moc7iiTmt9TS3xL/ZFc4xYozqJjJmUeYR0BaI5AJo4cMIfAKwWXg8zDBJcKUL551FWq7M+e9SElWaTazEJdW7b39noSmeTOf07BXHsnaDhf6IA3ygH68kHSIPsA6mBhPL8bBewRoOpzJVqWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kAdjz4eo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2888576599811f1b1788b6acf885367-20260527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T3IulHUKib8JGWnWMEWHwbse8Aex4qYCKxD3FE3iZdg=;
	b=kAdjz4eoG1iroKQbNr1e7L71KGla+bnnPbHxZXppBwaUsQmVlsEdZ7gcKgi4+nTXW1r4WeGKPRstkKd62i64nRldUDO8CzEoDVWkIMFSKpDrxZ5ecCEZYKENCQnChyV9Nxmd25X9Jjed58AWcWkv4MSSUUeECpFU7cIN6Zqmx5Q=;
X-CID-CACHE: Type:Local,Time:202605271431+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d4aa7c4c-6c09-4a7c-8c33-4047b55f2eb5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:acfee8f9-9444-476a-bc04-9e12dce7d69c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|836|865|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2888576599811f1b1788b6acf885367-20260527
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 145209192; Wed, 27 May 2026 14:53:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 14:53:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 27 May 2026 14:53:51 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <black-ch.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <jianyu.li@mediatek.com>
Subject: [PATCH net v1 0/2] af_unix: Fix inq_len update issue
Date: Wed, 27 May 2026 14:53:40 +0800
Message-ID: <20260527065342.2463433-1-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292109-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C3BB5E00E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianyu Li <jianyu.li@mediatek.com>

This series fix the problem that inq_len is inconsistent with
actual remaining byte count when only part of a skb is consumed.

Jianyu Li (2):
  af_unix: Fix inq_len update problem in partial read
  af_unix: Add test for SCM_INQ on partial read

 net/unix/af_unix.c                            |  7 ++-
 tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.45.2


