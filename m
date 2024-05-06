Return-Path: <netdev+bounces-93771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF418BD2A6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3E32833B3
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E1156997;
	Mon,  6 May 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2YYDBvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D104156656
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012631; cv=none; b=hT5PpUtX20I522Wdb/10adk5bRlNoiOtMoa680IJcHdDwj5gTDHE3GXEjPe0yNOKYiC6CoF+OzlIxYb37XbJTnbWICK6f3q4UDc8uYaumTdycJJahLQh+BuNdE+5h9cdon0yDbDMslnz0t6+wfi5521XOdWz+vSAG25xXTaPOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012631; c=relaxed/simple;
	bh=7TlM8mmsl/WTQtkht4Y1i59zCoa2yVvzYIQ46uRFCRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwNIWYTVaxc0BwHMZen2Z0YrMieW7/zx1YVkRyOEED8l2+R7PXL1TaXHMyEd3IBScPoE9CfOIvv5tjKiF9vaRp6oxP5nUy/3+Wtpbd4jmYuY0J6MSFOSKX5PFxuKFHOuFaamPiJ6M3U84YQP+y0IzuaDeJHvC8mh10qsuXv6Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2YYDBvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEAAC4AF67;
	Mon,  6 May 2024 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715012630;
	bh=7TlM8mmsl/WTQtkht4Y1i59zCoa2yVvzYIQ46uRFCRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C2YYDBvBmxaAQOKSf2PFm09rf3S7QUMdbDZ/dDeE6e1EzZz5YlGs0b8Q2sLYNeFTF
	 DlvQH1WtKHZ0u18fO64CbFQcBR0wg2wGj+70sfbTF6snxZInSFKHP4E+Km7XIPY7pi
	 SahrrDUmXnNWI1yQjdLdrHp6k1k/lpkgtL/8SdeDkdopRXsfyxX9K+dYNaHZocrt8g
	 EjpZYWSW34fe2HC5oahpcNr9M0Zz58/+aE5muC0SVlr6hn/3ySvCv1KsB73eXacjhY
	 Tiyg/1eJpGmV8RsEUFVocsIclckJMKY36SGwQwSErz1R/c8jFQdWmzaASC3owszBrm
	 cqdDSdrIL+fUw==
Message-ID: <f1da8bb5-4668-40de-93cd-3a150d000365@kernel.org>
Date: Mon, 6 May 2024 10:23:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] rtnetlink: change rtnl_stats_dump() return
 value
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20240502113748.1622637-1-edumazet@google.com>
 <20240502113748.1622637-2-edumazet@google.com>
 <d09f8831-293e-45ec-93fb-6feab25d47f2@kernel.org>
 <CANn89iKPSp9_bZAZpFM4biEg7vFXxMmY2nQfEmTfLsiHGdBTxg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKPSp9_bZAZpFM4biEg7vFXxMmY2nQfEmTfLsiHGdBTxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/24 10:03 AM, Eric Dumazet wrote:
> On Thu, May 2, 2024 at 5:59 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 5/2/24 5:37 AM, Eric Dumazet wrote:
>>> By returning 0 (or an error) instead of skb->len,
>>> we allow NLMSG_DONE to be appended to the current
>>> skb at the end of a dump, saving a couple of recvmsg()
>>> system calls.
>>
>> any concern that a patch similar to:
>> https://lore.kernel.org/netdev/20240411180202.399246-1-kuba@kernel.org/
>> will be needed again here?
> 
> This has been discussed, Jakub answer was :
> 
> https://lore.kernel.org/netdev/20240411115748.05faa636@kernel.org/
> 
> So the plan is to change functions until a regression is reported.
> 

As I commented in the past, it is more user friendly to add such
comments to a commit message so that when a regression occurs and a
bisect is done, the user hitting the regression sees the problem with an
obvious resolution.

