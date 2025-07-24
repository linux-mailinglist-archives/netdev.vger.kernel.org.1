Return-Path: <netdev+bounces-209746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA2B10B0D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134D17B521A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE642D3721;
	Thu, 24 Jul 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u05XR3it"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC83169AE6
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362662; cv=none; b=dMNLNMfK7Ec2DYE4Hco84LIhao+1oQDWgTlfPeKxsKBjlmIbSp4mEFA0pclNKNOuCrkM9A46F1VW3KEM7H80b0NqB70Y4B10Eh9EJO+XTlGwwVrgaCLifMp8CnqQvhThQgM/8j1dJAfqTh6JUiYnpFtrHI/ESb4zBeP5xbjfN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362662; c=relaxed/simple;
	bh=w9lGBLME35MXQLK57s/hBzDusXKiX6mMash/a2GgQuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bTy+RJiDdWBgMBFxXitXOfVdzFsL1RXR/KBnLIRpv9VMiXEbush+D854zyzJZ9nojDWZ52aiaHVqFyavKmGgT/RZzAju5C9zZf6rCrtPjD7y7V8zd2BSiA8S/AAducVIrTuWURKlKGrJRcKgD4/kY8tqOTQt/3kyvrYYK2zE9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u05XR3it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED464C4CEED;
	Thu, 24 Jul 2025 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362662;
	bh=w9lGBLME35MXQLK57s/hBzDusXKiX6mMash/a2GgQuY=;
	h=From:Date:Subject:To:Cc:From;
	b=u05XR3itAzwVb+ZCCvUILp7y7ehm8KJWQqNtqK/DeZApNP8kr5zY9ajIABFFZ5vG+
	 OI6iLEf6Ri/UOVAj5SQLiPqLUL14VOZpNfdbhxeAhNqYw6gy1TolnW7HcHit4DAXXU
	 cG/7JgTn3OyhKgppDMuBBzfnVXpZ4XnwB/Ho7NP8uJKusLpo/g33jcObgFxURjWWbD
	 9Go+APRgJG37ubHsCGisjuailp5yv/Y6Xuayj+JyCn6qVqePx1O3T+FzihQTG+/se/
	 LORJNoOOPbH7m2yiTA1G2FrdaIea+rNWn4TXyud+uqkOMoNsaOZtaQXx/b9EEzvzzK
	 4krMOp4L7QDBQ==
From: Simon Horman <horms@kernel.org>
Date: Thu, 24 Jul 2025 14:10:54 +0100
Subject: [PATCH net-next] octeontx2-af: use unsigned int as iterator for
 unsigned values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-octeontx2-af-unsigned-v1-1-c745c106e06f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN0wgmgC/x3MQQqDMBBG4avIrDsQE21or1JcBP21s5mUJJWAe
 HeDy2/x3kEZSZDp3R2UsEuWqA39o6P5G3QDy9JM1tjReDtwnAuilmo5rPzXLJti4fAaB9M7793
 TUGt/CavU+/shRWFFLTSd5wVUp5pVcQAAAA==
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

The local variable i is used to iterate over unsigned
values. The lower bound of the loop is set to 0. While
the upper bound is cgx->lmac_count, where they lmac_count is
an u8. So the theoretical upper bound is 255.

As is, GCC can't see this range of values and warns that
a formatted string, which includes the %d representation of i,
may overflow the buffer provided.

GCC 15.1.0 says:

  .../cgx.c: In function 'cgx_lmac_init':
  .../cgx.c:1737:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size between 4 and 6 [-Wformat-overflow=]
   1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
        |                                                 ^~
  .../cgx.c:1737:37: note: directive argument in the range [-2147483641, 254]
   1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
        |                                     ^~~~~~~~~~~~~~~
  .../cgx.c:1737:17: note: 'sprintf' output between 12 and 24 bytes into a destination of size 16
   1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Empirically, changing the type of i from (signed) int to unsigned int
addresses this problem. I assume by allowing GCC to see the range of
values described above.

Also update the format specifiers for the integer values in the string
in question from %d to %u. This seems appropriate as they are now both
unsigned.

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index ab5838865c3f..4ff19a04b23e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1706,9 +1706,9 @@ static int cgx_lmac_init(struct cgx *cgx)
 {
 	u8 max_dmac_filters;
 	struct lmac *lmac;
+	int err, filter;
+	unsigned int i;
 	u64 lmac_list;
-	int i, err;
-	int filter;
 
 	/* lmac_list specifies which lmacs are enabled
 	 * when bit n is set to 1, LMAC[n] is enabled
@@ -1734,7 +1734,7 @@ static int cgx_lmac_init(struct cgx *cgx)
 			err = -ENOMEM;
 			goto err_lmac_free;
 		}
-		sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
+		sprintf(lmac->name, "cgx_fwi_%u_%u", cgx->cgx_id, i);
 		if (cgx->mac_ops->non_contiguous_serdes_lane) {
 			lmac->lmac_id = __ffs64(lmac_list);
 			lmac_list   &= ~BIT_ULL(lmac->lmac_id);


