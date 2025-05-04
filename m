Return-Path: <netdev+bounces-187646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E208BAA887B
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D22817672E
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167971EA7CA;
	Sun,  4 May 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="tgjHuHyu";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="jgcSltq1"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF271C3C1F;
	Sun,  4 May 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379783; cv=pass; b=YI9WLsoLO+/lNEqXPHaKHdYWXvo9a+jvP2AQDTsya9eFJXQnH9Z69j6GPxx2t55rnqYRxOs2xCJmkcFXcrwQ6kE+kT2YDcL5xi0MIaKyhAFyjiJWF/C/19jufVHHBGpbIPiTYpQ0ItKHdpgvFzUtUI8L0uWOC11fCf+RngQqXz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379783; c=relaxed/simple;
	bh=iiWVSV6sW0SWminu5ahkgLdCng4caKv9C0p1VmJ6ZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqpKOp8rAuai56yLdbFqfW5xo9afOE4o9UazcZTkwlVKv5gH1GETpt4eneHpJRa6xr8afHd49SsxbPcGeY1u5OsaIDrUhMIPJ5rrA1kpAjonOR29oUOmo/Sg4sFsSYQhu85P+FQGdsWqL+MML1QXzb6EmszgMx6ZEAgC1MqY0dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=tgjHuHyu; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=jgcSltq1; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379771; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OsLJl5nV4sx/BoP8JbmOruR17ksw78JlUZiEeUutKd8Fd4r+6Q7bBcy7rvLkuFozSM
    qxY8clZWyr39UTbRlzb2sSYoccVDOmeJH711KJ2dxs/uL7jiqmdGhfG7UG2h+pDR5faB
    WPYCWCBQGbFFt6HFB5kUfTuXi5nuum0MVE5OKPhtgEeSHiOGyMS0AUojv6hZkFWouVeQ
    cPVchJWymmmnLqYhaeM/lKtkF6H9WUN8uMxg6uR1IybfKQD/hv8h8/SDc/A6aHoZ20uy
    tTA/QgdwzFtzX4EswXIZJ764mqtqJgBJcMznVZ8Lv+Yrg0h/aOM6o5doj36PjVlAGYES
    mkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XkoLn80Jc16pwM/vsx0xD/qYQJ6XVi2TIpKrdAA3k1Q=;
    b=r8s7+SY2+6a67R1QeBLDBxtueYVA7/QcwgybUxTXUC840em8UuejzrKoqFZKA5Yl2W
    Puo1JeQBx+FNbAclVSHgc7zZCzLrReP4aDj0BgYjCLpH42v+pKd8QbttX/DiBJUsMkDD
    pRRDwnJ8AfwMBGyzbyAR0D4/3cNCf4CsJQWkNdHVZSErEPHTj/nzOl/nwsIToKg+uT4p
    pMqYJFgvcbh5rYUEHrvBSBFAe4dIzjwh+tp7dwUI7UlHvG9kGhmMIWytW1lH994/3qqq
    7fw/VYSETbXRoSJED+SUMQSu/lFEieIJ6ly7Zvsh9rq4vhNVu0i/CyisjE2hDX6RnevT
    x50g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XkoLn80Jc16pwM/vsx0xD/qYQJ6XVi2TIpKrdAA3k1Q=;
    b=tgjHuHyunFHAUOv1e6q/v1rE2eh3dv5V1WQm9ShySg0ZkfHFfD7M4kcJiTJyrH/ai5
    /aj2YsWy8+dIr6Pm/ccfI3g7HtlF9cLE6IYJ/On/8ssg1TDdB1UhDa8rC+lRC6ELl2Uw
    9dXS3xLU8lzQbuA9ir2PVGTJJ7/P8QTzNyVN30ORsztXd4aq8Tti85lev9/b5SzFxsds
    Rlwl2/qovUNClz5GqqbY8jT3cnPRTtvos1HZ0YspP/cG0a9lNPi6M1C6doqs4UsYLdvU
    b2syKW3kM8onhOgtM1aqF8uO0KJnD1fbxXIjds0dSwA/Zop7nMGPJAuNoQf/LPaO9+C6
    Pvzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XkoLn80Jc16pwM/vsx0xD/qYQJ6XVi2TIpKrdAA3k1Q=;
    b=jgcSltq1eR91LsxvKyA7yzfrAAsYk4o5isLSA/9mIztfrb6Jd1+wxZtxc+v+N455TB
    cJHlC8BFP9V2rTTrESBA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTVz9G
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:31 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9d-0004NU-2K;
	Sun, 04 May 2025 19:29:29 +0200
Received: (nullmailer pid 243236 invoked by uid 502);
	Sun, 04 May 2025 17:29:29 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 1/6] net: phy: realtek: remove unsed RTL821x_PHYSR* macros
Date: Sun,  4 May 2025 19:29:11 +0200
Message-Id: <20250504172916.243185-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
References: <20250504172916.243185-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

These macros have there since the first revision but were never used, so
let's just remove them.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 05c4f4d394a5..a6d21dfb1073 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,10 +18,6 @@
 
 #include "realtek.h"
 
-#define RTL821x_PHYSR				0x11
-#define RTL821x_PHYSR_DUPLEX			BIT(13)
-#define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
-
 #define RTL821x_INER				0x12
 #define RTL8211B_INER_INIT			0x6400
 #define RTL8211E_INER_LINK_STATUS		BIT(10)
-- 
2.39.5


