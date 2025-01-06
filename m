Return-Path: <netdev+bounces-155517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BFA02D4A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF82E1668DD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B115C158;
	Mon,  6 Jan 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAeAc8lS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96C1531EF;
	Mon,  6 Jan 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179432; cv=none; b=gHouFTegTtrLjbudR+Cv7rHmT8vZzYJLW/QaYeXcSoGF+eZuDlSGw1GlFD207FVrBkXAg03lCyhWqextvi65yqk6/TljFW/8ngbNzwBClmtgtTNYChjTA6fOIdN5ec5Rh4gF8E07NI2CBQjuscEas9El8Vc5sEBhWaBiF+GN8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179432; c=relaxed/simple;
	bh=sSky3r7f3ARXobqJRBcivDBSrfOU9UXSretT1VtKh3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip/zCbHc5OQlft8ifidriH8ydl5H5wzKUk/hRSkstHDPT8bHBoYRbyHUXqK74hv6XEN7wo547L1Sc+oI46YGzEeazJXFFxZzZfNUfadoTRMrnahkOH10ycVeEkwh+S5EoeprcnvJKt9VINPWlM03vQU/T7NgK1gwFiJZekJSLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAeAc8lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ADFC4CED2;
	Mon,  6 Jan 2025 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179431;
	bh=sSky3r7f3ARXobqJRBcivDBSrfOU9UXSretT1VtKh3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAeAc8lSr4KVL0DZJTjYLCml1CMSIgYZiD/4ulJrwVPPHDGnkaC/usuJUxvterlZf
	 S6GlX8DXWCCrrVHdUYIfQRd4z/fJfpZuNqkza7bjvNsDzM0evckS3QNxRyaqZyUQeI
	 kMwdxoFyw1h894zUX9938ev0C69h2VMtwlI9aln/WNuBmk7mhruuMFkLr5iI0xeQUk
	 W7tLCyAoQB9oFzEGV0mN6Z2rdHMJgH13tG53J0iBwUMRdZsbApjeLpQlzcg8dZWbLZ
	 W99TEawXj7CJ28Oe9YxjNQG57rb8Fg7b9xZkdz8NNNmYNbfEbXuwJOjx0rDz20tLgD
	 1DAyuVrNrojwQ==
Date: Mon, 6 Jan 2025 16:03:48 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: st21nfca: Drop unneeded null check in
 st21nfca_tx_work()
Message-ID: <20250106160348.GD33144@kernel.org>
References: <20250104142043.116045-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104142043.116045-1-krzysztof.kozlowski@linaro.org>

On Sat, Jan 04, 2025 at 03:20:43PM +0100, Krzysztof Kozlowski wrote:
> Variable 'info' is obtained via container_of() of struct work_struct, so
> it cannot be NULL.  Simplify the code and solve Smatch warning:
> 
>   drivers/nfc/st21nfca/dep.c:119 st21nfca_tx_work() warn: can 'info' even be NULL?
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


