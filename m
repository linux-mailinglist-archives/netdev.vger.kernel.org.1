Return-Path: <netdev+bounces-115795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67246947CDA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947A71C21C2C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983813AD18;
	Mon,  5 Aug 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NARmnsY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BB78297
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868282; cv=none; b=dKy+EviwPpm4Qs2lQNb4glcSFUb2hQB5KCzQk2i+9+pwF97dpn3TRDVWO6wnAz4Dt0DWZUbNPD+pr8CUr88B4bHvwjOnlhqe4l4w53PELz/eNHNBHw/NjDLnz90yctBwd9EUmIPDCHaFI1T9QAkbp54Gk3V4np9KpPsWVYOprNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868282; c=relaxed/simple;
	bh=qJv6VQ5d3WbR3WyXUEvRdgdMvxcup2itbv7QPcEJsjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8vbAx0My9rNT8WvWR7/+CStvP4hrej6Rc+Q+OKL3BocaiLCVR69IFnobg887mDIRC7mz/fJJkfVanndlgN5QczNZIhg7tXcfwKj2FuuMXgBj0bLfcId381JN+5dgETB+YT0Xit53wKvI+64P0cNcZYCmXvH/3OzHPf2Ivxi4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NARmnsY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A467CC32782;
	Mon,  5 Aug 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868282;
	bh=qJv6VQ5d3WbR3WyXUEvRdgdMvxcup2itbv7QPcEJsjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NARmnsY15SiIZUenfx7GeD1yAvlvwBqm+IQXFYRJhDTVbaXE5FS7VvTriZ6r5i6/P
	 ZwnCYpoR5YzUV2gCtdF/AmnlVbDzVQdY5gFCuWcYNQIJPN1A9Y13wBKEH7TvQw6/MN
	 ehUL2d3FGBxRSMCp48SIn+1XVrBz8j1c2+B0f1Orguj1RqXaNSpFIhLUa+c11Xmpeq
	 0BBE9IF3Nmex1ncUhVmqu81WxnH/7A+PfMAl7gyhQuFYiy7P6EUkqpLSRZdp3Sg8d1
	 MIxstQYFSTmjvncmHYw+qSccvApNSldX9rD4nduTZFzCq7e1lBg6zX4y25CJj7Fqd7
	 Rfgtu81g6HZ4g==
Message-ID: <a4232f44-74df-48e2-81c2-75311f415002@kernel.org>
Date: Mon, 5 Aug 2024 08:31:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: nexthop: Increase weight to u16
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Donald Sharp <sharpd@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1722519021.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/24 10:23 AM, Petr Machata wrote:
> In CLOS networks, as link failures occur at various points in the network,
> ECMP weights of the involved nodes are adjusted to compensate. With high
> fan-out of the involved nodes, and overall high number of nodes,
> a (non-)ECMP weight ratio that we would like to configure does not fit into
> 8 bits. Instead of, say, 255:254, we might like to configure something like
> 1000:999. For these deployments, the 8-bit weight may not be enough.
> 
> To that end, in this patchset increase the next hop weight from u8 to u16.
> 
> Patch #1 adds a flag that indicates whether the reserved fields are zeroed.
> This is a follow-up to a new fix merged in commit 6d745cd0e972 ("net:
> nexthop: Initialize all fields in dumped nexthops"). The theory behind this
> patch is that there is a strict ordering between the fields actually being
> zeroed, the kernel declaring that they are, and the kernel repurposing the
> fields. Thus clients can use the flag to tell if it is safe to interpret
> the reserved fields in any way.
> 
> Patch #2 contains the substantial code and the commit message covers the
> details of the changes.
> 
> Patches #3 to #6 add selftests.
> 

LGTM. For the set
Reviewed-by: David Ahern <dsahern@kernel.org>



