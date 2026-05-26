Return-Path: <netdev+bounces-291866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAbrLDrbFWowdQcAu9opvQ
	(envelope-from <netdev+bounces-291866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:41:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD85DAD6F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 437DB300380D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A340B6E6;
	Tue, 26 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQUSdvPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E5402B8D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817272; cv=none; b=WDRq/Sy0DsJ63+S1w8IGwHzq8OTtSB2u8i4rv2mkZqYNmv7uJFKdn7L7X8VGFyMzFK28fbAwcIDF5DshPgYsxFa9etk5ZY1ezgO+Jdu9iHhDYgU28cIYjwT5SYNqlOVQRtY3yHX8b6F23d56raLH/E2BhqFNNQrXPChTk+pbc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817272; c=relaxed/simple;
	bh=9JMcCYkgv2MdyS/zDsjBocAv7/65B6uyswEBhfVfdNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzY1tIxEgPCbivy/Xqeot/+9w/yy2B3BnZHXhYPzRyIjZeb3yT3muGISE4JWvDxzFoQ35t1Anu7jQUCjSdmtvdjMypFC9g29hgPKLMwp99zLN20jHj0C7uv41Dtbd6O/kZ3CKV10M7D/Gi5prdRUnKc5ExjqKhmFYERxNtWE4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQUSdvPn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 57AD8C79ABF;
	Tue, 26 May 2026 17:41:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3D936011D;
	Tue, 26 May 2026 17:41:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46E44108889DB;
	Tue, 26 May 2026 19:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779817266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mAR/yvnDkpa/ETxUJ+Ubbozyg4x0TWs8sY+uTmw/qV0=;
	b=mQUSdvPn11TgDIvDkqMUqJJmMlv078f6rWqfOe0aIkY2HdPuKkNmXm0biRs2Hk9ZHAvgFU
	ydbxpJLEZ41KF0nWOcoELDjpYD1BIlbFUqbExHbKDIo5nke7tE5Cu18yQycGVOSsb3+Lll
	K/+stR3D6TFy5TkRsIPxNlh5nKs43QKYQf4MjkXFzG49LOwGnA7Cu3cX+MyAh9QdPYe7Eg
	ZNMlnzaLTYV6DR3vRa/8XsmitfZDMMGGMYaiFcqO+YSm8ET7P7KY2xiGkvWf8I0s857ZdD
	+tFSxjROdc1LR9r1n1KT69d13pXwN7xyt0W68d1WW/I1z5DyiRclSxUBmlsTvw==
Message-ID: <4a1f9f77-a70d-409a-956f-ffa7c5c4754c@bootlin.com>
Date: Tue, 26 May 2026 19:41:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/10] ethtool: coalesce: cap profile updates at
 NET_DIM_PARAMS_NUM_PROFILES
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch,
 hengqi@linux.alibaba.com
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-2-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,alibaba.com:email,lunn.ch:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 5FBD85DAD6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> ethnl_update_profile() walks the ETHTOOL_A_PROFILE_IRQ_MODERATION
> nest list with an index 'i' and writes new_profile[i++] without
> bounding i. The destination is kmemdup()'d at NET_DIM_PARAMS_NUM_PROFILES
> entries (5), but the Netlink nest count is entirely user-controlled.
> Netlink policies do not have support for constraining the number
> of nested entries (or number of multi-attr entries).
> 
> Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: haiyangz@microsoft.com
> CC: hengqi@linux.alibaba.com
> ---
>   net/ethtool/coalesce.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
> index 1e2c5c7048a8..e73fc3e5a02b 100644
> --- a/net/ethtool/coalesce.c
> +++ b/net/ethtool/coalesce.c
> @@ -472,6 +472,12 @@ static int ethnl_update_profile(struct net_device *dev,
>   
>   	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
>   				 nests, rem) {
> +		if (i >= NET_DIM_PARAMS_NUM_PROFILES) {
> +			NL_SET_BAD_ATTR(extack, nest);
> +			ret = -E2BIG;
> +			goto err_out;
> +		}
> +
>   		ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
>   				       coalesce_irq_moderation_policy,
>   				       extack);


