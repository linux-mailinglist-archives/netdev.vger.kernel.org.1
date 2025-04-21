Return-Path: <netdev+bounces-184447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E33A95932
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC123B3CEA
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59E22129D;
	Mon, 21 Apr 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUj/77a0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9F1EB1AF;
	Mon, 21 Apr 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274208; cv=none; b=lUOAtRL8dB0OWxSjCQC+J3KU5mrVQDXOKhE740o+GOeWpsrd45Un89b2FGUsSRgFuZz4v6TJFyWTy/XAJu+R8bwpKpYH34YdV5EZrph0oyQHirvERBuuOXi2sXLa0XT9PeEbB3rIS46JXf37slXHZnNV5oQh4EdU3MTDpw00NiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274208; c=relaxed/simple;
	bh=3KyAOcKFt92uBbrCVtqq6KU/l/LNfGd0bbhL2SsSAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyiIkobYqOyzw4UpjetOE++YJfEKMfzNbCG+I0ajelStJR/0ZfUq3fdT4XvyehwxXLctpPduefGLlI0PmhhLLB6Vqgd5geMnu6u8YKtx9yXapjJHD/RcOn69rCTBG5/raWDrxwqjSWpwYHpDofCo4UkefRTjjOm/+MvxOGDpDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUj/77a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB12C4CEE4;
	Mon, 21 Apr 2025 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274208;
	bh=3KyAOcKFt92uBbrCVtqq6KU/l/LNfGd0bbhL2SsSAXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUj/77a0smxqitS7wxZOAlBn6QHjYltWmfhnjWAa9Ber3/0A2FJ12aq6f9rZU807C
	 fxqM3OsDZUNR2BQuqSVzD6FYvmuNFyQNiqpO+zD2ZIia18M8nU77KnF/d5ZAc+ADPI
	 WMKKkhyzqoMEtdX9iogptAq/i256ua4NSRk5Qd+HtWhXILXKQvNvUy4yYEvf8xGvrr
	 hRXcs2Sq2ITq9BDc8ytBokIFiWdeD9p8SvqhTd/SBKDOAWzTVc4tJ0DSPIQLw0RTnX
	 uQdZfElHJfoH9PBfqezR+cn2B9y4Gi7y/hpTHAX/Y4ihFyc+/9LXxkLpnQw8onsjAT
	 BYUe54fyKZPhg==
Date: Mon, 21 Apr 2025 17:23:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Davis <afd@ti.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ethernet-phy: add
 property mac-termination-ohms
Message-ID: <174527420502.3181100.1284839992137524317.robh@kernel.org>
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
 <20250416-dp83822-mac-impedance-v3-1-028ac426cddb@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-dp83822-mac-impedance-v3-1-028ac426cddb@liebherr.com>


On Wed, 16 Apr 2025 19:14:47 +0200, Dimitri Fedrau wrote:
> Add property mac-termination-ohms in the device tree bindings for selecting
> the resistance value of the builtin series termination resistors of the
> PHY. Changing the resistance to an appropriate value can reduce signal
> reflections and therefore improve signal quality.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


