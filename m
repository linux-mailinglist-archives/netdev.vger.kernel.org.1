Return-Path: <netdev+bounces-293835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBWhHY21HWredAkAu9opvQ
	(envelope-from <netdev+bounces-293835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:38:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A116622AEA
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541ED300A63C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518932F0C48;
	Mon,  1 Jun 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t4ZerL+3"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F962D7DEF
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331189; cv=none; b=ZxUPr0zfo5zfyfVzuVTB7+PhVXaXy7YJai89MuX1Ld88rrw6/9C2UOgX6QzY01yVhhvidZo8/VhR8Zqvx9OpnBW0K9tmccO0RL2PVkDdLNFSHAO60LPEvMwcrtcAoNx7JuHV0hc6m597tgdLWEr57UodrQOzk39IKKw7Da2zLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331189; c=relaxed/simple;
	bh=2ILxi6sLoKrLroNCKNtFsKLEyMXxMsNKStp5c2Atbqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=EQzIKjwa2GZ/pt5iloDXG1AobWxmK/trS0hrNeMvUd/nRFxDmm3VMfacuQOrLqu/tlfp6ls7bETRsodBTjPoQM6uN9iMLkFBvg7tc5jpCYAo9oKL0PbCRcmaCfOpG6djreyUzrAgeK0+vWqxmmEnLjd/Fj+xcmqpPrBZkY7wWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t4ZerL+3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260601162617euoutp02f54cb2486386b773a383c521f1a2ba6d~1AcYCPTTI0606406064euoutp02c
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260601162617euoutp02f54cb2486386b773a383c521f1a2ba6d~1AcYCPTTI0606406064euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331177;
	bh=6qQRLbBkdKCwMbmSPKvfDONDSMKNMiDbKbY/Uct08dI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=t4ZerL+3N/lyPmEQYURdkg8UvUmzsKXUAh1oBjA8NDrtoEKSBfWEUbG0kol1OJ1Xy
	 nlNE3c2iNWEygP48CYVXREEobqPlvzXSDf7+kO67QJywuZWwlAjhLH8znGizL446pj
	 KnqTb9+UT5rBf/9LwVdGM3XKNpWUohxUdDhEKewQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260601162617eucas1p2efc386a4d9f9e7e98e8acb83f9c550d6~1AcXr2QwO0269202692eucas1p2T;
	Mon,  1 Jun 2026 16:26:17 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162616eusmtip13a721d88365eb0e92597b7024e014df5~1AcXEWt-s0485104851eusmtip1d;
	Mon,  1 Jun 2026 16:26:16 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 0/3] xgmac: Support for 16 MTL/DMA queues
Date: Mon,  1 Jun 2026 18:25:34 +0200
Message-Id: <20260601162537.553512-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601162617eucas1p2efc386a4d9f9e7e98e8acb83f9c550d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601162617eucas1p2efc386a4d9f9e7e98e8acb83f9c550d6
X-EPHeader: CA
X-CMS-RootMailID: 20260601162617eucas1p2efc386a4d9f9e7e98e8acb83f9c550d6
References: <CGME20260601162617eucas1p2efc386a4d9f9e7e98e8acb83f9c550d6@eucas1p2.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293835-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 0A116622AEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

New XGMAC datasheets for XGMAC 3.20a and 3.40a list support up to
16 MTL/DMA queues. This patch series does modifications to accommodate for
that, by following:
- Increase MAX value macros (this will increase memory allocation for driver)
- Add missing registers
- Modify/fix some functions to split TC and MTL/DMA handling

Biggest issue is that new hardware does support only 8 TC (traffic classes),
while supporting more MTL/DMA queues. This is problematic, as current code
does assume that these are equal which is not true anymore. Fix that by
applying better context to functions, using TC count read from HW_FEATURE
register where it applies.

For DMA/MTL queues higher than TC count redirect traffic to TC 0.
This is error in user configuration but quite possible to occur,
if user does 'one DMA/MTL queue per TC'.

This change has been tested on XGMAC based on 3.20a.
---
Changes in v2:
- Remove newly added num_tc value, replace with stmmac_priv pointer,
  to use numtc value from dma_features struct
- Change all new WARN_ONCE calls to netdev_err
- Add Signed-Off for colleague that did similar original patch internally and
  took part in new version of this patch
- Apply recommended change for switch case for readability

Link to v1:
https://lore.kernel.org/netdev/20260511165416.3093015-1-j.raczynski@samsung.com/

Jakub Raczynski (3):
  net/stmmac/dwxgmac: Modify DMA functions for future hardware
  net/stmmac/dwxgmac: Extend MTL/DMA support to 16 queues
  include/stmmac: Increase max DMA/MTL channel count from 8 to 16

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 65 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 15 ++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 include/linux/stmmac.h                        |  6 +-
 7 files changed, 85 insertions(+), 9 deletions(-)

-- 
2.34.1


