Return-Path: <netdev+bounces-143514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A639C2BFC
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 11:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3B1C210FB
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0D146A71;
	Sat,  9 Nov 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqb/RuJQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0C647;
	Sat,  9 Nov 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731149122; cv=none; b=ZxSg9T+/p0hho6sbleCFAw8hg1cjwTWdZKSFVNk+hgKRmUmwCETf3/lN9j2U841h1L2Jf2GACPQEbEIqNr6PZB/NppNh7G5sTr6fbaloNBa5hvjO4sCk33tSR0Ncv9KG1aW+OTuAhytfc/bQkdgXA4WKGPemv0k/xO2a8B4rZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731149122; c=relaxed/simple;
	bh=7J03tNFPT0gXl4Xx88tNqczqfJNq3l1OsrQieesV8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXe2BnoLNtXSW9C+vT0Ep7J3zadsHkhDEG0ANBkWqcks8AxC1hu9OX7AT2SbXv1tGYD1d+BR9t6BfKxld9mD4B457fVpQd3oZbgLjR6Ca+s1AFqDfGeXSYhqxFS1f/OGVZgbvlrgA/0zLrFSt7VHfqkXsKIJgp8wSkyE7hJTntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqb/RuJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB24C4CECF;
	Sat,  9 Nov 2024 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731149121;
	bh=7J03tNFPT0gXl4Xx88tNqczqfJNq3l1OsrQieesV8K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqb/RuJQVjovi0LGMybcqyPQ03Hg7PPyTogWoperUiqpeOyARBAdFHvAfQ/+vP2Rz
	 Ovff30/L7O1Pk5cDhW+lmOlbvUfxn4xJ3hVL2mH8fVF+prQRXt8Uhun95ElRB8CFNO
	 NfH7bXpnUdDXrvEDwfZRCXTvXy5i6KZYnZ4sC9KYNVUQmAw2zD0IPz931a0PveOT5F
	 IeueLeu/dYzgrp97PGVuJqYPtHw/mt9GAufY7LL24umdU0QIpCFnO5ZNr30suGlwa6
	 DVbJf0FpZvoeTzqBKT7Be+xBn/C7lIvWNk9Yu25656c9ksIy1/tIzWCB34x/3jp03C
	 woO1z4iNlc4HQ==
Date: Sat, 9 Nov 2024 11:45:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>, 
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add
 LAN9646 switch support
Message-ID: <lsnnb6nghbi67xx54ggk5chhqxt4e2qkiuanypramiqcky6cgw@bdd4vr2t6pph>
References: <20241109015705.82685-1-Tristram.Ha@microchip.com>
 <20241109015705.82685-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109015705.82685-2-Tristram.Ha@microchip.com>

On Fri, Nov 08, 2024 at 05:57:04PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> LAN9646 switch is a 6-port switch with functions like KSZ9897.  It has
> 4 internal PHYs and 1 SGMII port.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


