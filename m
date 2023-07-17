Return-Path: <netdev+bounces-18160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324687559E8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639D31C20A15
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA0815B4;
	Mon, 17 Jul 2023 03:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE41365
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:11:18 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E45E47
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 20:11:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R46YC5ZSRzBHYMR
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:11:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689563471; x=1692155472; bh=5pfHnurrO8HEEiqTxHThC6NSN3N
	hBzCzjOJYI5fhtmA=; b=h2GkpB1WMZWKdK8hojZqWD+pucPXuDJtGi5WTY0lVBb
	i5coZ+lEWTihCBNcWXnwQj9Iex9eIt7uZVEZ1LMysRotAn6Bx1dAZweomJzKo3mp
	dq2Y/D3/LyyshaSsseLaVU5gfChwdZ8g8Ubpa2Ao2KfbFtCYswBen1goekhJLoln
	ant02pKO5vtMEonV/HYnKGCOh4wOKiEvQNEXIRtyUVMcnjpUTYC9dD+M+NQiiIAY
	BOQvd8RGOKfIYTiGH34RV9qhDSEKtH0h4Ve0pUWqnntwzCUCWsO3LHLepZgabhoS
	gUKDuFxDtY3b3nMudyY+QSb/SitrhbvrNQByy06K/iA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A9lCEDI775zr for <netdev@vger.kernel.org>;
	Mon, 17 Jul 2023 11:11:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R46YC2GHgzBHYMC;
	Mon, 17 Jul 2023 11:11:11 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 11:11:11 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 3c574_cs: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_C283203D2CCA281A87720665D83277B4CE0A@qq.com>
References: <tencent_C283203D2CCA281A87720665D83277B4CE0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7f6fba66a5cad4486c04efe56ded5ae9@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch fixes the checkpatch.pl error

./drivers/net/ethernet/3com/3c574_cs.c:770: WARNING: Prefer 'unsigned 
int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/3com/3c574_cs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c574_cs.c 
b/drivers/net/ethernet/3com/3c574_cs.c
index 287af1d..6f5c9db 100644
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ b/drivers/net/ethernet/3com/3c574_cs.c
@@ -767,7 +767,7 @@ static irqreturn_t el3_interrupt(int irq, void 
*dev_id)
      struct net_device *dev = (struct net_device *) dev_id;
      struct el3_private *lp = netdev_priv(dev);
      unsigned int ioaddr;
-    unsigned status;
+    unsigned int status;
      int work_budget = max_interrupt_work;
      int handled = 0;

