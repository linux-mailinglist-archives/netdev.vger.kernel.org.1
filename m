Return-Path: <netdev+bounces-263227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGskCkTtpmmQaAAAu9opvQ
	(envelope-from <netdev+bounces-263227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:16:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 243871F140D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1ECE43001CD5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85B3D3D1D;
	Tue,  3 Mar 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNbywP6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1637DEB1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547389; cv=none; b=j6rUyiFrYOsp5CnarFTpUuNIR9l36sdpFnH6ZKk1tIOVZBgm161eVUAmtMqTR2QvwTO9+4kuV3kHzDIi8eBX0x78oj8MmfElgOZrKWrnunqZ5F5Gnwow3dtuwuYb19HACuR9AMC5nzbnqEDnkmEIlR3pFvn8kmZVrJmAR4OUZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547389; c=relaxed/simple;
	bh=PlsY62ALVOzJc1QWsF6hM8CmEKSHbumYLE1qUTIAmyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or/nOg+azCN8W4naty7PkH67cpSX1I0nBLZzWI5iLMDhAltf1Pk2ZPmtrQHzwGcd5c4vllm3UGhCrPhrG57hZO/t49uCVWfoLJjiYgMyIgeZnzBk7ewgsUHmprVBFmywC580T4D2MLorfiyMDuXBIS6BgveAh+yhCBL5jU2tWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNbywP6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779DFC116C6;
	Tue,  3 Mar 2026 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772547389;
	bh=PlsY62ALVOzJc1QWsF6hM8CmEKSHbumYLE1qUTIAmyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNbywP6kuOYrB39xGIvBVT428jxDk+LPgMH8piFSVADraj1ysUz0eEWENZ87BjiWA
	 XgyAPNoxnNkGdkNA8yMvEMbzJiD+KCLPmF5DQVBjFpUWdv5OslFaTln1+ns6jAJZn5
	 q+xx5wPcfX1QlxM+tjqQeCgMIfN9VN+N2gxUGSKMkDVAHcEpf6Dr0VdYwUbIPRvEHT
	 UoCcno/g4PfwQxITjC1eeJFG9yWBSrJLEQw9Jr8HRHtxfXNbqg/cbBMJtoiIiKrOBz
	 1OjUPqOYvozceahNPlNXF4W576w25zPK7SAiE880j88HBup3M26Nv7jA0VDIcVJvL3
	 53c0FTL5bxXBQ==
Date: Tue, 3 Mar 2026 14:16:24 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix GDM2 loopback configuration
 for USB serdes
Message-ID: <20260303141624.GD71509@kernel.org>
References: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
X-Rspamd-Queue-Id: 243871F140D
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
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263227-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 01:20:33PM +0100, Lorenzo Bianconi wrote:
> Flow Control source port mapping for USB serdes needs to be configured
> according to the GDM port nbd parameter. This is a preliminary patch
> since nbd parameter is specific for the given port serdes and needs to
> be read from the DTS (in the current codebase is assigned statically).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Is this a fix? If so, should it have a fixes tag? And be targeted at net?
Otherwise, perhaps drop the "Fix" from the subject.

Also, I think it would be worth explaining the situation
before and after this patch.

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 10 ++++++----
>  drivers/net/ethernet/airoha/airoha_regs.h |  5 +----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 3779f93b47bc13ae21d4ae088dece4712dc214e5..37fc2b33d3af8a190a74efc69ed54f163afa6412 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1729,10 +1729,12 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
>  		      SP_CPORT_MASK(val),
>  		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
>  
> -	if (port->id != AIROHA_GDM3_IDX && airoha_is_7581(eth))
> -		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
> -			      FC_ID_OF_SRC_PORT24_MASK,
> -			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
> +	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> +		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);

AI generated code review flags that the commit message talks about nbd.
But here we have nbq.

> +
> +		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
> +			      AIROHA_GDM2_IDX << __ffs(mask));

Perhaps naïvely I would have used FIELD_PREP here.
Maybe that leads to an incorrect result. But if not,
is a shift used here for consistency with the code at
the beginning of this hunk?

> +	}
>  
>  	return 0;
>  }

...

