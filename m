Return-Path: <netdev+bounces-303038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uo7oHliBQ2rHZQoAu9opvQ
	(envelope-from <netdev+bounces-303038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651C6E1BDB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:41:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303038-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303038-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B29F3007283
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF062D2486;
	Tue, 30 Jun 2026 08:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636B2D0C82;
	Tue, 30 Jun 2026 08:41:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808916; cv=none; b=aJbCM9w+n85uLI3X58JSntmV4cT1er8j9Mm0RsVF+cgJwvIqIGJ9AAbqdmGJcysp0S2Y8CmPjZSeJ+p/7Px7oKhdoy8pBH2nAvlm3sgY86pz7ANTZN9J6nnziUo7wPUlmHMXPpT4ErYNIPR19vdRcDlCCrkDCbQhA87sosHj/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808916; c=relaxed/simple;
	bh=87u65cYfvDzYnS7FJ4gbEX79iiGZMqB5TqN9Adkcvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phv4FUxVjF4ip+/izntER2QaWzMWZacjS1sgihuxnnIP7XSV80rhrM462ZjcvRlZmBEFYjZ8Rxd1bQBwT+pbmzBScUR9oBgquDSeAxaB6UhP8W53ajeSBWK5N4b1VBUDV0ALeIf3BWj7531YuUAjTsA4gpP/A3yEEASwj09RcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from localhost (bharat.asicdesigners.com [10.193.191.32])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 65U8ZU57017800;
	Tue, 30 Jun 2026 01:35:32 -0700
Date: Tue, 30 Jun 2026 14:05:20 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Markov Gleb <markov.gi@npc-ksb.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] cxgb4: Fix decode strings dump for T6 adapters
Message-ID: <akN/yC11CPSPV0Kv@chelsio.com>
References: <20260629130856.1168-1-markov.gi@npc-ksb.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629130856.1168-1-markov.gi@npc-ksb.ru>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303038-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markov.gi@npc-ksb.ru,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,npc-ksb.ru:email,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7651C6E1BDB

On Monday, June 06/29/26, 2026 at 18:38:54 +0530, Markov Gleb wrote:
> From: Gleb Markov <markov.gi@npc-ksb.ru>
> 
> Depending on the value of chip_version, the correct decode set is selected.
> However, the subsequent matching with the t4 encoding type in the if-else
> block results in a reassignment, which leads to the loss of support for
> t6_decode as well as reinitializing of values t4_decode and t5_decode.
> 
> The component history shows that the if-else block previously used for
> this purpose, as well as the execution order, was not affected by the
> change.
> Furthermore, it is suggested by the execution order that the scenario with
> overwriting and loss of support will be implemented.
> 
> Delete the if-else block.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 6df397539cb0 ("cxgb4: Update correct encoding of SGE Ingress DMA States for T6 adapter")
> Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
> ---

Thank you, This redundant code can be removed.

Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>

>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> index 8d719f82854a..f3e8153a7a0b 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> @@ -6735,14 +6735,6 @@ void t4_sge_decode_idma_state(struct adapter *adapter, int state)
>  		return;
>  	}
>  
> -	if (is_t4(adapter->params.chip)) {
> -		sge_idma_decode = (const char **)t4_decode;
> -		sge_idma_decode_nstates = ARRAY_SIZE(t4_decode);
> -	} else {
> -		sge_idma_decode = (const char **)t5_decode;
> -		sge_idma_decode_nstates = ARRAY_SIZE(t5_decode);
> -	}
> -
>  	if (state < sge_idma_decode_nstates)
>  		CH_WARN(adapter, "idma state %s\n", sge_idma_decode[state]);
>  	else
> -- 
> 2.43.0
> 
> 

