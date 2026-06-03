Return-Path: <netdev+bounces-294850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vT4YBOdfIGpS2AAAu9opvQ
	(envelope-from <netdev+bounces-294850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5E63A0E4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hdczkQaV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294850-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294850-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 967C2302E0D3
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4344E053;
	Wed,  3 Jun 2026 17:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D644D03B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506444; cv=none; b=RvmKcgzwcr+u4f5HyzMiPGZvqtg+tivLPr6eZ+NF8cCiT0J3uPXxJ9b1Foh/+GV1aM+uRgzXSbDWYIf63RUfbmZJ9B82yzlbossKXD6wfH7xLVxCpyolx0lj62EB9vh4K9uPcRJpCV6q23nF31uQ3senSsryb5efpVGP7zxGJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506444; c=relaxed/simple;
	bh=dA0TPAl0/6YRI7m1pp7g6esmakoUZdBAGb9D0B1FbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYYNVuEhRvcrD/PK3H4gSqxVdeNKL70qJi+N/XgrYXBaT9rMrEdb/PgVe84cXdKXuyFTZoxFC77j+CtBO5dBz6EgcmDBcX3xH/3KXIqTnhVfC6bMrT6UOSK9NcrA2Tl+55bkDongnZFCuR118+drT4trINKx/DaD6Dh/i62tBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdczkQaV; arc=none smtp.client-ip=209.85.214.193
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf237e1433so60585535ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506442; x=1781111242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X33UvQUnGJC3h8LUMsBQH32wmuT9+nkAY/1g3EYkDig=;
        b=hdczkQaVo8WGpPnr4pq3G3zVdrgXmZR2g4gbwbXrMaAgNvGTNRbjFMIhFkYrbLfpeY
         9CwTFjGWVOv2XvKMkkNlUTe+DYIdBCjAKZG9eGvo1Bg//6Jv0gcVKKbiolHISfETMaKw
         q+4tfJlYHQTm2JB1ZfJBh5SH88Bn3eScORDtCozStm28Fz5E5yZp5BZH9JCnfyKR0j1j
         XW1lYiA7m742tC7D9aQjc0VXxZF0Qrfrkd7CM43YIcFuSm9PBBoAfyEbrBBncrBde6y1
         DmPxy/q2BRG6FVhrFyvxdhdwzBv4xghJBXJGhObPnbBZPfMB8Vwf4ljMNit+NR0JpyYy
         fZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506442; x=1781111242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X33UvQUnGJC3h8LUMsBQH32wmuT9+nkAY/1g3EYkDig=;
        b=R2zAT1zY2CNMBhyW6MNqdkA7RP1WliGdkdBfytYsbcgCIvRnQQaOvnKXYVnxc+ZaLi
         oysqTQPrqYfEaIois4/eOueuSEJtN5K/2KkYwsScWPMU5ie3YEqk+SVryOP5Mt9Rrp3X
         9kbmJ1jML4FyqTGot/GhwiKjGCfDfh/PEqWhElYcj7JGm0wyd2G6Yuv6Bl52VIRsXZZL
         5Y06REfjtbatxbHyIcxEbAWRT8CV1Z4R3YopNLyhchoJ/bgXNLMJHkRb4TLl91KA6+hU
         2Fzc6w+bgk/835VEUov74gbIHRVHhVtQTvUQ2rBkLk2th8DLEMYohoFydhDM4j2Uw9Nf
         VzZg==
X-Forwarded-Encrypted: i=1; AFNElJ/WdX/91AuLtWsLrtZeMUdTtAer+9f6yx7YfWcsRdG7WuSTi4+KOciOriesoitRwSHTqFNMvKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhtwYKrgTLU4rLhNOw7+eeQymbgw65uYDaS92nwJSnNE42MI1
	CUNCcp0fuUy+EfMVvOsiFtjUkg+QV6nhGV06BUOhSddMi+hfdu1Yw2AN
X-Gm-Gg: Acq92OEOBp/ooE75x4i741IaUzZ90Kyyaz8IN4klM4FqTiSZzMAh83fQ+ZyYqyKHUxI
	XkzNf/PaQjktwM+wTStY3rltzF6jN+AwnIj3BEMFDSjRO+XmLU1Jaed7BSPbwbKcgt8o0hnCz5u
	35azHvXeJ63MY85JuQ9lU+b+IQdctGPGGndobus8ZAtlm0EGblnzRVLDmy8MdazzG96uM6BCy26
	l53+1iLVbl6AdyxcDnH0DinXl7f/B3GBej/UI0zi1g6Kl0lrwZWX+7ozzh/KVYQUaSm3BWETdal
	nNz9eYh6iX6+gC/UvMCm12PsEuh2TLzqGR1prwWR7XaOQju+Des9p3eP7fqrJm/ehDA0bNG4nD+
	aU1A3Q257OrQHt1AHx8HxU5JFOmkjZdqyNZozGSxQgtVKMcy9fV3fH2/bWQ37TPhSWEtwMwo+Uk
	NOticic7KnuSd1QI3aBpLjQHptSgk8DhRmFBon
X-Received: by 2002:a17:903:944:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c1644a65b1mr44910355ad.29.1780506442184;
        Wed, 03 Jun 2026 10:07:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0bbsm30904975ad.50.2026.06.03.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:07:21 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:06:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jakub@cloudflare.com, 
	maxime.chevallier@bootlin.com, nb@tipi-net.de, lee@kernel.org, linux-leds@vger.kernel.org, 
	pavel@kernel.org, jv@jvosburgh.net, michael.chan@broadcom.com, jhs@mojatatu.com, 
	vinicius.gomes@intel.com, idosch@nvidia.com, razor@blackwall.org, hare@suse.de, 
	jhasan@marvell.com, danieller@nvidia.com
Subject: Re: [PATCH net-next v2 04/11] net: ethtool: add
 netif_get_link_ksettings() for correct ops-locked use
Message-ID: <aiBfDEM-WsYyKxz1@devvm7509.cco0.facebook.com>
References: <20260603012840.2254293-1-kuba@kernel.org>
 <20260603012840.2254293-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603012840.2254293-5-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294850-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jakub@cloudflare.com,m:maxime.chevallier@bootlin.com,m:nb@tipi-net.de,m:lee@kernel.org,m:linux-leds@vger.kernel.org,m:pavel@kernel.org,m:jv@jvosburgh.net,m:michael.chan@broadcom.com,m:jhs@mojatatu.com,m:vinicius.gomes@intel.com,m:idosch@nvidia.com,m:razor@blackwall.org,m:hare@suse.de,m:jhasan@marvell.com,m:danieller@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72F5E63A0E4

On 06/02, Jakub Kicinski wrote:
> __ethtool_get_link_ksettings() is exported and called from sysfs
> and many drivers. It invokes ethtool_ops->get_link_ksettings
> so by our own docs it should be holding netdev lock for ops locked
> devices. Looks like commit 2bcf4772e45a ("net: ethtool:
> try to protect all callback with netdev instance lock")
> missed adding the ops lock here.
> 
> There's a number of callers we need to fix up so let's add the
> netif_get_link_ksettings() helper first, without any actual
> locking changes (this commit is a nop).
> 
> Not treating this as a fix because I don't think any driver cares
> at this point, but if we want to remove the rtnl_lock protection
> this will become critical.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

