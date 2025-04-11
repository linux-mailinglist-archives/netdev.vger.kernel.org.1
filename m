Return-Path: <netdev+bounces-181675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA28A860FD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4597AAD24
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BE01F1507;
	Fri, 11 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiqecLlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBA136A;
	Fri, 11 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382837; cv=none; b=MwIQW1VjeC2Jdl7FWDEng2eIn0gyCAfMqbzDZ8/OLdo1vRoyi4m4olk2OPOpr1k4M58wGvCJdDm93t2N3iUa+7Q40S+e3KMyuvGbq32xflO5WDcOP7eTmXYlcRaysIaXZimux0LaVEkvloTAveNvyN3BQuh7uypm2OdsD2jBFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382837; c=relaxed/simple;
	bh=bdmi96KJtXzBzzp/XRee5Nf9BbtE748KyLnsywYANZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW0kD09j9RJuGUHFhZBxZZa/g0OEKMawp5+EP/jnR6CVsRB9RW5oz/9ri2t497/EVkLvFFYyabvYYKKW904gglpU6D+5Xs1keM5D4SBxN1AIQI5NVtdmizV8pln7YFyfnPxaVYVLgP6kWil83Ji1+ZT5dMMQyVI4vUNErOreUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiqecLlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D3EC4CEE2;
	Fri, 11 Apr 2025 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382837;
	bh=bdmi96KJtXzBzzp/XRee5Nf9BbtE748KyLnsywYANZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiqecLlYzxIgZEc8oW6GoafOIT18aPWu+pqWnagxmv9+EAOVfpwdG5ftgUQA2VKcm
	 BwfKAJKFbp8+6WguPaFzQ5lDvs7gVDqfR/ehsS0T+S7W8nLJcVrABXseciK4r77fNj
	 777ftyM24e/s/UUd93hERrOv65501Hd+tA7ebyAlfoPJyn+Wd56P/6yAYP17+1i6oR
	 tahcog69OuTAxC3YiHJxX/28oJguSxM4V7/FRvsmqIYaNJJLAUbfhguP4BmRTn+6G6
	 jRaa1s/KE3UtScrZx3A3sUDlXNOPm8Tpi7dZcoEr7nCwL43AEaGhQSNmv9zeEEKEx1
	 UIRuh4F+kFiZA==
Date: Fri, 11 Apr 2025 09:47:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, upstream@airoha.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [net-next PATCH v2 14/14] of: property: Add device link support
 for PCS
Message-ID: <174438283512.3232416.2867703266953952359.robh@kernel.org>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250407232249.2317158-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407232249.2317158-1-sean.anderson@linux.dev>


On Mon, 07 Apr 2025 19:22:49 -0400, Sean Anderson wrote:
> This adds device link support for PCS devices, providing
> better probe ordering.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Reorder pcs_handle to come before suffix props
> 
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


