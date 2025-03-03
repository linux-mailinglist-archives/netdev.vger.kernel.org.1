Return-Path: <netdev+bounces-171267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3AA4C476
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DD31652B9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DE2144A2;
	Mon,  3 Mar 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH52aVg7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8421324F;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014887; cv=none; b=V6JEvauG1KykrIc0lGI/kk12iw8vyvnqgkh3RaZjI7jASG+0cCs+IjdoHFvmnog05KToTy4T+PYPExek96M+LAomwi4j16hKCHVk3qMUa+tyYfCJWJREGw1lNHOkb9exwGF+PqnkZUI7bEJmhrUK4ib55FdFZ57k/wnwtQ6kYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014887; c=relaxed/simple;
	bh=7DLOK/uhRKtW30A5mCMAwsDsod/wz2T3WW1IlbasAnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c41I6Rpsc9ux7omswh1fBbgeM1DUMcHFx0lXCVh5kJo0LuqnMDII6ehZpQ2Z0jTPB1541WshuB3zdNDwtxvS4nPwh+EVGBBSxV8kF6G4AXZmtwDlnqvHAXZKqDXIgDaA2/Jkn/w6HeOiAMWO0EpKjpCzVm/PaordP8Pf19nARJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH52aVg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65445C4CED6;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014886;
	bh=7DLOK/uhRKtW30A5mCMAwsDsod/wz2T3WW1IlbasAnk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RH52aVg78+4nFkhYzAgYwIecdKRt5XxVaUZYXzUBH2ZQ4b3AUBlnf4FEw30cTgeWd
	 +1ilbNZ+FhVSZE254s1oy9l1p2Gb8ait0duF+xuDLmaz7TjPS5jS55p9fjsMPiCKst
	 gR6yDyoeFFD0sBdj4EePVUt+Nbjee60ztCy5iFkHq9LZAant4zstYWAwGxjplZXzM9
	 HIctNUJNHZJ/iQPokudGJmb19wxLGl9VHuf+0wDWjlH4k8h2XY2dLKJZt24QMwHnmk
	 Uyr3CvqATxw1274K+tIN8lWYYK0S1aBhoI6ByjuP79Uh8uPNwLk9fFmz7E4vZ/4DGn
	 gTYtbMbMiE08A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD1C282D1;
	Mon,  3 Mar 2025 15:14:46 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] net: phy: tja11xx: add support for TJA1102S
Date: Mon, 03 Mar 2025 16:14:35 +0100
Message-Id: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvHxWcC/x3MTQqAIBBA4avErBP8yaKuEi1Ep5oWJU5FIN09a
 fkt3svAmAgZhipDwpuYjr1A1RX41e0LCgrFoKW20kgjzs0pJTULvmI80ims0W3nFfbBN1CymHC
 m51+O0/t+sMKyR2IAAAA=
X-Change-ID: 20250303-tja1102s-support-53267c1e9dc4
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014885; l=566;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=7DLOK/uhRKtW30A5mCMAwsDsod/wz2T3WW1IlbasAnk=;
 b=aagF8ewbwPElpUY+E2ZZONvvLuQXE+3+j6MZYavYlI+YfpogKKmYMiMbKU4mrqT2cndfpY8FA
 MC15ND+uWqYDP1Pu8liEaHxfI69xO4UGNLgbVAseQKTD/cDAmnuPNCM
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

- add support for TJA1102S
- enable PHY in sleep mode for TJA1102S

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      net: phy: tja11xx: add support for TJA1102S
      net: phy: tja11xx: enable PHY in sleep mode for TJA1102S

 drivers/net/phy/nxp-tja11xx.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
---
base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
change-id: 20250303-tja1102s-support-53267c1e9dc4

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



