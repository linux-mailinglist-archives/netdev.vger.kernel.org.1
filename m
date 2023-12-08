Return-Path: <netdev+bounces-55185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34D809B96
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549C31F21097
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B153AB;
	Fri,  8 Dec 2023 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wegch4Ye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1BC6
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:13:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf1e32571so1802372e87.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 21:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702012416; x=1702617216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFZQ1l4Cn10gr5ZGDLbwYHmz8s4OZLO9jiUn9dIl2oE=;
        b=Wegch4YefZrqxnfuv9iRthSt6FJq58KuDT5lhkQBkcdaGOLmyTC1Ak2KB29P4uhXvQ
         8QqNuGHBcRkk/n6b0AxrxL0FT+q8Yi/BL3HHFUCUUL5mOlnwGNt2H3gH8/cgUrRbTupb
         o8Ek14alVFT6uNbyWv/EHRQXMuz22rUHwnFh0l4RCGAL2xYyPsAcYHg4sU9cjw1CSYzO
         s3aRrU9+HafX0rlGo3g2YJ7SIDTpzxbsLl0r78WXfpTe8hjFzjFe7XnSvGw7Pj40xRPK
         pzD2vwRLMQgOhlqnadAhi4IG9YvZDnJGoLP4442iaW0QbOKjz2Zpz50brlaipZPAMIhN
         5i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012416; x=1702617216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFZQ1l4Cn10gr5ZGDLbwYHmz8s4OZLO9jiUn9dIl2oE=;
        b=Y3e6RDTMzIS2/H8ezFbAbVCGllEdFRp5za9ZApj0uiCvyrkiGZopYREx1lgZvJC3gu
         h+XRRPxe31O7M+Zf8crw6jGTEPemymy4yyioMYTD2Mjdhl4cdrgjaXb0n+uhlwPufsc9
         UJPTjl3YiTFksNAgrRVxDngGCvfg7WTY/F0BxhjnhMcZ2IppsCuhh+4VFQIT5ICBnGI9
         d2UEMXxIei9Hw2OKZckzgNXmcsopc+ZjWeHsTWgCBCHNyq47nKBZ2KWHsaKliELthdIv
         jjpEqAIXPHAMgPTLt7i0DU6/rV1H6RDmkE2XQp5vhyhX/nLO2bhZSgk3NUNyAbXvb6Nn
         +YRQ==
X-Gm-Message-State: AOJu0YxU56sYKa4OH51BE7DW5xAolzc0BhlfvXQm5oK8dOCQHDZw9303
	U+AQ41i2ps29i0OrwRRfHYoQkgDrpUmcoGcKwWgDSHzEUnesGDQQ
X-Google-Smtp-Source: AGHT+IFVX/X+U8Y7G1kHRoo4XVREVggLh4fybuFiwiQGYeIfWRhRbBaFAG6l2CECAoBg3VTw4xwDmqrGll9UCRHtvkM=
X-Received: by 2002:a05:6512:1155:b0:50b:fd4a:f788 with SMTP id
 m21-20020a056512115500b0050bfd4af788mr2395924lfg.33.1702012416068; Thu, 07
 Dec 2023 21:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-3-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-3-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 8 Dec 2023 02:13:25 -0300
Message-ID: <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 755546ed8db6..ddcae546afbc 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -389,15 +389,15 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>         priv->user_mii_bus->write = realtek_smi_mdio_write;
>         snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
>                  ds->index);
> -       priv->user_mii_bus->dev.of_node = mdio_np;
>         priv->user_mii_bus->parent = priv->dev;
>         ds->user_mii_bus = priv->user_mii_bus;
>
>         ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> +       of_node_put(mdio_np);

I would like some advice on this line. I have seen similar code like
this but I'm not sure if a function that receives that node as an
argument should be responsible to call kobject_get() (or alike) if it
keeps a reference for that node. The of_mdiobus_register does not keep
that node but it does get some child nodes. I don't know if it is ok
to free the parent node (if that ever happens when a child is still in
use).

Regards,

Luiz

