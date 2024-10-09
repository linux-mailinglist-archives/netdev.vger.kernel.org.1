Return-Path: <netdev+bounces-133659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51589969D5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D13D2848F6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D121192D89;
	Wed,  9 Oct 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqgHid9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6201922E5;
	Wed,  9 Oct 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476487; cv=none; b=erm2S656Uzx1f6l3xmJXPUWs3pi1n3MUM8wOxI3owuOAj6omikjxQAoansZVVhOfGNALLmYDA4CKAoKK8gr20kX8HDnboFGFaawYWgBkBBtdNRpc6nDrZBPSf6asPvuVTsyGQohjlWc07GQgNqggrb55Q0RbBdHEXg1fSWEh4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476487; c=relaxed/simple;
	bh=MMKsuUZ7GNsnHwqHzxr4QZeRnXZjW/cLz7nirJtz+nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLePUL2DY4h9tBJSO5OL06RfSOYhSbkSpR+9VIx2m5b3l7kPvP0Gw7foiXpzSK+Rk8lYBLXZKH/7kyoTcYqbAA/xFfaJt5JnEtOKi4wslcUseInoz2F/YJFNyQGpebD9OIxV3f//ybq8Y1PZOL7xuWtpfCDb91MbEyiw8DZmaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqgHid9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA06C4CECF;
	Wed,  9 Oct 2024 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728476486;
	bh=MMKsuUZ7GNsnHwqHzxr4QZeRnXZjW/cLz7nirJtz+nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqgHid9vFd11LunT4zVyTj19L8Bf8At2xOEaIHK5fU7nwdbl8PMj3P/worh+ldaFa
	 n8RguXmMAstARuQWDGK/MucTUlJYwK+O8dZp0CSFr6AL1XTbzozqogHPZWG6706jpN
	 PsMKgo/eC0xW4v4Gkl27Rvrtdkg1IpM4mA9ErmKS9YObVV8kzdBC51D+cit+W2zTKO
	 5Uu+7W/tacoE3hkNIA87yHpAxHRqCw4qsEgkv5aV6ddnKqPGxDB8/vx8p1dFF9lNRI
	 Y8YQVf0U/nvFFsu8TIIkTUoUMO4r2bqs9AvFqEFEM8uaXECKKa9ylvi9g5xx32rJBL
	 SlDYgr3gvzqeg==
Date: Wed, 9 Oct 2024 13:21:22 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] netdevsim: print human readable IP address
Message-ID: <20241009122122.GO99782@kernel.org>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
 <20241008122134.4343-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008122134.4343-2-liuhangbin@gmail.com>

On Tue, Oct 08, 2024 at 12:21:33PM +0000, Hangbin Liu wrote:
> Currently, IPSec addresses are printed in hexadecimal format, which is
> not user-friendly. e.g.
> 
>   # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
>   SA count=2 tx=20
>   sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
>   sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
>   sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
>   sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
> 
> This patch updates the code to print the IPSec address in a human-readable
> format for easier debug. e.g.
> 
>  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
>  SA count=4 tx=40
>  sa[0] tx ipaddr=0.0.0.0
>  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
>  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
>  sa[1] rx ipaddr=192.168.0.1
>  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
>  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
>  sa[2] tx ipaddr=::
>  sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
>  sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
>  sa[3] rx ipaddr=2000::1
>  sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
>  sa[3]    key=0x3167608a ca4f1397 43565909 941fa627
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


