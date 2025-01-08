Return-Path: <netdev+bounces-156289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B65A05E70
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD29161860
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4181FCF5B;
	Wed,  8 Jan 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c5xTEQTw"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101D25949D;
	Wed,  8 Jan 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345927; cv=none; b=llSFjOagt5mq7s6JMiDUfimD6gbvALsXdpOiI1DEKY9sOZXG7v75sCmCM527YeGiiTu7v+21tx+Os9TKWSdFs5EdsChBQSyKZKrwHMMKMyWIGnDrpQOnHHFcuO6DxRenATH6rhJkGXGeKr1qZhsB3TslT24hRiXbMBQk4+9R4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345927; c=relaxed/simple;
	bh=Gslm0Ry9/vw1oyrHfG3+MH4yXJQrfrxXW89YPKcwZDc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=tWrYPzigzPvPhOGXitjHWPPSD+yeg+6XqBqMCxRBlJzuupd4W8CL2xZHhUGIgQhNTS+u7+QiVJI21uTOFyBK9t9YHHA7aGtx7+wrgrQJHaYbmSdfVfe+U3k0AHNIwdEut9wfDm/P58SgOfx/MW1wYBpHpc52A2xxVfJ7YxGx424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c5xTEQTw; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736345615; bh=k3qmLXqsFQaHwLyI5JQGFcNTVXpKgnErBA9tqiPP7K0=;
	h=From:To:Cc:Subject:Date;
	b=c5xTEQTwsm91nLl7omtS1IRHJap96FBMPBdG9zg2wKnZMMShweWddXE6gwj2kFIxA
	 QG2ay997xmI9GwBTMNQaqfsAQm2aum8ygdOYy8XosRxLafixVORKhkXYoKQkA+FN6U
	 FuxMhzYU5poTJvsrFJ9h8k7zLRzQFwqeligkiHq4=
Received: from mail.red54.com ([192.42.116.209])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 3550AE5B; Wed, 08 Jan 2025 22:13:21 +0800
X-QQ-mid: xmsmtpt1736345601tbqgz4gi7
Message-ID: <tencent_DCCF5160376D4BCFA435D41FF333627BDF06@qq.com>
X-QQ-XMAILINFO: MwqrwaLzgdebdr6SSjckoZ7hRIXc/USHP0kmk/CVHhKragxUQcx3v4u4nhqRbg
	 fX3uTJlE1d8iaZ7d1764cLw+9qFSVzw7AsQRGUf9s5PulYeWswLIX2vbTMjiBs7g59lw5XsxTfny
	 nqub82KAk1NZJ2scUQUvUr3waN6AmpGRzrlfHpcrZupUUWt0CjKYqXW7a/qvjg+SXssqIGHvJVFX
	 CjDayjtSRa7CgQDAEsRpkzoq/rO0222DGdNgA3UPC6dfF69xaMB+8ucNccM/fxxUEjURMZ9mdiE4
	 MtJ6JFRErk3OJe8m9tr5qmVXoDLoiPLgrRfiv1/eGE9DM7pAcafjth9ppqKwyUbTlbr9Iyco6HAn
	 CInNX0MOS+ANkMWVdTX2+LKKWOMSawMp0qzvHE3+kSHYLZIiSiAJ4yHDn97JuyDRlnfTjhcNzoPU
	 VC9RK1vgLUmKgEiWesWFmr7QYx1ikLb0ka/xlbCWleC6HT4/7EFjc97oI28SXEUtvKn5c0g70wA0
	 HYAE8hL5WSV6286B665oG2ys7e8GzHVl5uFE7AufpTqO9woD4PoZ98zhtOa0ovx6eMuUPKC+bqyq
	 iwZQ/uaD3t6ODsD/2acv/izkZBcvoKnDBkdQ57raps3XqScrEugpqNrtecfcSFN4q6InzmnkFcBt
	 UqL18Jzdwl0KeSC+EjiAl4fm1moLLBKLdWK0AnTqP9FbERbpr62BGWyHcyAzT4WoEKC24PnFAaks
	 gZMZuFKfCbrOpyEAovYNRfGcsnDqhl7cEoRhW8EEZ3745mcPtdKGGrOWaJDMGUF4oA8+N3Xe7QTx
	 YQIpW/1Cod176mfKGVlYZWOlgSbJJUG3rpTYkUJ1k5de8qp2FspGya70+c4SuJTA6JsVgS93gcZi
	 /TUJC8THiovyDEiPGJksgYozwEWPDca5ZEbtnjeGdW28sAt+dDH1EuEk+Pq6L1go+JtriXrHDlGV
	 F/oU5ppPXSCf1pfLphWnPCIU67nzTyMg2LHtsRPqGjzczwugaDaWPJs9e8iPalRNTuOBuFHmfLpW
	 w5K9uRXxebNA6i5ly3
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wellslutw@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
Subject: [PATCH] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Date: Wed,  8 Jan 2025 14:12:38 +0000
X-OQ-MSGID: <20250108141238.413-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.5
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
so use ndo_eth_ioctl instead.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
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


