Return-Path: <netdev+bounces-291860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PYDGPvXFWpYdAcAu9opvQ
	(envelope-from <netdev+bounces-291860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D05DAA7B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20491307F4E7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8A4657DB;
	Tue, 26 May 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zoQP3lGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19E409634
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815727; cv=none; b=DkJqGsqLdk6kSqv7diGP6/RIg7LQuDq8jOz3WpHVNoUBu45dVvytw5B6gfbVhGH2NfwkEIAtZj09Q2ShGi4AQYqlSlK+VqXI0iyCfGVwu/fYsz+byk0Z3rEEUbLUhLioRTV2ecAQ/7XRHuLivt6PVZOb3+gWDhViSUAdGMTozH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815727; c=relaxed/simple;
	bh=7qkPLEBV6h4Rty6XVZjsIAuB63LeLGkYWAppzBh78bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKbsbiSfzZhZZx+9XgtgBF8Ni4e25ER1TnRWlRlxTv6G13bmyf6XHVkGC42wAkBULLppX203liHCe1wRJARPlmbsF8/0kgQjtIq2vTQESRbnnJR3ZBwuJONh/5i79tvFFL4ZQ/8HVdSitjNoQjxqf5+CPzaL4gJU026KMPouELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zoQP3lGB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B990AC79ABE;
	Tue, 26 May 2026 17:15:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E5FB6011D;
	Tue, 26 May 2026 17:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A9881088897D;
	Tue, 26 May 2026 19:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779815723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=O4ihxJuw8U/dvO5k6NDCRTW2nILGUxgx0sPV5BB0QZo=;
	b=zoQP3lGBCHrDZ7fLgIK60F9BFgH3qL17tSnNSuacr23FEL60KM2PC6CLcZ5X4I8h/sW1rN
	3t/FCqzEFzkRCmyG4lReuYqiqa4W5jf8daf5iFFrBcIdmAWfxQ5qo4raQpv+EfTPpLCokR
	cvhZ7edkdaga0pFfh43fyeqhMGX5Pfg8X4fUNjDKf4avISTGTaAHaZu3uyy65OGbuT51al
	TI/cthJ3Z7is4KMZSwTYqmwIWNTUacfNXllLGwrgXPLOAKLmCwzmMOq0FZH4x4zLSA/yrO
	MKSj5rBXAmKLmSZ1ttTfLpXZgFrzVYoSvUjmxHPcgKOmyCwtJHGDc4rNAsR1dA==
Message-ID: <c1ef0cd4-746c-41fc-b1bd-d72b5c107e87@bootlin.com>
Date: Tue, 26 May 2026 19:15:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/10] ethtool: strset: fix header attribute index in
 ethnl_req_get_phydev()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch,
 liuhangbin@gmail.com, chleroy@kernel.org
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-9-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,pengutronix.de,bootlin.com,microsoft.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD0D05DAA7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> strset_prepare_data() passes ETHTOOL_A_HEADER_FLAGS (3) as the header
> attribute to ethnl_req_get_phydev(). This is incorrect, in the main
> attr space 3 is ETHTOOL_A_STRSET_COUNTS_ONLY, not the request
> header attr. The correct constant is ETHTOOL_A_STRSET_HEADER (1).
> 
> ethnl_req_get_phydev() only uses this value for the extack,
> so this is not a "functionally visible"(?) bug.
> 
> Fixes: e96c93aa4be9 ("net: ethtool: strset: Allow querying phy stats by index")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Indeed, my bad :(

Thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: liuhangbin@gmail.com
> CC: chleroy@kernel.org
> ---
>   net/ethtool/strset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
> index bb1e829ba099..94c4718d31ae 100644
> --- a/net/ethtool/strset.c
> +++ b/net/ethtool/strset.c
> @@ -311,7 +311,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>   		return 0;
>   	}
>   
> -	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
> +	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STRSET_HEADER,
>   				      info->extack);
>   
>   	/* phydev can be NULL, check for errors only */


