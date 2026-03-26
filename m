Return-Path: <netdev+bounces-272017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB5cIEcmxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:27:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9443352DA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72078304DCAE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182BB388E40;
	Thu, 26 Mar 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du4SbXau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3533F8D4
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527444; cv=none; b=IXRnd3Jm963y/zVGEAAfAdVVDG7ZI7Ckf3chimx/1VWaDg+64OfIh3ikUqacCAm/66TTOp+tq/u3Gv+O3Ks3AzuWvWhnLyKbfgY7WNfSUlFXSxO698OitT5RaeHf3gpfj8ZkoX5hitY4k1BQInZW3KEC41OELp6rxSzIgYCH8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527444; c=relaxed/simple;
	bh=3VbtHsOVRFRjZnMXO5LgMUckZdMMBskrErAVbmlVWSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiQ73P1JlFF2xNtX1Ph/3E5CSa21udQ172yr3YEsHFmcFWa9Wz9UI15mgtLCklDmY6U2kR/mx5wX40HUILpS2hU1XgeLnZCVEOvjr1w2Ty/Iuy9+r3jpC2OQbpTn/Pb6codorv+ephfPDHbnHkSSZ6b/ao4LHUb29LwmKvwFy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du4SbXau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8040C19423;
	Thu, 26 Mar 2026 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527443;
	bh=3VbtHsOVRFRjZnMXO5LgMUckZdMMBskrErAVbmlVWSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=du4SbXauELOkRIZ4Mr6eNzSeKmc4VZmQFpauQEYxqPa7pbDa3O/vCUUbIs3T3iXDA
	 04xMnalgNvzLD2ZXgA/WnqCFVOHjuKt3BrT99131wZJr+6bEFQv7oRqYIlEl9tS3S0
	 AC/QWhpx7U6FVYV7g43M9qmhzOzeZkxIGLuYnJi56tlzM9YxKJ0bS8k5qDAPluxAER
	 TiGK+Ek5N09nRLi1kfvjAh34KdqQNRxkvDVV41MBCzKgaOxtvptgxYfqzhrSEihfwW
	 CKF0E7jfidziBvrrhBVnyvqeabr+kebAa6CPgwdcWnGmPGvZBkIwtVjydiasaIzMH3
	 iEuXBYRGIXfJw==
Message-ID: <fea7935a-ddd7-4ac2-a2f4-622133b91281@kernel.org>
Date: Thu, 26 Mar 2026 13:17:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com, andrew+netdev@lunn.ch
References: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272017-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hitachienergy.com:email]
X-Rspamd-Queue-Id: EF9443352DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 26/03/2026 à 11:02, Tomas Alvarez Vanoli a écrit :
> Immediately after setting to 0 we are adding to it, and subtracting 0
> from budget. Replace with just assignment and no subtraction.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index b72ab9951875e..3bd57527b1be6 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -628,8 +628,7 @@ static int ucc_hdlc_poll(struct napi_struct *napi, int budget)
>          hdlc_tx_done(priv);
>          spin_unlock(&priv->lock);
> 
> -       howmany = 0;
> -       howmany += hdlc_rx_done(priv, budget - howmany);
> +       howmany = hdlc_rx_done(priv, budget);
> 
>          if (howmany < budget) {
>                  napi_complete_done(napi, howmany);
> --
> 2.47.3
> 
> 


