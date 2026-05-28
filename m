Return-Path: <netdev+bounces-292657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIfdEr8gGGocdggAu9opvQ
	(envelope-from <netdev+bounces-292657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:02:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF825F1022
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62E273014241
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3013DDDAB;
	Thu, 28 May 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uJDVA/rI"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6063BD62E;
	Thu, 28 May 2026 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966061; cv=none; b=V9MIc3ivPOazHq0gK5jEpVHnjwp8pZAn6XdHI2mz72ilsGqTlWJFgxhZWJjixxbTk8L90NhPH2aIdP3JJqhMkGrG4KMzJ5dI2v5V1EBeW8hdC/OpJE4jKA1SPRx6GehUdmQwvRJtdB4ykDd1lW+wBgBxf11jRslJ+ZgsCJGF0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966061; c=relaxed/simple;
	bh=QvOe88gTykryw5lGzTzbWYFvWNRUObZ1n+QrML7jmTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OnynRQPE4bfFMevG0X0TyyBF5GI2uVnxTMling4qekDLeoKvj8MsyVmQ12TmmbR3/m+9s72hI42k2QMxWelFc6yNephVCX5MYhCDvFPtyyvzw+dNnFaqaDElc5MmoC7WCpvRWl+pGTnwhuj4CTgBk2lU8zHTxmCQTTmOSPSMgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uJDVA/rI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7ac2e06a5a8411f1b1788b6acf885367-20260528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ekG8ShMKQNg7cLZxq59sSFmJlRmeV8kuINu0fz0yaQM=;
	b=uJDVA/rIokan6/nAomF29j/QX8Rjt37yLFcjM61+A6D+hKgSSeL/1kgYS249srhOUQZ9HbRxr7MDkZolkR/iKAFL0iBnN4/UIpBz///UCcfuEFmT1NE3JKRHaurm5i+gQvtfQ9fKsj9U7R4ONZs50QIrj4LqGNWvVNND6WASqIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:c258d36c-68bc-4e52-86cf-9fe9f6480aed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:291c3b01-8ecf-400f-ba4f-4c5e0901de3b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|836|865|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7ac2e06a5a8411f1b1788b6acf885367-20260528
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 799363041; Thu, 28 May 2026 19:00:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 19:00:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 28 May 2026 19:00:45 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infrade>,
	<black-ch.chen@mediatek.com>, <ivan.tseng@mediatek.com>,
	<jianyu.li@mediatek.com>
Subject: [PATCH net v2 0/2] af_unix: Fix inq_len update issue
Date: Thu, 28 May 2026 19:00:31 +0800
Message-ID: <20260528110033.3327744-1-jianyu.li@mediatek.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292657-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mediatek.com:mid,mediatek.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BF825F1022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianyu Li <jianyu.li@mediatek.com>

This series fix the problem that inq_len is inconsistent with
actual remaining byte count when only part of a skb is consumed.

Changes:
  v2:
    - Patch 1: Improve lock usage in unix_stream_read_generic()
    - Patch 2: Follow reverse xmas tree ordering in partial_read test case
  v1: https://lore.kernel.org/netdev/20260527065342.2463433-1-jianyu.li@mediatek.com/

Jianyu Li (2):
  af_unix: Fix inq_len update problem in partial read
  af_unix: Add test for SCM_INQ on partial read

 net/unix/af_unix.c                            | 11 ++--
 tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.45.2


