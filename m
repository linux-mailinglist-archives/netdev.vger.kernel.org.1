Return-Path: <netdev+bounces-288601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOl9D3Q3CGoHegMAu9opvQ
	(envelope-from <netdev+bounces-288601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED555AE8A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442A1300F5DE
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4231AA87;
	Sat, 16 May 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hSRDkQCf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-67.smtpout.orange.fr [80.12.242.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEA2309B2
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923351; cv=none; b=Xx3NS5eHhZZlIGkXGpOW2Fs/FB6X0kvYBWyO01RETTFh8UYNXp3a0IidIbKAbDVs390X8fvbOVVdW4KU+2oo4aj8cOxwSv+E727KQ0ZIvvBW85PTMtQ/L5IVaPe98Fh1+ettKy3wLTgs5hbxAelb3V+pdrVAo8NMxSTN81qjRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923351; c=relaxed/simple;
	bh=4H88ltRZQbtmLvPIO6JNbeo7+UL3ESvP5LV/kuBL0T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+c7ewfJgnQwvOe888Z5+k6ujp3DF4W3DdAXX5hdQcv/XIFDyxDIN/uf64vc1tZZd1ghwDHUzSc/8i+V9oyvsvWVCqh+8HoA8wxujXtc3w6BzPCQK9XVC+Vk9TivbrHhAvKsRk5VI7F2MZ9AoAIzmxKxFmeUwXsTl8Zp6XkyAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hSRDkQCf; arc=none smtp.client-ip=80.12.242.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662] ([10.65.86.66])
	by smtp.orange.fr with ESMTP
	id OBE4w2MIZ778NOBE4wgSSN; Sat, 16 May 2026 11:22:28 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id OBDtwBqUpdU5COBDtwQCAV; Sat, 16 May 2026 11:22:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778923340;
	bh=ajy47/jzv03szTUERQhkyhrJCDY8Me3a1R/MdjkE3KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hSRDkQCf9OdkeOgk0buy1VBKnDY2E3hay1UhlPqXyFP/murL+35D/wZ/GS7rSz7td
	 nYnslfWZJtoPF29pc7Yc7H2x5f6VQLewMAWtdOmpZiKZ4/scnPAWhAQE4L+pPZgoAC
	 WlbjEKAEDIdDaqlmznX6CnSB9uvkuHn9PaAoF9mUbHM9Be5kmOFBbDWcmYNXSSxrGH
	 iChqPPDTnqc56rCSeKFarujR/cizqzPGf8a0GbAi0VJ53C8jxzbeSvN0Zs3DX5z5pi
	 KpVwpy5oVYE4L/zcOFWzFM+DWvXLCa5knd+7fbF9p9A2e+K1jOnILzPzwRqAwkLWoQ
	 J0lXzwpUI/BMA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 May 2026 11:22:20 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <2f6d28f5-0b7c-4618-8a71-87f25909e52a@wanadoo.fr>
Date: Sat, 16 May 2026 11:22:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check
 in slave_add_vid()
To: Alexander Vassilevski <oss@vassilevski.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Chintan Vankar
 <c-vankar@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260515225715.3641804-1-oss@vassilevski.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260515225715.3641804-1-oss@vassilevski.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BED555AE8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vassilevski.com:email,linaro.org:email]
X-Rspamd-Action: no action

Le 16/05/2026 à 00:57, Alexander Vassilevski a écrit :
> am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:
> 
>      if (!netif_running(ndev) || !vid)
>          return 0;
> 
> so vid is guaranteed to be non-zero in the rest of the function. The
> subsequent
> 
>      if (!vid)
>          unreg_mcast = port_mask;
> 
> is therefore unreachable. unreg_mcast stays at its initialized value of
> zero and is passed as the unreg_mcast argument to
> cpsw_ale_vlan_add_modify().
> 
> Drop the dead branch. No functional change.
> 
> Found by Smatch.
> 
> Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
> Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>
> ---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7ac75fc8cd..77f59996a0 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -316,8 +316,6 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
>   		return ret;
>   
>   	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
> -	if (!vid)
> -		unreg_mcast = port_mask;

Maybe unreg_mcast could also be removed then.
It is known to be 0 and is unmodified.

CJ

>   	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
>   	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
>   				       unreg_mcast, port_mask, 0);


