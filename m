Return-Path: <netdev+bounces-115736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07150947A36
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B700F28227F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E0154BE4;
	Mon,  5 Aug 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0+GqTiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9614E2FA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855927; cv=none; b=ebDA8V5xNYF+OOZW9zGflvbmpk58P5vgpIzqaiz0E+Jtd8mqVx6Omqmyey2EV/UmzI8gMgq1Kco49/zEdZS+GeBnfLxHS5MZnf+OHvmyQYVfk1Dvazf5JKJvdHv3igufroRjkPgnJh+rIssaY3l+e2ZWu7Ll+Jytq5++xEMHN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855927; c=relaxed/simple;
	bh=7YcJSrIzEFqmM4t2F+elmzTTTJCgV5nN26fXQgHVm3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N41g2dJZYZtwGoFGZGig3HxKYsQullfZvOFsiNWwn8Gjllg8h08G70ftPagLC51MpBtntNq2uVOFCerDXzX9pzdYaXmkWPVkRRmpImlYenNR1l7LdwWFyKepXNLFCCjQXEsFwkYRCM8rG987UmDNbtM3HgUPHlpTTskn7hrmg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0+GqTiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F7C32782;
	Mon,  5 Aug 2024 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722855927;
	bh=7YcJSrIzEFqmM4t2F+elmzTTTJCgV5nN26fXQgHVm3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0+GqTiUH/dbF6l90as1hrVENTmd9qxfKALrL15MVdxUYqe6ykmufGYUjy0Ruj6rn
	 Tvg0yu6PPlpR7NNMRH8mch/NYqr6LR+xzPGJ1oQWsT1pH1m7utDyxzjNoAL3hJvNWa
	 hQQjrrVbnKbnefA2yKm1QRzUmC/tYX/NIECEHzX9gyqcOLeMfDb4/ZqUZsEcxzxYX+
	 Bq7weEFlCxMDx1jkm/Br9DX3qXvtwh6iKSqoE88nhsK/5wUqg+jLVlLzi4Wdu4+2y6
	 n8HiLFzzpY91qj4utWbilgxzWQuG1asrYQtFlHCZRx+j554HKJ+IAQp8+3LvUTLpQH
	 dMOornmBg62Sg==
Date: Mon, 5 Aug 2024 14:05:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andreas =?iso-8859-1?B?Sy4gSPx0dGVs?= <dilfridge@gentoo.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	base-system@gentoo.org
Subject: Re: [PATCH] rdma.c: Add <libgen.h> include for basename on musl
Message-ID: <20240805110523.GC22826@unreal>
References: <20240804161054.942439-1-dilfridge@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804161054.942439-1-dilfridge@gentoo.org>

On Sun, Aug 04, 2024 at 06:10:20PM +0200, Andreas K. Hüttel wrote:
> This include file is required on musl for availability of basename.
> 
> Note that for glibc adding the include can have the side effect of
> switching from the GNU implementation of basename (which does not touch
> its argument) to the POSIX implementation (which under certain
> circumstances modifies the string passed to it, e.g. removing trailing
> slashes).
> 
> This is safe however since the C99 and C11 standard says:
> > The parameters argc and argv and the strings pointed to by the argv
> > array shall be modiﬁable by the program, and retain their last-stored
> > values between program startup and program termination.
> (multiple google results, unfortunately no official reference link)
> 
> Bug: https://bugs.gentoo.org/926341
> Signed-off-by: Andreas K. Hüttel <dilfridge@gentoo.org>
> ---
> Only build-tested so far, but should be straightforward enough...
> ---
>  rdma/rdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

