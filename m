Return-Path: <netdev+bounces-291113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRtGm28EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE325BF704
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22603300B46D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF432DC32E;
	Sat, 23 May 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CLoDOBtP"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A43597B
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547242; cv=none; b=fMLAJDBSoJUy9xnjacTz2rhs0mb6as8wO1aeKSPhdKxvr2kHgitenZ/6V47fOYp37Ybm6hlJDSnP0uORp4v1vz+BgCUe1fEjI6Ugw1vkoI0Ess1eOKFLqa9zjrRXOYzKeTqD7eRbEsnUgsJlr5/7CH8N3OGssnW5rYt0d9Fdt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547242; c=relaxed/simple;
	bh=IBOatEi59SMSq5znKgRcHeVn6t8VA+W9H/MEa5KfDDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cux1Tje/moZSLHnIizmA0vayC+zP/Z+IkmVbim/A25CdOC2Syb6l1T5osKAHHdlp3mfIi9fuwwwHO7TNGutqdfMeJzIpS5F9znaNkg49Q/cxEJOai6Xsezn1vgZhqgPBZbXL7X7nidcxFp1ZIStKrU5nVM5DD6smwKKwdF5RcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CLoDOBtP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5BD9A1A368B;
	Sat, 23 May 2026 14:40:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1463760733;
	Sat, 23 May 2026 14:40:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F23F10811D8A;
	Sat, 23 May 2026 16:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779547238; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=H+wq1nwbkifpms2nuEiAAtFMDh6/XSwnTDwZM5GityE=;
	b=CLoDOBtPpiUezEO/lEWT5HMwuRA43D6vQMqRUB6ZZVVe5OwnOpfWuJxq4SnB4YF6iRQlLR
	+Wi0V32PG+mG0AV/Mdws4XUk2mrQVw/hy1oW2+iuD0zjEgDBJDiYD/7kMDbs4hVfa0oIzT
	QSqh39JfeQdT5vrzVfwaKvH6Jic5Wvbwg2mAvvegVp9y7PlioO2PJhhn2fi3+0BNRuD006
	DRJPJ5Nmp9kRDzxxyvwzpeAaKJtjxHOccPVH+/1+Qw+c64WDkGVJyneB2G27SiLZ05ma39
	3+rnb0b2iBGDfxvnYLbRQLGu3wFgIdObAZ6Z/8aJsYBDXr0Hxwi5negSaNf8Jg==
Message-ID: <7a81d215-20d4-4a5c-a12d-c3593dba832d@bootlin.com>
Date: Sat, 23 May 2026 16:40:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/9] ethtool: module: check fw_flash_in_progress under
 rtnl_lock
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-5-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDE325BF704
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> ethnl_set_module_validate() inspects module_fw_flash_in_progress
> but validate is meant for _input_ validation, not state validation.
> rtnl_lock is not held, yet. Move the check into ethnl_set_module().
> 
> Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: petrm@nvidia.com
> CC: danieller@nvidia.com
> ---
>   net/ethtool/module.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ethtool/module.c b/net/ethtool/module.c
> index cdb85e19a23b..5b49004ddf60 100644
> --- a/net/ethtool/module.c
> +++ b/net/ethtool/module.c
> @@ -120,12 +120,6 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
>   	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
>   		return 0;
>   
> -	if (req_info->dev->ethtool->module_fw_flash_in_progress) {
> -		NL_SET_ERR_MSG(info->extack,
> -			       "Module firmware flashing is in progress");
> -		return -EBUSY;
> -	}
> -
>   	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
>   		NL_SET_ERR_MSG_ATTR(info->extack,
>   				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
> @@ -148,6 +142,12 @@ ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
>   
>   	ops = dev->ethtool_ops;
>   
> +	if (dev->ethtool->module_fw_flash_in_progress) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Module firmware flashing is in progress");
> +		return -EBUSY;
> +	}
> +
>   	power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
>   	ret = ops->get_module_power_mode(dev, &power, info->extack);
>   	if (ret < 0)


