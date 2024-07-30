Return-Path: <netdev+bounces-114237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21550941AC9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10171F246B7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1831898F8;
	Tue, 30 Jul 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Q8hK6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0918801C;
	Tue, 30 Jul 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358044; cv=none; b=a+D8peNmvEZU2uUuO8oVByIwHr2odkGeDwUr9A7wYE+UzSz0KaWPH/EWBbCInXxM6vLyeNmxCjqAY5ZvvZCWft/mC7qHtpO8pCmGBwuQ5YumJ//FLuM//m57BjULaXwPOusx1JK7OdHVU3gjxJdSYZ3Aa8RGb/qHJL8Wbl4tCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358044; c=relaxed/simple;
	bh=iW188wid2hsi1VixfIG9omx8ew2kXFpKnTpf5Qc/Yxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgFdYi4MypeR9by0tL1Iis+1PoceqQrt75RBGik3rG+VAE6O+9v05IJ3RvwXoCFlqcB1a9sfvdKh+J8BDuDbEN5+7qzdmqrXkEcAMRFtlYPtWYW0N7WlbiD7snUmRyCoJ+5lEPCEPbim3pyggJIgTr2LSaJM6Qdg7TOVfQ3hdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Q8hK6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B5AC4AF0C;
	Tue, 30 Jul 2024 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722358044;
	bh=iW188wid2hsi1VixfIG9omx8ew2kXFpKnTpf5Qc/Yxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8Q8hK6OKoY54+DqzqfjdHbcEcKcXGDbVC72g5qWSyznb3Xdpy18F8WQsCencn0Nw
	 QPrpL4P6FNP5Lzc62ESwByJcRnjf9fzuslez1BCbJDtv+qz6CSZSZdnqXyQvZYbBHf
	 yVFOAQay2ROMuG9BEY4TlIjAiZTXZHfl1tp7nnGpWDSEh0KlPp5R6d2t+WVeatZD3+
	 T3i7ZlL2hCEhirukzB1No16poU+fqee5x8wnYe3wg0Ll26qi1ifdEp2vFD+LFizB6z
	 BLUranhqcRysEyNKMBX44U4mqjOZS/T3jvw2v3/o0Np6XswCd8TIOwiBu1mftDMlMa
	 nVb5MzdNnFI1A==
Date: Tue, 30 Jul 2024 17:47:20 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: Add skbuff.h to MAINTAINERS
Message-ID: <20240730164720.GF1967603@kernel.org>
References: <20240730161404.2028175-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730161404.2028175-1-leitao@debian.org>

On Tue, Jul 30, 2024 at 09:14:03AM -0700, Breno Leitao wrote:
> The network maintainers need to be copied if the skbuff.h is touched.
> 
> This also helps git-send-email to figure out the proper maintainers when
> touching the file.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changelog:
> v2:
> 	* Move the entry from "NETWORKING DRIVERS" to "NETWORKING
> 	  [GENERAL]" (Simon Horman)
> 
> v1:
> 	* https://lore.kernel.org/all/20240729141259.2868150-1-leitao@debian.org/

Thanks, v2 looks good to me.

