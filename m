Return-Path: <netdev+bounces-151879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA29F171A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3D1881A3D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3811198E96;
	Fri, 13 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOPPvpbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824361990C4;
	Fri, 13 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120041; cv=none; b=eheL6oPwoBj2Gvmhoesj6kQldklHdsKcZruqjqXssEcM8ywmfHE1h1n0ZPrDMmw/VCdeTdKEHm7i4ciqYxqRLyzyed+okSGbp3Pni5tN6YGJQwCkzir6t11Up6zccmPTXrj9NKGXhYyGG3UCYZFth/eGX8xpRtAqiq5lAbW9odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120041; c=relaxed/simple;
	bh=xhtS6wcQI01sWh/2YXkLeK90U0JZniriHzDuVNitY8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9uH8PdB4m/3IWG32OJB5RWEMGggw85G4Yu0qZzDfaNIKXVxlSE1wb71DThRLKfYuYCX7gRrB8P+V3Qn26HyzpIA04Qq7pHX+NEILOroYa0Wsey6dngWTpUoh2osxCcJu+UnOSoAUbkAYAHvCHX2cGpdDd24+bql9CmZbVxGP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOPPvpbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A35C4CED0;
	Fri, 13 Dec 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734120041;
	bh=xhtS6wcQI01sWh/2YXkLeK90U0JZniriHzDuVNitY8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOPPvpbTuYkJJSMmdr48hzkYCupGrgyvYpaB9b7Z/+H5B+jeTHPYCEInC6/6bMH4U
	 xplvR2gbdbFjg3wro/JToT+WP/gaGzkkAa2Io7N80yikxQ/6fAxO7s+U7W1niPYYJp
	 Zgf3C8czMKKRGoi12XePzqXTobfwLydxxDrx2VsZUa9cAule0DaJKbMb8b8EK8P/kB
	 Q1gsHwSFbnpsU9mVsZVCrAamdJeVathhsal2LVC85L8ycSt37IDM60Rv5FPNrDCZqa
	 u+RaF7Bw/YAZN+fsdGpgRDfOVxTU80VMiF/yjsMpc3rXQtLwp94PMDqV2HYDDaTyfE
	 lOp1LZPK9lZhQ==
Date: Fri, 13 Dec 2024 20:00:36 +0000
From: Simon Horman <horms@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v2] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
Message-ID: <20241213200036.GG561418@kernel.org>
References: <20241213-net_fix-v2-1-6d06130d630f@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-net_fix-v2-1-6d06130d630f@quicinc.com>

On Fri, Dec 13, 2024 at 08:09:11PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify framer_provider_simple_of_xlate() implementation by API
> class_find_device_by_of_node().
> 
> Also correct comments to mark its parameter @dev as unused instead of
> @args in passing.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Use non-error path solution suggested by Simon Horman
> - Link to v1: https://lore.kernel.org/r/20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


