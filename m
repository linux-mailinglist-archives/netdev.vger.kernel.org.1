Return-Path: <netdev+bounces-23518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90876C492
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3956C1C211EB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9410F1;
	Wed,  2 Aug 2023 05:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76B15AA
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A3CC433C7;
	Wed,  2 Aug 2023 05:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690952762;
	bh=vIsmaLOHNHCmvZTxuykbw4hyJBbUacnWk4VvMmzUK9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGoDdwO7hOgoCxkDVBaD4hulYPoImelxdjPjcsAzBC2Hck8e6L1owP4Unq/187OVz
	 AaStDAYVHCuEzbXh3yndCl5XABgFRv/5KrYue7+slumcRYB7WQ2g3CME5mdZ+llh66
	 jII4nKJ7g63cth/fX997PJyM8Kry7RBTy31bDAp+MWEwX2BfKZg4uLn9TWVJWWQtP5
	 oKN++/7yTJTf5yp54Xz8LRF10QeLPhaJaOBXF8ivvu+VLabPMa2Nnf3KHILWMn692S
	 Xb3thfwhybIBYbI34Btvu072VaqksAauTVZoOI3ndEnrtNlYosLlTpWYVOr0c8x5TY
	 woBuhwwh0qrpA==
Date: Tue, 1 Aug 2023 23:07:06 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/4][next] i40e: Replace one-element array with flex-array
 member in struct i40e_profile_aq_section
Message-ID: <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690938732.git.gustavoars@kernel.org>

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_profile_aq_section with
flexible-array member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 010261a10f56..b9d50218344b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1524,7 +1524,7 @@ struct i40e_profile_aq_section {
 	u16 flags;
 	u8  param[16];
 	u16 datalen;
-	u8  data[1];
+	u8  data[];
 };
 
 struct i40e_profile_info {
-- 
2.34.1


