Return-Path: <netdev+bounces-34809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BAD7A54D3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB91C21211
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653830F86;
	Mon, 18 Sep 2023 20:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C728E0C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:54:18 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10098E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:54:16 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a282340fdfso1493096241.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070456; x=1695675256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMA2Tlorp/5C3XjCYdfhDG00VA/Qyz1kb9MumbAmE3A=;
        b=LcGpOAbNBLnA5Q/MyHWFqvc256KVSf1EBl9S6psNA3IN5egYn2IzzcwrVz9L0N2pYN
         IcyhXASKVx+LtIyHSZN7bKlusaNfT2fbwpD0P23G1I0Lvbt9Sv7MUmWZuUvWE7OXYEf6
         4c1E6EMaXG4PRfVrQH6TzPaNeiVAf7n6jE8HjZNe09xZNfUTKne/57umZr8hnaj8eQHV
         1W3DO5B76irdozGt5X4Ne139Rq65JUI38Xn8rW+DwjP5G/sRZ8WOBGkjBaIWBFWBwmhT
         yh/NSMhKTxc1TwDq9gbdRiZcLyV44ej6qfPvkN6JB8CYCcBN9G+JXsdoyo19cDMXz86t
         POPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070456; x=1695675256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMA2Tlorp/5C3XjCYdfhDG00VA/Qyz1kb9MumbAmE3A=;
        b=t+RCoe7fKfNewI7hllbgQJ6iy31vzDrEUvg0EmeBwpPNm6DbSRFvxvbsyukHTFYtd9
         Cf/X9EzFY3uwUgGuV9bWSyi6sGgWJyEwEBmaTl33pRMr+OTtUdktxsa7QODSSiTnB2Ng
         VqGkEh7J+jfp4QKd/gCTGUNWHrGuyavqGEvQYbuLcYNJoOFMBmenMmRvmqR/JvTziaOp
         mJ4L5y2GKM8XZ97SgHQ1iIkskAS7URBxJOuWZOXPa94tBP49zHKwA7UfmEBSL3k60xzB
         nB5294Ln9na4YJHaXkxWgZVCfdxWnQDCXfdnXzDQPHaplmqVPAhXB3ognlni51xGjR09
         vSOw==
X-Gm-Message-State: AOJu0YxTdRaeUXUECJfFKA4NduFy07gn8mXJOgTdhkju3XhDSz9dj92r
	9wWXp6RzWxmfk2iy57fV4rw=
X-Google-Smtp-Source: AGHT+IFwCCMuWANPIA3rQxXfuBYy6uk0lOQYPIH8fKIEbAwD3RUXcWBYpE+OOckAi1QRP1ORn9fgGA==
X-Received: by 2002:a67:f3cf:0:b0:44e:a18a:2514 with SMTP id j15-20020a67f3cf000000b0044ea18a2514mr8791998vsn.33.1695070455768;
        Mon, 18 Sep 2023 13:54:15 -0700 (PDT)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id a15-20020ac84d8f000000b004108c610d08sm3268875qtw.32.2023.09.18.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:15 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:54:13 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 28/54] net: ethernet: litex: Convert to platform
 remove callback returning void
Message-ID: <ZQi49RlWeYWPPSxG@errol.ini.cmu.edu>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-29-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918204227.1316886-29-u.kleine-koenig@pengutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 10:42:00PM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--G
 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/litex/litex_liteeth.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
> index ffa96059079c..5182fe737c37 100644
> --- a/drivers/net/ethernet/litex/litex_liteeth.c
> +++ b/drivers/net/ethernet/litex/litex_liteeth.c
> @@ -294,13 +294,11 @@ static int liteeth_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int liteeth_remove(struct platform_device *pdev)
> +static void liteeth_remove(struct platform_device *pdev)
>  {
>  	struct net_device *netdev = platform_get_drvdata(pdev);
>  
>  	unregister_netdev(netdev);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id liteeth_of_match[] = {
> @@ -311,7 +309,7 @@ MODULE_DEVICE_TABLE(of, liteeth_of_match);
>  
>  static struct platform_driver liteeth_driver = {
>  	.probe = liteeth_probe,
> -	.remove = liteeth_remove,
> +	.remove_new = liteeth_remove,
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = liteeth_of_match,
> -- 
> 2.40.1
> 

