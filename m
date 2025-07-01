Return-Path: <netdev+bounces-203035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE3AF0403
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A5188D6E3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A92820B7;
	Tue,  1 Jul 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJO3hgps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88C27FD5B;
	Tue,  1 Jul 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399005; cv=none; b=dQhFCPGIZahqqFMNd71y4KTT4/OP2OryFvv2WUp5j3iZxTaaIheGq68Q768S/6vvsakHta3eqxv1n/83Mdk9394h8ZTvXLdqCy7n1q3jXuMzY5MnJL82cRiSiewgPccbLDLOu3Ow0koPrRtqR5G5Eg2roS7LzM91VcY6xq5fIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399005; c=relaxed/simple;
	bh=icZlz7R3vFdcA2pibeP+QCTT5PR2YOh1fqsef7gF+y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYwec1okWwQGY/4AfIOYxAwUhMraiGu3qcm6KuUyfK2x99JQp7nK4oQV9bIHWNgIIhrthbNDMkq5iIVBPCgQrH31iQOqGS3kYiOmTJHHWeulCRRrbEmXDgJm6saOGia47GQBPioqWw7V/YO+DexaBtCUh5t9a1nDGNUco9+OLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJO3hgps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F3FC4CEEB;
	Tue,  1 Jul 2025 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399004;
	bh=icZlz7R3vFdcA2pibeP+QCTT5PR2YOh1fqsef7gF+y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJO3hgps6FUm7R0t9OL9DPJi5Ez5Q93dfx8OdoJkNwHqI7BasTJ364lgeCqvlgwp6
	 gfFbNHUdrsnbwspX0G2YIESwpVbouSN1GQHE+NmZh4v12mXE/EwT3WJNdpWPpj635X
	 lzqyHCFzpuhgydcgQHaAc/QT2b+MUdo4h/zVuAbiqYNRrX1XFTeqRsJwj1FslIQDQa
	 7cwb8JpoHw0yOMc91FbxCFm2ZU66jTOj92hPjE6gDSQKxOdp8Gl5VyQFKT/1c65IXk
	 njyJbefEuBJbtO1cIqLY4Nv7KOOzPp2SDkrOnwfvBesdf4neC0OyCTybxRpP55q8XV
	 UTsJde//14HSQ==
Date: Tue, 1 Jul 2025 20:43:21 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] lib: test_objagg: Set error message in
 check_expect_hints_stats()
Message-ID: <20250701194321.GB41770@horms.kernel.org>
References: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>

On Mon, Jun 30, 2025 at 02:36:40PM -0500, Dan Carpenter wrote:
> Smatch complains that the error message isn't set in the caller:
> 
>     lib/test_objagg.c:923 test_hints_case2()
>     error: uninitialized symbol 'errmsg'.
> 
> This static checker warning only showed up after a recent refactoring
> but the bug dates back to when the code was originally added.  This
> likely doesn't affect anything in real life.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202506281403.DsuyHFTZ-lkp@intel.com/
> Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


