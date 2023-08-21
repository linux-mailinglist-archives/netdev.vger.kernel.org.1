Return-Path: <netdev+bounces-29301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D4D7829CC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BCB1C208D0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613363D1;
	Mon, 21 Aug 2023 13:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1663AF
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:01:15 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2FCD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:01:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcf2de59cso428922166b.0
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692622872; x=1693227672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghOBdh2dgvCV5pm0gzE9b1aE/p6n0Xoq3JuBs8Whqfw=;
        b=YQ5EpqVwzuv4icY6g8L0ZHcvYmHrwxeQwSc2Efoc8pYDKPjRdB3GA5ziMisDaJIozH
         u/I5S5/He+FL+n0Smwtwqp3wwkbEA7gk8Zf/FvrV5fQrGLgH70QNvA8yEsFRTk1EbDWT
         u4RTh9puipar8dhaUOe3BYUUhcoitBNPiUetaQtyKB1zHQ9Pgq+KRyqMHHAKu2KJiwEh
         Uf3tTsjm4OmG9R/iUXa2JVBmnu80IRtpXjWnpLhwK6e9Amw2JGLCqQvpJ0KqphKypoDm
         3gwLf39CsddV+tUDHxlL9JHEN0/ZvUGnUcsdlRbLlSj50tRb5lulTQqM/HrgLGkOGtP8
         51Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622872; x=1693227672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghOBdh2dgvCV5pm0gzE9b1aE/p6n0Xoq3JuBs8Whqfw=;
        b=k0iTizQDRriApKf9Ph3jP5TVG64beTe1t4Mo3Y0ulubbeV3Tb75W111fPOhKiYPOsT
         UrfQ85XAfy+7aJKOD26Yflj3hWN/po6HZvBCbd1X67BuZSnsi8uNVh/K9gqn2gA5yHGk
         Vc5K7/Vc4kxsSO4HPHOoxM5RXxkuHG+Ivf+2sLe1/6cyArExgVLBS2JAo1RCw6TPX8S7
         C7nZVf7NlDxMiEJ/e+6timvb2dNlpGmbru4Jr1PDdSsLd8B6dnEEKZHB83NIVMtUFnpv
         AhkMiujIip+ywrjqNDBfzEtStK1W6zl01SEGOglD46htqx8WyHAZt3NK93l2ecE/vt41
         FVCQ==
X-Gm-Message-State: AOJu0YyQkdjIiBgiI4j2BDjUpPFlYWj6J7gTF+ImBu9MVT1P0r/p6zcV
	msvE9MrpmemXQSpUCmfDvgE=
X-Google-Smtp-Source: AGHT+IFG5GsR9YYOr8QfSHFVEWcHxiYm02CdevYi2o3U353EO0PCRn0sAIpFR8gaWE1YKwYtZnpBRQ==
X-Received: by 2002:a17:907:a045:b0:99c:bcbc:bd86 with SMTP id gz5-20020a170907a04500b0099cbcbcbd86mr5150950ejc.16.1692622872461;
        Mon, 21 Aug 2023 06:01:12 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id jw15-20020a17090776af00b0099d9bc9bfd9sm6437447ejc.48.2023.08.21.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:01:12 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:01:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, linux@rempel-privat.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Remove unused declarations
Message-ID: <20230821130109.dxx6nijkhekzv2to@skbuf>
References: <20230821125501.19624-1-yuehaibing@huawei.com>
 <20230821125501.19624-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821125501.19624-1-yuehaibing@huawei.com>
 <20230821125501.19624-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 08:55:01PM +0800, Yue Haibing wrote:
> Commit 91a98917a883 ("net: dsa: microchip: move switch chip_id detection to ksz_common")
> removed ksz8_switch_detect() but not its declaration.
> Commit 6ec23aaaac43 ("net: dsa: microchip: move ksz_dev_ops to ksz_common.c")
> declared but never implemented other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

