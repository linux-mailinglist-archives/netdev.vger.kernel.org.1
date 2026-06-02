Return-Path: <netdev+bounces-294092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEgHMvidHmq5CgAAu9opvQ
	(envelope-from <netdev+bounces-294092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975162B156
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A3C5303101D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171E3C81A9;
	Tue,  2 Jun 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="C9HD/D2U"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296D3CA499;
	Tue,  2 Jun 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391153; cv=none; b=GKVR+smqaDG2pHs6D8q1JW/IvWFwzxjE4EiIIEP/9OZIRiKRd7/Wexnu3sLRY18qqW0swgOFF/UWs2CPUNrAOM2jq6n9yLuY9DLAMaX+j96VBQEx1bF3hNQ6RALcvpSEJK+SRTq6Hia4vkqWmAIr4LlBLq3unxj7++X+FNtyjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391153; c=relaxed/simple;
	bh=lweiL+U2j2RD3aMWvkdQnLbv+Zt65R/3p1OBZyuX8zQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AUhT0+mm/NqQs/9o1rv2CTzs9t5u43db87N8j0Hgdu8EhDaW8bgp5oSZMaVzDiaW1dHYb+0gMAmoDAdBnG2aVy+DBCAf45l8cYH36G0D7IeQPw8KvNkt8Eb/xe9Y1norNv5UGvDVJfL0WQM/Kbt+DrY4sl3QZCM4L9ZffrurhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=C9HD/D2U; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780391140;
	bh=IfXjH9yulXqPjRJqDC6fFJUDuecKipMTki0rT6mscnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9HD/D2UMcYJEAtEdEsfP4iCbaGf5fkzK7QFxl+G1rCusDlMHKo5bqyl3iWxr9ZzI
	 TzvGZ+fchegXKljQPFp1XwlGNiISrQzm74X2Q5vAx2n6eQcTZyB4K3eSSwCbE1lPGl
	 2KIiIXN1kp6pq2N2LCeLdbPpsRrW21MphAQ43rvM=
Received: from localhost.localdomain ([2409:8915:2067:10d5:5f88:ceb0:c03b:f401])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 15E02E54; Tue, 02 Jun 2026 17:05:30 +0800
X-QQ-mid: xmsmtpt1780391134tqodw4ljw
Message-ID: <tencent_F1AF1F5AD39C56485BD16C6DB2415E5B9508@qq.com>
X-QQ-XMAILINFO: Mu/Y/wNdJF3zrvDE1bImiIpsfpdFo914hZlhvaTgd4tv7YRXClT9GTL0R20w1i
	 X676F/B41Pe5YHEgUbKu6BHqlYGaFQPorqh+MylqixeuxrQAdv3CbJEZ1ZODiocgxDNK+ogrBo/V
	 7ou7jdgoMl6Lifwm0/Ztvb8AXLrKYZxlmsOEa6XjkHuwqa5+uYlns8D2f16//3l4jnebfTNgj2fS
	 58oZjEyVf/WO3d3mse6lXglUxqvvWSdilsxI80v1fs3nj2yh5ZOWjwO7X048ke05i5etm++90QTD
	 BuuGxL7dr0HsmsMwL1Vh1Hf8ck/IUOlg4Q/KofU9SbRumkKKH3c21I4+NnPhsl1adHvq8JX1Y4CC
	 7xoIyCMP1BSGIgcB3qmL2loJAoRBAx9iHm/Mne1qqHGIZ3snU+wSR0tEnzkkgcDv2mGJ7fAf96s6
	 kafcv/gjiR/RwYjpGwWKO76Ti3P2W4QMvUVCPphV1ZSLS+z8tBCd9VSsrFnOfK5dE3bYvxC36OOS
	 a3hBrxvIKwBD1Xh5im46OLzrE0hwzbkoO0uEa8P2+SVSNvdZkO4gIwWVimkh8qOBrgHWJlbNAHZG
	 JHLCOh3QeTbVt1WopdKnkkonjewFh2fWC/8KqycOD2LsEnzI6jsRxK1S75cTIdMja4W7gRC9Q4o/
	 R+PpMnGICsaW2vZsd5lkMVl11Tf3tGwan+8Szv7eM0eD/sFQ6P8VSRTyyLjRcDJxLM5NIblU0WpE
	 B8IWchPcDqaQLfqZ38SXMHsLKGoUW6qU/AaWRoC3WaUWR6D2CPhTYAs/y+9sKU9ohK7+yOnJjCtN
	 Oi3BEcRuAqcRbsbXOwIOmvEWc9BX5fyhEvly63QIG3LClt6EKuXLB0wmZa58zgsaa1DVk1otclHi
	 M55Xt4+ktN/7dasWMZkhjCg7DwdpNy+vmbc8xlTKqywuX1mQiZVR0yaVJ6IzSiGzB0Qj6jiR8mCn
	 ktuspkeUaG49Ry+HhNYcJZb6EJV+sBTf7w/ZMqHu0rf3M0nDfdT9jMwNP86UUJWbVzmjcqHNsQwn
	 gQ6RZXgJt2DdKDYHC3PV8ZO6QoDTT5LiPyCQ/fl5YPQhr2dBTndtBX6f34lKa3Oz3dNRGELg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
Subject: [PATCH net-next v2 1/2] rndis_host: add Telit LE310X1 RNDIS USB ID
Date: Tue,  2 Jun 2026 17:05:27 +0800
X-OQ-MSGID: <20260602090528.2544-2-shaoxul@foxmail.com>
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
X-Rspamd-Queue-Id: 4975162B156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294092-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,foxmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid]
X-Rspamd-Action: no action

Add a device match entry for Telit Cinterion LE310X1 RNDIS interface
(VID:PID 1bc7:7030).

This is a functional no-op and keeps using the generic rndis_info for now.
Power-management behavior is handled in a follow-up patch.

Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>
---
 drivers/net/usb/rndis_host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29..46eab7bda 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -657,6 +657,11 @@ static const struct usb_device_id	products [] = {
 	/* RNDIS is MSFT's un-official variant of CDC ACM */
 	USB_INTERFACE_INFO(USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
 	.driver_info = (unsigned long) &rndis_info,
+}, {
+	/* Telit Cinterion LE310X1 RNDIS */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030,
+				      USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
+	.driver_info = (unsigned long)&rndis_info,
 }, {
 	/* "ActiveSync" is an undocumented variant of RNDIS, used in WM5 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 1, 1),
-- 
2.34.1


