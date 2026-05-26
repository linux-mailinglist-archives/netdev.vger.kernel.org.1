Return-Path: <netdev+bounces-291838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAfuEP3VFWrRcgcAu9opvQ
	(envelope-from <netdev+bounces-291838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:18:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C65DA84C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D71F30485B8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724B1421890;
	Tue, 26 May 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EOMZJwMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800F413225
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815635; cv=none; b=t1DToOjgtQjgsJfLUzBnRE/RTnLAdMSHTGnmX8BK+moCUkAz6ZpFuPTtmudmvlaxSbBr2TJjhsT/FOVMkm5EXQH4wXI7W4HdGtXaaauyyWaVtdiST3cZeJr8teSPq68s8EeVDKhI1H9OMG37Huci309H9XGpIUywDD5JDyBmpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815635; c=relaxed/simple;
	bh=WAETMV+93fuc7jRBnUMhC43/BsuKuoKB5qO1saXMzuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvKnkEjgEdrQJitr8Caj3S/XjpasMmT8UTpGY8Yst8rDho3wkV7UTHPAakZo2xt4fh0glnI0kkFE6w1IcLMZ2c6tgSJGU1PN1yj14iXNYj8X50KH66zd5Yjksjx6nliSl8JwZzGmGoBgjULCkcOapViyrPpBXqhTdCHQfUp5lUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EOMZJwMw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A1C7CC79ABE;
	Tue, 26 May 2026 17:13:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 365656011D;
	Tue, 26 May 2026 17:13:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90E5E1088897D;
	Tue, 26 May 2026 19:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779815627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3xHFuC8og3ZxbcbR67FIEfNVmxijX0Xd5qe9gz/OvEQ=;
	b=EOMZJwMwr1a6MSeHihbhNvbRctQnytiPJd0AnDzvqVM4royrn8Jvbej7gREOO3+rm4kclQ
	IAuy7iO6Xp23uj8NnbMcJ9HIfbbQns3PLIEQjBjyBPpr9042bVWwuVBg5gbmq0DFI3cd+M
	6LmNCnG6T7atWHTjmyHFK3XAaNOsHiUWf+3sLAw3yeaz1tAM1fYGF9P0D2W01r9x1M8r2p
	1hDC5PsjxkWQkNlFXDCir3+/iVnoSEAkgSMe53ZU72ERcGLOqhijD6ESsYLZHSsf8UPcTO
	1bnta5Em90VPh2edNDtYGYx2JZlankS2FM6ec8Px0oQNPhG10WvIdU8q7W4dpQ==
Message-ID: <e7de9862-9e31-4210-b3e7-80785fb7e553@bootlin.com>
Date: Tue, 26 May 2026 19:13:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/10] ethtool: eeprom: add missing ethnl_ops_begin()
 / _complete() during fallback
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-10-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291838-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD7C65DA84C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> All ethtool driver op calls should be sandwiched between
> ethnl_ops_begin() / ethnl_ops_complete(). In Netlink eeprom code,
> if the paged access failed we fall back to old API, but we
> first call _complete() and the fallback never does its own
> ethnl_ops_begin(). Move the fallback into the _begin() / _complete()
> section.
> 
> Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks :)

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> ---
>   net/ethtool/eeprom.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
> index a557e3996c85..836316df3092 100644
> --- a/net/ethtool/eeprom.c
> +++ b/net/ethtool/eeprom.c
> @@ -141,12 +141,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
>   	return 0;
>   
>   err_ops:
> +	if (ret == -EOPNOTSUPP)
> +		ret = eeprom_fallback(request, reply);
>   	ethnl_ops_complete(dev);
>   err_free:
>   	kfree(page_data.data);
> -
> -	if (ret == -EOPNOTSUPP)
> -		return eeprom_fallback(request, reply);
>   	return ret;
>   }
>   


