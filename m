Return-Path: <netdev+bounces-193060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38FFAC2470
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E03A6282
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FE296D17;
	Fri, 23 May 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoUVAChN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87451294A0B;
	Fri, 23 May 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007920; cv=none; b=g3K6nwVcK/rDzSdfyvVCNXYcgr1SyjIW5GWPwFiRHAKqYv+CI6pbefroGbg/6sjQvVihECH+HgfRW93D8Ysvo7tcCpVrGVGoDCAMDejPL6jFdPSqL/6y/dw7RETCkXnQ7FQC7QgrJ514PkdtmFq3H1xsvuXvPB8jLZIa3WKoezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007920; c=relaxed/simple;
	bh=lqIApE0nl8vR2ZKYSc5WtRW8yPtNyjTg1Kx44NgbUAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw5TUzjLBaqne9jGd87J89eu3bBDAadrfj2pEAjHSLaYlvnw3QtrnHSwUT9zrQ18+bfaaNbf1PT7x5272XWPlY9DpgRyjzYkk4Qm1GzrU7Zyl/fIlLV3BP4S0f6gIDomzCDdLXElwGD8XNIvbz1PucdvIKpn41QgWlVPVkDwGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoUVAChN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57068C4CEE9;
	Fri, 23 May 2025 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748007920;
	bh=lqIApE0nl8vR2ZKYSc5WtRW8yPtNyjTg1Kx44NgbUAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoUVAChNXROVEp12L0SpLcLeFTxk+EeHEXXeWnDwuLnBasLZlIj39DNbrqurXQ+EG
	 E6gcXlm/KD969yl6yWy2PI5xGSljFIpEWjCr0UmtQTebKsrhAabPakXZYi6/9BDzNC
	 KRWk5iHu+NbiXvDytglbb3esiceIG6Jg4cojuHDsPEo7zp3/Htygs5GC5KfzFA4JIA
	 szP8dXFgKbhcJIaEqI8D3e/iH951BskV+kLJXz5emIBQFSEv7uCVm04sbFulNCiAC7
	 7uScfLaF4yjQqj8V+7kgRO9y3StvmRSXj0M2qNYbtzh10oURZ+4+hXRBw3wvBbREFe
	 QSKrI3McN8Ziw==
Date: Fri, 23 May 2025 14:45:15 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [net-next PatchV2] octeontx2-pf: ethtool: Display "Autoneg" and
 "Port" fields
Message-ID: <20250523134515.GY365796@horms.kernel.org>
References: <20250523112638.1574132-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523112638.1574132-1-hkelam@marvell.com>

On Fri, May 23, 2025 at 04:56:38PM +0530, Hariprasad Kelam wrote:
> The Octeontx2/CN10k netdev drivers access a shared firmware structure
> to obtain link configuration details, such as supported and advertised
> link modes.
> 
> This patch updates the shared firmware data to include additional
> fields like 'Autonegotiation' and 'Port type'.
> 
> ethtool eth1
> 
> Settings for eth1:
>         Supported ports: [ ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>                                 10000baseT/Full
>                                 10000baseKR/Full
>                                 1000baseX/Full
>                                 10000baseSR/Full
>                                 10000baseLR/Full
>         Supported pause frame use: No
>         Supports auto-negotiation: Yes
>         Supported FEC modes: BaseR
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: BaseR
>         Speed: 10000Mb/s
>         Duplex: Full
>         Port: AUI
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: off
>         Current message level: 0x00000000 (0)
> 
>         Link detected: yes
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> V2* Add validation for 'port' parameter
>     include full output of ethtool ethx

Reviewed-by: Simon Horman <horms@kernel.org>


