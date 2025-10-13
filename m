Return-Path: <netdev+bounces-228676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106BBD1E0B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 570BE4EB809
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABC2EAB6F;
	Mon, 13 Oct 2025 07:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1BEADC;
	Mon, 13 Oct 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341996; cv=none; b=IxoD/cJrEnYZUt7jl8Cb7OaTxhThzS7WF8/2xZpF+WjwKsqFg+D3BTDTidiGVF7Fo0o+q1JKBXZTDa6AvX+kkQCmOXDxYgxXTZFB/hkLWro9gUQppuQDYT3TZpBj/E0r1JVtC7XKy+u/ALE2kx+8VXUVI2TH/N9r8Sk/ZgUhWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341996; c=relaxed/simple;
	bh=RVbSqysug34SR/SVpuf7+x3DtGwk+rjgK3h3fV/4w4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GRkmD21fqe+JGCwgKrJaSCB4DKG1+wZQNmTuudvNH/AQaL0B3pGmV6dMlSlTFpYM4YZGI+S7unq0X5mQI8BJ1kHWVKl6/QFBv8W4Lm1rSQ7fIv72bJW0+clt+sM2vSwdhLepnx4kF9s+tUusC/HOfUI5U3qHXZqB0pDs5d9LcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54617C4CEE7;
	Mon, 13 Oct 2025 07:53:15 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id D4A8E5FA42;
	Mon, 13 Oct 2025 15:53:12 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20250923140247.2622602-1-wens@kernel.org>
References: <20250923140247.2622602-1-wens@kernel.org>
Subject: Re: (subset) [PATCH net-next v7 0/6] net: stmmac: Add support for
 Allwinner A523 GMAC200
Message-Id: <176034199282.234636.10650174207490097271.b4-ty@csie.org>
Date: Mon, 13 Oct 2025 15:53:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 23 Sep 2025 22:02:40 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> This is v7 of my Allwinner A523 GMAC200 support series. This is based on
> next-20250922.
> 
> [...]

Applied to sunxi/dt-for-6.19 in local tree, thanks!

[3/6] arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
      commit: 460a71b5642a60574809032f0a21afff0f942474
[4/6] arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
      commit: 7076938d20d22d5f75641f417f11edeee192e3cf
[5/6] arm64: dts: allwinner: t527: avaota-a1: enable second Ethernet port
      commit: 2e5d147ba90e887271297f69721d2d88122c7c4f
[6/6] arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port
      commit: a3606e8a7819534026b46e2b8c7b0e156e292f13

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


