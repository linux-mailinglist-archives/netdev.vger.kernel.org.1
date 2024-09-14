Return-Path: <netdev+bounces-128315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257AA978F55
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BDC1C20A38
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8D13B780;
	Sat, 14 Sep 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JCUsxhlW"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0313B280
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304523; cv=none; b=iWjbYR92o2aGbfuMvNRPoH9SE2liaNHQNjSf8HMWbvSpGw1Hpy4bxm2UxeVMotg7UoYxOCGsp2ebfLlHZ23+KXM0hzeqa/4V7IvTEx28vLdCDca0WbaHmfUnAbmmWssA7FJVrLNef+uhTk2YdHE0TWOndMni0YVz1OtiMk1satk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304523; c=relaxed/simple;
	bh=RguIB3aGEfSWCgglIE1kYAFxeTfH5FygVmsAfzK51S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkmGsilamm1aLmOnRq4bA9ZcUbfR+A8AwITNqsmoZUX5iESY5wA1epE+rxvZkYXsX/9VaI9+3me1E+TYBXHO+hAh8eFz0oyzXV+amO8kGjrzQnUgxlJUefkhyDaimobYoX/YwBkm0xyHrg1RxCQCQ09Gn65Gx5Z1YXZPnezjBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JCUsxhlW; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pOfCshuFQv6ompOfCsZIYM; Sat, 14 Sep 2024 11:01:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726304518;
	bh=knYckm5aJnSchYoHGjtSQ5Mu9N8dnHyi0u0NUCdhg5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JCUsxhlWfnXYG7qqBlHRwqWbVdqUSsjgkQL6eUR58kbIeuUVtWohDGPbV5/s2q8Ee
	 4TSYJVLz5jqr29u0eDWEUW4IbLK1xdclOTn/+c3sdiztY4zYW4r4FmWssPaOiPGkxd
	 qRyk0A8vwwRLQnQcfRqCScBOLofMPnqZla4+sQTtxLXVZ+u7gpbUnuQ0ubJc4JtXZ7
	 PvIXA2Y6oFzDf8jmElTU3OgoFNv5CyODjrReBzHeuebceWwtXjgjNs9Gj7fI4OTV1W
	 w7OJ2fPASMTBKQDpp11+MMZJeuY/RIGb4o9kswfaRZOEh96zUxkZBK/jXewddbJz7I
	 srteqXsdDNv8A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 14 Sep 2024 11:01:58 +0200
X-ME-IP: 90.11.132.44
Message-ID: <484a980a-8ea4-490b-89b3-9fca3c471133@wanadoo.fr>
Date: Sat, 14 Sep 2024 11:01:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: fs_enet: Make the per clock
 optional
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>
References: <20240914081821.209130-1-maxime.chevallier@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240914081821.209130-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/09/2024 à 10:18, Maxime Chevallier a écrit :
> Some platforms that use fs_enet don't have the PER register clock. This
> optional dependency on the clock was incorrectly made mandatory when
> switching to devm_ accessors.
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/netdev/4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr/
> Fixes: c614acf6e8e1 ("net: ethernet: fs_enet: simplify clock handling with devm accessors")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> This patch fixes a commit in net-next.
> 
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index d300b01859a1..3425c4a6abcb 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -895,7 +895,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	 * but require enable to succeed when a clock was specified/found,
>   	 * keep a reference to the clock upon successful acquisition
>   	 */
> -	clk = devm_clk_get_enabled(&ofdev->dev, "per");
> +	clk = devm_clk_get_optional_enabled(&ofdev->dev, "per");
>   	if (IS_ERR(clk))
>   		goto out_free_fpi;
>   

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks

