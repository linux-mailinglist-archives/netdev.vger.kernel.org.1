Return-Path: <netdev+bounces-150767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9E9EB748
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D216280C02
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76E1C2DC8;
	Tue, 10 Dec 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO2lCGPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B31AA1E5;
	Tue, 10 Dec 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850051; cv=none; b=O1jvWo9IAqjOWtK7ql+eXjlrSBaL/uT8L7gKwQfYTcC5GNl0q+KH6pv3ak7sSDwyJEI/ds5PDBwV4w489bjTUUzz/4Q82jhiy823joMHtIBC/1DvOh4toXm9sqsXlzsGDMQ7YtTLJMsCO+MEwt8r02gMXieDrlb+bqwJ+eZgDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850051; c=relaxed/simple;
	bh=1PDd8uGZupfHDrOEaJNWBGi5/aMu9Oa8BwOhWISvABM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc/bkr9A6lIPtmkjMgVgxr/28eAdFVR8yOlaMz06QS0VuI5An2qQJgpuJfGlNN5SGdfm8aNS002AsPX1VyLRYscoSRGCIGFUacf9EUcGP1M+s4/IlSFaoJDgFwd0kW39ZL3EjIiK/XrK3bkZQKetVAFIfCv6nG1rotXGG+Mop7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO2lCGPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206EAC4CED6;
	Tue, 10 Dec 2024 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733850051;
	bh=1PDd8uGZupfHDrOEaJNWBGi5/aMu9Oa8BwOhWISvABM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LO2lCGPOosp2jJyVMspmxnntroXHCrD9R4uqrRPY2DE4AWJBsCKspT1GpfPdDDH3k
	 s7Gfo0VHtge2rUQMkei8DuzILitzj/uyYS1ref2qj2WFgYGinOCQXOPDqdnQIVwLoD
	 /MIqLobFo3HVITFv7VrDUfGkyNqKJJAbqoNm212ta71RnSd421mbLSobOs4MLLLnD6
	 tqRtbj0YJUD9rYKsh/cis7qMn9K7nP+tB7NbE57Mao1SOImOFhYwfbfhv9lEIhL7Wc
	 6hlRu5jVrzLwSW2HUBwbmE+AlOfBcbCago2FK/WDJwlGw3irCaCF92Qp/P70S55b8I
	 kdSu6+Rz/3G3A==
Date: Tue, 10 Dec 2024 17:00:46 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: hinic: Fix typo in dev_err message
Message-ID: <20241210170046.GC6554@kernel.org>
References: <20241209124804.9789-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209124804.9789-1-algonell@gmail.com>

On Mon, Dec 09, 2024 at 02:47:30PM +0200, Andrew Kreimer wrote:
> There is a typo in dev_err message: fliter -> filter.
> Fix it via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Thanks Andrew,

I agree this is correct.
And I see that this codespell does not flag any other spelling
errors in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

