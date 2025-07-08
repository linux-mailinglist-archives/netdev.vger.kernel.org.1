Return-Path: <netdev+bounces-205077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DCAFD0A1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881B6482ADF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F52E5415;
	Tue,  8 Jul 2025 16:25:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC682E3AE3;
	Tue,  8 Jul 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991912; cv=none; b=R3/LeeJTdVrj/Mbpbbsd5aVBtczZZdh+fE+m966rOVPKBWV07qOoOH1QCHTQrSjeP1sw06lNcM792EOlc+vm0wirRkAeKuCgnkZQWkRXNF2ErAa/G68Z7apCjY/W8Y5Jqo053dRxU5qfSU37pTdZmw97stUZKY+HzLoTbzHtPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991912; c=relaxed/simple;
	bh=jIXuqcI6MOmeacEdZ0npRde57ZegIGrDkobKmJQGJWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lh/uk3zfdjwHiYBPwDOd7EizXaIGsxMdlz7jdhxFseM343xJXswGU+o4yg4o8FfhWHdQEAslUit1BbBqwoC50aPSIvK5cP2AFDHkzadvih0yXAkwL/nJj+MYz0zMpcVTdMl0/zmjn699yIq5aKrmCR1B78/cY7TUbRqF1U2J6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55564C4CEED;
	Tue,  8 Jul 2025 16:25:12 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 398055FA91;
	Wed,  9 Jul 2025 00:25:09 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20250628054438.2864220-1-wens@kernel.org>
References: <20250628054438.2864220-1-wens@kernel.org>
Subject: Re: (subset) [PATCH net 0/2] allwinner: a523: Rename emac0 to
 gmac0
Message-Id: <175199190916.3345282.2851662318368432777.b4-ty@csie.org>
Date: Wed, 09 Jul 2025 00:25:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 28 Jun 2025 13:44:36 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This small series aims to align the name of the first ethernet
> controller found on the Allwinner A523 SoC family with the name
> found in the datasheets. It renames the compatible string and
> any other references from "emac0" to "gmac0".
> 
> [...]

Applied to sunxi/fixes-for-6.16 in local tree, thanks!

[2/2] arm64: dts: allwinner: a523: Rename emac0 to gmac0
      commit: a46b4822bed08d15a856966357a4b12273751cd3

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


