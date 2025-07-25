Return-Path: <netdev+bounces-210050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2FEB11F38
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1371C27148
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC22ED172;
	Fri, 25 Jul 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgKgR1zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3A2ED15C;
	Fri, 25 Jul 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449199; cv=none; b=a6+RYVoaYSfmGofN66374dTWCjixosQDz/gL6CqOhmHhwsUsUWkflI+Lk9LfZ09ns1kfk9WPHx+dvMyWSW2i1uASUAkET8QX/r8OZtAafKxX05W94WuxG+ncMgxX2hqE3eYmNbbeSfvnzA4X2zoHTe+HilxT60NMVURKDFgzzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449199; c=relaxed/simple;
	bh=K2REaqk436/HBiVa3PYWivahq7G5rrhnQDhvYw7U8sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNn2Ni2K13r3AxScoRYdU6Tdo97wpLJVvfnbU3qQ0164K73jnHfl9a9jA7yaG1bUnf9zgKfxDRSjYMZ1zTxv3pUi3U/Gbxpo/ACVbRMcotiMTWc8Fd6DnvssIHyMKwsrOoR0sVe2UFDtMFIFHkdswRcA4P3Grm06RMIIDkVVTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgKgR1zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE4C4CEE7;
	Fri, 25 Jul 2025 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753449199;
	bh=K2REaqk436/HBiVa3PYWivahq7G5rrhnQDhvYw7U8sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgKgR1zhkQ1q1aTdj5me7BE9A8Ce5cO/+ZJoWHE//JymOms1tpnS+eh+i6IGE7Sx/
	 E7ipbIjL18u+eVHVKmLtj9nTOesnBRzjCFgXUfOsLFOYII09DiNEQXblle8Dv0t3sP
	 L7sBeeZgMhBJkpOt1t+YN9O3yaqoAu15BXgSZcypj7nLG4+W86pyrNvnCis5TkWGPE
	 5Z2FMqFCfzT4zboRsbKeBWWaPQj+fwWpZSqzcE4QtpLTHFDX96GZuQU3VxncbOXmi9
	 LqNNxCxMqe9mrWarqbrGBTgyYNPz00QO2hgaX9KtTKzJQNHJZIqjLEp7kQRSQSyYbj
	 YIz5BFnEO6aWA==
Date: Fri, 25 Jul 2025 14:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PatchV3] Octeontx2-pf: ethtool: Display "Autoneg" and
 "Port" fields
Message-ID: <20250725131314.GD1367887@horms.kernel.org>
References: <20250724101057.2419425-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724101057.2419425-1-hkelam@marvell.com>

On Thu, Jul 24, 2025 at 03:40:57PM +0530, Hariprasad Kelam wrote:
> The Octeontx2/CN10k netdev drivers access a shared firmware structure
> to obtain link configuration details, such as supported and advertised
> link modes. This patch adds support to display the same.
> 
> ethtool eth1
> Settings for eth1:
>     Supported ports: [ ]
>     Supported link modes:  10000baseCR/Full
> 	                   10000baseSR/Full
>                            10000baseLR/Full
>     Supported pause frame use: No
>     Supports auto-negotiation: Yes
>     Supported FEC modes: None
>     Advertised link modes: Not reported
>     Advertised pause frame use: No
>     Advertised auto-negotiation: Yes
>     Advertised FEC modes: None
>     Speed: 10000Mb/s
>     Duplex: Full
>     Port: Twisted Pair
>     PHYAD: 0
>     Transceiver: internal
>     Auto-negotiation: on
>     MDI-X: Unknown
>     Current message level: 0x00000000 (0)
>     Link detected: yes
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> V3 * Fix port types in firmware 
> 
> V2 * Add validation for 'port' parameter
>     include full output of ethtool ethx

Thanks, I believe this addresses Jakub's review of v2.

Reviewed-by: Simon Horman <horms@kernel.org>


