Return-Path: <netdev+bounces-278359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBrVDkAF3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1A3F7B3A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBDB3038A67
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554973BD242;
	Tue, 14 Apr 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URAoCmSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84B3B9D9C
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157982; cv=none; b=b2BdZAMjUksbxiPk0U3FiHUq6YVVWTNlHzEIpPCPdxoBrj64xehK+wK28BpERRPQIZ/9ySldtFwKeRcpdl1C+aJChG0sCC2bs5g96l5lwfZ1Sr1RWf47oWqIlVpt5PFi+zEX3N0AzwDUZVfyAe+YBA86QkxyrmfZ8CilJ7qoJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157982; c=relaxed/simple;
	bh=ueYfz0riU01OccrDWCw9HEhIJW+EJERRqwTDZ72FBYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3Pa9RQz7eed0Y/52Kbs/gdapbhHukCWqruBNR+yvO74FsYAEFeCGFEQW3ndcJ1HyhbPxL5no6aqQh29GAGMwq30JLC+U1JHQQQXAr3BuV7Gm7weWjm3mgOLADD8yjlpIcu9WC53RbVWyriQ0/uy9grKVMcCPUmZ3+xKRRaERSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URAoCmSB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so51816935e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157979; x=1776762779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Dd71Vwcs/wH2BqkWU93Xb8qQUrIJYFt6l9omprx4eE=;
        b=URAoCmSBCoPdRSH+QbleLuenQN4v817PRPWz7Xqn2myagX/ER5LuAR7KdeYvQkiTSK
         H35N6N7KDgjGAM536g4Uer2p2zsU6H59WggA4gNYJUiBItDEU6eoRcLQFNFDOiB+PAY2
         SpOBEzEDzITPkIIe26d2FYwh/da+IZWFWpSaaOKEcZzQ8jiG4Jb6I7JCmzPmg5gTqNMc
         8nExfPPH64v0y6IqQJruP7cH1Kr0/qqfOZcUSzP1qj0taIka97AmqxnM+OUZGkpmXeZO
         umR0PGORbXlGBZ8Q/+BuEuvL619Z8eyvW7FmgACkjZazUWs2uLMrAFpVesQjvsT1Et9S
         qK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157979; x=1776762779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Dd71Vwcs/wH2BqkWU93Xb8qQUrIJYFt6l9omprx4eE=;
        b=dyUqNU1Z9Gd00lS2ySwCwFrJmXPFPQv/0r8yGQCu5nVI/mlMW54AJiHzJoeRux7/SZ
         xPtc83kZMmIpm/cvQlruw/CmZJD/U6lvjHGdXi9YtlMnpXC3XNUV/OhYbE1+kr0XWg1i
         C4i3xGdEaKlIV/m1GnJCRiEGfgZV9KLbW/wraa3CP+53T6tytKyASNbabMgJhc1P48ob
         yofk2O13R0PN0A6y8I0rkWv+WgSd/rn3nHCgGz3s83ZQIzU/tBtlytk8FE9Q7U3yGZNr
         z+K5AKyhf5Y+arYmmWSsbTklqaLATh9yD2N47VzfBhq68ep6n4C7J3c/IqwLWwfeGXue
         0zoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jvlxcuPh5BqDo15MI2LyceGz4pKKHfUVjEvWFB8zi9cDhbdIBbq+LePhFNA4UjbaRD5DgW5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAFPvHxSgb4DqfNjx/Qi9KNJILmrrsCjVo4z7p71FP6cr4jDu
	0NAo17uNBJEhIHvbI0v/OuiNMMDJpegqwQLS/xNkWYqxPcssH4O5g2n/
X-Gm-Gg: AeBDieuhC64SVw6kqa96tXw/GiYqJv9Mduzf4ssYITFKvo8vEMt0/Hcl2lj5omnuO8h
	6thwGMQX+0ahpcGMoGerzREtLHJUE8M1ZMPn1zggR6djZdCGSwjEkzGC3vahEol4iX/jCKmN2Uv
	NqpyUtEWEQgrZACUbQrHcNMxcE6GorhPGCt2c1XixqbB9LC0RLz+GtS7NPMDwhSNeHHWtLL/khn
	qMl16WB4+6+FRU2D1SMnbqY4ZQtQjkVD5j6AyYBn5HIRvRoMViaE13OBELkNiTv4wjBuyduhIPX
	iDHX3ZhRhHgWiYD4TTtTzTTk4SJ63/pcX82yKdwFO2X2mOV1sj0xbf1LDoE3y3fsq0q4wSdLgwL
	EskpHJ8Ck/XxuOSLUslUR1LJSoovtJxL1b2o9bKyasQF3WRw9mD1x3jhhEIcpgwWzb8aEtbc0t+
	2+J3lHj+Pp/KbaEwx8/kyRziYSiXO1ry/r5o5uywTCb1cYeW5E1hVPy8AObST5ImINzvqPhORIv
	XcMgsn6Ig==
X-Received: by 2002:a05:600c:3546:b0:488:c085:22ad with SMTP id 5b1f17b1804b1-488d68867ddmr226055715e9.29.1776157978862;
        Tue, 14 Apr 2026 02:12:58 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddba112sm37720175e9.0.2026.04.14.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:12:58 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 14 Apr 2026 11:12:35 +0200
Subject: [PATCH v3 2/3] net: ethtool: add KSZ87xx low-loss PHY tunable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ksz87xx_errata_low_loss_connections-v3-2-0e3838ca98c9@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
In-Reply-To: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776157976; l=2311;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=ueYfz0riU01OccrDWCw9HEhIJW+EJERRqwTDZ72FBYQ=;
 b=TcVfomq/oo06I4d6VI7EKSRvwWGQx7sC+9XRsF54FY2vQNPRD4B4uPJwXIP3puPfYS2QBXtDW
 Yx+g5/DGw42D4d2jL3jq5D7eWvjDAt4zujelmzvTucSoHfIJv/wPhrO
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278359-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:email,exotec.com:mid]
X-Rspamd-Queue-Id: 8EA1A3F7B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a new PHY tunable identifier,
ETHTOOL_PHY_KSZ87XX_LOW_LOSS, to allow userspace to control the
KSZ87xx low-loss cable erratum through the ethtool PHY tunable
interface.

KSZ87xx switches integrate embedded PHYs whose receiver behavior may
require specific equalizer or low-pass filter adjustments when used
with short or low-loss Ethernet cables, as described in Microchip
errata DS80000687C (Module 3). The new tunable provides a userspace
interface for selecting the desired operating mode.

The tunable uses a u8 value and is vendor-specific by design. The
actual handling is implemented by the corresponding PHY driver.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 1 +
 net/ethtool/ioctl.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..5c539e1bca4b 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -295,6 +295,7 @@ enum phy_tunable_id {
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
 	 */
+	ETHTOOL_PHY_KSZ87XX_LOW_LOSS,
 	__ETHTOOL_PHY_TUNABLE_COUNT,
 };
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..e1c98ce66093 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_KSZ87XX_LOW_LOSS] = "phy-ksz87xx-low-loss",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..9e7bd887acf5 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3109,6 +3109,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_KSZ87XX_LOW_LOSS:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;

-- 
2.53.0


