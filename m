Return-Path: <netdev+bounces-292175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCnJEUaqFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF05E109D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0853300E32B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC083DC4A9;
	Wed, 27 May 2026 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nYPyDrTS"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4673DCD8D;
	Wed, 27 May 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870269; cv=none; b=l8nwr9VrNsaj3/0lXGEoUYt2VWVta8CfTfpfkTnS0iHs1DseSMQGyPxELKIoh+lF727t5AgO6AwKL/u2C9poUi/A9pyxnXcvXOIdAkplJH/Z3RmhhdNQDNMhcj62GnXOVqvaZ/bYpkxA0hGElQDX3iWFVG3oeZj87sNlG46gzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870269; c=relaxed/simple;
	bh=Mu6SJ19ACRU19B3QoaOsRb5p5LNRKIJYmOKXEGBYOr8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ii19Mv79d613S7TFL4v1+wWL5g+/vdqg81FqvQ3sX6KrBd27r1UJ0N/BPFFP3N24l7QJ5B3LJH7m2X5FaMR0QKryrCIcHbBBlv+CsND2aDa121hiiHpU1UL2/1+bDXCm1aTvhkzAaF0xFOJ2qVbXqNEGy/l4eHMXMoi/2x1Xlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nYPyDrTS; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779870263;
	bh=9HuMwzHiOFQ6cRhE+WD/ccaIIu7OOVejhB8VQT70LDY=;
	h=From:To:Cc:Subject:Date;
	b=nYPyDrTSBs0PZyvhXrKfEXzu2aN98x5eqpXL3tjDnDxaASvgr7ATHttXNvrANLg6u
	 KrSRsBUz3eY3RtT1dnvOU09vpKZiKZ++D2FisODu2FIjOHqyyxpBCSf1QnpbNqY1oG
	 mLravg9/jtDC2eS+68uozffBCUR89doowq65envA=
Received: from localhost.localdomain ([2409:8915:2048:5463:c452:e9ec:29bb:c572])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 611AE8F7; Wed, 27 May 2026 16:24:17 +0800
X-QQ-mid: xmsmtpt1779870257tbfyva1pm
Message-ID: <tencent_68CCB6B6D8A4644FBC502B5D3E82A731AC09@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+5oFjE70H5Zjtf7n4OrihhFWiJ/JdOU7DLc+EGkuz/Ack5mkGSP
	 bsjTidMnlPFwZafnuGKTAlNHpncObE0GMaGUNZH//qZYwo7CeMqM95cpDpODS4JcqdCMog2h518w
	 D3uvElGe3Zi+ajHu82nfvJ8xv6aH7HgsDRaR7rYOWyDVHh7xVSZP2f9ylu7HFim1J9c0CnKCRCZG
	 5zIJ9nEHicQYxHVHdCzzeL9XVenCiCH3btNWNKVbIPB8BqpokhPNO4aIVgWF+hnL2oVWdhrJFHcN
	 q7irxNsvmV6uQ6a384M1vDkPC2LcYCoaZDcRy6V43lfBcuC5fNSMX/OaItQUUldK+QTIkhHD7J6H
	 9btP5xQU418gqtivgCiV+GZbQZ59hdHCHtCJvZMYSF+UoWEAarfVzX89UCrCBaTHIQP3vakpEzkc
	 t65yiUcdqn2bdVwxePVOmQetEeJLnyLRlTzVUH4Q6ncwy2E0t4rDtxbTDu6D99Rjtp8FpIZWTycL
	 btl4iESBMIOoMZISYLpAjV9oZVgNSfiTAPVEXhBJtWqn+lN8wXLzu0Kt7O63HSCmkPTa4cFU5Wcf
	 KExAFPeRjaEg8Ep0EaOJgOY2lMuDhYXoETYs0Kf0Zv3axZimjBmrkALNIQ9QY05GcVQvlEch4ywT
	 rLqACpy3tcGkBoMHq1FayDwpBKsPPOLwsPV6Jwp3z4nHG/DdUaiHm4/XUiwe8ikeoGN2knYIpJNf
	 8ZV1jZDtjUZ3qeKeNdIedRoW3F/maH+Bbtylxn+RVz2JI53tvRdH6rAgU+Kr0tJdmyNqprsDuNJj
	 RqUHCO3sUIjYbNS9Bq0nngJab/t3JK/r3aKXb3rTpVjQuqe1D76mK9PZvrrsJZJo4M6Igc9NWWbJ
	 hQtsIcUFXxpesgk0S7XUZnFywm66aSKd8HaPgjcM1iuaRnNlqDv/tWBBmMa5DE8FPyIsleCF0wdR
	 R4xp1loCBCo/RNs1GRxDrO9eoEXxeEx9Q/RzbvqIC9ervcLWlAJqMovAc3T5EKZPoU80YdgCQ1bf
	 86YyaBtRsxQxj74YMPqdZDXdSIowkS0IZeUiquP8LVtiqjPFqkJd3xeJ4SEH1uqeo1E6Yj173MSX
	 Jt3sg3AyuLxyZrSPlb4/cYAcTpJs0/olggRqcG+aXk/PdlBtY=
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
Date: Wed, 27 May 2026 16:24:15 +0800
X-OQ-MSGID: <20260527082415.1746750-1-shaoxul@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292175-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4CAF05E109D
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


