Return-Path: <netdev+bounces-44511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DAA7D8567
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808961C20EB8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836C2EB1A;
	Thu, 26 Oct 2023 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5Vy8LWf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F682EAFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC7DC433C9;
	Thu, 26 Oct 2023 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698332376;
	bh=ZROp2oPSB9jGPftAzPt+SBtEusxJ/81vyabcRXqWoHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5Vy8LWfM7+8DoEZQ5CTdEZnfIZen84yqEIAJsFEuFAdn0dUs9Sjc0Y09jfi2ndfP
	 ai6ZaB1Kn92ShsEWdZEuqZDWZh+1ncmv2d/oRkBiYnO5tAoTro/QtzH+CtP5U55/ck
	 ra9szOwhESHZvnnDN5gbC4e1yTlr3qUSuMFukjGciOFakWhiC9sh0Z/LlA3i07Midy
	 TAd0MbPymz4UH0TcmM/XibqCiZx6SEXDE7DjpuNrN1Q/piy2VNbaATk1WjM/Ml2pT2
	 VchHWjr+XEeh0i6eognmjY10q/ypgyyTSclpcw1Db+qdBb/0XlEYxCVLX6/F3lXxvc
	 pj+TAGj7aUW2A==
Date: Thu, 26 Oct 2023 15:59:30 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3] MAINTAINERS: Remove linuxwwan@intel.com mailing
 list
Message-ID: <20231026145930.GC225043@kernel.org>
References: <20231025130332.67995-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025130332.67995-2-bagasdotme@gmail.com>

On Wed, Oct 25, 2023 at 08:03:32PM +0700, Bagas Sanjaya wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.
> 
> Remove the ML to keep Cc: lists a bit shorter and not to spam
> everyone's inbox with postmaster notifications.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

From my PoV this is a good step that cleans up the cited issue - a dead ML.
And futher changes can be addressed by follow-up patches, as appropriate.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  Changes since v2 [1]:
> 
>    * Keep M Chetan Kumar in MAINTAINERS, as Johannes is trying to
>      keep in touch with him. As a result, this v3 is reduced to a
>      single patch.
> 
>  [1]: https://lore.kernel.org/netdev/20231023032905.22515-2-bagasdotme@gmail.com/

...

