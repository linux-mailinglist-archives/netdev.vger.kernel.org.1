Return-Path: <netdev+bounces-143451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8969C2774
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05201B2167F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03A1DE896;
	Fri,  8 Nov 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OCr7evBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D6233D8C;
	Fri,  8 Nov 2024 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104571; cv=none; b=SfVQGKgATDGbGf+cU1w02UTY0PBunfXULNn8CjY2BF59De13n300vBDI4H2u+WGLVywqPSctE59US/7JSK1vXPjRaypn10zyi2eZDmVI6DuzFozNbMIEmsVql7H1L25i+9788i2sztWIicwiKIBoz1e7+7vT0CFbRspo92JX8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104571; c=relaxed/simple;
	bh=VUMNYqBqRk+bOB2rzDRhOy4I7Q2ptnmdSgkVoXxejhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TXvqqdRYAynTuRd5aQRjzYCnq9Z2wnBPBa88cckKE8RLrtcf8E3CUZJAhiIcicYAV6zG90+T1X0dcqORvXFeaiDEJKw+S5mvut8bioJ8QLAB+aqaPPvrbTxyvU3sViMgatLgCpSvSdf0OIXxz9KuiwU8920grJcXML0VTHSrOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OCr7evBA; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 9XNFtMV3pFhC09XNFtsbar; Fri, 08 Nov 2024 23:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731104560;
	bh=xsrkrId2lIYJCFt7oB7Y6EgOkBTSbKIAh53Ak1OYI3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OCr7evBAcLliDBH7JIO9KPXO4GVZDPVDjUgFQ9LlzM5RBLMwhuKMYawIHNoAxKCVq
	 cMyopUJjii8GKWWvR06KKD5u3GhPD+jxh9S/7AV65E3byZCtMUuQ5zqXEycIcgvQhM
	 JH45ITWtTzTg0lYCPt7KYOwVoCV0Q4V7qd6He13S571rsTIroeXFmcMpDgwOAA7yE2
	 CinZpsO8TC3kN1gxSUB17xNqmuG1BYGeNsnJfNCX/pktLwCsYxr0WqgNi47YCfUreu
	 LqiuSLBvqAKMdgexiPIkUCGTGNNzQ23PJliHTkBsLzuLzC15GXW4cdRwTrSUAz0kA7
	 pH6ZiIeBx4KZQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 08 Nov 2024 23:22:40 +0100
X-ME-IP: 90.11.132.44
Message-ID: <9ea17ec0-921f-4197-904e-52a91f6a5170@wanadoo.fr>
Date: Fri, 8 Nov 2024 23:22:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108200217.2761-1-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241108200217.2761-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 08/11/2024 à 21:02, Christian Marangi a écrit :
> Some DSA driver can be simplified if devres takes care of unregistering
> the DSA switch. This permits to effectively drop the remove OP from
> driver that just execute the dsa_unregister_switch() and nothing else.

Nit: s/driver/drivers/

> Suggested-by: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Please, remove the "Marion &"

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   include/net/dsa.h |  1 +
>   net/dsa/dsa.c     | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 72ae65e7246a..c703d5dc3fb0 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1355,6 +1355,7 @@ static inline void dsa_tag_generic_flow_dissect(const struct sk_buff *skb,
>   
>   void dsa_unregister_switch(struct dsa_switch *ds);
>   int dsa_register_switch(struct dsa_switch *ds);
> +int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds);
>   void dsa_switch_shutdown(struct dsa_switch *ds);
>   struct dsa_switch *dsa_switch_find(int tree_index, int sw_index);
>   void dsa_flush_workqueue(void);
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 5a7c0e565a89..5cf1bac367ca 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1544,6 +1544,25 @@ int dsa_register_switch(struct dsa_switch *ds)
>   }
>   EXPORT_SYMBOL_GPL(dsa_register_switch);
>   
> +static void devm_dsa_unregister_switch(void *data)

I was also wondering if it would make sense to have callbacks used by 
devm_add_action_or_reset() have the __cold annotation.
(AFAIK, it is never used for that up to now)

CJ

> +{
> +	struct dsa_switch *ds = data;
> +
> +	dsa_unregister_switch(ds);
> +}
> +
> +int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds)
> +{
> +	int err;
> +
> +	err = dsa_register_switch(ds);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_dsa_unregister_switch, ds);
> +}
> +EXPORT_SYMBOL_GPL(dsa_register_switch);
> +
>   static void dsa_switch_remove(struct dsa_switch *ds)
>   {
>   	struct dsa_switch_tree *dst = ds->dst;

