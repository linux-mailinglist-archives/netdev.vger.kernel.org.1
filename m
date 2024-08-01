Return-Path: <netdev+bounces-115114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0196594536B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045D6B21D8C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85854140E5F;
	Thu,  1 Aug 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgXV/mGQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606461EB4BF
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541014; cv=none; b=CGJtJmygCsi38eyHLDVN2HcXMPcOEwJqYHCijwqIW6AviyMW1gJ50ADL1vGkHB7XOkfsHlDnCbL+1xJd5r+F3zyos3nDkispxJTwgXXOtTtP+JhuKaoQN+osMe+g1deN070Osqe1L5oLlWrQrUNP4uQ/PbCCQAojkoeOnKJsEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541014; c=relaxed/simple;
	bh=p7kaI8XM2kVxBIXVv4MEUBH0cp/qhCpMDMVYeFkxrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoUJYUezRY+8DUBhhUSBWE/QjAwsLEqyrZu8uV7Tf2IxCgSBojTqFOUP1eCo9lbaY3lPqcwIpNhTMM+iLfisUKZDAu1V2eHyezVVXK5XX/yfRJFeUd+rddve1+q3kXgCC0k7RwTMYINYtOHoVw9gKkxlxptXdxE0j2BoZltfEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgXV/mGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CF2C32786;
	Thu,  1 Aug 2024 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722541013;
	bh=p7kaI8XM2kVxBIXVv4MEUBH0cp/qhCpMDMVYeFkxrYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgXV/mGQlfRxh1cnKDqkjBpD8fARgyxnmcvil35DTYETP8tgX2tcVFdI4upZ67VqE
	 6HKjLayiIbMnDZ4NI78PzXwn6w/gP6A+CKiQBd/BR+OXzD1njePrY1OiR4NKC3QMcC
	 jIgGHFm22GuTjLjDVPEtHU5HlEa7HWZHGFmpGKoMXBel08atyWdHRU/DiuIStNToKk
	 zuU4yVTVlHrFadu6TuXHsFgEqR33vLUtyG9uKm2BaPDYX3eesjqLovpu+woBYSPZ47
	 4q20jByL0HaE2bm4VkJX8q7xMug9UPMAED7yoB9kwJ9c68fw4uIMkMdhf+SeIQuT/N
	 jPV9/bnJfg4wQ==
Date: Thu, 1 Aug 2024 20:36:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: remove IFF_* re-definition
Message-ID: <20240801193650.GB2495006@kernel.org>
References: <20240801163401.378723-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163401.378723-1-kuba@kernel.org>

On Thu, Aug 01, 2024 at 09:34:01AM -0700, Jakub Kicinski wrote:
> We re-define values of enum netdev_priv_flags as preprocessor
> macros with the same name. I guess this was done to avoid breaking
> out of tree modules which may use #ifdef X for kernel compatibility?
> Commit 7aa98047df95 ("net: move net_device priv_flags out from UAPI")
> which added the enum doesn't say. In any case, the flags with defines
> are quite old now, and defines for new flags don't get added.
> OOT drivers have to resort to code greps for compat detection, anyway.
> Let's delete these defines, save LoC, help LXR link to the right place.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


