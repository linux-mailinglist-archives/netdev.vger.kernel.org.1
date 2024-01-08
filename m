Return-Path: <netdev+bounces-62420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C658270C3
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345D81F228F0
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718345979;
	Mon,  8 Jan 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvrji40y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859D45BF6
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so2246902a12.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704723066; x=1705327866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrYxUvmW4W3BDqDmJn9mLefAdpbYBWmuv5IGTaCi9Fc=;
        b=Wvrji40yR5/Qpu3I9TPybrDxKol7Nj8REKm1DoyKvPkMYAqNXtL6FHpQ699Kuo6LDC
         4yWYUC0Zhb2UFqM5eXDstmHW/Z+2FnkpnWw2qINmixSKZg+TIFxfdONWh5Z7UkJkrmrG
         3IAAIeYsSMEbs9iMBDYScwMNdAIsiCythpE0QdshryXDq2F0E2qpEBQEjchkad+1kFPL
         KT/F7qMV40jyIqt+Tp8yo3lgORFaJseG385uf3fQOOKw0lkV8JqCmbItphI6PRsPErJr
         7d531mqk8yrzXXkHbtqLS2X/I9io0cgfGA2wCrYqLsN8aAMmYQOZJLZsx+hPugZIEYsJ
         dm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723066; x=1705327866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrYxUvmW4W3BDqDmJn9mLefAdpbYBWmuv5IGTaCi9Fc=;
        b=K4HfhguCkcldTN2fdY3C/ZOt1p5Tq+pnNbRlr/G+Tl9I4KBIBR3vkB1oXfoOCRgRi2
         9QUub3qGs/oneTzaKFYyIjrzrDlKy9QvDqs7JH8g3tyoE0UVQXI9viC7qxzjnzEevBTo
         2pFxzwVk3QL5TFmAaE07tGW6rCOHERGm91qexW8muikd0OgzZAjcB6J4hJoCdl5YRnDe
         A4VmKNptu2R/r/zpFS/oIexoJYh182IffL7CbEEqh+PGHbxnbsZIMBYXT412A5+utgBk
         Yh/U973ekf7dsPTN3boiGhSGKqE/vG/MYI3ZeWupx4J7Jr+Bi15SIpvoVrPMlHGZnUlw
         gw7A==
X-Gm-Message-State: AOJu0YytweuwDMSMd4Bf4QV4hu2ILr5vM2dCOrtbGxCJLr5ulAIFPWaV
	w9FZPyKwVIFMf7UG3W0rTac=
X-Google-Smtp-Source: AGHT+IFgmEnuO8mb7SAKTsDEAlWu3vh5nVms6IwD+syD0e638Yn2bgkgIf+iEJxbMRJXsyFL1ZK38g==
X-Received: by 2002:a05:6402:1855:b0:557:e341:3fb5 with SMTP id v21-20020a056402185500b00557e3413fb5mr170634edy.44.1704723065967;
        Mon, 08 Jan 2024 06:11:05 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402235400b0054d360bdfd6sm4285473eda.73.2024.01.08.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:11:05 -0800 (PST)
Date: Mon, 8 Jan 2024 16:11:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 4/8] net: dsa: realtek: merge common and
 interface modules into realtek-dsa
Message-ID: <20240108141103.cxjh44upubhpi34o@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-5-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-5-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:32PM -0300, Luiz Angelo Daros de Luca wrote:
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index f4f9c6340d5f..cea0e761d20f 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
> -realtek-dsa-objs			:= realtek-common.o
> -obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
> -obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
> +realtek-dsa-objs-y			:= realtek-common.o
> +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
> +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
> +realtek-dsa-objs			:= $(realtek-dsa-objs-y)
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
>  rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o

Does "realtek-dsa-objs-y" have any particular meaning in the Kbuild
system, or is it just a random variable name?

Am I the only one for whom this is clearer in intent?

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index cea0e761d20f..418f8bff77b8 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,9 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
-realtek-dsa-objs-y			:= realtek-common.o
-realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
-realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
-realtek-dsa-objs			:= $(realtek-dsa-objs-y)
+realtek-dsa-objs			:= realtek-common.o
+
+ifdef CONFIG_NET_DSA_REALTEK_MDIO
+realtek-dsa-objs += realtek-mdio.o
+endif
+
+ifdef CONFIG_NET_DSA_REALTEK_SMI
+realtek-dsa-objs += realtek-smi.o
+endif
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o

