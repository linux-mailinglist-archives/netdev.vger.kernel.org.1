Return-Path: <netdev+bounces-261751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JE0MppNoWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:54:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E031B424C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC3F33049D64
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418B4364E91;
	Fri, 27 Feb 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER/OexAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBF364046
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178838; cv=none; b=Di8HDhsjGGldh0f/lZuV9jADGOlp4YpdCnxuI90bPEW+qDtBTGQYNosiN+K6Z69E7BojpEjSBRwb8DwvG5RW4bpTgWQyLKzkZyCCs3eJxRQFl0lDMPwsYVZA3bln4vo3ZQin0KazAMHWKt/m/p9vZRjc2FJ6fkBJVsoMosRhUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178838; c=relaxed/simple;
	bh=h9syD6WVkAmzTGwQ3i1VIb80j/B9jUPw/Vy3A2x0Fv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ste/KBiwLns62VNnjne6eGizf16GJi6x3i0+qxrav8eV/NBDfOPPSbRfBtJpn1Hg3OrV2CeLieEIGnRjB2ozxnbWEUXILQwFpJ4fRhagidU8DzRfEPlzKKTpKDW+RZWlKPZf8PGQ67AFslnCKzf/wbv1jLw6eI7KfCwFB0rOrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER/OexAf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaf43014d0so14126015ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772178836; x=1772783636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evrPnhC7VvTZpi7YgqhzDnPSPz72Yoy2AMHX8h76Rd4=;
        b=ER/OexAfSaNT2a8Zn4t9yC+HtuLjm5H6DDp1rLwM67p15aMrxbUgPkkdqUh4Uk+99l
         KEZwLGdQO0bkr82e3uh550EMK87ySO+n4Wv5LWcL6fIOIlm0qXYLHnH2Am1fJStQATHg
         7Vk4gPNgNUB6suw4bj0/TRqy0m2aikdyL9O3BV7SPrk/KH9UmWxHuowZdit17Y7MQB4m
         dlhkTuSSZG8n51tdV1E9MqbYuSMGfEvfcAh9fvTtIHutmxp2V7hBioLy//yCtiRwiKAG
         7Kk+p9DLLP3n/H3v7eUgNUxZGenpp3363Zp3YipchJ+D5la2WFGI02t8j4DVx1TXRwo5
         KcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178836; x=1772783636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evrPnhC7VvTZpi7YgqhzDnPSPz72Yoy2AMHX8h76Rd4=;
        b=E5AclVvj7PYUOIPoXsLlIvezWxARXcy2EhCi0RpGpi6e6s26cpexohXp2xe0GmQquF
         zG8fyMFw2MFha0HmX/jXIpC2Ev8D2GpyUTNS513Z0tesvJcawuV8chSvvvN+Jv5HMCYz
         yNBMJ3LHFIE9T81Gc8bwjacrl+AHaL3noMwLDLryOQmPvnb97LCi9U+ArTdib5cLi4fN
         2YzjVsYtfJDXwC/kJYRGSL90syy4I1puDD8nzPsmO22mGhuGkzImbW1pHTYAvJj80Emz
         tyDRGk20j9pH5JLL4YOV7c1YZJcxo81fZTuM9YiDbAfx3LLtY4o19ENuqUNn0gI7LJf7
         esAg==
X-Gm-Message-State: AOJu0YxCkSbY6139jLHDK8BfdPsY8XMdr/ef3Fh21np9riV2cceL5CZF
	kXaXKfQ1B7Ja3kieBy8ZOZk0WIYtDufQdOZrb8Z8sKq02Efxu8NzShvo1flC05INX7k=
X-Gm-Gg: ATEYQzwigYP9kr23r2qKCNe5JJ10ORwpsi1yVhLczxqoy5tMcXOt+xOcK2NiiZ5U8AB
	gSVFZDRa6WEyBWliEwfd15SfSa6sRqyscQgcqX34p0rVXMaqPxmC5NsCUlacKx9NZU1yPFDo0Gm
	N8Y1ziWZSwIBOyZqaKHrrWGw9EM30Q6F4wOHVFkPa9FT6OREr/R/ULOIRYxFg919UwCmiIYihnj
	zCF6O3TYa6qxCPQc2J0WCg6Yv5NAhCUkdOcCKfQOHq/iT+JLL0fXztsQJ8MTbUWsTOuVa6G1W7t
	PcRl/GoZdyeoJxeTYp1baRML7SicJQVU0MB+GtxrpktJDrRtFWnR19hIqOHh6MHgFYw+pscjx6W
	bmKW7hN03mx9t0797OutyVMrwiuEn0vGLml1Q4ZtqqyffWc2ExWpKHwNAqo66p7T44j1RM2mCoK
	9/ID7VHNd4XkMdORbKRaugxGKcZRY=
X-Received: by 2002:a17:903:1208:b0:2ab:3cba:42fa with SMTP id d9443c01a7336-2ae2e4b4c52mr19615825ad.46.1772178835895;
        Thu, 26 Feb 2026 23:53:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm46817515ad.4.2026.02.26.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:53:55 -0800 (PST)
Date: Fri, 27 Feb 2026 07:53:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC PATCH net-next 2/3] net: use ndo_update_offloads for
 bonding/bridge/team
Message-ID: <aaFNilMyFaD9cA2u@fedora>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
 <20260226114208.27774-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226114208.27774-3-liuhangbin@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261751-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75E031B424C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:42:07AM +0000, Hangbin Liu wrote:
> Convert bonding, bridge, and team drivers to use the new
> ndo_update_offloads callback instead of manually calling
> netdev_compute_master_upper_features() during port add/remove operations.
> 
> This change centralizes the feature computation flow:
> 
> Before:
> - netdev_compute_master_upper_features()
>   - compute offload features
>   - netdev_change_features()
>     - __netdev_update_features()
>       - update other features
> 
> After:
> - netdev_master_upper_dev_link()
>   - __netdev_upper_dev_link()
>     - netdev_change_features()
>       - __netdev_update_features()
>         - ndo_update_offloads()
>           - netdev_compute_master_upper_features()
>         - update other features
> 
> This ensures offload features are computed automatically when
> upper/lower device links change, removing the need for manual
> feature computation calls in the driver code.
> 
> The netdev_change_features() call in team_uninit() is also removed
> since it calls team_port_del() for each port, which now triggers
> feature updates automatically.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 10 +++++++---
>  drivers/net/team/team_core.c    | 11 +++++++----
>  net/bridge/br_device.c          |  6 ++++++
>  net/bridge/br_if.c              |  4 ----
>  net/core/dev.c                  |  8 ++++++--
>  5 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d05837c0713a..7043ee022980 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8893,6 +8893,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
>  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
>  				    priv);
>  
> +	/* re-compute all features after adding link */
> +	netdev_change_features(upper_dev);
> +
>  	return 0;

Another benefit for this change is, after calling netdev_change_features() here,
the later netdev_sync_lower_features() will disable LRO automatically.
So we don't need to call dev_disable_lro() manually in
bonding/bridge/team/VLAN. I will add this patch in next version.

Hangbin

