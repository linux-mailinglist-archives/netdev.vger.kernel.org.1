Return-Path: <netdev+bounces-174346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB9A5E594
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F99C3A8F33
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA21EEA32;
	Wed, 12 Mar 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="qlnIjymf"
X-Original-To: netdev@vger.kernel.org
Received: from mx24lb.world4you.com (mx24lb.world4you.com [81.19.149.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F11EB5DD;
	Wed, 12 Mar 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812267; cv=none; b=iJcI6Lza2tSriqoFqHOqWNr+I4dXFBjoYO17ubVAa0PaFNVC7K+TbSVhZLLIot4iOCwz23C6YmE1DyXzjBJnK5pBlYDtGn2c6VBRstHsgmyjp4ThKtNUGrna80oe8uT1OfhLkrHZLN5i2pZ6gQ3vT+/ZUwVszu/NqZOpI+/vdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812267; c=relaxed/simple;
	bh=J1oZje+WV8g185SX0nKzlvP49TcZE1B9YOsqmkkiclE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LotlSHweEfH7QPZkgtvy88ygc2K2fy9IJF2suQqJCKeHaI/TsKbG7j+bzLQUeWP16vg0xI+LUrc9pYs484qS2pfDDvqlJ7Q2q/egZvFO9fNBAIWbtJOoUhBYBOhpJugZoUyWW7C9wRqIT5/cxswnPeSEkQJqgyAPe3X8YwoBv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=qlnIjymf; arc=none smtp.client-ip=81.19.149.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=souxOsPlCBPTeuPyUcbRSBsJixO1AHsrYMzGeA7HE90=; b=qlnIjymfTunOTpYm3/T0wz8pBk
	GGL4d2xCwqZeTWYbF98fatmV1VoGMHfSf3l0EbkZQNos3yxIQo8P2x0StMr5+ZUVclWFqDI74ou7L
	Qy4czKGBRLvIghJ8IzAU9RE92heKtQctwecEcOr0wQJ4+FmVgk77m12yad2HPHmvLPT4=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx24lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tsS8x-000000001oz-0FGl;
	Wed, 12 Mar 2025 20:53:31 +0100
Message-ID: <b753c0e7-e055-4764-b558-68b7258a6b6f@engleder-embedded.com>
Date: Wed, 12 Mar 2025 20:53:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: dp83822: fix transmit amplitude if
 CONFIG_OF_MDIO not defined
To: dimitri.fedrau@liebherr.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250312-dp83822-fix-transceiver-mdio-v1-1-7b69103c5ab0@liebherr.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250312-dp83822-fix-transceiver-mdio-v1-1-7b69103c5ab0@liebherr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.03.25 18:23, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> When CONFIG_OF_MDIO is not defined the index for selecting the transmit
> amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
> is no need to modify the transmit amplitude voltage. Add a flag to make
> sure there is a need to modify it.
> 
> Fixes: 4f3735e82d8a ("net: phy: dp83822: Add support for changing the transmit amplitude voltage")
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>   drivers/net/phy/dp83822.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 3662f3905d5ade8ad933608fcaeabb714a588418..d69000cb0ceff28e8288ba24e0af1c960ea9cc97 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -201,6 +201,7 @@ struct dp83822_private {
>   	bool set_gpio2_clk_out;
>   	u32 gpio2_clk_out;
>   	bool led_pin_enable[DP83822_MAX_LED_PINS];
> +	bool tx_amplitude_100base_tx_modify;
>   	int tx_amplitude_100base_tx_index;
>   };

You could instead init tx_amplitude_100base_tx_index in
dp8382x_probe() to -1.

But functional it should be ok.

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Gerhard

