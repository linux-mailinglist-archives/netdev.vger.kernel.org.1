Return-Path: <netdev+bounces-155536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AEFA02E5F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425AE3A60F0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E281DF244;
	Mon,  6 Jan 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG6rcyki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377A1DEFF3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182470; cv=none; b=rBiCSztBB4BtPmS2+xy2pgPRj/CKIoWkktvy8gl2Yh3UAKd4J7umMN+6NPfC2xMCh6iK6mgZGszoN3XME7bMf1VvY0zbT2ZV7fWdKSj5Os8RCcBaLasMf+UQqewpVyPH1hZ80zjBmnv1sI98ziSHWDTuINq7P2eRuk9kUwo2XUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182470; c=relaxed/simple;
	bh=Hwn8mTXtB0panZbuQJAo3FZccxfMQsrHQj7DczTawOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXUeE5DXyKgFgPWSnvFouspmp40wrr+2pbIi5sWxulZlfAe7lt911u/UYphS0Z2yE9AHFwu+NqQKm3OMZOEboTQi+c+pOoDPWfnjbQ5rOIbo0ITNqOnKw1G0e2d087smTkGdx7ST3NBKgbrxZ/Gg/quVzhdw3CWlc2FNTWuoEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG6rcyki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB538C4CEE6;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182470;
	bh=Hwn8mTXtB0panZbuQJAo3FZccxfMQsrHQj7DczTawOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nG6rcyki8blDc+5cA31iAyjk58bUj3l3gF/wLcWY3K9osm1fQCsyWd4wFO2pN6F0E
	 Mdwmug6Zq3VeAq3cd7rXvnwo6n/sIFqiXQP9SIopsv6GE1Fe/BjIDZlSRfvf7oUddR
	 5ITDzaEs59fXqYBCDA2K/xryfCbU+ohs2ENkoA2Ak2cr3oJ+HhI7GsDf0Mn+V/0/9w
	 oXXeZPh+nUpfXfyn75x2aYkzDYs4/ushtYwAe5vOgqpa4enSSa6CD9g7ilVTEJFMuW
	 XDzMPCC3HMlqnpEl7ozhtT0+YXEmPzw6I4rIEg6dIlFVZeXWXaAJqoQmlyOAcYPyvu
	 2rhGiXtPa+BMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	lars.povlsen@microchip.com
Subject: [PATCH net 8/8] MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC
Date: Mon,  6 Jan 2025 08:54:04 -0800
Message-ID: <20250106165404.1832481-9-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have not seen emails or tags from Lars in almost 4 years.
Steen and Daniel are pretty active, but the review coverage
isn't stellar (35% of changes go in without a review tag).

Subsystem ARM/Microchip Sparx5 SoC support
  Changes 28 / 79 (35%)
  Last activity: 2024-11-24
  Lars Povlsen <lars.povlsen@microchip.com>:
  Steen Hegelund <Steen.Hegelund@microchip.com>:
    Tags 6c7c4b91aa43 2024-04-08 00:00:00 15
  Daniel Machon <daniel.machon@microchip.com>:
    Author 48ba00da2eb4 2024-04-09 00:00:00 2
    Tags f164b296638d 2024-11-24 00:00:00 6
  Top reviewers:
    [7]: horms@kernel.org
    [1]: jacob.e.keller@intel.com
    [1]: jensemil.schulzostergaard@microchip.com
    [1]: horatiu.vultur@microchip.com
  INACTIVE MAINTAINER Lars Povlsen <lars.povlsen@microchip.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Steen.Hegelund@microchip.com
CC: daniel.machon@microchip.com
CC: lars.povlsen@microchip.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 009630fe014c..2dae9d68c9b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2689,7 +2689,6 @@ N:	at91
 N:	atmel
 
 ARM/Microchip Sparx5 SoC support
-M:	Lars Povlsen <lars.povlsen@microchip.com>
 M:	Steen Hegelund <Steen.Hegelund@microchip.com>
 M:	Daniel Machon <daniel.machon@microchip.com>
 M:	UNGLinuxDriver@microchip.com
-- 
2.47.1


