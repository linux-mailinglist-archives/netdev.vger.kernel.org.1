Return-Path: <netdev+bounces-163550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138EA2AAD7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391C5188787D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BF214A99;
	Thu,  6 Feb 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="J7sh+k75"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB21EA7FD
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851245; cv=none; b=Au3QAM3K98vNykG0OktgN7+GFfjHxQJV2HpDKHlWpjYhhHBklzBICDbTee9KkngXeQB0kAFKiqKlTyoVyd9hlEGGxwMFxDY4fD83102CZ6vqRaG/xp6h2f16W0ASlxl2BEXJPBT6abuelTR/KwvUcIIhhd2Nihy+3GxYegBc0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851245; c=relaxed/simple;
	bh=jwfMeoN8qdiK7hSweXrTVHveOh+4D8/ilaEBT0ay/Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vo1EE3whibKm7GP/SxIeUSKkbAnM/ql5QLUyYwTlEB8dvnEVSY6nN506/ad5R3bGa1WiUVPbT63Xwr+UYx76rDODmZqEkph/y84+0saSP92X45x1qG0O5jcEkg8sUET7T+BuTLTIuh/AShMin8y63TgSHt94cfKhTR7+HlgvBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=J7sh+k75; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id C9F9D3FA5;
	Thu,  6 Feb 2025 15:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738851233;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=m+yP7O2OoLUgMMYnKp9PRAYvDDAEHKsr5IjQROK+U1U=;
	b=J7sh+k75BnlKCJg0TBWxHaMSDEpLhXB3lp0P9/pwH8cFmSnkl18e2+zZBJ7DBpwQ
	gZcWamBRFsuj1bHTWu/vW/qG8wwySTbd7d9Pq47f7aPAPz7T219lGBP2L6SLEKqRO3F
	Bk+o81KkgqQSpvh4hHXNja0m0C9aKpXuSxNO3f27VRemtBXkpqlkL3K1ebj6/BJvwVq
	9hRNvgBHQTQVmL/yv5vdVG2KcOh2C7tkM1opMjv+cvU0qbhGPALoKnKYyNmlmf4aOqv
	M7LaAzjw4UqroY+TPvn0Akwx7q64r/OftoQUlvmiEiNfJIXAzSexOl50S9JKvvKvyz4
	rsBHxY8OvA==
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 6 Feb 2025 15:13:51 +0100 (CET)
Message-ID: <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
Date: Thu, 6 Feb 2025 15:15:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
To: Eric Dumazet <edumazet@google.com>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250206140422.3134815-1-edumazet@google.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20250206140422.3134815-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688

On 06/02/2025 15:04, Eric Dumazet wrote:
> Add a device tracker to struct batadv_hard_iface to help
> debugging of network device refcount imbalances.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/batman-adv/hard-interface.c | 14 +++++---------
>   net/batman-adv/types.h          |  3 +++
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292d020462b6ad60b699 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
>   	struct batadv_hard_iface *hard_iface;
>   
>   	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
> -	dev_put(hard_iface->net_dev);
> +	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
>   
>   	kfree_rcu(hard_iface, rcu);
>   }
> @@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *net_dev)
>   	ASSERT_RTNL();
>   
>   	if (!batadv_is_valid_iface(net_dev))
> -		goto out;
> +		return NULL;
>   
> -	dev_hold(net_dev);
>   
>   	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
>   	if (!hard_iface)
> -		goto release_dev;
> +		return NULL;
>   
> +	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
>   	hard_iface->net_dev = net_dev;
> +
>   	hard_iface->soft_iface = NULL;
>   	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
>   
> @@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
>   	batadv_hardif_generation++;
>   
>   	return hard_iface;
> -
> -release_dev:
> -	dev_put(net_dev);
> -out:
> -	return NULL;
>   }
>   
>   static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0d198a15437d49ea73 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -186,6 +186,9 @@ struct batadv_hard_iface {
>   	/** @net_dev: pointer to the net_device */
>   	struct net_device *net_dev;
>   
> +	/** @dev_tracker device tracker for @net_dev */
> +	netdevice_tracker  dev_tracker;

There are two blanks between type and member name. Is that intended?

> +
>   	/** @refcount: number of contexts the object is used */
>   	struct kref refcount;
>   

We also have hard_iface->soft_iface storing a pointer to the soft_iface 
(batX) netdev.

How about converting that to netdev_put/hold as well?
See batadv_hardif_enable_interface() / batadv_hardif_disable_interface()


Best Regards,


-- 
Antonio Quartulli


