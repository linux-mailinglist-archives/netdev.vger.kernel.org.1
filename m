Return-Path: <netdev+bounces-291863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMPgKefXFWpYdAcAu9opvQ
	(envelope-from <netdev+bounces-291863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:27:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE25DAA49
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 337083025498
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62551405C3A;
	Tue, 26 May 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U2kNvPlb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F163FBB67
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816209; cv=none; b=foxAvB7WshiPjmmelt0a5Cu9W5ZTxqEdvXQwqu5KMnsUfvF+OIBF9P0CZmR6wzB8RL6pnYLqEL7NkHQlJ74BERGJujsA2FTK3Zr72C66ErqJjkJie6lJo+3fauHua2sYYWYf1I0fVEkAlW42D6Nj4k7A3pkRQ5u6HbRIXZSikKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816209; c=relaxed/simple;
	bh=rWUy9cACuZ3mbw9PvZS+3NkKh/j7p3pNtLWTf3mQh0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro1u8/HEs1vzVUM4twjwr/y2JgIT5X7+nbubOzl2BsbktOf7rm21c+IsMKJ4yOUjSOOynAYcEHhzP++TeYMClGE3x1gW3+AnOYfTO7waCjuvv3Otm18IVZ5bza3L9KY79oxnsyiJh1Ectfn2fE50dK1WGEiVxesx2HUPHP3tCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U2kNvPlb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 99E4A4E42D61;
	Tue, 26 May 2026 17:23:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 652496011D;
	Tue, 26 May 2026 17:23:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9DD5108889CC;
	Tue, 26 May 2026 19:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779816204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=p4GeGzPUJqKVD636uCuGfIJB5f26pAqq4LwsHNLNP+k=;
	b=U2kNvPlbgGrkOm4maWwSzZLA9FIjIjTAQrd/Xk3gci0VTO/U0rjOvPpcAZXpa1TvrZldx+
	MDedjOsg0KlBWUHSO/gk+DvoACF+AMFQjdLBvy/ldMfked792pLvq04RNVm+/zWJS+hfeF
	9XhCtlYNtoTtLN+sQoog7SREMf/sfh3P+/z4zTmFzYopd6xdaeIGFbuiqmH6ZwFLWvK/Fg
	lktHsyl4nf6NOY8CMjaauyD4slDN9ILIRBjZbRu4LyvJ/lGiNZBUk3LgJUJJCRJh8mjMOG
	H0JVlXG19pB21GJFs+1ocNvc6n1eagEcXsAVUG/XyAPwnWR6ga0o5MThMnz7yQ==
Message-ID: <1716074a-e103-4d25-9f7c-167f755e002c@bootlin.com>
Date: Tue, 26 May 2026 19:23:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/10] ethtool: tsinfo: fix uninitialized stats on the
 by-PHC path
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch,
 kees@kernel.org
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-7-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291863-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: B3DE25DAA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 17:35, Jakub Kicinski wrote:
> tsinfo_prepare_data() has two code paths: a "by-PHC" path for
> user-specified hardware timestamping providers, and the old path.
> Commit 89e281ebff72 ("ethtool: init tsinfo stats if requested") added
> ethtool_stats_init() to mark stat slots as ETHTOOL_STAT_NOT_SET before
> the driver callback populates them, but placed the call inside the
> old-path block.
> 
> When commit b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to
> support several hwtstamp by net topology") added the by-PHC early
> return, it landed above the stats initialization. On that path
> the stats array retains the zero-fill from ethnl_init_reply_data()'s
> zalloc. This leads to the reply including a stats nest with four
> zero-valued attributes that should have been absent.
> 
> Reject GET requests for stats with HWTSTAMP_PROVIDER or dump.
> 
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

We may have per-provider stats one day, but for now I agree
with this patch.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: kory.maincent@bootlin.com
> CC: kees@kernel.org
> ---
>   net/ethtool/tsinfo.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index a865f0fdd26b..f54fe6b662b2 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -83,6 +83,11 @@ tsinfo_parse_request(struct ethnl_req_info *req_base,
>   	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER])
>   		return 0;
>   
> +	if (req_base->flags & ETHTOOL_FLAG_STATS) {
> +		NL_SET_ERR_MSG(extack, "can't query statistics for a provider");
> +		return -EOPNOTSUPP;
> +	}
> +
>   	return ts_parse_hwtst_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER],
>   				       &req->hwprov_desc, extack, &mod);
>   }
> @@ -523,6 +528,12 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
>   	if (ret < 0)
>   		goto free_reply_data;
>   
> +	if (req_info->base.flags & ETHTOOL_FLAG_STATS) {
> +		NL_SET_ERR_MSG(cb->extack, "stats not supported in dump");
> +		ret = -EOPNOTSUPP;
> +		goto err_dev_put;
> +	}
> +
>   	ctx->req_info = req_info;
>   	ctx->reply_data = reply_data;
>   	ctx->pos_ifindex = 0;
> @@ -532,6 +543,8 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
>   
>   	return 0;
>   
> +err_dev_put:
> +	ethnl_parse_header_dev_put(&req_info->base);
>   free_reply_data:
>   	kfree(reply_data);
>   free_req_info:


