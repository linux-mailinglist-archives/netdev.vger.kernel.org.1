Return-Path: <netdev+bounces-293702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDweC+NuHWp/awkAu9opvQ
	(envelope-from <netdev+bounces-293702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E561E653
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726E5300AEDD
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0036A342;
	Mon,  1 Jun 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Dm2TqH9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B02264D3;
	Mon,  1 Jun 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313819; cv=none; b=o8jzMj1hXk7wbIKjfGnAIGu2ZJhi3va85m6S4OpmUtiSWwGIs/RhWfJHFeBsCtCgojYuEqWjRatufalTkqmCaEXCitsNo2FLJJt7DUD+QRrfpR4MnDb7mwVHsSRs4Bc1dxzbKssyHrAoB3yruTNEV4FBsa7XAbXJcddnEPEzIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313819; c=relaxed/simple;
	bh=znJ+HCcdCCJ1GWfD6FnKm0pxoLp3VnESK/ltQa2LJKw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebsrMDI2apQK0JZRXA1hrHGWovylgxw1wXtESx4Y9vof6OXA3Rkxsvb6Z3Xy/Drsn3XJvKVFLTu0C+LtQgDCy7MBZhz++5a+OBe5cUY21mqYVvvODkvdLBV/95R92LhrqAVFOLajeFjxyXCZHLGwi9g3EuQEA6w01qTsDsQooaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Dm2TqH9Q; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f2760e05dae11f18dc8c9802ae25ab1-20260601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MHZjnI02OfF6YizpdL3PN+VzTcT2/Mb5aOfBNWzWv0U=;
	b=Dm2TqH9QEzJh8ciVU0mpqBhBppvENDBp/vOMqYw1EtupfSb8TOiaQ7kgLZ9kAdBhGsrKsvFyXTAWJeYg/NTi5SbtvbsyBwdWuwObNXp3BteB4g39srL3oluBePMq+8JCcFSbFNZaPitKBHUuq7XEMWSMoFuYJG7sHlcLn7nxXOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:4b3e50e8-61c1-401f-82e9-567f8d4377c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:0f048a30-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|836|865|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f2760e05dae11f18dc8c9802ae25ab1-20260601
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1863607328; Mon, 01 Jun 2026 19:36:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Jun 2026 19:36:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 1 Jun 2026 19:36:51 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<black-ch.chen@mediatek.com>, <ivan.tseng@mediatek.com>,
	<jianyu.li@mediatek.com>
Subject: [PATCH net v3 0/2] af_unix: Fix inq_len update issue
Date: Mon, 1 Jun 2026 19:36:38 +0800
Message-ID: <20260601113640.231897-1-jianyu.li@mediatek.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293702-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[mediatek.com:server fail,tor.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mediatek.com:mid,mediatek.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 366E561E653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianyu Li <jianyu.li@mediatek.com>

This series fix the problem that inq_len is inconsistent with
actual remaining byte count when only part of a skb is consumed.

Changes:
  v3:
    - Patch 2: Align macro definitions
  v2: https://lore.kernel.org/netdev/20260528110033.3327744-1-jianyu.li@mediatek.com/
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


