Return-Path: <netdev+bounces-294093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPYUDzqeHmq5CgAAu9opvQ
	(envelope-from <netdev+bounces-294093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:11:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600C62B174
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8453086208
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B03C988D;
	Tue,  2 Jun 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="I97V/E0U"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD263C81A9;
	Tue,  2 Jun 2026 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391158; cv=none; b=mYwtWacUiD8fBEn7WwKvhPoNPjKAxvF5UcAzSj/T0M6vObMOqeaRkqxAdMN66n0l38uIWhA8qvZRvM7EvVRzmeI4lODg9MUMjAd/PDRUx57h95/KfP+gBwuxqM6N1aplkF33INJ/nWO6OZfJrArGGdryTe2RDTksHTvmguP7KZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391158; c=relaxed/simple;
	bh=HKBXWv+eonGNrv6kb7tv7EZ9MZ2EISofoaQRtg/sswI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=N3o6TzZ2rrA7zsnukYdscwaokJBm7sAfakVWilVSGTSWUkvj1rUM6gLJh3a7yGEb8ZD4xv/gZCz7tD5+O/U4pc7i3ZNKJmB1EdgYN2mfjBCC4UJ22vkrgkiiDKJKAWc8SFw/Ab99uf4jnRqp04Ftjf1uYyS8s11eEfTpwCLREqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=I97V/E0U; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780391145;
	bh=ylUuVX5/fzTNDiftXf/yPHUAumkurnVvyD0i0uzdRWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I97V/E0UiloCp2QhxCfw/mNA3dzFCDumqLNRZTWanNFzemb7JUzqrMqWQ/D6juE8L
	 ouMBYgWuyYWxUrdquu2J+mvLK0pJGc6R16MLaAEaihB2UzFtbbgFIAzYdkfjdjJFU0
	 kzB59Y9oeIwVbSWn1vAQE8gphXrj52yks8peNzd0=
Received: from localhost.localdomain ([2409:8915:2067:10d5:5f88:ceb0:c03b:f401])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 15E02E54; Tue, 02 Jun 2026 17:05:30 +0800
X-QQ-mid: xmsmtpt1780391139tf7959ljq
Message-ID: <tencent_B7686B84CD4B76D76BB912FA6367FAC2CA05@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJesILK4oliI4YDNv1tVXJ/JkfX06j8ISP5gcNAXSrftpr9KfZSC
	 2mDrjTZeCvCk1VhPlhcQXxYet6gS8W1+scnMneSmxyXv1aOcxeBrfOUIE0rvsu0kuB2tW7sDWh86
	 9aKanDRijSIPKQ0wlBTl6ptt4zKN4Yo1QWoak4nKLa44Nx2oh2uqcknC205boENawG1qxFKy3EaU
	 T2cCV+rEyVJT0drMJbqVrWnwwaOtGmRZcXbVpVHDPiWekF3U5K+PaoEQ9kT6KfsiZE8qL8AEvwt5
	 Xs5kc5Z3hhCoJ/qYJaZMxN1Bab/W8lZcJGEttyCsWlt9vaDlL4ylw8KiH+uQrOTPUD3b6V7/7c0a
	 +L3uOW9GW0/zH6Kw+ZCVq666mCLjAIIawJjGaNZeHjipt2TvxTOs8T6jp1R6BtPfjV2efNgz6KpS
	 lWW7GcHkBpTD8+qfF4ip6/i1Xx4bivNhus3DhDHZLxVIKVwoGfrZfCVDqHKck8vBG/yeiqhXyle4
	 yAl+2dYavOG0jJWXAUw16p55pKzh64Mm94EPZL3tOfaTwf82/6KpssbkHVQJvPhANGSwsfdVAJDR
	 0NRc1VuCBBf7lVdbRXSW/JWBo84t6CJMT1PjNduqIN6SCbPjfzTzAPbt7iHFMtzA5+KyeKQaf8BT
	 hN4XWk27x+YO56IkzrzfqGmvhSSHpf8CQ35htCT52yrB9OsaRYJ2+by8YLowZ04IChW8szvUSzsH
	 q5OPvmlmKtioIVdKgd79lJGriGoYYwVAotqUdJbVA+ANm4hw5FxMoSl6RCEZfavuojo27uH5xbJq
	 jvymy6KHBWYkxwoe+NGNqzU0RDFbquIUVz7ZTyFaztDLfaUPXnmhOHmZ7JGBKko4tZq3EDCFuoSG
	 sKyIBQ25oPHDkT7VH5rEvwnws/+bf+oTdUSp/cErbDTw3fO8Uh7mbwsWFvWQ4d15Xf7xzGUZ0Plx
	 MCBVK7PWSc94CmDkGR9mVYNADmpVolGFXc55IKt+k+pWrbesOnJ8fwpuZKvAwqANE1kS+Bb0eYX/
	 I7qaJXZ4VHHC915LEth/Mze3pvDIhKMaKwo2S/+bpRRO+QHdoeuxSF3rK/woU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shaoxu Liu <shaoxul@foxmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: shaoxul@foxmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] rndis_host: enable power management for Telit LE310X1
Date: Tue,  2 Jun 2026 17:05:28 +0800
X-OQ-MSGID: <20260602090528.2544-3-shaoxul@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260602090528.2544-1-shaoxul@foxmail.com>
References: <20260602090528.2544-1-shaoxul@foxmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9600C62B174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294093-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,foxmail.com:email,qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Enable autosuspend support for Telit Cinterion LE310X1 RNDIS interface
by selecting a driver_info variant with manage_power callback.

This keeps power management scoped to the new Telit ID only, and avoids
changing behavior for all existing RNDIS devices.

Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>
---
 drivers/net/usb/rndis_host.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 46eab7bda..5e39d05a2 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,6 +630,17 @@ static const struct driver_info	zte_rndis_info = {
 	.tx_fixup =	rndis_tx_fixup,
 };
 
+static const struct driver_info	rndis_info_lowpower = {
+	.description =	"RNDIS device",
+	.flags =	FLAG_ETHER | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
+	.bind =		rndis_bind,
+	.unbind =	rndis_unbind,
+	.status =	rndis_status,
+	.rx_fixup =	rndis_rx_fixup,
+	.tx_fixup =	rndis_tx_fixup,
+	.manage_power =	usbnet_manage_power,
+};
+
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -661,7 +672,7 @@ static const struct usb_device_id	products [] = {
 	/* Telit Cinterion LE310X1 RNDIS */
 	USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030,
 				      USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
-	.driver_info = (unsigned long)&rndis_info,
+	.driver_info = (unsigned long)&rndis_info_lowpower,
 }, {
 	/* "ActiveSync" is an undocumented variant of RNDIS, used in WM5 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 1, 1),
-- 
2.34.1


