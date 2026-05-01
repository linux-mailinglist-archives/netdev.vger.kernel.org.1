Return-Path: <netdev+bounces-283197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCSADjK39GmvDwIAu9opvQ
	(envelope-from <netdev+bounces-283197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921284AD317
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56F7301175F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56D3C9EF0;
	Fri,  1 May 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks6Hkz7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9443C9453;
	Fri,  1 May 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645309; cv=none; b=h3J2xhXUH7uqKNMSIfn4BRQFT7ILGNnDzgCcG/CtE/Uiwvz88oIUKG+XbL1JAT+B9MV1+BZ7jT80d0vVRVXjm8DrxYRGZ8Q0LTPAdmM//nC6oeir2x4QzN1bQ0M6gimlyq8Ka6OiOdf8Qdji9zje2vILVEE93icNHUJW9ov4g5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645309; c=relaxed/simple;
	bh=00t9DBsJfkCV2gKtJJZPFBWxa+mTHkh+lPTgfqFFcd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZWAQbEr4dNej6bCx1aqk2TgiN8ChYUu3YUC/lrhlUJtJSgj7NBqZfdlMFN/Rxjy+EKVMXN5YSMfoYMscXFHi7paXpft6fpPW8817ftusFxtuVQn+I4Dpod74sJ7nEm3iVbF3tjWxenNxwWduKGw3TtJs4j6K+BT1elyGPJ50mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks6Hkz7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40076C2BCB4;
	Fri,  1 May 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777645308;
	bh=00t9DBsJfkCV2gKtJJZPFBWxa+mTHkh+lPTgfqFFcd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ks6Hkz7wUekz+RWrsu8Yl7UQXSptMvfTUr9RrAeAWeh6umyjnNglNH+hxj6P3cpWo
	 z/3ePZWfC45nf9n0kUci65AZ2oSLaKz0DsiTbK25W/XA+W41luqQJ7OMAPAvC7hkMd
	 8VO+xgwxTEklpnD8tVlm2lTkh9JFPp2DWoDLRVtCgw5f/DfxDA7mCnnaAji4OmF6eW
	 H5fd9KriWVOA8LEQVh17LqpksBfhNt88BUX4TzQyrxuzElgbulxFUmB60Wu6o4XmPF
	 HDMOQ+SbY7tzcb4iuSRu2VkX3VgJRK6JSDgqBxLBPacoyZdETvlqyuCGoZlG7LKKpL
	 y4xSxUMV8Ru4A==
Date: Fri, 1 May 2026 15:21:43 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: cs89x0: remove ISA bus probing
Message-ID: <20260501142143.GF15617@horms.kernel.org>
References: <20260429145624.2948432-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429145624.2948432-1-arnd@kernel.org>
X-Rspamd-Queue-Id: 921284AD317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 04:55:45PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The cs89x0 driver is really two in one, and they are mutually exclusive:
> 
>  - the ISA driver was used on 486-era PCs. It likely has no remaining
>    users, like the other ethernet drivers that got removed in
>    linux-7.1. The DMA support in here is the last device driver use of
>    the deprecated isa_bus_to_virt() interface, all other users are either
>    x86 specific or or got converted to the normal dma-mapping interface.
>    The driver was maintained by Andrew Morton at the time, based on
>    the linux-2.2 vendor driver from Cirrus Logic.
> 
>  - the platform_driver instance was used on some embedded Arm boards
>    around the same time, such as the EP7211 Development Kit. This
>    is the same chip, but uses modern devicetree based probing and no DMA.
>    This was added by Alexander Shiyan.
> 
> Remove the ISA driver as a cleanup, including all of the outdated
> documentation referring to its configuration.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd,

With the increase in both AI generated patches and review,
and the maintainer effort required to process these, the
cost of maintaining unused code has become entirely non-negligible.
So I welcome efforts to reduce that surface.

I note that there is an AI generated review of this patch available on
sashkio.dev. I believe that covers only pre-existing issues.  And I
illustrates the point I've made above. I do not believe that review should
block progress of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

...

