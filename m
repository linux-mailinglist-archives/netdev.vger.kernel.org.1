Return-Path: <netdev+bounces-259062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED+mNyeBlGniFAIAu9opvQ
	(envelope-from <netdev+bounces-259062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:54:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1D14D53E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD24301FFA0
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAE36C0BD;
	Tue, 17 Feb 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8q/EDe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9D36B07A;
	Tue, 17 Feb 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340052; cv=none; b=mIyvdd2HouREEJPE3oaAqW5qu6TWDEDIVFVZJdA17lL7PY4PnThQo/i+atOa3/N7c1R717OVoRuSWo6brjr9I2fD02S58SU4zkrXCTS3Q5v80SlJhjGP0YmJkuzb9vfmaciKU5pmn84yoEpMtl94IC4HZO+BcMl3f3cfT/o4/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340052; c=relaxed/simple;
	bh=RcBQHDr0j8SYzFRqixUevuOacUEvH1YqjNDP/rgvjJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUYvGIn95pAMT4WceqQPR4fYioaDWmQ9O+oK7UsZV/U/gean7cExeoUR6Pzv1w5gHjeITGP2rRmEIHJDWn3vsS9XWddaqrJWB7Vu7XV1Xl3SR0WF06E0vzEaNeZ8vg7Fau+HX+weNJKxENL0DyUbhPAAAs1BwlNhFXJpwSizjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8q/EDe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB8FC4CEF7;
	Tue, 17 Feb 2026 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771340052;
	bh=RcBQHDr0j8SYzFRqixUevuOacUEvH1YqjNDP/rgvjJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8q/EDe+d7vMSd1AYjihY6NrsHO6BJQYK4YheWdrSO47NcMhdo4cjF7uq8TGCk+G2
	 NdyFdZkSQW3tWkLJ1WJpjCLrfYOjv32XSxktwNaUIuNW7GRLylffGpjpVI2TPA7gsO
	 g1mJvj0286FLi2KYP9oKFXeuBiFPm9F8pu+G4Qs0bRgTRqzqgklWlQPW7lMtzDdgsD
	 esesCxn4XVI3cDYYcl0JPPmOCgWpbPnAZAG9sQbgyMqDG7qcVuVtczzFvoyHIkz/DY
	 MQdxg3cvBe8B5WhYBp8WYwvJ17TApRcXUbAtvCqtly8ehT5+NPNRiXuypdXqzhNNvx
	 xBZTyunytX3iQ==
Date: Tue, 17 Feb 2026 14:54:07 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: psp: select CONFIG_SKB_EXTENSIONS
Message-ID: <aZSBD6Au8FJPV1Vh@horms.kernel.org>
References: <20260216105500.2382181-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216105500.2382181-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259062-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,arndb.de,glider.be,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 41A1D14D53E
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:54:54AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> psp now uses skb extensions, failing to build when that is disabled:
> 
> In file included from include/net/psp.h:7,
>                  from net/psp/psp_sock.c:9:
> include/net/psp/functions.h: In function '__psp_skb_coalesce_diff':
> include/net/psp/functions.h:60:13: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Wimplicit-function-declaration]
>    60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>       |             ^~~~~~~~~~~~
>       |             skb_ext_copy
> include/net/psp/functions.h:60:31: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>    60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>       |                               ^~~~~~~~~~~
> include/net/psp/functions.h:60:31: note: each undeclared identifier is reported only once for each function it appears in
> include/net/psp/functions.h: In function '__psp_sk_rx_policy_check':
> include/net/psp/functions.h:94:53: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>    94 |         struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
>       |                                                     ^~~~~~~~~~~
> net/psp/psp_sock.c: In function 'psp_sock_recv_queue_check':
> net/psp/psp_sock.c:164:41: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>   164 |                 pse = skb_ext_find(skb, SKB_EXT_PSP);
>       |                                         ^~~~~~~~~~~
> 
> Select the Kconfig symbol as we do from its other users.
> 
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/psp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/psp/Kconfig b/net/psp/Kconfig
> index 371e8771f3bd..84d6b0f25460 100644
> --- a/net/psp/Kconfig
> +++ b/net/psp/Kconfig
> @@ -6,6 +6,7 @@ config INET_PSP
>  	bool "PSP Security Protocol support"
>  	depends on INET
>  	select SKB_DECRYPTED
> +	select SKB_EXTENSIONS
>  	select SOCK_VALIDATE_XMIT
>  	help
>  	Enable kernel support for the PSP Security Protocol (PSP).

I agree that the is written in such a way that it assumes this is available.
And select is an appropriate way to do so.

Reviewed-by: Simon Horman <horms@kernel.org>


