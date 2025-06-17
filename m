Return-Path: <netdev+bounces-198533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D31ADC950
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225B116EB80
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650FF2DBF63;
	Tue, 17 Jun 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO0NfaNw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0542DBF4A;
	Tue, 17 Jun 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159675; cv=none; b=inxBJSfWc75z1lImTXpaPL6poknOX+qF7+NEL9JGdqy4QJmh4Qn4VFLLBVYYEyAdS+dPaVabmRB2qVX7EXgCUkQBElB5bl+C7cpvAKLMo0BJ7Cfst0pezjPSz0KA3mYP1kg/2444MoeFiXIIxNmZiMJxFsVPSxusjy35uXOmDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159675; c=relaxed/simple;
	bh=yBdnl3WQbfaiqRSVMuFMu/uClMacIGTTB72nosObzKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzPiLd2oxy1hA+v7dKvfW5/y9K/LjwHdsjE03Mw85WwvVwEcfJcSpnd0/RyuS78G/MKbOEpVevOsBXy4IZfvmuVKjjOt9jx9Dsy7ysvXfgEbD9/KUs1YQAHHFmdM0udsn1+c5SICcCgVxQhUR95zQNGkN0kHqpOFcyOU4zCGg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO0NfaNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCAFC4CEE3;
	Tue, 17 Jun 2025 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750159674;
	bh=yBdnl3WQbfaiqRSVMuFMu/uClMacIGTTB72nosObzKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO0NfaNw2nomzFsZEBSVYNZ3VUm1VwRxgEkc24+LNVQlW9aPbgTNB7RU1QEVaLxji
	 suDQ33+DA19e7G00JKxFOxcT8YO/9L+17uDdctv0zxkqZNBPYREuuGlQ+keL0JgJD0
	 PBs4hiRl7y5VdUDa+MeDqjid8k9MvduUHCHgO+Q860PM+6MNDtw2ba4jkkWURY0QuZ
	 WFSEpycBxxdF0nbwJcaRArXF3EM7f0AybQfYORon04hv8e0TdBgOllKsnRwiosLAjE
	 OqKBZD8JAqa7xggV5MkhWhYUenVGCNsZGssSAfSxqVxtyHq98Tj8MY6mXppIlRdwuG
	 y4Mo51mJ1OKBA==
Date: Tue, 17 Jun 2025 12:27:50 +0100
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
Subject: Re: [net] Octeontx2-pf: Fix Backpresure configuration
Message-ID: <20250617112750.GG5000@horms.kernel.org>
References: <20250617063403.3582210-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617063403.3582210-1-hkelam@marvell.com>

On Tue, Jun 17, 2025 at 12:04:02PM +0530, Hariprasad Kelam wrote:
> NIX block can receive packets from multiple links such as
> MAC (RPM), LBK and CPT.
> 
>        -----------------
>  RPM --|     NIX       |
>        -----------------
>              |
>              |
>             LBK
> 
> Each link supports multiple channels for example RPM link supports
> 16 channels. In case of link oversubsribe, NIX will assert backpressure
> on receive channels.
> 
> The previous patch considered a single channel per link, resulting in
> backpressure not being enabled on the remaining channels
> 
> Fixes: a7ef63dbd588 ("octeontx2-af: Disable backpressure between CPT and NIX")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


