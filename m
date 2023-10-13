Return-Path: <netdev+bounces-40802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB97C8A2D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB82831C9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF2A1C6AA;
	Fri, 13 Oct 2023 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTXsAu2H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AB20B1C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:13:43 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A46658C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:13:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c894e4573bso17579375ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697213580; x=1697818380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQ7u6ck/B5OG+GhmR+IrCX8L1hM7CCc79Xh822RuJ+Q=;
        b=KTXsAu2HdVTGuQfhOsH/Lxvdt6prAAkJ5AmyUBAPQ6iQYvB2ELsPbGrxJ0C9mqULqT
         UkHLJhsN/AYeuwPfcUyqHLDXZ45AGX0e0oCWm9Y1k03ON9Ag/v80W24qbYl03Gibsz4n
         54yFQrQfxhTITNgU2XMOgSFlOs3JPNgMTZvEoTzjbm6iEdgPk1CoGUDP9rxUaLxKCNqk
         Hls+6FgX2p/TnDllCeoEBzrIGU6MEWXz99s/0znqRHuhrWM6QHCyYb/fGjB+JORZ20qI
         46yF9RkTtjrByChdNVuCxgCSg0ZTXyLyI4bu0KfhmUUKgH5xhQMiZMkxktOrtps8sPAl
         tkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213580; x=1697818380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ7u6ck/B5OG+GhmR+IrCX8L1hM7CCc79Xh822RuJ+Q=;
        b=Li9pVOKTnjkZWIF5GE/9GqY3xI5FHazHFeV5aGyFXCfYrz7cxqqZwkfOBB5npQfLo4
         C/yR2iwbpeLPsTT0W/LHj4xseuoJr1qspEOX5AdhCfUm3g6fJ2fmFASaSPkC9lE1ySdg
         vYTh11yll/vJHAe3zzFt0VsTSC0Z0+0gcXgYd5iAUCDAMwCI4xbtHeLIc9V9PaiVltHp
         SWNCNcjH8gdtddZ4OQXArHfvJFhXkLRNwKVfJ21zo1t1TgXwSoGNSEYsJr29JyBHbik4
         ZbCA/nBWYEf4wWEKoMHaJaIjjpedPK1GonR1GkZGXTfvDR/l/CTLPwOeEjRd29M6+jur
         SNrQ==
X-Gm-Message-State: AOJu0YzeLCHRPKZGsmjcSrRNeUlzBZv/BgLXXFow0ktvkSxu7aGpHtJk
	a/eqpOBSCAXZwpE4RizpG9Q=
X-Google-Smtp-Source: AGHT+IHDGNXtcQiY/VB6wPGIC5viZz965EYNKqGHkNSCPKa8p0S8vxupKZK2zh7eUYnAEoOHIfDwiQ==
X-Received: by 2002:a17:903:32cf:b0:1c5:8401:356c with SMTP id i15-20020a17090332cf00b001c58401356cmr30868486plr.62.1697213579575;
        Fri, 13 Oct 2023 09:12:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u9-20020a170902a60900b001c06dcd453csm4053097plq.236.2023.10.13.09.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:12:58 -0700 (PDT)
Message-ID: <cf91334b-0f9c-465c-959b-0cb874a48b3a@gmail.com>
Date: Fri, 13 Oct 2023 09:12:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: dsa: bcm_sf2: Fix possible memory leak in
 bcm_sf2_mdio_register()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, netdev@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
References: <20231011032419.2423290-1-ruanjinjie@huawei.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231011032419.2423290-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 20:24, Jinjie Ruan wrote:
> In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
> to increment reference count for priv->master_mii_bus->dev if
> of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
> fails, it will call get_device() twice without decrement reference count
> for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
> fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
> reference count has not decremented to zero, the dev related resource will
> not be freed.
> 
> So remove the get_device() in bcm_sf2_mdio_register(), and call
> put_device() if mdiobus_alloc() or mdiobus_register() fails and in
> bcm_sf2_mdio_unregister() to solve the issue.
> 
> And as Simon suggested, unwind from errors for bcm_sf2_mdio_register() and
> just return 0 if it succeeds to make it cleaner.
> 
> Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


