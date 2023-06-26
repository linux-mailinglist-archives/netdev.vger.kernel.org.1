Return-Path: <netdev+bounces-14083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3173ED0D
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B796280E84
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744B1549F;
	Mon, 26 Jun 2023 21:46:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4014A82
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180B8C433C8;
	Mon, 26 Jun 2023 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816002;
	bh=kNlt57kfoTRNbVJhKEJCmh7u/FMjIyTPyNK0rg+vYRc=;
	h=From:To:Cc:Subject:Date:From;
	b=PzPwHrcpH2zzuPnwKiU4HR2fidJpv9iORp5EHZi6fXsKAnxVm4GQoniL9qmvX3xie
	 fYofj+J5x0exu7OTZ9KoRxf6ostb+m6RZekZWqP0PR6T9yLhtpS1ORII+wqmwwds7W
	 JQHw06ocTbcD+m11I9m1dIAzknZZKiZhPOLHIuHaMOqGUE413ir3VDEobMhgu6yowl
	 TP/o//sODwmnTMKeZS0tH86pm8r1BmMBosBdtEn2+BurMVpVMWFlzt7GxFdR5BxZsY
	 suCNw6qZL+AocAbeVW7/nf8ZKRByI4BTpXPV9v7av688dc61SLH/aBUAyKG2WVT0aT
	 ydo27rMHey4MQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Russell King <linux@armlinux.org.uk>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] phylink: ReST-ify the phylink_pcs_neg_mode() kdoc
Date: Mon, 26 Jun 2023 14:46:40 -0700
Message-ID: <20230626214640.3142252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stephen reports warnings when rendering phylink kdocs as HTML:

  include/linux/phylink.h:110: ERROR: Unexpected indentation.
  include/linux/phylink.h:111: WARNING: Block quote ends without a blank line; unexpected unindent.
  include/linux/phylink.h:614: WARNING: Inline literal start-string without end-string.
  include/linux/phylink.h:644: WARNING: Inline literal start-string without end-string.

Make phylink_pcs_neg_mode() use a proper list format to fix the first
two warnings.

The last two warnings, AFAICT, come from the use of shorthand like
phylink_mode_*(). Perhaps those should be special-cased at the Sphinx
level.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20230626162908.2f149f98@canb.auug.org.au/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Russell King <linux@armlinux.org.uk>
CC: linux-doc@vger.kernel.org
---
 include/linux/phylink.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 516240f1e950..1817940a3418 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -105,11 +105,13 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
  *
  * Determines the negotiation mode to be used by the PCS, and returns
  * one of:
- * %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
- * %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
+ *
+ * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
+ * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
  *   will be used.
- * %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg disabled
- * %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
+ * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
+ *   disabled
+ * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
  *
  * Note: this is for cases where the PCS itself is involved in negotiation
  * (e.g. Clause 37, SGMII and similar) not Clause 73.
-- 
2.41.0


