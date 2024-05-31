Return-Path: <netdev+bounces-99605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D672E8D5771
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F373B22BB9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F81C01;
	Fri, 31 May 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC3Ibh8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44FA3F;
	Fri, 31 May 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117236; cv=none; b=bWF7eR5oE/qu8ac4afC3AulwQiZlrHeuxUJywMRERK3SRBOtk3NUmuRw+fxZBFASptiPncpTaDNBv6ynBYTiovk/saXrMRCLgveLAClHOuMVGxyzMQhDbEK4Ku4KQpKgzhzhkYEEosHRgPIpGl1RDJaiGjoJCgQU9pqTTvdHHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117236; c=relaxed/simple;
	bh=ES9aO4Lob9Kr+9h0GUl7IBUWqejdBMZMDC6J89Hm2MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W81ijT9E3HgvffHkfsxsphl7ZWDGzFEUpy7C/9RE3FP6+XEeJWumnlcu50MpdL0iNGH9vKUNCsh9RFPIEk2gK4bYQUPC+jN065j8QP27ZpFcgZI+cYABEbjEtzBGx+D3zrRUdRXi7h9m2gcHXXtAM4jE6wM5lV5m0bCSzZ3Fu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC3Ibh8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8BC2BBFC;
	Fri, 31 May 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117235;
	bh=ES9aO4Lob9Kr+9h0GUl7IBUWqejdBMZMDC6J89Hm2MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PC3Ibh8NujyIK0Q2X8jeBUuxm/rHPN5wS/ydDzk4/2qRp/MxRtFRFDb8x1Y/Snnun
	 zx80KggrT64/xoRQO6srb0DpxpYyHSWBQ845YcbkVTlUsKpmmGrvCpbsw867mRbey7
	 LufbeumlXfC6tpcfXtmAf7GjDyJASY/eh3EdqW+xX1iMQxYSudMkpDJtIeYDSooDIg
	 m5l0iIENOmYC41KuRUOQEzASQg3HatyzjiQiw+QBGIE6ky7VXCbPy98Bs7RMlX51Nv
	 ebnfw6TsxgUPKDSq3xrE1iqBsbGdoTcq+KaV0LMakXhDFDVi5w/GVJco2nrksr6nTL
	 1e154XmheENTQ==
Date: Thu, 30 May 2024 18:00:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Message-ID: <20240530180034.307318fd@kernel.org>
In-Reply-To: <20240529111844.13330-3-petrm@nvidia.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
	<20240529111844.13330-3-petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 13:18:42 +0200 Petr Machata wrote:
> +fib_multipath_hash_seed - UNSIGNED INTEGER
> +	The seed value used when calculating hash for multipath routes. Applies

nits..

For RSS we call it key rather than seed, is calling it seed well
established for ECMP?

Can we also call out that hashing implementation is not well defined?

> +	to both IPv4 and IPv6 datapath. Only valid for kernels built with

s/valid/present/ ?

> +	CONFIG_IP_ROUTE_MULTIPATH enabled.
> +
> +	When set to 0, the seed value used for multipath routing defaults to an
> +	internal random-generated one.

