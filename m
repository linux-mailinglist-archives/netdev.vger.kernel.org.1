Return-Path: <netdev+bounces-293458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F1UIAeddHGpvNQkAu9opvQ
	(envelope-from <netdev+bounces-293458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFE61714D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F9E3018D4C
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712137268B;
	Sun, 31 May 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnWddoRo"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53A30F7F7;
	Sun, 31 May 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780243937; cv=none; b=F2fM835yTEl8qR5xt2OPVHaSs3KPjrp0EiMbD7G2CjAOiAPUvtnJYPzQvp9vG2fzw8F/T26y+SHwjjNRfldPH1SV0sx23CGq7u/gGNag1+FrHCPo7sfdZ9+J2G/bLYQw+R6HQ/YgIRGYUHGNyYXefAUFEaArqFFb8hxSDagvZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780243937; c=relaxed/simple;
	bh=NEFLkuSTxCWs2924ngnPJ6eCDTa8JGSMiaCxiHXXsLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G2B0uJ7JNT2CCqSplcjW54EuS/AChetTQj3/zogDfxJ2/AC0pG9FTU9Pyi5Q5MB0ZsYzYF25RIqAO/qlk0EzGCQrEoCqBLj8Ffhdbgrt4CKA8b6rTGuMeAQSG+mVNxmdQdk7FqNircZ/MZIzwKsXoom6+VHrqXvQzIZ8jWYK8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nnWddoRo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=lRfsJRjVnz63B9zDXXJQSFpGpPDRHumKiPkeEH3p/P4=; b=nnWddoRoW6kYJ3DPZlJngMaGdl
	1UDWVYUF3M2u/LmgDvjU6sOfXKDgBhcmOCfYl0pSkVP2pGCSU1sXMppG8saVBgBYvZTM7suer30az
	ey3QcRYwN1BOzSBNpI/210TCIWBDBow98fk3aDPjA/V1G3F3a2Eo4B1x5noMbE/p7sTbnVqfBYW5n
	O7ZxnVw4jnmTnARZOT1Mbb1LALHkkeSs7w8qWZ06FHwXyIKi80ZXeAlS+pz9OvEnEp8675M6LQv+1
	nJDOXwUzsvemdti3ELwV95o488Qp0HDT59aoyDyMLPQy+iAZxztaM4GRB5+ybsRRE9EJfAY81XoMj
	49ZmBZ6g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTilp-00000009k0J-0AkH;
	Sun, 31 May 2026 16:12:13 +0000
Message-ID: <5cf7a4f6-0a0b-4f41-8137-d6c3e055d4e8@infradead.org>
Date: Sun, 31 May 2026 09:12:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: Remove orphaned ax25_ptr references
To: Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260531134837.4111349-1-costa.shul@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260531134837.4111349-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293458-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 4EAFE61714D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/31/26 6:48 AM, Costa Shulyupin wrote:
> The AX.25 subsystem was removed in commit dd8d4bc28ad7
> ("net: remove ax25 and amateur radio (hamradio) subsystem"),
> which removed the ax25_ptr field from struct net_device but
> left behind the kdoc comment and documentation.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/net_cachelines/net_device.rst | 1 -
>  include/linux/netdevice.h                              | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 7b3392553fd6..eb2e6851c6f6 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -91,7 +91,6 @@ struct vlan_info*                   vlan_info
>  struct dsa_port*                    dsa_ptr
>  struct tipc_bearer*                 tipc_ptr
>  void*                               atalk_ptr
> -void*                               ax25_ptr
>  struct wireless_dev*                ieee80211_ptr
>  struct wpan_dev*                    ieee802154_ptr
>  struct mpls_dev*                    mpls_ptr
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index beed64b8d93f..460350a7f77a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1947,7 +1947,6 @@ enum netdev_reg_state {
>   *	@atalk_ptr:	AppleTalk link
>   *	@ip_ptr:	IPv4 specific data
>   *	@ip6_ptr:	IPv6 specific data
> - *	@ax25_ptr:	AX.25 specific data
>   *	@ieee80211_ptr:	IEEE 802.11 specific data, assign before registering
>   *	@ieee802154_ptr: IEEE 802.15.4 low-rate Wireless Personal Area Network
>   *			 device struct

-- 
~Randy

