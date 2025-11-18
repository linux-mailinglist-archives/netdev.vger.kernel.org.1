Return-Path: <netdev+bounces-239302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62546C66B23
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 73AFD297C9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0805212549;
	Tue, 18 Nov 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFNBWEJO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895B78F4F;
	Tue, 18 Nov 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426802; cv=none; b=cwjeXXfpeVSgHc7gF5JSwXae6DQdMTC343gYxISI2VQfyFZrm4SyjEs3yi/3+2vG9BnRkiw8DTPbpXXv6pqaKLnWHKYfxZnN8K2p/MkCz9zqiIv3mue+buSyanC3/k3w3KOiqgoxmAU2R1PW0ybPwmjf4iB+tfKN6NGMgcr1NMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426802; c=relaxed/simple;
	bh=ipcOyQbTTPnMo22v3zWvt0ge2+1gF/2FP1ADLPquZwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVDmuctzGbJwDXhmWq8gP6KBXzM/zlBNLrgylbDqUoFojQwu75mYnZ44CgDhuIdsgtvGhFnAEvknW4k2tFcDhqOx5CRcleTyKPIaSG2iPnLTthLhngGmKd0gQfOoLpXrfYiG8IbmNBPhLWZdZAZXC1agCGI4MqjMXjui/T2mL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFNBWEJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88D4C2BCB3;
	Tue, 18 Nov 2025 00:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426801;
	bh=ipcOyQbTTPnMo22v3zWvt0ge2+1gF/2FP1ADLPquZwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFNBWEJO0FcMeqi6mFkjlxnGNkGDpmlXFpnUrGjSTfwWIBIToQqldZ+BRmmkdDBWc
	 fK1Fr8H1dhoyVENEu/RRbLLi3JUV69uOAr+oe13YS/MCYqHp2v1AddnOT9D3Gr34gW
	 RBZPLDEXJJwtyo5vZRlN5trgYVNa2WHC19XBN0FfypV25WNIrpfGjK3ooezLSONX16
	 4zk8wKEBamNf/sIH4JFOcMf9gEH2XY71rTNnuA2av3pMBEVSbpTTcqD6oiX+iED3V6
	 H7OClZVLfk3T5m6sw3Zvwhq3bEDpUR1MuUFg1B3ut1Hir9HWYBmaQVaIXwpjTRKnfI
	 8L/SvRZVAUFzQ==
Message-ID: <698e0349-f392-4c73-804e-bcdf4fab825b@kernel.org>
Date: Mon, 17 Nov 2025 17:46:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] devlink: support displaying and
 resetting to default params
Content-Language: en-US
To: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
 <20251117-param-defaults-v1-2-c99604175d09@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251117-param-defaults-v1-2-c99604175d09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 5:40 PM, Daniel Zahka wrote:
> Add devlink cli support default param values.
> 
> For param-get, any default values provided by the kernel will be
> displayed next to the current value. For param-set,
> DEVLINK_ATTR_PARAM_RESET_DEFAULT can be included in the request to
> request that the parameter be reset to its default value.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  devlink/devlink.c            | 83 +++++++++++++++++++++++++++++++++++++++-----
>  include/uapi/linux/devlink.h |  3 ++

uapi changes need to be a separate patch that I can drop when applying.


