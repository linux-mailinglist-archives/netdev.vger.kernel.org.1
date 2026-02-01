Return-Path: <netdev+bounces-255596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKY4J1xRf2m9nwIAu9opvQ
	(envelope-from <netdev+bounces-255596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 14:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777EC5FB7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 14:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF73B300CC88
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F824346763;
	Sun,  1 Feb 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg15Sg+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6ED345CA3
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951578; cv=none; b=cRvpuSjJZWhOaOiRQeFh3iKIawOF0LGL9CF3378QTaQrdc8Cf8qB312td1dMtPFNhpT6hKL8PPRV+jokkwWO+tyjil6kALvzAeLnyGu+A+SRreSeh9lCuVzvc7fZZ+Yq2JSRvTI394n8sCVGDctGtrXz1ZA+aaXGtYzlI3GtReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951578; c=relaxed/simple;
	bh=e21CdEWPFNTttAUifMXV/x33HiCUjBQco6i+6rzp3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr0zGCUFmCxfWpgZ4Gs34WUB2ij0gDhet6KxYUsN3dFRij102it7NcWNRKBSo6r3j7bEroEwxbUIboYLOYemxUkB3wJP/bh1lZ0x4mJrBqYpP2o8vPedA9QlPWCAhwudfdVe+lp6QtYYRbC/wja3ko/ONA6/O4MZQTOJngZwqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg15Sg+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C4C2BC86;
	Sun,  1 Feb 2026 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769951577;
	bh=e21CdEWPFNTttAUifMXV/x33HiCUjBQco6i+6rzp3/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tg15Sg+IVAzQEKN5UjSX6u+UL8m+/mpXhpPAo7Piuj/kC/5I+fKSfYrTlwUhIUICF
	 gpmoWl4PIaFftKpVT2Shnf/mxHCQXspJ5mhlRdREVHsZxyh4OFQLAzFCPnzq3UpZYH
	 lYeA49lGxKAZ2Ip+LdI3DM9V88fMabV7KO3/HpCdm9s1s/5iiV9gSKIQlHMoweymRt
	 qLQ+JutE3qXbuVRmda4YUSlKbN/W6nbHgf3VJ9BEaZJgz9gcmJfJbMrxZkt3nVxBm1
	 0D4/M/3sY8M2m6XMPKxUFx5GuDVignMD75LMOW+tN2m+hBMQcwiRDRrpR/jmXPxUbo
	 XzvHJEWK+xHEA==
Date: Sun, 1 Feb 2026 15:12:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <20260201131253.GD34749@unreal>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
 <20260129090959.GD10992@unreal>
 <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
 <aXuFTJZ3SvaCBXj5@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXuFTJZ3SvaCBXj5@krikkit>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255596-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1777EC5FB7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:05:32PM +0100, Sabrina Dubroca wrote:
> 2026-01-29, 19:16:30 +0900, Tetsuo Handa wrote:
> > On 2026/01/29 18:09, Leon Romanovsky wrote:
> > > On Thu, Jan 29, 2026 at 05:06:08PM +0900, Tetsuo Handa wrote:
> > >> On 2026/01/28 21:35, Leon Romanovsky wrote:
> > >>> On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
> > >>>> On 2026/01/28 19:24, Leon Romanovsky wrote:
> > >>>>> I think this can work, but IMHO the more robust approach is to ensure that all
> > >>>>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
> > >>>>
> > >>>> The transaction will become complicated, for dev->features manipulation
> > >>>> function can fail.
> > >>>
> > >>> Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
> > >>> and remove everything.
> > >>
> > >> That answer needs more clarification. I came to get confused about what we should do.
> > >>
> > >> Question 1:
> > >>
> > >>   Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
> > >>   support NETIF_F_HW_ESP flag. Is this interpretation correct?
> > > 
> > > Yes, however any device (SW or HW) should set this flag if they want to
> > > provide IPsec offload.
> > 
> > OK. There are "IPsec with offload" and "IPsec without offload".
> > Both cases use code in net/xfrm/ directory.
> > 
> > Users (not the kernel source but Linux administrator) can choose
> > "IPsec without offload" by clearing the NETIF_F_HW_ESP bit via
> > "ethtool -K $dev esp-hw-offload off" command even if $dev supports
> > both "IPsec with offload" and "IPsec without offload".
> 
> We should avoid talking about "IPsec with/without offload" when this
> can mean multiple different things:
> 
>  - ip xfrm state add ... offload ...
>    (and the offload request actually succeeded)
>  - packet going through all the offload code and to the device
>  - device with NETIF_F_HW_ESP set in dev->features
>  - device with ->xdo_dev_state_add
> 
> (I'm probably forgetting a few more)

At least for me, "IPsec with offload" means all together:
device has ->xdo_dev_state_add + NETIF_F_HW_ESP bit + "ip xfrm state add ... offload
..."

I don't think that it is correct thing to adapt core code to something
specific to netdevsim which was introduced to emulate missing HW device.
Like in real HW device, the expectation is to have NETIF_F_HW_ESP bit,
we should have that bit in netdevsim too.

Thanks

