Return-Path: <netdev+bounces-166312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8DA356EE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155711892539
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E71FFC4E;
	Fri, 14 Feb 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="w/KpCZy0"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4941149C64;
	Fri, 14 Feb 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513779; cv=none; b=WEhcmGfhUfCFOk6Q3pJXngKHpa02Ix48TyHTIyKeS5GR2jaPKJGWcq61vH8Q2Zdiu3luWeopPDINhQPhUOjvuxBqpsQqJBWpTXpKMjlMOayjHdTk5KQIK8ecAbGP7YV8x8/p32aKnbhe/6KRH8HlOUtd18xvDCfWKWRL2RpLpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513779; c=relaxed/simple;
	bh=x2Z55WN/bolhypsMCgfZrcr9/UcmIPhudFFRNZuvWEg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nkgBYhkDNRgOmMw/EoXqtZ82UEkuLER7obcBG11htgiaznNEyXI/7ctqIBHdkgdhskLrI7qIqKDm19ykrzFsKbQ/s4Kkfjw4qC3gh7IpfHgYXI9f2knnFzEfv63epcr6MDc22F3fIn1pHuxMRBC2S9O1MhrCB5ZlPL69g+vpIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=w/KpCZy0; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739513470;
	bh=I9tMxA0b35Ehfj2sW9QpEMSfeMBVVc4pqXPgNUSyFJI=;
	h=From:To:Cc:Subject:Date;
	b=w/KpCZy0aWUOFHdBAkYlMqQCljvDhY7b92Qz+comKXMpNf/G89XWHheUEXMH5t+0X
	 x06sv6SAJ4dadI56gqfYVW6x9+fEq6sZRfQQlhh/ACOEwJIFVz8urL5sXRx/KxgLBw
	 RI/5uQRBS7+NhkvcaeRIJjB3bn5/Khn/nL7cS/38=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 2C88A6BB; Fri, 14 Feb 2025 14:11:08 +0800
X-QQ-mid: xmsmtpt1739513468tg3oqmv9r
Message-ID: <tencent_832FF5138D392257AC081FEE322A03C84907@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiehVxo+faJzMBrZMJ7TGsCOUlN4TBw/pxiWd3JxEndMuo3xdDyMB
	 hw5nZTeA8kHAXi7hoIcWIWLCkCMSXVA1V0O/T5Y3RuToIEUY0hTdcgQb08vo3LhJXKsfC/JAvHfI
	 dFlAWCttNdr0V4trtFUMRcXnyH964UhkOzb51/bZfoor6r0FE2f9UE5YpxX23Di25YQaAxO92CP8
	 Iooke+oYAazomDNH/ofk9CYXzM7PWpS3LueiFgK2e4sYNBJwAD1p0ggeJ0w7cBQI5nTRJ3/FDl+p
	 qXpgEjcHKK2keiab4mSAS8b42zMoQoPLh5J7lpAOR19p0C6Y571Ut1RFfO8Omf9nvA+1xTe6f50z
	 aPB1LPh2k8dFdMKfrKyseGDSs9y8rruJGtcYvHKLtjdmFtirUK5ERtB3UlnFYv2JnXesFYeBqcg6
	 BxOtiLc1Dx5wUCEWorxZxyLEzC/LBHrjr8RzA7jcElNt1TwfAcb6Ot7QEVnb38LH6O/xuJT2fNG9
	 629mM3h7fo7+BL5hS164+RWu94Qk3xXaNtzcRQAuc9f0BCg6HlS8QrIjTUDG234gtklE/UKr/WhP
	 te6CenuNctvR3b+WXNAmV3Tj6s1Xd63QDpNhtNd0uFf0we42I9EabA9cvuHqWxGLjmUiDinwhStd
	 QCLf5Kk/h+n+p5AhXFoQ0xui7AhcQwkap7EAJIR6ml9cu/gelcHTcS9st2JiNamIIwMhx7GOm7Nd
	 vPv/Gd5+/xMlLsx+zX75NAXtr/M9vb6eulH7KVYwuscVqFFqpnATGfv0X6ewFENr35Sk4CmAalXH
	 tdvlO66UxWeQbpTOqoG5v5la1zDSixvPfW101WnC8fQgKxSgha6LOEj6Eda7axYH+zT9+V+hmbvm
	 zDVyI7Q5g6Cd0LKk3uL36EOhC+x59LzSAecuUmSLPTAFF0p1ZEwsFo7ZHJSFBDjBMKLF2Ef1NaE3
	 AfAvZ+qmc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: xiaopeitux@foxmail.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] net: freescale: ucc_geth: make ugeth_mac_ops be static
Date: Fri, 14 Feb 2025 14:11:07 +0800
X-OQ-MSGID: <e940237592fae0d6e8e32d6b61b4ff18724dc918.1739513279.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

sparse warning:
    sparse: symbol 'ugeth_mac_ops' was not declared. Should it be
static.

Add static to fix sparse warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502141128.9HfxcdIE-lkp@intel.com/
Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f47f8177a93b..c24b2f75435f 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3408,7 +3408,7 @@ static int ucc_geth_parse_clock(struct device_node *np, const char *which,
 	return 0;
 }
 
-struct phylink_mac_ops ugeth_mac_ops = {
+static struct phylink_mac_ops ugeth_mac_ops = {
 	.mac_link_up = ugeth_mac_link_up,
 	.mac_link_down = ugeth_mac_link_down,
 	.mac_config = ugeth_mac_config,
-- 
2.25.1


