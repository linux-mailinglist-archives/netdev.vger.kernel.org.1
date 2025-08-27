Return-Path: <netdev+bounces-217429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AEB38A45
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785FF4E2648
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA19A2EBDD6;
	Wed, 27 Aug 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEEKmRTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A427815F;
	Wed, 27 Aug 2025 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323437; cv=none; b=nEAxJ1disIbuV9z7ZQpx7YnfQ/xHXoDlCw3fqE115HWCoeyD+iuCFDYBgVZ5M9lV3tVWBz1pU+CSn9QVUhj2++q/s+Egp2jK5NNjtTT5NFSebdCDq02AlfU5DoQJu3/5ahtLKkXJbM0M+czn8ASKerl89EZQf/TcgxxLIkkOzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323437; c=relaxed/simple;
	bh=K1XTGE4MN2P+aCGgRWfp/hPBijxkjr+OSHnR1IeqAE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J52bZRyh1k0CqTpqL42MXRAShrA8H2eCvkp8CtIxLCyco0DU+cWJYk/aHV6JrqEnjw+fdypyyu8YmNNWr7RxH35hQCT4Nf6Av7x05ccaD0IXlTDu/ePJ5OlyAXLH/9FlHrPeKsIk2I8sTVANXjdNw0EVJqPDl47Zh6AMWtT8H7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEEKmRTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE080C4CEEB;
	Wed, 27 Aug 2025 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323435;
	bh=K1XTGE4MN2P+aCGgRWfp/hPBijxkjr+OSHnR1IeqAE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEEKmRTWeodVBjBbH73lkZAxwH1UfRtlk5C6OJ9rRDfTH/5+stFleldq5xVQ8Q51D
	 O1Wh59nNNaGkNOgSJWC3ipzV1KcbAaFmhPmlEjA16F0X+vQUryS5UrzNRwWUFpJvk4
	 GGQL/kdyPcmiqTnaVeYaEP04FmrYH+79HJjsBgwq4bq6etdL0Sk+phfVmS605EG/g+
	 7V0C/YiIAcBVL0MUb8OUKTFsIfooDyAaLYI9Ldm0ZezPdN12Onq7dqBvpRoTkWBF4N
	 LyXdCyW9Y2n8ErWnTZeGn0oL2GuPGTJEksw5piExZp97N9rflX05hGHWjPnFyt+J21
	 roHQNq3oElBoA==
Date: Wed, 27 Aug 2025 20:37:10 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net-next 7/7] net: stmmac: add TC flower filter support
 for IP EtherType
Message-ID: <20250827193710.GT10519@horms.kernel.org>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <20250826113247.3481273-8-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826113247.3481273-8-konrad.leszczynski@intel.com>

On Tue, Aug 26, 2025 at 01:32:47PM +0200, Konrad Leszczynski wrote:
> From: Karol Jurczenia <karol.jurczenia@intel.com>
> 
> Add missing Traffic Control (TC) offload for flower filters matching the
> IP EtherType (ETH_P_IP).
> 
> Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>

Konrad,

As per my comment on an earlier patch, your SoB line needs to go here.

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

