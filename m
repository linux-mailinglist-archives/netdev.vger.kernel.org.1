Return-Path: <netdev+bounces-89847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B618ABE54
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 03:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7014628130B
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5C1FA4;
	Sun, 21 Apr 2024 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3zrz3WV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E138C
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713664278; cv=none; b=SCFOmI5QYhuYpeJXsOVCypyhVdJCk1obSnzaOr2qLHQo12/Wnfs318o2ZCn3JTHFFo3bCRz9VIGPKEIqgrSitIZBT3oKtLKsoRHd2OHRc4TCbm+YiusT/fj0irndz4XmMcUuRMtkG22YJqCmu2zuB+fGMHjqX3LaW6x2PQYJ5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713664278; c=relaxed/simple;
	bh=V63Hl+0d09bV/EgkpCeaWGAt9rZTvABgNHE90qihmgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hhpVgui6I5Z6frjTrXx3JRFQFKkdY5ExtShUOiUcqTxdOvvTDl+GVXosVgK+TU34KhcJnm1J2+PF6xbHtCOawg3rr3l5QfRrIb3nX4EP6KO534ayCbqoOSzHQw4Y9C8vTwReHhLnKQZUDWp18iqzN9GXX7ECOoOonY7PYVCFRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3zrz3WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E5FC072AA;
	Sun, 21 Apr 2024 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713664277;
	bh=V63Hl+0d09bV/EgkpCeaWGAt9rZTvABgNHE90qihmgc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=s3zrz3WVXBQtSlWxTtCTExuEMC/a0u8OO790pUEuwjQHxTJKW2+bzXAWMojYOWULu
	 iMRcF4Kim0hxV9gSA+fVgNBfc15yxe7V3c0kUn+MPhHaSq+h54ye6cvYIPmicAUSOH
	 graGARaywNyH4aHjOren8/HBE593XVJUzWEN/4UzYQgaSn1SLgmCjp2A0MtbZZmIld
	 kAcHn8W3QwyGZjkP0FbtAUzOzC+SNGUZPm8gxea1OL9YFi+phiY+XDw8TinQhQZiWh
	 siCEJE58cHNzQ2Xf1ugqhvmdrVG1d3KOlDRfSco+WyvFnC1P92rlHT2UjPBIwGaty+
	 qiWWjertaHY9Q==
Message-ID: <69e70f69-f314-4346-95d8-4ced8e7f66f0@kernel.org>
Date: Sat, 20 Apr 2024 19:51:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/7] unused arguments
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240413220516.7235-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240413220516.7235-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/24 4:04 PM, Stephen Hemminger wrote:
> While looking at finishing JSON support for TC in all places,
> noticed that there was a lot of places with left over unused
> arguments.
> 
> Stephen Hemminger (7):
>   tc/u32: remove FILE argument
>   tc/util: remove unused argument from print_tm
>   tc/util: remove unused argument from print_action_control
>   tc/police: remove unused argument to tc_print_police
>   tc/util: remove unused argument from print_tcstats2_attr
>   tc/action: remove unused args from tc_print_action
>   tc/police: remove unused prototype police_print_xstats
> 

applied the first 5. Patches 6 and 7 required too many adjustments -
easier to respin the patch.


