Return-Path: <netdev+bounces-59278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E657881A343
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77076284F15
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540F40BF0;
	Wed, 20 Dec 2023 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTDqzfxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE740C09
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4CCC433CB;
	Wed, 20 Dec 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087738;
	bh=E1x84bnuY9MBujh4fYbcWHnm3rDiud10CG9d0k2oNXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTDqzfxT01sHBbU/wvwWYBDkqmbnYTnARJv800R2f0mcCkWial14luLAnz4tpeiDH
	 +Cf6AyqKf1G4Go8RvIm6IY/BnqiBBn6l3m2rQCiDVEaE+B2LfQOfBvFG+QiAlkx2Hd
	 +pcEXyKUlAZPnCS/ylWgZOWJDD7GnL/wXeHyHkgRr3fbuBq8BCbw8ZP8ebSKzGMd7I
	 SlOUjJuwlJhPyk08Cc+tCxVl/64/yF/tr2/nR3pmsh4S/Ld6ASH3RfuVCoGZHoxopl
	 MDfKhM3RliSQanQ8IoEkxD3oo5PCGm5PgAMg8QKYcXvBqb2NNI8GxWauz9duQWnKc6
	 P75t2KCLyt0Sg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 05/15] net: mdio: add 2.5g and 5g related PMA speed constants
Date: Wed, 20 Dec 2023 16:55:08 +0100
Message-ID: <20231220155518.15692-6-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add constants indicating 2.5g and 5g ability in the MMD PMA speed
register.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da180e..3c9097502403 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -138,6 +138,8 @@
 #define MDIO_PMA_SPEED_1000		0x0010	/* 1000M capable */
 #define MDIO_PMA_SPEED_100		0x0020	/* 100M capable */
 #define MDIO_PMA_SPEED_10		0x0040	/* 10M capable */
+#define MDIO_PMA_SPEED_2_5G		0x2000	/* 2.5G capable */
+#define MDIO_PMA_SPEED_5G		0x4000	/* 5G capable */
 #define MDIO_PCS_SPEED_10P2B		0x0002	/* 10PASS-TS/2BASE-TL capable */
 #define MDIO_PCS_SPEED_2_5G		0x0040	/* 2.5G capable */
 #define MDIO_PCS_SPEED_5G		0x0080	/* 5G capable */
-- 
2.41.0


