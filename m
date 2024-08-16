Return-Path: <netdev+bounces-119246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2C954F66
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F8A1F21855
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FA1BE241;
	Fri, 16 Aug 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cICrCmNu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E638156F5D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827474; cv=none; b=SDTa32Rxm/7SOXRDtNnjwcaQLrJVXTHBoleHV/kcw2m8gYOKOx60ppKE/pLR9WFC2h//tuhWWgw+Dg07PPBHr+rg6zexlDyJU46UG3TA4bdm6fb5MLlzT7tuWEj9v0irhXfHlFdONfCDIFBii2jdfUuHNYfcSG7x8kntj0P/DmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827474; c=relaxed/simple;
	bh=gASyQrVX1cUhl0eSvF2hY/td/3vRsyJJJeXPVRwCWG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozn5lQp2lCnEvCJzE3wvON79C3euL2ufjXE0WKb55H1TxJCqTWP/j6pIPagKgx3WUZXC+CFpbweo1eGcB6xgPDxx3LAMyblMndhP8M0HrG3fb/XUyoGUi6rKp8wQ1m3z0aX46tGIvQbFXfAZeQav5Q+X55bK65kmAaDOlejQHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cICrCmNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C8C32782;
	Fri, 16 Aug 2024 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827473;
	bh=gASyQrVX1cUhl0eSvF2hY/td/3vRsyJJJeXPVRwCWG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cICrCmNuppIfo7h6wTIHzeymTRvM6DbkkdOHLW8Kryqc+esOY5P99KcafQ6dUQurs
	 5JWjxqlqIEWp75lAqweqU1vxgRQC3kF9XqoMbpY0pI5SDHDsUqefq1x/FrZxiSacQG
	 9D9zkfLeOCN1bvJtEpFiDetZQZJCXl4w6U6cetLfM7sXihX+0jfXQuDNy6RgYVpefI
	 JpfC5Si4jCxzKELzYtACBtkPy9FkPd4b1EOW9vJA8zBHPa1SH87nZ4ERwbdwz4Rjv9
	 KZaf9AQ2+XZ8Ek9YxuPXopKkg55A2A6qyYjZHfELPyXgGPS9uMGbtwtnTxnG7b03W4
	 CnUZL8DDEOLmw==
Date: Fri, 16 Aug 2024 17:57:49 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
	Guo-Fu Tseng <cooldavid@cooldavid.org>,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/4] MAINTAINERS: Add header files to NETWORKING
 sections
Message-ID: <20240816165749.GC632411@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
 <20240816-net-mnt-v1-3-ef946b47ced4@kernel.org>
 <20240816132535.GA1368297@kernel.org>
 <20240816083858.6fddd8ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816083858.6fddd8ec@kernel.org>

On Fri, Aug 16, 2024 at 08:38:58AM -0700, Jakub Kicinski wrote:
> On Fri, 16 Aug 2024 14:25:35 +0100 Simon Horman wrote:
> > Sorry, net_shaper.h doesn't exist upstream, but must have in my local
> > tree when I prepared this. I'll send a v2 in due course.
> 
> Any thoughts on using regexps more?
> 
> Like for instance:
> 
> include/uapi/linux/net_*
> 
> should cover existing missing cases, and net_shaper when it comes.
> 
> include/linux/netdev*
> 
> could be anther from the context of the quote.

Sure, let me try and verify that we don't get any unintended consequences,
e.g. via false positives. If not I'll update the patch accordingly.

I agree that it would be good to catch things that don't exist yet.

