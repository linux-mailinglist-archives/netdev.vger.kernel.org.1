Return-Path: <netdev+bounces-209172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1423BB0E86A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2291D3A4632
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C861AAA1B;
	Wed, 23 Jul 2025 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npE0nzSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C817B505;
	Wed, 23 Jul 2025 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236016; cv=none; b=JfM+W1gMfVF4N8oOcO9auGo+GCtWmAijrM5F35UDGHPsMcj0gAxIahdDxknC/89FrLHbvbGN+VtfMPvuVr+zDz12p8mhqpwQO5T6oliupje6KSwk68x10QxMIg4pygi5or2uBpZ0CPVhbsjaoWOSUT6XsFRyINgo9NiYTQqBKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236016; c=relaxed/simple;
	bh=tV7ReiOZTbiTuQ/j8YstySUvS9Dh37ilq3EP/DWGPc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz0fHWp+VaL4CQ/q/8Elnr+Yx/TbuHbgeM/en+t4Cndvn9VzeGYp0yRKg9AJ6DzEfpLtPe58ztKTnWPVB5fmbfqCEAGLJ4i0pPqSeYbeibeNV2tZHng9khM30ZSWkwtG94peXgWWsXTXDjnw3OGUkUv8GEVSP74kLTYnRFo/zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npE0nzSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9C1C4CEEB;
	Wed, 23 Jul 2025 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753236015;
	bh=tV7ReiOZTbiTuQ/j8YstySUvS9Dh37ilq3EP/DWGPc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npE0nzSkOszcfIyQKfpYPhhfvgpznebJIj6i+XCd+uP0+NljxIh+/ZxNg+7VAvU1f
	 rp5PobUDPDCgWi2jWROdrJqVyWhn4jIFeLJEAlf5auwE4l22qkJmktUGS1qdT5nK1k
	 ZOFS9+jhZ3V4D0XPsnnKoTuI+v9My5WIpZAzd/8FgRCVxMrPvsI+PoDKGHYLxMQvf6
	 54sfTaMYBGZaLXbHppqqLfWj8ny7Id6H0RsJyyp7ZoEMkX57yqXnJBTxfVFZDyZsDk
	 e++tfLSzOqI+zDx8X0d0yZtTbJttf6Wz10PnItZme71peTRPPWbFjs3xnd2CbM0T3G
	 Slzz7t3qaa1Pg==
Date: Tue, 22 Jul 2025 19:00:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: Warn when overriding referenced dst entry
Message-ID: <20250722190014.32f00bbb@kernel.org>
In-Reply-To: <20250722210256.143208-2-sdf@fomichev.me>
References: <20250722210256.143208-1-sdf@fomichev.me>
	<20250722210256.143208-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 14:02:56 -0700 Stanislav Fomichev wrote:
> Add WARN_ON_ONCE with CONFIG_NET_DEBUG to warn on overriding referenced
> dst entries. This should get a better signal than tracing leaked
> objects from kmemleak.

Looks like we're tripping the severe nastiness in icmp.c:

		/* Ugh! */
		orefdst = skb_in->_skb_refdst; /* save old refdst */
		skb_dst_set(skb_in, NULL);
		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
				     dscp, rt2->dst.dev) ? -EINVAL : 0;

		dst_release(&rt2->dst);
		rt2 = skb_rtable(skb_in);
		skb_in->_skb_refdst = orefdst; /* restore old refdst */

There's more of these around. I think we need a new helper for
"saving" and "restoring" the refdst? Either way, I reckon the
patch with the check belongs in net-next.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5520524c93bf..c89931ac01e5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1159,6 +1159,12 @@ static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
>  	return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
>  }
>  
> +static inline void skb_dst_check(struct sk_buff *skb)

skb_dst_check_unset() ? Right now we assume the caller will override.
Or will there be more conditions added?

> +{
> +	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb) &&
> +			       !(skb->_skb_refdst & SKB_DST_NOREF));

Why not 

	DEBUG_NET_WARN_ON_ONCE(skb->_skb_refdst & SKB_DST_PTRMASK);

?
-- 
pw-bot: cr

