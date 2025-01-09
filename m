Return-Path: <netdev+bounces-156503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415FA06AB5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7FA166E47
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5E15E97;
	Thu,  9 Jan 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="guexTI9K"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DA22339;
	Thu,  9 Jan 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388467; cv=none; b=A01arXDOUg4DBV816OdpD9yXdYEbrjZZ17LIqsjUHLWkIDBjWc9NMp10S30Ie0CGxT+x5nn4EMVvBg9nVeF+EdUKt5xWMhP5wvJa7RfYWFr7yEWQNd5ujuMKHWi+yaXHGB1Ku7Wa9olW+XF9o7gcImdoFq6WHxrU4S+sYt8daTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388467; c=relaxed/simple;
	bh=6f2n9azF4W0FhdSxNy0OF18CGc0v6wqQpbni8R0Dy1A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOOelsM5HTQdcFkCmw4z3U0AMV1VHgXUzRsdtDtEKSMtX7j8KtEeKXu+hgmu9/6Nyfi8O+H/IvAJGwf2AXqNh6KiIBNKwClADFF/rCjhvGwj/SeRXHoVBqvG2XAmrS/M0kvbmasD97WKg6FUVt9mhY7EBCjxZQ0Tma4+1YddVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=guexTI9K; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736388457; bh=y3QtwddAQeI399IfmYqnIRT81Ji6XACESu2yZHq0xaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guexTI9KiRZcI1r32OuPrqPZ73U6xPSxJiTkvMdVnVryNaRyvTlx2S882d/aUWHzM
	 qMdBk2KDkTe0nGr7sz/FAQtdmDOrfyWtpKUoB8/Po1zNh/tApOh4ZNXp1HVmAdPe+4
	 GEhpQhYZrKhRP6v/ARJjjJmZJjwtqtRHaqB2Phw4=
Received: from mail.red54.com ([185.220.101.83])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 18016669; Thu, 09 Jan 2025 10:06:00 +0800
X-QQ-mid: xmsmtpt1736388360t9jgacrsi
Message-ID: <tencent_E1D1FEF51C599BFD053CC7B4FBFEFC057A0A@qq.com>
X-QQ-XMAILINFO: NeshAIv1+ONR4fWLD61+P1lm19n7UXQe/Ip6WAmhWPgblchvyrE0EEmWUHFDPP
	 /KsBg+SQmB+twoKopw0QG5fuzV30+82tWUGrdGfDwRegosqIbSYT+2O/QYqk7ZAXLP+pBHSxKnsJ
	 AJner8pFsVdabkVSV7m9BDqLu2r0LWqQa8m3JiY1XUbHw8iKg3mH6g/ocSWbIR5F3HpTktKAM+dW
	 fiIcve5vmcM8ivmdsOWRflexCuZKxT3gM1uSrj67UlL0aeQiD8Om35pqM0TS+342hltbUbEjFBci
	 VwZfQcwc6HRDjm7t0jT6GVh/rwSUjmTwzPPs6IabOdvCj91v7Mq6WqfIb34wkzZKAm2cU8t+EKid
	 8DSZGQQADUxHc7FYOO0PSSZTlDTA4ZIAftNdJhmMijs5hB8FTfZKpIu7g/mdWaYV88UrpVAhxHRQ
	 MW8mXPLDMKrm+kfJyZnfRSU4DIFEKr4neoYSFfrbxggvwhJvqL064QmiYFnutpCEpsTNcyD7nymg
	 Kv9FCEtSPGBadLDQLq9nuqiuGTwuszbPrvDO3K6CZY7nPxKgmSpM2649f9L4cAAJ0pejyctNqFel
	 lHY3ozb2pSwFB4ESTYXyUYx7aoN+s4R76OSY/Y6NpV+IsMwQ16mG1hYqirGuHfXzcw0yV2yAegtX
	 J4zyPOyp1i2qDmxGtpiu6kYfBpnEobk+F9OBFfki1XY86umSQ2jqXDU4pF22whLhNd2FSwa1Mq7U
	 4B4UQG8rM0frXXKrb6ArE0qFTmxKhXfTdgQMjfiXpU67+PfD3VJnFfyj60QioTm2dGO/M2GEaMks
	 nLKPD2LxYwSztt3rg0aj2wO2dvHC5ppV1A7w/zcBHUss4osF48EmNKqOhR+4EMIpBoTbaRe9DLPX
	 d1ST+6mozt0bOh8z6gtFtwP7WEpGk3wPM9DbpyJqo7REbYL8+KoAZOjUHCnLuLMMM3tAsB8PAPkJ
	 IPYUc2dCYPejr4VJSuJkdEXv62wxgBRNuQ3+L4XH5bNkhFYtH7Jdh3Icfz2uXKoRuJrHibqdpQJ+
	 6BakSJYQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: kuba@kernel.org
Cc: Yeking@Red54.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wellslutw@gmail.com
Subject: [net PATCH v2] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Date: Thu,  9 Jan 2025 02:05:52 +0000
X-OQ-MSGID: <20250109020552.44710-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108100905.799e6112@kernel.org>
References: <20250108100905.799e6112@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

ndo_do_ioctl is no longer called by the device ioctl handler,
so use ndo_eth_ioctl instead. (found by code inspection)

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Fixes: a76053707dbf ("dev_ioctl: split out ndo_eth_ioctl")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V1 -> V2: Update commit message

 drivers/net/ethernet/sunplus/spl2sw_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 721d8ed3f302..5e0e4c9ecbb0 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -199,7 +199,7 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit = spl2sw_ethernet_start_xmit,
 	.ndo_set_rx_mode = spl2sw_ethernet_set_rx_mode,
 	.ndo_set_mac_address = spl2sw_ethernet_set_mac_address,
-	.ndo_do_ioctl = phy_do_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_tx_timeout = spl2sw_ethernet_tx_timeout,
 };
 
-- 
2.43.0


