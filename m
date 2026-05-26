Return-Path: <netdev+bounces-291831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCbpC53RFWogcgcAu9opvQ
	(envelope-from <netdev+bounces-291831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C965DA44A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77DD53035F35
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C0C3D6466;
	Tue, 26 May 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d5+wmFmH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B323F7865
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814299; cv=none; b=OopH0FEU1Kwt5gnpFj4ITM9/UwLgU1QcTheueD2YrD0NvCpBh7WIn4EbH0cD5tr9OjpRzV8JPi9dhsqyzQNuCFqEl4BpafpZjLYWK4FK4eq7XD1SZsy38fKJD8LejTAz+4eLDCofSxKftQloBPyH1/partYML03mLzj/YT5A8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814299; c=relaxed/simple;
	bh=5AymClZEoPoN1I/ayZKrb1HYUqU4OLw4SF80hR8uPws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTg7ACo+5tq8ZDfo6rRJF0F/yc+7JOyKaKS69r4YODHrbB02qZcHhPl+eiB1jxft78IylIUAjCwjAGO899Ja4n1CaXYyTy5Qrf0xJGb5lz/u0b2MysFBsDIzdllNOmlh7+n4yr6+R7tM90+i7tQuH9n4y10qpms7MdRw2E7V8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d5+wmFmH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 051CD4E42D61;
	Tue, 26 May 2026 16:51:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5DB26011D;
	Tue, 26 May 2026 16:51:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D861088899F;
	Tue, 26 May 2026 18:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779814293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j/A/hn15fCwY/6fIjA55PwASVVJRiR8tXpbm3BxnJto=;
	b=d5+wmFmHSsj+K6t3jxCfNV+75cVuNz+pYZTtSNuqqlGtTL0jrsBh8zbyyWH/O2l8er6PqI
	l55BmTMtKshMAI1rEQGqT0DnLCdacOXduo7VgFTHZbKNFYbwDn1yDGDxVB/UQUqj7car+Z
	qOoEPlCzsjrk+Ps/NTmBN9KdTAfI6v9aK1mpEJtWvGytqNDoUNaWtkgM2NpkrxejphxNxM
	w0BN1bV6uJglZqibTfgrFNW7yVKc+t0M6lwYmC/bYVTayoQRCAM91hETdCwUjgJ+jX7K+M
	TlLmUgpHBAvcRvzIFbl7rAWK/bbnMy0Scr43mAGnk9RT7zsK3SzNoJK7Tn9kCg==
Message-ID: <d16bf6d2-94b3-4e7f-b71e-04215dc66965@bootlin.com>
Date: Tue, 26 May 2026 18:51:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/10] ethtool: pse-pd: fix missing
 ethnl_ops_complete()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch,
 chleroy@kernel.org
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-5-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-5-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-291831-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,pengutronix.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3C965DA44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> pse_prepare_data() is missing ethnl_ops_complete() if
> ethnl_req_get_phydev() returned an error. Move getting
> phydev up so that we don't have to worry about this
> (similar order to linkstate_prepare_data()).
> 
> Note that phydev may still be NULL (this is checked in
> pse_get_pse_attributes()), the goal isn't really to avoid
> the _begin() / _complete() calls, only to simplify the error
> handling.
> 
> While at it propagate the original error. Why this code
> overrides the error with -ENODEV but !phydev generates
> -EOPNOTSUPP is unclear to me...

The logic is that ethnl_req_get_phydev() may return -ENODEV,
meaning "you passed a phy index for a PHY that doesn't
exist", which is different than "there's no PHY, setting PSE-PD
params isn't supported then."

But there's no real sense overriding the phydev ERR_PTR with the same
value :) Your fix should be fine :) Thanks for this !

> 
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: o.rempel@pengutronix.de
> CC: kory.maincent@bootlin.com
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: chleroy@kernel.org
> ---
>   net/ethtool/pse-pd.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2eb9bdc2dcb9..757c9e0cc856 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -62,14 +62,14 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
>   	struct phy_device *phydev;
>   	int ret;
>   
> -	ret = ethnl_ops_begin(dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
>   				      info->extack);
>   	if (IS_ERR(phydev))
> -		return -ENODEV;
> +		return PTR_ERR(phydev);
> +
> +	ret = ethnl_ops_begin(dev);
> +	if (ret < 0)
> +		return ret;
>   
>   	ret = pse_get_pse_attributes(phydev, info->extack, data);
>   


