Return-Path: <netdev+bounces-131886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D490D98FDED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762DE2844DF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC813B2B6;
	Fri,  4 Oct 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="k/jjFWPV"
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD8130499
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027518; cv=none; b=BxxYc/pYnu8WYIazU0AUd/azpj7FP5IxirjrkCXJ6qktb4OCrMQ49/l0M6bRbeAaaRk0xlOM16WpyU5BtsqNOk1BT6Ni4ifnaeHNOJvOPrEc+3f5Px6yGMsoF22/AlPH9yaC1YeeuHZ6qRjlT8usBPViYDCvl6xgn8t1oc2uP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027518; c=relaxed/simple;
	bh=s+8GRiHCzafdVxYEuYTniPFWHKOrejSe2cOamq+uGFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr8gacT3V1BXSoyB2jat6BO8rUG7nCzNaOKoSErEvvtdwpnU5gNdgwIp7d2ZPDOhf6t4NHgF9YdnJrk24zprvCDG9SBOkAAGHSB5/GAMr7DLLnGhu7fNpsiUN8ryW89SjXy/pt+O0PfFaczTymwFpG8jE1XuXejqtI56seAxBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=k/jjFWPV; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 8DB17C0A0C;
	Fri,  4 Oct 2024 09:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1728027505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n3cksAqz8bxRfKVQU8ul77+AxYu4EE3u3pFx6NdhHM=;
	b=k/jjFWPVCWmN+ZMHn33Yjf5frKNU26dB5M8YQO28bLtF1XAuj8HmECDxCljok1vqSarrHU
	LXtlAWMKxe3Nsk1V/DIK3PP+73u7BSbz8z+bHN93zG41cS4Dg80L+hNmrimGKaCJtsexEQ
	rF1OwpWzXHMaM6JhPFTwZnsfZpWrApDo7RX9jgJHiFHM3m+2PozddaJy1yyh41p6ckQ9do
	wfiHyMJ6PaNszK3pmWsA1RKW6czNhTEyMoWf+Mrm0q1xwPXjkz/D8yCNzMr8PvzNGsKPiU
	ShfzgiJt6dGwkDzrRxuFEoWEqMEFBZuhlJFXWhi/hxJgpynKIk8vjMptEMpEXw==
Message-ID: <c0133261-8931-4e8f-a645-ab38412e3ca4@datenfreihafen.org>
Date: Fri, 4 Oct 2024 09:38:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: Switch back to struct
 platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
 <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello

On 10/3/24 12:01, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net after the previous
> conversion commits apart from the wireless drivers to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>   drivers/net/fjes/fjes_main.c             | 2 +-
>   drivers/net/ieee802154/fakelb.c          | 2 +-
>   drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
>   drivers/net/ipa/ipa_main.c               | 2 +-
>   drivers/net/pcs/pcs-rzn1-miic.c          | 2 +-
>   drivers/net/phy/sfp.c                    | 2 +-
>   drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
>   drivers/net/wan/fsl_qmc_hdlc.c           | 2 +-
>   drivers/net/wan/fsl_ucc_hdlc.c           | 2 +-
>   drivers/net/wan/ixp4xx_hss.c             | 2 +-
>   drivers/net/wwan/qcom_bam_dmux.c         | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)

For ieee802154:

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt

