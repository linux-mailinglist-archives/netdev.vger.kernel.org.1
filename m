Return-Path: <netdev+bounces-239513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CEC6905D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7071D4E2BEF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA86302748;
	Tue, 18 Nov 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="N2m+80q7"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571D2D7DD4
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464551; cv=none; b=T2cZVkDlbNaGD5b8f1+0CXy+6SE9HKevsnTDlzf7seyElR7sjIR+jE9vsFSeWoa1gkSeP3x/4pt5CMxj+Chl4dwbZR67UPyOICX17gNqqjWVvleBC8EfhacRe/FQDKoAUM0VHuRNclELaN2ee/R52NAvb09IAXZw44d3uRKoWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464551; c=relaxed/simple;
	bh=ew0aP0bvMHyPMYbat48QyRB7oX1N7ecozFNqjhH1m8c=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=bAgrOakFHpQwV/ehsUH+s/s0cSrElukCdaeGQxmNGRP+eBI0XEC4C26NigaqqpHMDBkAsuckg0D8zIEkrB3QkadUSuBCIQxCFxsJoF9arzdM/A1n4gVtZXCgnpDl3r4BBopk4rJpmJJHfUxFro/j24cTIixdI4FDo7V8F2h6m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=N2m+80q7; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=6STgneLtsH+LacyzRoFNleqoBW/c2hZSvz/okXx5/74=; b=N
	2m+80q7lPe9DIL2z73ht72x03oNJyoj48T3t40rsGEpUjYujXPxPp1WTkPzqGF4NokZFJQHy4Y1cI
	8Wye4j5YpBEMnYHRHDGFTwybqC2Kr7gEyH/Onb573L32CJVhYHlnXQ1ayvBrP5czyTZCLIdUJ+rLR
	OKtVJ44/Oa8Ls5y+JUvJDdYOla+jF4jpXL1sL6M+Xmu2SPl6erN7taUruNCwSM8KsqWmO7shq2VqN
	QJsdB7xjzs+HeXPX2vqrB/BWWj1FHpwUP2FEfPIIcBeBM+/faFpwZ2SUzCvaJE2L9GGaiyzProEsx
	YF6b1GHUh2SyvYmCVrkI9tQ/qwYgxKIsg==;
Date: Tue, 18 Nov 2025 12:15:56 +0100 (CET)
Message-Id: <20251118.121556.485782007294139002.rene@exactco.de>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH V2] net: 3com/3c515 fix build error
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

3c515 stopped building for me some time ago, fix:

drivers/net/ethernet/3com/3c515.o: error: objtool: cleanup_module(): Magic init_module() function name is deprecated, use module_init(fn) instead
make[6]: *** [scripts/Makefile.build:203: drivers/net/ethernet/3com/3c515.o] Error 255

Signed-off-by: René Rebe <rene@exactco.de>
---
v2: git-format-patch
---
 drivers/net/ethernet/3com/3c515.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index ecdea58e6a21..1cb94423db72 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -1549,7 +1549,7 @@ static const struct ethtool_ops netdev_ethtool_ops = {
 
 
 #ifdef MODULE
-void cleanup_module(void)
+static void corkscrew_cleanup_module(void)
 {
 	while (!list_empty(&root_corkscrew_dev)) {
 		struct net_device *dev;
@@ -1563,4 +1563,5 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+module_exit(corkscrew_cleanup_module);
 #endif				/* MODULE */
-- 
2.46.0


-- 
René Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
https://exactco.de | https://t2linux.com | https://patreon.com/renerebe

