Return-Path: <netdev+bounces-177912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA3A72DDC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840AD1898522
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C820CCFD;
	Thu, 27 Mar 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6gXbVHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731C12CDA5;
	Thu, 27 Mar 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071605; cv=none; b=r7h9NbZ6pvP+4dGFVUTuhk/y4VaudCYVshTMwpYhxJDZYH8ibGGmzGh5DinVwRTfhQ5vEo29cxyF17QaFWDsDUPaC/c9trqq69dZaJ81o+5O+4kE3bl9slJ346If7W5n7kfiDWn44AYzh9lPxqARpPl/r7zRzdM0ZxAkIpSfG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071605; c=relaxed/simple;
	bh=ThaI9ff2qs1t6Y8l0GWnHLtrsC+oNBuxl50t/4RdMk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbnyE1E5STIEwyCoiNsfIb88I3YXJdTMNKTCucEIsoA+PxMHsEWiDHIcIUrdSijoEIIjXnj+NTsJ+guLsKNxoBM1H5BpCjIbHdTtjCNiRDvwjcbhctrcGDbRSmJj130wXJ1+wer6NLtzAb3GlWuAUtz7YpoAJv6fWbkQrtE4RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6gXbVHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AF2C4CEDD;
	Thu, 27 Mar 2025 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743071605;
	bh=ThaI9ff2qs1t6Y8l0GWnHLtrsC+oNBuxl50t/4RdMk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6gXbVHY1abhNWlKKzpDxVw5b/HCBXaHkUO7x+qb4DgD2VGj9FPdvBPcIlgpmqgyI
	 O8Z8WwIHJynThWKEbv3wA6nwm3xI1nxVEiOwNLx8ajabPwaI3RcSfWXstI7SdeEc0w
	 wD6VmS42xZFN/lbVOd0SNTh3YSnYNJGd44AWb0/lnOlrWZWA9W6Hemo5v8FSw63UwY
	 CPCtHQ8mm53b6KonKoPoy/6KQArKK468Pou0szf/7optp9w7ZE1TrLokW48kxVUrzp
	 nFF9bPpEib61wiLbFOyW7TejinulB6PeFeEYmOUKjuK4HsVjW3EFStAGyi/K5BBRd3
	 0jplWNeepqDYQ==
Date: Thu, 27 Mar 2025 10:33:20 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	tduszynski@marvell.com
Subject: Re: [net PATCH] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
Message-ID: <20250327103320.GH892515@horms.kernel.org>
References: <20250327094054.2312-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327094054.2312-1-gakula@marvell.com>

On Thu, Mar 27, 2025 at 03:10:54PM +0530, Geetha sowjanya wrote:
> Due to the incorrect initial vector number in 
> rvu_nix_unregister_interrupts(), NIX_AF_INT_VEC_GEN is not
> geeting free. Fix the vector number to include NIX_AF_INT_VEC_GEN
> irq.
> 
> Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


