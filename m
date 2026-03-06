Return-Path: <netdev+bounces-264828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCuUMeHpqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:51:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49A22316C
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B343302E1EA
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173B3A9D8B;
	Fri,  6 Mar 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEB4kfUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70434B404;
	Fri,  6 Mar 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807948; cv=none; b=MNTisu/eylEZmsyx+TX8H2mSERMLOWEzx264oP7luYgC1Ar2237DksCuUFe3mtORBjERD0x/S+DliPQbiy3EOrVxtaH5ov1owU3IkB5kimPcgas+9EPWZttQGsJWWpk2mxtvkqCXkWmKGolSj7+wpNr7iWxXFGyi7lp5VR2P9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807948; c=relaxed/simple;
	bh=vBBjxIFSGGAtX4SwrO8XPSLAXjsibg14UQFa1FhHB/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eruwmis2Kz6fZaU2VEMVArWRUyLxyClbGkFNb4Veketc8NQadCfVZ0XjfAbRgFuA0I2PcZtsUPUOigM8rzufg2NM1pisgIGdj8hvCPppfhgVeZfsU/7VkQ0Rpfdc+TliDCSN7fimxrT4HZQtur+Flb/+YZIIwaGa7j/lB0GsnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEB4kfUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A94C4CEF7;
	Fri,  6 Mar 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772807948;
	bh=vBBjxIFSGGAtX4SwrO8XPSLAXjsibg14UQFa1FhHB/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEB4kfUN1UK2wnXoYdmW8Yi9zDEMNiu8bsrD2kfLZmmwhfU4Zv16ZfWsirl2wGraJ
	 KezS2yhoUbGY/Ll64NAIioW25UfEnYwgDrMGRNJ4yxtlrdEzU7P61E7KtGWc5qbiBq
	 4WwnbSZsKV7ITp93f2StYzf6uuW3Tfl2dSaDyE7fXLb2ROd0FrNAG4mxChLJ2yJKC8
	 9j13kpXnN4Jt8t9arWax340amUnx/EEioouKJBWqsYjjcZAR282P1Kc+q10cPNdqnS
	 xW7/uJ/dlDHkM1cECGiGtqsZuxACrCrdyUpN0H5dtoCzbXFyuujjoDgh1alQL/FGlp
	 gpKNGkYiRwKpg==
Date: Fri, 6 Mar 2026 14:39:03 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: refine netdevsim testing guidance
Message-ID: <20260306143903.GG461701@kernel.org>
References: <20260304151647.2770466-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304151647.2770466-1-kuba@kernel.org>
X-Rspamd-Queue-Id: AE49A22316C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264828-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lwn.net:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:16:46AM -0800, Jakub Kicinski wrote:
> The library to create tests for both NIC HW and netdevsim has existed
> for almost a year. netdevsim-only tests we get increasingly feel like
> a waste, we should try to write tests that work both on netdevsim and
> real HW. Refine the guidance accordingly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  Documentation/process/maintainer-netdev.rst | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 6bce4507d5d3..3aa13bc2405d 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -479,8 +479,14 @@ netdevsim
>  
>  ``netdevsim`` is a test driver which can be used to exercise driver
>  configuration APIs without requiring capable hardware.
> -Mock-ups and tests based on ``netdevsim`` are strongly encouraged when
> -adding new APIs, but ``netdevsim`` in itself is **not** considered
> +Mock-ups and tests based on ``netdevsim`` are encouraged when
> +adding new APIs with complex logic in the stack. The tests should
> +be written so that they can run both against ``netdevsim`` and a real
> +device (see ``tools/testing/selftests/drivers/net/README.rst``).
> +``netdevsim``-only tests should focus on testing corner cases
> +and failure paths in the core which are hard to exercise with a real driver.
> +
> +``netdevsim`` in itself is **not** considered
>  a use case/user. You must also implement the new APIs in a real driver.

I don't know if it's desirable, but the line wrapping could
also be updated.

>  
>  We give no guarantees that ``netdevsim`` won't change in the future
> -- 
> 2.53.0
> 

