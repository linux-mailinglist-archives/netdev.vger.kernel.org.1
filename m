Return-Path: <netdev+bounces-39328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175167BEC7E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453E61C20A11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300641225;
	Mon,  9 Oct 2023 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+jT9QNg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF682030B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 21:14:29 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB98C118;
	Mon,  9 Oct 2023 14:14:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692eed30152so3650575b3a.1;
        Mon, 09 Oct 2023 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696886064; x=1697490864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcXX7RVBze6PtaEVGPwxBuREbw4pOeYlpdgmI3+Ezos=;
        b=C+jT9QNgXaA3vr3Kt9HKSzgl/vt/Zq46roaYXA7rr2dAdhb5ls9TQlNHWlDAmdkr+Z
         QGCnyMFfgVUhmjTIlaFGblmugXmIe/MoWICxh7OqYSyKEen8WTjoA6jHMha1CDODpppR
         j+Mw/5oZojgR2rcsfyQEORxlnWtDcjBBTLXNpExGbGlkyPFWR1/Av3cAq2NiLB2xcCZO
         0F1ERwVVvCFoUJHFgfXISqnIPckUiJTGExstjNPdvbVcYfdNZVgidPfdqKGGFGrLna3T
         IFj3X0efowAwcw2LR5VvWamkutKANhFtDrE3VRh0/8ZNzoagXhem8zwGSvzyzxZ1eyoz
         4C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886064; x=1697490864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcXX7RVBze6PtaEVGPwxBuREbw4pOeYlpdgmI3+Ezos=;
        b=Q78R10VETzgf4PwuCpiCYrsk7LjZtXUyYvsQGp/zkrAyysRcUrOC8HUfsePEguVMQ6
         x9cqmoQkADlCWIlFozL4b+MkGLaE2z7Uj7YYlQ+xWQQgV0yGJZ6v3DlDV4nIXKlhQULH
         WWcEo9aSIPKAnbYtyzB3konKtmaC4beCUM/OErtAEZOgiRBF4EF5xSYMnX+3ut/XzK+Y
         lRmeqKtLouw1erJOkMaQUOa0yGEUUregkHVjHfCDA5q7RtMhhdMpwzGDWRlNVs3Hujap
         An6V2SLJpRml3vwGiQBM0M9tSZyXix+JBxmBeaZI6rKi8nv1Ra2KhU34fMuN0N/7R/zf
         0AnA==
X-Gm-Message-State: AOJu0YypeJ5myUE95H8h9XN+V+uF01iGXaAGpWp/3Fjf3r3yxVcWS7lX
	ZoGWABfsdzsObswQY7yU0T4=
X-Google-Smtp-Source: AGHT+IE7FLCoSoMsHQNQ/0WOOgZ6ZheIOjBVYKDJAopjQ13e0Y75eg4ZPgE3eYlX9lADV80hdM3jRQ==
X-Received: by 2002:a05:6a00:2e89:b0:693:3851:bd98 with SMTP id fd9-20020a056a002e8900b006933851bd98mr16553359pfb.2.1696886064624;
        Mon, 09 Oct 2023 14:14:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x2-20020a62fb02000000b006889348ba6esm6826794pfm.127.2023.10.09.14.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:14:23 -0700 (PDT)
Message-ID: <1aac2644-af91-4408-b84a-0c92f1202f7c@gmail.com>
Date: Mon, 9 Oct 2023 14:14:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 07/16] net: phy: micrel: fix ts_info value in
 case of no phc
Content-Language: en-US
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-8-kory.maincent@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-8-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> In case of no phc we should not return SOFTWARE TIMESTAMPING flags as we do
> not know the netdev supports of timestamping.

There seems to be a word missing, maybe:

as we do not know whether the netdev supports timestamping.

> Remove it from the lan8841_ts_info and simply return 0.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> This patch is not tested but it seems consistent to me.

This does look correct to me as well.
-- 
Florian


