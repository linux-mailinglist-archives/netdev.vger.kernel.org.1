Return-Path: <netdev+bounces-167123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF730A38FC9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A12D1890C68
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFEF1ACECF;
	Mon, 17 Feb 2025 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="QdMXciE7"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057E1A5B83
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836486; cv=none; b=mIIXdvrEdguzY8TJWBHA10eTfc8btYxEt7Aj2ZSeKSea2slJ/mPkWytz0b+awDSzbe6luh+KEdAM4aULUdhg0tTXEBZh4O4xOVBYU2erQeuThp+c34kImfL0B4bs763GvNOK3x28gWLBs9j1pBa7YRhJQJ/fyDY2Q2PnwzhbYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836486; c=relaxed/simple;
	bh=ilQrorP2JZXo3khw+lo7SLfy9N+xBBHV+C/3n8jMw1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i+cLlBEpUGnDb4T0EDvuQf2tjNAE4LekcGMhjPNBEUCd6kEvGzSsclBfW1vrD3SzX/2GfBkShAzRiHaPnIPOhZWu5WzIjm4FBZURq2QEJdKFSWHjLRlLSJXfhpeO+o0Pb+anFmJ7kxGmNywx9WhKtl7aL7YgYMzL3RYNSjvaErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=QdMXciE7; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6429C240101
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:54:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739836482; bh=ilQrorP2JZXo3khw+lo7SLfy9N+xBBHV+C/3n8jMw1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=QdMXciE73eB0q6oiX6zIVU6kSn13xOxPpWNloikGac0/uG3NSJNSIuSMzsXZn2a/s
	 M6LndH5Z3iGMtBVNExvqoBVRiORyNt9upnS5SsFPwYXyPERZQ+OzE3R5F7gFtnlkv5
	 T8ZsGMK9aljEds8QQoR2qKsjFpDaMoM1qJ5Iv7nHXWmklX7uIc+Jzns4IepsmhnYw6
	 ngZ4i2/xpXYtH+QS/f6Nkhk/MDiJvYFEWkNDim3QieFd3xHkxgo09SaA/BvLRQESr6
	 rrowHfDYrJF+SkmXF/5xK7umxiD6MJNYbgLDaDDVTPngEtIlVa2qKkTMib0Fip7s/D
	 94y6yWokSQ57A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yxfdq5Bd3z6trs;
	Tue, 18 Feb 2025 00:54:39 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Mon, 17 Feb 2025 23:53:50 +0000
Subject: [PATCH] net: phy: qt2025: Fix hardware revision check comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
X-B4-Tracking: v=1; b=H4sIAA3Ms2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3cISEFM3OT83NzWvRDcts0LX2DDRPM0iLTkp2cxECaixoCgVKAw
 2NDq2thYA0OnZ6GQAAAA=
X-Change-ID: 20250218-qt2025-comment-fix-31a7f8fcbc64
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739836470; l=1177;
 i=charmitro@posteo.net; s=20250218; h=from:subject:message-id;
 bh=ilQrorP2JZXo3khw+lo7SLfy9N+xBBHV+C/3n8jMw1U=;
 b=eVYiW5uicazNJ8ilHdcKdv0TGYayJSCchZzoulAUgbCRCLcZh6rbfq3+71Rrbj/zhD6Y/jpaj
 teRxF6Kdi58AqqaiB39AaXALzoHOh0KU2Fl5xsZvHdmrD/hMPqcso+Q
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=tqvFF75nwS3URscujaAaCD+j9ViKh5jLMkj1mnX7Rws=

Correct the hardware revision check comment in the QT2025 driver. The
revision value was documented as 0x3b instead of the correct 0xb3,
which matches the actual comparison logic in the code.

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/net/phy/qt2025.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
         // Check the hardware revision code.
-        // Only 0x3b works with this driver and firmware.
+        // Only 0xb3 works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
         if (hw_rev >> 8) != 0xb3 {
             return Err(code::ENODEV);

---
base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
change-id: 20250218-qt2025-comment-fix-31a7f8fcbc64

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


