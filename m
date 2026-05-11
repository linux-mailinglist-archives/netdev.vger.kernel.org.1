Return-Path: <netdev+bounces-286747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCJ5GRwSAmqIngEAu9opvQ
	(envelope-from <netdev+bounces-286747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1ED51374A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD1C330B2E96
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2E43DA50;
	Mon, 11 May 2026 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lwvNUVCH"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06243D515
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518474; cv=none; b=suMt3eVe8bVUdHrazYOG07k3nJN7FaT35C4nSN2ZpvojTQoauGNmUjQ5bO+OWa+vCRE6aBSH79DULJgcujpntkSUSJpHdiz2VwAKF3fgT1UWGbWhMrbQnqr/2dzLcw+SPfzf0JpSIVx+EEFaVPAaoMTWHLQeGTVqd9Y4VYFnfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518474; c=relaxed/simple;
	bh=r5eHCP7rNq9HIwxsZU9jp+giwHXdYcUAKOJxfxHvCyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hPOw/1KvjfCsBTdJQRpl1Ncf+tecDs3+gXjdyBbZ9iMJo71/paP6rjsNASl4ETh46tgCJh69tOCp2DA/Pz+cjGCC71TQNOj2E9N05V0NM9vW7X+9gmme1PDqGd9mIvTjPqNOtCvLIUevNW4fK4btHQ4aHKKaSnP3zZkaFV8oS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lwvNUVCH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165431euoutp02e995e6b6e6a1b2b0758c604341914f78~ukSBosRJu2270622706euoutp02Z
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165431euoutp02e995e6b6e6a1b2b0758c604341914f78~ukSBosRJu2270622706euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518471;
	bh=uZPkYNKUuqVZHm5wcyPwbUV02wridxyiun39DDJjZhU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lwvNUVCH0QsVAzWhCT5Uihz5+K3urChpk7dNJHLXVd9gpo6E8Q/kZEf9L54oyVjmY
	 MVaua2s/L3mTEl/MHhFOyd0a2AfDcLaNqenBXayzWDp50dU3Z4sDPB5VSCtXjtN4wR
	 InJos7vKTsz/1l+T7RsFf3nBlSPuopBlxbP7HPVE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260511165430eucas1p2d91808b8aa51316842509f19eea4a0a8~ukSAxlW6c3106631066eucas1p2k;
	Mon, 11 May 2026 16:54:30 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165429eusmtip1504fd4f2fb1d123be44ac24b595466f2~ukSAG-wKs2784027840eusmtip1D;
	Mon, 11 May 2026 16:54:29 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH net-next 0/3] xgmac: Support for 16 MTL/DMA queues
Date: Mon, 11 May 2026 18:54:13 +0200
Message-Id: <20260511165416.3093015-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165430eucas1p2d91808b8aa51316842509f19eea4a0a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165430eucas1p2d91808b8aa51316842509f19eea4a0a8
X-EPHeader: CA
X-CMS-RootMailID: 20260511165430eucas1p2d91808b8aa51316842509f19eea4a0a8
References: <CGME20260511165430eucas1p2d91808b8aa51316842509f19eea4a0a8@eucas1p2.samsung.com>
X-Rspamd-Queue-Id: 6E1ED51374A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Action: no action

New XGMAC datasheets for XGMAC 3.20a and 3.40a list support up to
16 MTL/DMA queues. This patch series does modifications to accommodate for
that, by following:
- Increase MAX value macros (this will increase memory allocation for driver)
- Add missing registers
- Modify/fix some functions to split TC and MTL/DMA

Biggest issue is that new hardware does support only 8 TC (traffic classes),
while supporting more MTL/DMA queues. This is problematic, as current code
does assume that these are equal which is not true anymore. Fix that by
applying better context to functions, using TC count read from HW_FEATURE
register where it applies.

For DMA/MTL queues higher than TC count redirect traffic to TC 0.
This is error in user configuration but quite possible to occur,
if user does 'one DMA/MTL queue per TC'.

This change has been tested on XGMAC based on 3.20a,
checked with 16 and 8 queue setup.

Jakub Raczynski (3):
  net/stmmac/dwxgmac: Modify DMA functions for future hardware
  net/stmmac/dwxgmac: Extend MTL/DMA support to 16 queues
  include/stmmac: Increase max DMA/MTL channel count from 8 to 16

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 58 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 17 +++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  5 +-
 include/linux/stmmac.h                        |  6 +-
 6 files changed, 80 insertions(+), 9 deletions(-)

-- 
2.34.1


