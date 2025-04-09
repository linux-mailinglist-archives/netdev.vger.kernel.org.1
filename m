Return-Path: <netdev+bounces-180929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B9A83047
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6348165CEA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC91E32DB;
	Wed,  9 Apr 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eguGp2QX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1C1E282D;
	Wed,  9 Apr 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226313; cv=none; b=UCjlhuP5R0cliNudvd/xXbjQZjUgaY87Wk6bS4/z/hqNPB/k4wTgUhN3RddPMIUsSqfsDT21WT8ejXLGBTApElIJ1cjO/oPz7EB57nQ1VBkkzqykTf6mw9NrP8Vvpt2FXD8pEguF2oYLagXezvo/Fwb2lz5Xf4Fk/sJx4uWr6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226313; c=relaxed/simple;
	bh=wcbtyHQFCt+bqNR0sF5VKZ4aQCqoXS6gcVYqoRYJ/RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HluduDTtFx14eX1Zt0Zv4ny7dY/zi4XGhwd0NiSjuy+UxGfbrPGCQiEHJaAjRn9VMSli801UXuWPmGkMCj6SmONVyXnQtwwSjz2CLwWTFTjCniqWg0AKWHLMeFxeSY7/iqxKYOyW3O9N+0NB2G/2VBG1BUmVsIiMLcmxeehzVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eguGp2QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B88EC4CEE2;
	Wed,  9 Apr 2025 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226312;
	bh=wcbtyHQFCt+bqNR0sF5VKZ4aQCqoXS6gcVYqoRYJ/RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eguGp2QXpwJ3VV2aOYY/aNRS+JWaYHq1u71qdTn9EAXkdE9au0oV/a39AylUT8JlQ
	 iOC7shrwHF7jmbEf6R6EbpkkwUuO8AW9zGLrXlavgjWIlThqY7/ZlpUDBlX+icsm+d
	 Mikje5aTEqzAeX3ZINuka6ZmcBo2/cyp5ie2S+6kWmYFAW5byqc/8NaBijVzE+YTX2
	 9Jg4M0kW++HDrUsjl8Az+psBqeSLT9fgqc1W93VYHif9T9JvIKk3r0aWu2QmBJ0xXU
	 5U4ZaUp7Bj4sqZqBgH4raSUAWSbCI1qCqeJsX1QSGkzpAWB9ZbItcsRSdPEoXA5Fml
	 6AZxq6wM6lTKg==
Date: Wed, 9 Apr 2025 20:18:28 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] octeontx2-pf: Add error log
 forcn10k_map_unmap_rq_policer()
Message-ID: <20250409191828.GS395307@horms.kernel.org>
References: <20250408032602.2909-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408032602.2909-1-vulab@iscas.ac.cn>

On Tue, Apr 08, 2025 at 11:26:02AM +0800, Wentao Liang wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors.
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop, and report a warning if the function fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v4: Add brackets for loop
> v3: Add failed queue number and error code to log.
> v2: Fix error code

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

