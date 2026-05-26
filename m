Return-Path: <netdev+bounces-291874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I+6EFjgFWo6dwcAu9opvQ
	(envelope-from <netdev+bounces-291874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776725DB211
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7ECF301379B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368D3C5DCE;
	Tue, 26 May 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MmZqekZv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D9410D06
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817628; cv=none; b=EXRF1RMfGK49BRKM29+CYMUpO86BDV7u3qmgGNSIqxFR9fDHYVki++BTjWWdcBvRUut44vJvo6+Q4Xsk5Gr3L+7Q/dYcWMwfGWQHpMuu2Ewo6IIeN3VSttFZ1vTdVzvWNUlGvP42PumJsLWO8og76munyWEg1OQY5NOb/sQaP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817628; c=relaxed/simple;
	bh=TLesoEoiCAfLI3uupikvinn+TFASbXk8rqOJGh9e1VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rjm4KZBj/5VEhSvehDKOO2J49gpUNi5D6OiUHDtnfFLupkBUEihwF/FKiDh6GtUR6dkH6r9QYtikgdrK7kkuqsJ2k0Dj8ZNFMqMKDu2yguTIEUalB9yxZNjDMvn27rOTSIZ4HX7guHgBdC8MuqTQl6eZkOk0KAnHnN0cX6G4tUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MmZqekZv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A0A91C79ABF;
	Tue, 26 May 2026 17:47:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D4646011D;
	Tue, 26 May 2026 17:47:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 737FF108889E1;
	Tue, 26 May 2026 19:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779817623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=quOHQzwdS+5HN7n9+dcVJkNaXla1ATVSNcbbILKyics=;
	b=MmZqekZvnQEjHCa2I/3jqxF4a7UwFtcr7hNhpsD9WBHqc9Q4jK99pUg2O7EdZJDBFByFO/
	TeM9iuDbPzhdLHLFAN6JL4g4gWWhCKXBcSp/AuByDy892dZOfz66HOCh+q6Dh+rlvTxyiH
	4d+A4DnjpbJKCjE5DuKKgS35/c9FbuAsmqsQXyk/Tm1Zl6Rzt9mutDoPUOutlso7OMOBET
	Bh1fjaADzWehAIUCQ9G7mtHNuSuro/HjRCsyDjjTCiWkRqvXj4CrX6Df7uya/nE86MciY1
	9tNjthmMp4rjp4dgcfggnL67n4hBdwyyDwFILejACHw3FFLOcKmteNDNR0/yFQ==
Message-ID: <f7c262de-d60a-4029-9833-e83257983ea7@bootlin.com>
Date: Tue, 26 May 2026 19:46:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 07/10] ethtool: tsinfo: don't pass ERR_PTR to
 genlmsg_cancel on prepare failure
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-8-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291874-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 776725DB211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> The goto err label leads to:
> 
> 	genlmsg_cancel(skb, ehdr);
> 	return ret;
> 
> If ethnl_tsinfo_prepare_dump() failed, it has not started a genlmsg.
> There's nothing to cancel, and passing an error pointer to
> genlmsg_cancel() would cause a crash.
> 
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: kory.maincent@bootlin.com
> ---
>   net/ethtool/tsinfo.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index f54fe6b662b2..14bf01e3b55c 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -407,10 +407,8 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
>   			continue;
>   
>   		ehdr = ethnl_tsinfo_prepare_dump(skb, dev, reply_data, cb);
> -		if (IS_ERR(ehdr)) {
> -			ret = PTR_ERR(ehdr);
> -			goto err;
> -		}
> +		if (IS_ERR(ehdr))
> +			return PTR_ERR(ehdr);
>   
>   		reply_data->ts_info.phc_qualifier = ctx->pos_phcqualifier;
>   		ret = ops->get_ts_info(dev, &reply_data->ts_info);


