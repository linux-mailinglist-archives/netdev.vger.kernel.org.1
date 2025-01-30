Return-Path: <netdev+bounces-161665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315BA2321E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EDC3A3060
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D91EBFFA;
	Thu, 30 Jan 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjQ6UVm+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC91DA5F;
	Thu, 30 Jan 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255349; cv=none; b=EcmJmK/c2b3LASlsyHVb9fYoMzBIE0Uhu8+16k1oYmsh18uWsF3KS90p6el9+fpdPdG+c35N6tcLfaGBLPex+rrjPPJf+LbO+QwWrBGJ+jBnYo0PoqVde4Ql2ioOlheF6i2UG68Ij/5t8j2cLtHaZkac79YMeDEqTQ8NxDrR6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255349; c=relaxed/simple;
	bh=C5tkHjl374egAiLs9CufmhrPlTwqZ5f3MDt2W48Fah0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZO+TRDaYnKbg1zA2w3h47T+EpUlaRedt58o+i0Q9bsopJfGAU1GCdiHhW8o/H53AydHmyzKibF8oD94Lwt295q7THmqMNUoyrbr23gFL1ookA1A3vTrbRA/ahoWzhHkARUSitGd/6IhYeCNmrFi3yI8BAn3pDYyKmDzvqMSE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjQ6UVm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F9C4CED2;
	Thu, 30 Jan 2025 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738255348;
	bh=C5tkHjl374egAiLs9CufmhrPlTwqZ5f3MDt2W48Fah0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HjQ6UVm+Tn3kGwGOs+WUMFM+2d2BFeaqgo8OZuDJ3OuqeZIUeTmatcjrlTWoXavfz
	 JsGtfnSNz06RYkiw+3CbOLmbIobchpeLDGIk4w2p8PVyixjXCkns7boE0F2DHRleQS
	 uaho1qIZvZLID3qt31uAX3fSq9S4pP2l+QRE06kSsGwn5iW0v7N4MpSWbkg7pn3uGH
	 Onxt1/AJsBr/AGXYn923MzEXEXHjjL3EJrgT6VwqGNysmnd9D8lQ7Wdz/JZTu63NMh
	 BtShqurgrJHjc1CzWrEQ2xRhKV0YNgpem7Pgd9f7H4TXNUee2Z2hlcLhQwBNCcwNUw
	 T5hLRIlRp4RsA==
Date: Thu, 30 Jan 2025 08:42:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: ethtool: tsconfig: Fix ts filters and
 types enums size check
Message-ID: <20250130084227.51e29094@kernel.org>
In-Reply-To: <20250130102451.46a4b247@kmaincent-XPS-13-7390>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-2-87adcdc4e394@bootlin.com>
	<20250129164508.22351915@kernel.org>
	<20250130102451.46a4b247@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 10:24:51 +0100 Kory Maincent wrote:
> > This is just a code cleanup, the constants are way smaller than 32
> > today. The assert being too restrictive makes no functional difference.  
> 
> That's right, it was mainly for consistency with the other assert. And to avoid
> possible future mistake but indeed reaching 32 bit is not expected soon. Should
> I remove the patch as it is not a functional issue?

Yes, drop it please and repost after net-next re-opens.

