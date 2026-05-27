Return-Path: <netdev+bounces-292150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHi1HdihFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF25E09DC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E363013A95
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EC3A6B89;
	Wed, 27 May 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Y0pYicHg"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92B27AC4C;
	Wed, 27 May 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868081; cv=none; b=jD9xR2JVRoD6DVHRiNJ8eq/y04dPUwuAJ8Pdga8+dkVsMeUhop+7ukzSPo6BEiHqL7KesRbAd+0okLRp1NsW/agngKvLgwZNesn7602vdj6I86/HDD2QjQuQ/uBNCfLDdp7+QCbFlTzJtAxkRl7gGOMttqyu4hGJaSdLfrCfzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868081; c=relaxed/simple;
	bh=G/hdT+O03dUuWDzA9+4+fQQufDEpCTrv3vA91IV7mEs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=vA5faWlwl+0zvzWCwVU19USPXtap2DLkeAFjR0Dvr8Kq8kfamSS5v8CuH/biKuwZBs2ZrM1T8To7wprcq3xr3LyqWIgNk7PFUCp4l35/el/79l3e4KTpA/d6JmvyGNLdeb/JMh3X4/DOtWnMhLh4co0hhkso9G5O5GH3lYXIaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Y0pYicHg; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779868068;
	bh=kGb/P9sVP4tFSWde8ZJjt2Kzmw/l/ZEke0ZC5I4sGrA=;
	h=From:To:Cc:Subject:Date;
	b=Y0pYicHgzayp1p7yx8VN2PF2+/VY0AXAkm2IaM3dtBKHYm9L2Cqr+rCzPQkhB1bGf
	 HoNEvQtiKhSSyAP8+NUpN1WgFSeBwImbQt+iVNLTNr/kylOiGO/XHQpC7L/FHXVrhd
	 T+Ed4kaMoue8m71OVJsftA/od09HWL5kFopjJz/0=
Received: from localhost.localdomain ([2409:8915:2048:5463:c452:e9ec:29bb:c572])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BEAB8844; Wed, 27 May 2026 15:47:42 +0800
X-QQ-mid: xmsmtpt1779868062tkl3m9m0s
Message-ID: <tencent_513B1F71D30856A55BAA6CBDB22A5E719508@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIsZgO8oH9Cx26rDCB1rEun6zB7HmKkAfdNmW7doaNAQw3C5LNB3L
	 K6UHDp3pf9lm27RzZQIrzf+0csK8lhb8zzquE4WcW3aYq2BkL0em8iSW8kBtrltKPqURa4N3aYNg
	 /NJdWNc9MxU7bREpA5c2cmOURW4NgtVdN0jsVN4Pwx/ghF3zkOWeI+CtA7HxKbx2gHEQkejHv/Kg
	 PfDVUdInafI2ljFHVsMZWBHwtB2ARXUbdPVq67IG0C4jcmTlRppBm4oJopTuSSVrOOphgtcAOfH6
	 HLBlsQzuukp4qvYxhZFSGJu+txL+a5C39ubWF2KHueE0KdEarMGDI4I7CIGjVQPqf6bK3Hl2QTSr
	 WUv+5VyY3u64p6t/5we6GzXUj+NshdZ/BLbPslJPly3DcFe47cpWNlkMVk5pnwARuwFk+hGw1I8J
	 ApL6BYUEWzrkEKQQZ9tJmwdKm9PGjpF0N/0wQAfJbMeOOlnVoZtjePv/HffBHhn2QsYpqoVo5eHb
	 hhcxYoaQlibQjI2Hh+/n//8Hw4Edcsq++FvV0gJWO8n8lXo+L8F2FFTqNGzCyzZ+P/cVLA0C0iHV
	 FL+M0ui/eKtI2k+3GajrwxiWRzekwPw2zbQQSXEITMd4nxoidQcc+xOzqNCmsWRjLQsFW1LOfxGW
	 BZBiWM44xA682vBfejfwa2ilwAuDTvUqhLkDVuPtgWj6FDJcz5EHR3rjVHhjnxrCuWpl//3WsbZl
	 DJpfKx+uY4cf0Y0igk9ccEMub8nQBjGV7iQ0G7zqH6pStKNrM1bD/ER0Uz7Kp6kuW+DODx6bV3Rh
	 85E7N8lI+gsOAVvViCQXLCVoRb7/u498FMALKHUcjSzI38GkLglpRa8AjKYaW8j30iU8Sk6Wh5zN
	 fC5qNHNdp1fH6k8AfwBzqj9om5YDTsvuzsfUmQPUoyUx659SFLSnNuTzMhXaIfFPCZtz6jBlZuVa
	 FDlCp2dzvkCJFyMV1dyLTnDsmMCU4actaIPQW/TBU+T4lGTrP2UmHPPD1Qry6XhucuUafp4q7cea
	 JlqMSiE3nG5O0fg7Au
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
Subject: [PATCH] Add power management op for RNDIS host
Date: Wed, 27 May 2026 15:47:41 +0800
X-OQ-MSGID: <20260527074741.1745978-1-shaoxul@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292150-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,foxmail.com:email,foxmail.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: CAEF25E09DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RNDIS host does not manage the USB power, and it will
cause more power consumption even when no data transferring.

Adding the power management operator will make the USB
enter suspend mode when no data transferring.
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
Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>


