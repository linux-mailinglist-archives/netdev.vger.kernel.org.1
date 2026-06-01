Return-Path: <netdev+bounces-293840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJLDHPC1HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1366622B8D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6A2B3042910
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA33019D6;
	Mon,  1 Jun 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DBgWRTLR"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB81301465
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331597; cv=none; b=QAVtAtruQBPXJ0LtqSUroPEiD/artz34ViodVtKJEDtRzfRFxZm/6wB85bKcSkz6cw+HYnaopkleOM7gPuigrU1p1EG/pHruGEsGoyIwZF0ww+h5hv0n39dP/K1OeaFrISgQtwDSyRjKhU/ipvijQtvDvVf+6IAu0sH5ANRPQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331597; c=relaxed/simple;
	bh=gCxPWrO04yHNYpPu9+2ctvart1vc/N6TIbGgHha4yXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=k7ODdtqgBfAXwCp75Sk585/lhSYxE+4Q4PWdMCE10Bi7c4JlNzyKqIeOkMGx9Yb5Elu0VETGQljTsPfBTTSFe8fEcQtclxq9rYVklmDz6bW55FwtWBJrtoxINNU5Xv6c6gHMAudA2wOhXWx7NpDcBZVUkE6R8XPalc2TX2KvyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DBgWRTLR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260601163312euoutp01cbcad8deccf086c35e0af8c452569645~1Aia1v5af1557715577euoutp01c
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260601163312euoutp01cbcad8deccf086c35e0af8c452569645~1Aia1v5af1557715577euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331593;
	bh=nM1UYjUFsqgVpSk4nSlweLBrpjE5KgdE5dO04+x2cOs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DBgWRTLRFOXNUYkbU/Tae9BAlzYO71fgAns0GmGpdlUPr9dur5yjRwwMdFhChS/eh
	 lsmeUhUi/h/sgI2QHOwxNCxax+fK2+R4OPZ54FahymBzUr7oSq3oBAp6vcb6rzABP1
	 GPVZpBcQiw+E0LNplCsWanyPJEjmhkW8CDlUtFi4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260601163312eucas1p12744939721f71e313bc25bcc54dfe144~1AiaM-sCc2325923259eucas1p1t;
	Mon,  1 Jun 2026 16:33:12 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601163311eusmtip1d581a0f2e042d7dfedd60b0a87a31637~1AiZlKVcs1061910619eusmtip10;
	Mon,  1 Jun 2026 16:33:11 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 0/2] net/stmmac: Fix panic during interface
 shutdown & apply STMMAC_DOWN flag
Date: Mon,  1 Jun 2026 18:32:56 +0200
Message-Id: <20260601163258.554300-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601163312eucas1p12744939721f71e313bc25bcc54dfe144
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601163312eucas1p12744939721f71e313bc25bcc54dfe144
X-EPHeader: CA
X-CMS-RootMailID: 20260601163312eucas1p12744939721f71e313bc25bcc54dfe144
References: <CGME20260601163312eucas1p12744939721f71e313bc25bcc54dfe144@eucas1p1.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: E1366622B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When testing interface shutdown during XDP operation using stmmac driver,
we have encountered kernel panics, either poison overwritten or wrong
memory access, caused by NAPI processing data after shutting down NAPI.
Fix this racing condition by ensuring data has been processed.

After discussions and some checks, it seems that problem with shutting down
interface during NAPI processing is universal, but is very hard to trigger.
Originally this patch was targetting XDP shutdown, but kernel panic is possible
in every use case.
Although this patchset contains 'fix' in title, it is so hard to trigger that
it is not critical, since it requires shutting down interface during
heavy traffic and testing this requires looping up/down for long time.
It can happen in the wild, as happened originally, but reproducing it is tough.

---
Link to v1:
https://lore.kernel.org/all/20260511165045.3091475-1-j.raczynski@samsung.com/

Changes in v2:
- Split patch into two: one for XDP paths and second for general fix
- Change commit messages & title
- Fix all cases of NAPI release, not only XDP, via modyfying
  stmmac_disable_all_queues() instead of separate later call
- Drop setting/clearing of STMMAC_DOWN flag in release()/open()

Jakub Raczynski (2):
  net/stmmac: Check for STMMAC_DOWN flag in all XDP paths
  net/stmmac: Fix free-after-use panic when interface goes does

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.34.1


