Return-Path: <netdev+bounces-157170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2B6A0922E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60367A1456
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489120E002;
	Fri, 10 Jan 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kM3tV0F7"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B93B1A4;
	Fri, 10 Jan 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516237; cv=none; b=SSFLTdS8uFr03QhfUp4QhRI6X2HT2jrTsP+vJPDSUkfogH3lBZN7NDo4eazZgUVAi5u9bboCPfqBSihEHttu+j/bH9WpDsGVmazdy8WUhSDzgDvg1q5JbGjYWkW7vgjrSijE0IPOit4D+Fwh5KzeZsP3a5z58duteKGN4P5X9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516237; c=relaxed/simple;
	bh=m6VUFaR/D7WTEcmJ6jaCbZjzSM1ny8BZP1vfCmkNa6k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=XQaabnKMtdGlML+S8EXaQWGnZURI9eivpwrIvEfTcBDig5NVtJ7pbc2aKrwA3FrW+C38Wf6b00j5KiMzvl8ZZtBDk0QUR2jgG6ZEl1eTRsFyj/etglvhRZVOR+l33gQAMRMv1Ww6qJvN27o3cus7dR7qQmpD18qNlxqMJn7jTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kM3tV0F7; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736516225; bh=rnr34XuBomF9f7/48Lx0eRQBzok2jkeVClqDiRrOUU4=;
	h=From:To:Cc:Subject:Date;
	b=kM3tV0F7aninh//ieZeVi3x4L2LyEFZVXHOsxcDPN2ZcjmLvYrZMEf+Npm+z2VP25
	 8xSjuBBGdcSYVPbwEe08lSU6mhUOOqEms8rzDWeOzZxf34wJCsHNjmZ3Ww1r5eJpoQ
	 yx0DNtKkOTDVftrQ/Tbn/hSOBZnIn44tyN+xJ0rE=
Received: from mail.red54.com ([192.42.116.211])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 92E9CE3B; Fri, 10 Jan 2025 21:36:46 +0800
X-QQ-mid: xmsmtpt1736516206tohugp5jz
Message-ID: <tencent_BDD603E969ED7B30ACFBFFBA9EA3DA3D7E09@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0anjWyCsM5AdhL0tONaeVX0z1ZCM2e6UXPO2V8BXZ6tBK2VU2FAx
	 h7+wf7n00yNH2+NZ0TX3/Z8l5M7i/uhO7SlDYamRzJ1AiymziFg9rO4gNRa112uPm/EXYN6pQofk
	 pemtaZQ/zbQ5hVqtOXxR3PrH23hFmpMH6QHTMEtxGGuNu42/6XjcEcTQFFluecIOkQ7K2zh+vbp6
	 C9UmGMFUp2XfmjTQBYYqNn8scaC9Q6MypCWp1zYumEaS32inpTd0Eo/c/9HO0/ATb8MDZnAN0Bt4
	 tIOXS0ljsyzF3yAZMZUuWm9Ob65eeTxag1l6gr8OlaGAydpo6A48twEgk2XlSiNuLrcYy+GTD30m
	 InNaIuA1EenPzVRM19uqbABvf8dVxRDHnxerEwQUP2WiAh/W9iTcUs9lg3VX1JKiRwQjCcdyaSRK
	 F0o60bzX7qhA7OMddUV3odsvjtStINlWIQqCNAyJu3oGDOLX3gzDPSb+ZWAnO/Mz6QxC0NNwnXjn
	 zsbmlT5J/H1C5txYMAoi5vvNdrqCemQHZuVOFolu2D17+FwHOJ/yDn5AJK6eQ3/xJtDU1AFrXYsC
	 0brYKF9gFEtD1ULrnAyrhBmnnz2qXCpEOQPI7/gzmJK0p78YKu0Fz0WFM72wcmTbz102nq2T+hCK
	 50gTR/G6cpqNmC+5x2IakvpI/51v1tCbm+z2A0ka5KJZn484qnBPBSmYYDUnaI/oCWFHWHS9P90Y
	 o/6jvHbnK5HtmToQ3tu/dIkUKhdrkNtCltPmWgafFlwrCrVxSLMJj2JmjUas/iPJcrIgMdUBC3Uf
	 0SNtKsVdYIfPBseLUyEcURLDk5OmbskLKS32WZTD3KvEuctlzaWUsGKW+oA64ZBXKcSTPFfu06GY
	 uOPvaKL/0gcoM6mhVgF3bYlAs4MvvjRmS6XHgnMVZRnq4kqvnSesqEsDypPPy7FgECaamPOuPhSR
	 6qGcgYwzLWKxXaE6rbVhyAFhgi92WsAXmgOJv3VkzLkVOnVbewZA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Wells Lu <wellslutw@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Date: Fri, 10 Jan 2025 13:29:21 +0000
X-OQ-MSGID: <20250110132920.81269-2-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

The device ioctl handler no longer calls ndo_do_ioctl, but calls
ndo_eth_ioctl to handle mii ioctls. However, sunplus still used
ndo_do_ioctl when it was introduced. So switch to ndo_eth_ioctl. (found
by code inspection)

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Fixes: a76053707dbf ("dev_ioctl: split out ndo_eth_ioctl")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V3 -> V4: Change Fixes tag back to old style, due to the objection from
Greg Kroah-Hartman.
V2 -> V3: Update commit message again, and add short author date to the
Fixes tag to make it clear at a glance and reduce misunderstandings.
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


