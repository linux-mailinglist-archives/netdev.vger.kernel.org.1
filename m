Return-Path: <netdev+bounces-106537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71115916AA9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2960B1F24649
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848C16B725;
	Tue, 25 Jun 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK1oA7w2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CE154C18;
	Tue, 25 Jun 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326368; cv=none; b=Qp+RFHpwWCR7Wap4SmUzYT78vvXxp0sbYt+4Gm4f631ezqNokkbF3yFUXUZjOS29HBSiuBk1ZdVsD6EjuxP4ZJCPmzXiTwHB1EIKLz+cn8vGkx6t1x0iAumampODt3rRZGZ18CbtzqbD8BgZ3eKoRqEbWaeFrm6siBewwYNB5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326368; c=relaxed/simple;
	bh=LyB86D3k1vBzWqSbP53281A2OWOSd8SaUo1kRPk9I8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chZKj98omGbujMxieX7j7X99dlza/VeckcYkhvajhfKBZCWg8sEIM0QlyLFmM36LDIAkQrNsjXrXkG2kMwLorjp43yjgaDtrkJTmF+9tUnGHJLCJylc5wO9ECQRdjR4eYdMK5xcCw7YeTI2jEygur3gMVpXI87gJ/G1HEUJNju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK1oA7w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AB2C32781;
	Tue, 25 Jun 2024 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326367;
	bh=LyB86D3k1vBzWqSbP53281A2OWOSd8SaUo1kRPk9I8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oK1oA7w2L4+qOb1hhZC+cUiVIQH5UemsLT3orNl2Xe7zTjApMTptv0Ugu83Y+GFfZ
	 lXx9HFddmRZG4j4mB4pi6rpOKEtIDe9IY45uOhyeQ9SGbjRpbDDOZsDCwkPruEXa+w
	 yAfW2a1klXD7gKpKIgB7YafR4rX2jzLnLy5pBH8b8fWRk0hI/zVb9VkIVeDe7uDbLc
	 rnE+uIVRh/z35hyz8KLao0dgq1MoAxQxbONe1AtmRyAJs5xoNnb0xVsORSGshrzw54
	 o8Ymto7TJ7g8eBIvK4k6fo7D/V14FfRWZfSnYXtIZhc943Xjn1+TJL9MD/4pOaLSBQ
	 haeZv6CaJPm9g==
Date: Tue, 25 Jun 2024 07:39:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
 linux-kernel@vger.kernel.org (open list), Horia =?UTF-8?B?R2VhbnTEgw==?=
 <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain
 <gaurav.jain@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <20240625073926.15591595@kernel.org>
In-Reply-To: <20240624162128.1665620-1-leitao@debian.org>
References: <20240624162128.1665620-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 09:21:19 -0700 Breno Leitao wrote:
> As most of the drivers that depend on ARCH_LAYERSCAPE, make FSL_DPAA
> depend on COMPILE_TEST for compilation and testing.
> 
> 	# grep -r depends.\*ARCH_LAYERSCAPE.\*COMPILE_TEST | wc -l
> 	29

Cover letter would be good..

Herbert, (Pankaj | Gaurav | Horia) - no rush but once reviewed can we
take this via netdev (or a shared branch)? As Breno linked we want to
change the netdev allocation API, this is the last chunk of drivers
we need to convert.

