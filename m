Return-Path: <netdev+bounces-293530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN3JB+/8HGoYUwkAu9opvQ
	(envelope-from <netdev+bounces-293530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AF619386
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05E7300A13E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE5175A70;
	Mon,  1 Jun 2026 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="U5yYzer2"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5220B80B;
	Mon,  1 Jun 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284648; cv=none; b=YUvAOVTsAoAfrKapl9cCrVhU71ellm2PuW3C+xxDNCebaY11trJiKDqYdxCUJ73s3rMB9vwEoJQR63094cEhpH+nflFBDS/EotncVczkx3Xe0RU2PyN7rL15y17JdP7bAAGJqeZ5oNx+xVAjAhUvDFAS4Lg8Bs+9Dje36Z0eCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284648; c=relaxed/simple;
	bh=Mu6SJ19ACRU19B3QoaOsRb5p5LNRKIJYmOKXEGBYOr8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aV1y2iOG/LHPj1Pa4t8jSApXsNtHqmUsDyNQyLSAJimCsVtBt99U7+JCiZq+g57pEqRL6kEgUx8Z4st3AdGQBtddNvws5DrpzVg22cLDYiUlLFEf2wdszRXFO0bCbyp7IrpVIl5/uSpvOHaOKiPBgqRpezMp48HBlO6RSrINVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=U5yYzer2; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780284637;
	bh=9HuMwzHiOFQ6cRhE+WD/ccaIIu7OOVejhB8VQT70LDY=;
	h=From:To:Cc:Subject:Date;
	b=U5yYzer2YUzRBTCNoaZBR7lN2zXt0Jf/vcTp2gUoai/gKASbtcUB3XaWjQtKrJDmv
	 AGlQU9MI/xy45RXft6FWDLx0VRsH/eqjlDdJbVytVAPGW4FvGSmeATMUI39LFfu+Mx
	 yzGqzQk+X9rhOq6NhqjScdDuxyAL51vRyKHXihhM=
Received: from localhost.localdomain ([240e:40d:2100:2c8b:dc3c:374b:f004:8f4d])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 7561C849; Mon, 01 Jun 2026 11:29:22 +0800
X-QQ-mid: xmsmtpt1780284562txqawymen
Message-ID: <tencent_96AA6EAB892D4596D70BA972ECC3667AC505@qq.com>
X-QQ-XMAILINFO: NA01pC2kVxOgVdyRhJbs6IC8JQOODnACZfF3z8ZouUvK6Wkw4nVWbSbbz+rcdp
	 FgFJDmHGiE5pQNihnizcdbXXeRyGyY/Oi4f8qnsQYdDOE+LJOwpwckXWIoKUUV2P18InKukSu5ax
	 ioJJzwzivclxkJNpXd918vDqp4xLYIZShmdBDSWaFsYunhVvcc95xehYSCwloVmFE9aFBMpNnnf1
	 HZjO0vuw+2thpeeW4GkMt86b+PU4hiU83/hV13zC8j4aX22yI2B42Ccq1NCzFEN3KGzC0M0VtONm
	 hCc9LfqJrtC6sX3dmh+EFeUmgIc3e8il7Pgkpsr4Q7mu0fgD8n+J/9+G+cNGthnJy05NBNcLZc/b
	 NN65pVoV+k0LVIHhG/RkIH4GtGpCZnrJe4FWzVeoJbAU7h4OAt/r0RpWVz6zHygMSsk8cJVylgcg
	 j97tico3GmzXcMHOqlfW2PLbZmN+aFH+PVoiLO7dyQwS9qi0ysPfkSzeSoE3+82+e/qms1Fm2aJK
	 L0jymRz7pqv8UlPkBxnm7pKN5mVsPFLBZJ0JmJPg31yhz5mLgcIQpxLc+dr8nV0L5zl9nmyWUM1T
	 V71Kebfk/nb4Jxc5t9LsldGCFjKli7GPpp/yXVMSwMO0T4Vxks3/b2XzWEhyUP6l8ZbgGnkkPTm/
	 6MdxztI2PXk9Z7IGEKZLLlvpG+KO5W4okrBUFNSfES8+PkEp4JleK9MkO1rjdu0Mqao5bKcK4g19
	 fQa3Gkci9DOBTz1UFETz3qmMPNx/RtPqpqYOqAcHiw0h40x/s1SKz1m5uVfw5fNtUpBMmw3c6InP
	 +nIDBp+TOSasZYu6SuOAbfL88JolKXAlZgWHGPk6iXjG34MF2ms3A+36A/yi86z5rrfWrrj7pVtZ
	 eCG0pbGDCicJR+aHUBsUUWGmeSoUIgRtTwneVgQxp1f1r1woNzZ3OrslyAZAmRWUvzHSoj/NnFEt
	 j5ZsPJqhh6oTNo76g+/e4AnM7OARSNrsRYKHBdINJyqBxfxfsPwnIW2fPtQlIeF7FIf5rfZqR/Q0
	 twSBkKN+yyAbQdwGZ/dY4UrEDPfASD2AJR4xCevvyv0NpHCKSb
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Subject: [PATCH] Add power management op for RNDIS host
Date: Mon,  1 Jun 2026 11:29:19 +0800
X-OQ-MSGID: <20260601032919.1877007-1-shaoxul@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293530-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 889AF619386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RNDIS host does not manage the USB power, and it will
cause more power consumption even when no data transferring.

Adding the power management operator will make the USB
enter suspend mode when no data transferring.

Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>
---
 drivers/net/usb/rndis_host.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29..76eb65fd5 100644
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
@@ -657,6 +668,11 @@ static const struct usb_device_id	products [] = {
 	/* RNDIS is MSFT's un-official variant of CDC ACM */
 	USB_INTERFACE_INFO(USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
 	.driver_info = (unsigned long) &rndis_info,
+}, {
+	/* RNDIS for Telit Cinterion low power LTE cat1biz modules LE310X1*/
+	USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030,
+				      USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
+	.driver_info = (unsigned long)&rndis_info_lowpower,
 }, {
 	/* "ActiveSync" is an undocumented variant of RNDIS, used in WM5 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 1, 1),
-- 
2.25.1


