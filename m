Return-Path: <netdev+bounces-64676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C637836499
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 14:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAE51C23217
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CE3CF74;
	Mon, 22 Jan 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZCVDr5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B23D0A0
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930980; cv=none; b=in6uKZZsIVJyQzPXIR3tT/fnJbVEza+VGatzFO20DcbflaRXSoK76Hi07/YaaXEZXf71yhN7Yy/1SbEQpMv7klO9toWN7uJBJFQkuF2AT1zBnGHiZct4FiVHSTMz28kMsUSS/siQL2RZmkG9TO5PcGp87aNmzzYaGlmPa5PBmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930980; c=relaxed/simple;
	bh=xp//B9T0uPV7jqaYVfPpGhyh5ljfDFGCrodMuwI/Mp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4Tsb5Qk5yDkH3/EMZaIV/mulz3k9pvcg6P0fNxel5BUwUyzlMcPBdER6Hi7F/OuqeonsoqFYlCz45VyAr0yVsmPy6A7qGAQm/msihwg/ZHqhjxcsRQV/MTA/oMOl9QD4g/DXeVB7qCp/nA5rRFPutdIOtfoDxyJuaLdhmWRphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZCVDr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B43C433F1;
	Mon, 22 Jan 2024 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705930979;
	bh=xp//B9T0uPV7jqaYVfPpGhyh5ljfDFGCrodMuwI/Mp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=btZCVDr5Jf3In3I2Ln7unfVxSYKXwCpYCukrzS7mrXDcJ8fBWDw4Swc4Voi5133D/
	 Q838W1jk7OVSs9ulCZWRrW62xA/u3qTSpgxqTn5kHjPCNghtuL7xjMlHUS+pNn7hAb
	 S1ACz+/HJnvbosSouljvWIYXvdLFWyn75Bjv2271EimZH+SGk43hOBe5+AyO4NXZwF
	 FkYlr1b8PoqfQx84wfq1rYfCPHAqXeOHnDOV7+dC3Mygsa6iXJ906o/vyjkOQNVZlE
	 cXSdQJOV2t8QUxCirsDlW3F9lMOFHAslc5Oyp7QGmvPOcA9Alib/YQy9xpIkbe5J8l
	 beB0U5gGFi+vg==
Message-ID: <81aa3232-b706-4931-87a2-13dfed82e9c7@kernel.org>
Date: Mon, 22 Jan 2024 15:42:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] net: ti: icssg-ethtool: Adjust channel count for
 SR1.0
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, grygorii.strashko@ti.com, andrew@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
 <20240117161602.153233-7-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240117161602.153233-7-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/01/2024 18:15, Diogo Ivo wrote:
> SR1.0 uses the highest priority channel to transmit control
> messages to the firmware. Take this into account when computing
> channels.
> 
> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index a27ec1dcc8d5..29e67526fa22 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -141,6 +141,9 @@ static int emac_set_channels(struct net_device *ndev,
>  		return -EBUSY;
>  
>  	emac->tx_ch_num = ch->tx_count;
> +	/* highest channel number for management messaging on SR1 */
> +	if (emac->is_sr1)
> +		emac->tx_ch_num++;

I don't recollect now but is management channel always pinned to the highest priority
channel?

Wouldn't it be better if we don't mix up management channel details here
in emac_get/set_channels(). So this patch is not required and we only need
to set ch->max_tx to PRUETH_MAX_TX_QUEUES-1 for sr1?

>  
>  	return 0;
>  }
> @@ -151,9 +154,12 @@ static void emac_get_channels(struct net_device *ndev,
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  
>  	ch->max_rx = 1;
> -	ch->max_tx = PRUETH_MAX_TX_QUEUES;

Leave the above intact and add
	if (emac->is_sr1)
		ch->max_tx--;

> +	/* SR1 use high priority channel for management messages */
> +	ch->max_tx = emac->is_sr1 ? PRUETH_MAX_TX_QUEUES - 1 :
> +				    PRUETH_MAX_TX_QUEUES;
>  	ch->rx_count = 1;
> -	ch->tx_count = emac->tx_ch_num;
> +	ch->tx_count = emac->is_sr1 ? emac->tx_ch_num - 1 :
> +				      emac->tx_ch_num;
>  }
>  
>  static const struct ethtool_rmon_hist_range emac_rmon_ranges[] = {

-- 
cheers,
-roger

