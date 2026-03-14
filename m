Return-Path: <netdev+bounces-267691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP4DGEgrtWnNxAAAu9opvQ
	(envelope-from <netdev+bounces-267691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:32:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B696028C624
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B43305E9DF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E034E75B;
	Sat, 14 Mar 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="IoPz02Lu";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kIpDSA1T"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF133BBBD;
	Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480715; cv=none; b=F1Cb09H5+WT2YaXWHRhDSBRtv6jZzZumtS7g+0h9fHiIHCkHgAUd5UETHgbzKYvnuiQjF0zZpwKgfZlMUjuTs5wpmA5/vGzok919aSQg18O0YjywN141M9EFkkMsNfl2SrZyHe1ZfNI3S5dHNH8OX9zFtMys+De8m12RSSqZlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480715; c=relaxed/simple;
	bh=pgDTvuXbxejoe5q8T5y5XzwAT+BjkglNndhC2uWcbQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkZANtHqffUb+8SS9WCprujWY9vF25XvD55rzRZVpXOMlbNlX4rXh2L154qA2zFEjjAzS+yyVePiJOkFfdx0URtwmafzI8eTF66PzrciVHOr+a3WDm5dg5wRUhPJ0vE/tAWMqYs8GxIsf4cEpIDwUTdVEJ7pJQr+Hrq0V5ie9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=IoPz02Lu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kIpDSA1T; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480709;
	bh=pgDTvuXbxejoe5q8T5y5XzwAT+BjkglNndhC2uWcbQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IoPz02LuPx+rvheyuzojKb7WnSa85R80atz2Ndg2EVpZ5+9l3aPeydy2bxypGeDIN
	 PCRBswusdTOEQSfM6fVl2pUYhgv15Dq+k4wb2daTDy+7Db116yF1w33/v8r/aQwy0X
	 xLg342422UPOE9M9ugkh+xgc3seQ3w7vX3G0zmMZSYcsc3ux5KU75LeYFe6yzSPJHX
	 HiQnnfDw6H24qcBoATFHdWABx8dX6qQnqHlzqHgEgw26+n/zstCEt8XS/eE/vYSnp4
	 mkoHG9ylANpEeD/f/W/kUrCCbCpC6joPNTqFaHBq0uExGk6CO9qq2PuCPmTc6sDY7W
	 r2KfXWGUZa5qg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 868073FC9A; Sat, 14 Mar 2026 09:31:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480704;
	bh=pgDTvuXbxejoe5q8T5y5XzwAT+BjkglNndhC2uWcbQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kIpDSA1Tk+0ei3lnjgUaBnt5cikRpjtzqHZYjPpHb1ckNLF7FfOfYGpVPUHoQIn7o
	 /FoQkH4Tl4CPvuzfVQq5CgZcbuO8RVNvMHKmIv4/NszYYqP6XlyBAI+5/epvE/ZA0n
	 cmVy5YrW92ZonGO9/tti++7O5W1bQndrctTnjoGy9rjPw/s4ogJUnJId0ZaCQGtZrU
	 83ciPjp62vNyw/F0ZcE0CIVKsF5u4i6UlU8YiaCKK7f8Xg+icw+cNfZLVPHaOPkkLn
	 VhpUM0cBqgbMUYztbcVh80b5V1uU2R51M/svC4Fz+P9ULAXulcbnU8e0qHEFPdbYwc
	 qAwOL91DyGqsw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6A8A73FCDE;
	Sat, 14 Mar 2026 09:31:44 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:45 +0100
Subject: [PATCH net-next 9/9] r8152: Detect RTL8157 and setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-9-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
In-Reply-To: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: B696028C624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the USB device ID of Realtek RTL8157-based adapters. Detect
the RTL8157 as RTL_VER_16 and set it up.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 427a05d166ad98622a113df994b01a96ad6b2872..fd913f09ffc0189ac6a84b19ef6ae7b66700e100 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10170,6 +10170,28 @@ static int rtl_ops_init(struct r8152 *tp)
 		r8152_desc_init(tp);
 		break;
 
+	case RTL_VER_16:
+		tp->eee_en		= true;
+		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
+		ops->init		= r8156_init;
+		ops->enable		= rtl8156_enable;
+		ops->disable		= rtl8153_disable;
+		ops->up			= rtl8156_up;
+		ops->down		= rtl8156_down;
+		ops->unload		= rtl8153_unload;
+		ops->eee_get		= r8153_get_eee;
+		ops->eee_set		= r8152_set_eee;
+		ops->in_nway		= rtl8153_in_nway;
+		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
+		ops->autosuspend_en	= rtl8157_runtime_enable;
+		ops->change_mtu		= rtl8156_change_mtu;
+		tp->rx_buf_sz		= 32 * 1024;
+		tp->support_2500full	= 1;
+		tp->support_5000full	= 1;
+		r8157_desc_init(tp);
+		break;
+
 	default:
 		ret = -ENODEV;
 		dev_err(&tp->intf->dev, "Unknown Device\n");
@@ -10320,6 +10342,9 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	case 0x7420:
 		version = RTL_VER_15;
 		break;
+	case 0x1030:
+		version = RTL_VER_16;
+		break;
 	default:
 		version = RTL_VER_UNKNOWN;
 		dev_info(&udev->dev, "Unknown version 0x%04x\n", ocp_data);
@@ -10631,6 +10656,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8153) },
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8155) },
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8156) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8157) },
 
 	/* Microsoft */
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab) },

-- 
2.47.3


