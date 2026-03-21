Return-Path: <netdev+bounces-270193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNomBoZovmmTOwMAu9opvQ
	(envelope-from <netdev+bounces-270193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:44:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9A2E4731
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF039300E715
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EC30AD15;
	Sat, 21 Mar 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7MPmnON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894312E63C
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774086274; cv=none; b=mgF2IBTRWVqJJqgvoTU5e5LIrk+hNxt/HCcy/jz4T91aLKUntn4SZbLEYs9m0pJQcSIude4M1EMg7lVfPPqmTTliTEA2/+Ils1IpkW0E4Kik7PZw6fi6iYgaipka5svizRr+HXu04WZfGPNf+W5b97zVwl2mfvu+A7qXbcv+3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774086274; c=relaxed/simple;
	bh=+FyqSc/pT33KY//yXjdAJJt7KUdidRtWT5vfO6X7t40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHieSD7/e64REbspmSjs8WjXYr4eNXLE7j12J5Iy141t2orIbM4TX83KMnd9ZsrXTTGUWBzKqPOA7xF9qXxAUZXQqFW4Q459BGRRJ3f++yBoWgQVDv5PR9OrmfyH+KN7LJvW+Ed3GMBuqjFRL+bbqtlyiRbb1niqJcmIMIcqsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7MPmnON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7FBC19421;
	Sat, 21 Mar 2026 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774086274;
	bh=+FyqSc/pT33KY//yXjdAJJt7KUdidRtWT5vfO6X7t40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7MPmnONJGYhKLNLCg2y3r/vaAIZxMwCKMd6yxn0EDfWwdr+uWJtaJocW38EfJAOH
	 qhNTELdffSsnTIgargdhVflFxFw04UupLpGb2xdtkax5SPmj19CQHFoZoUfXE+ZY3k
	 LpzisNLS8QtRbkv8YJfFo01y/iwpv7fDmtfHLUY05x6j/kHRMOpZeFvvgcGF9UJou+
	 W+tFhsZsjPrDCEgTeKcnaEw+PRG9WgdOO4hFZK7U/bQljZLoScC2Eo7NdY6PtU781E
	 +cZMIR4bnOnOfvmo0KwJ9lcnDaxN4SUOVCKrHRvGzfPSnQtwPgKfuwoG/ihBH36iV+
	 zaF5UMf0A1hMw==
Date: Sat, 21 Mar 2026 09:44:29 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
Message-ID: <20260321094429.GW74886@horms.kernel.org>
References: <20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 5FF9A2E4731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 09:42:28AM +0100, Lorenzo Bianconi wrote:
> As suggested by Simon in [0], rework the code flow in airoha_remove()
> and in the airoha_probe() error path in order to rely on a more common
> approach un-registering configured net-devices first and destroying the
> hw resources at the end of the code.
> Introduce airoha_qdma_cleanup routine to release QDMA resources.
> 
> [0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org/
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 82 ++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c

...

> @@ -3028,7 +3044,7 @@ static int airoha_probe(struct platform_device *pdev)
>  
>  	err = airoha_hw_init(pdev, eth);
>  	if (err)
> -		goto error_hw_cleanup;
> +		return err;

Hi Lorenzo,

AI generated review warns that eth->napi_dev is leaked here.
And that does seem to be the case.

>  
>  	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_qdma_start_napi(&eth->qdma[i]);

...

