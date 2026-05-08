Return-Path: <netdev+bounces-285980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPbgJMdT/mntpAAAu9opvQ
	(envelope-from <netdev+bounces-285980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 320444FBDA6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FBA830089AB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B033F23BB;
	Fri,  8 May 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgJevPmx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245E31715F;
	Fri,  8 May 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275266; cv=none; b=Ky0drbaOqVVdWsppktqfLniMmsV0eQCijv2sfgqzS9Iq9epnYP9sOt3ViObuYXvMtco8fsKgTzGu5t1rH+Z5k0vxRwSCxm3ee5VfaPC4Pn6y4JIDix3XMkjXeVdgvZhjCZXN2DEEXHi4eiFSbD/znOFWmfKOu9N3lFAyaJbOGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275266; c=relaxed/simple;
	bh=/4xLVTYRRJmOtJBRufc46FWoiGaSuJOkh/bI92mmbZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN8dRy2+sQk4elETAmlxKLVAFX36P3Sqvq1D7y+36LBwEPEsRn12u69n1IzC1Edv3msbByVDCMXGkwb9YWFR8aqq+xnysSHRfq51OpxXKThWYyB6YWraNosMThey7JqcXzcaGBDCYtkZN0lx2y7hLzzTrbf8VxlrmGokOGA3k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgJevPmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252A6C2BCB0;
	Fri,  8 May 2026 21:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275265;
	bh=/4xLVTYRRJmOtJBRufc46FWoiGaSuJOkh/bI92mmbZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgJevPmx3gxDzL+KNlNmrujQDe7HQ4xEn2AndsI+qvlXYJGXMmhqT9E9hmG+TOmuO
	 E0EPqd84ewmcqxQ7UMtozzuj95tsnTAeWmAqH0ZE+pgJ9ZWSVDLYb81hzycY7GYAIE
	 o6udnN3/UGBpsvbeQQBKVq1AwNxBIlzpCvaCH5Fv0BDDInulX//JR2Hki4QJrZoJFR
	 i+ukNsb+kMk9lOsLb9fQkVoTkgTEgTXigW3JCtJKerFnY8nKOn5a8uwuWCsaudblPu
	 TolfU5JF4ejNc60rSuc7yP6cyYwE9s4e/ZYU+jSX+5q2iHeDzMJ58woXulso8SS/DZ
	 9itUvskTX9Fgg==
Date: Sat, 9 May 2026 00:21:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <af5TvSZHwBH0N8Jq@kernel.org>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114422.313356-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 320444FBDA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285980-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, Apr 27, 2026 at 01:44:23PM +0200, Thorsten Blum wrote:
> ->data includes an extra NUL terminator despite never being used as a C
> string and only accessing ->datalen bytes. Remove the redundant NUL
> terminator and allocate one byte less in dns_resolver_preparse().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Never being used where?

Let me go this through.

I read this from the documentation:

  /*
   * Preparse instantiation data for a dns_resolver key.
   *
   * For normal hostname lookups, the data must be a NUL-terminated string, with
   * the NUL char accounted in datalen.

So what is confusing here for me is that should upayload, which is
original data with options and '\0'.

So my question is which is the regression here:

1. Incorrect length. Then the fix would be simply setting length as
   'result_len + 1', which aligns also with the snippet of documentation
   I pasted.
2. Unnecessary '\0'.

If there is an issue, your commit is lacking fixes tag and cc tag to the
author of potentially failing commit.

> ---
> Changes in v3:
> - Update commit message
> - v2: https://lore.kernel.org/lkml/20260409225703.158552-4-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - No changes in patch 1/2
> - v1: https://lore.kernel.org/lkml/20260406175810.1018681-3-thorsten.blum@linux.dev/
> ---
>  net/dns_resolver/dns_key.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index c3c8c3240ef9..451247864a63 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -203,7 +203,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  	kdebug("store result");
>  	prep->quotalen = result_len;
>  
> -	upayload = kmalloc_flex(*upayload, data, result_len + 1);
> +	upayload = kmalloc_flex(*upayload, data, result_len);
>  	if (!upayload) {
>  		kleave(" = -ENOMEM");
>  		return -ENOMEM;
> @@ -211,7 +211,6 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  
>  	upayload->datalen = result_len;
>  	memcpy(upayload->data, data, result_len);
> -	upayload->data[result_len] = '\0';
>  
>  	prep->payload.data[dns_key_data] = upayload;
>  	kleave(" = 0");

BR, Jarkko

