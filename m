Return-Path: <netdev+bounces-55716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7080C0B5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A654A1C2034C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546B1CAB3;
	Mon, 11 Dec 2023 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMKjYPdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C87D7
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:30:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2cc259392a6so2205091fa.2
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702272605; x=1702877405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4/FPo7bFAl7zW6MvazkOgXX7gr0ydAXk1MyofPK4xg=;
        b=aMKjYPdNOoita1s66Uyx9AqOQcI0K8iGqduJPF+9st/1lsn6bU5ueIRWU6TqfWxIHA
         e+v9EHt0663tY+LQmWqFIxF/cGH/ZVnpBReEbKH7jBkFCkkYsqkSkpQZFLoIbT1Q/7BD
         eGFGgb8D6O+ZHC0D6LAs25qhT3ffI/Ej5hAI4XOFCuLfZXPqo4BnB+5lTHu2tsfJhW1g
         G8zbV4WAQ/+Otv8oMKeFN18kY6EWb4oBZRgZOQn4dhsa1acXgb8OYPBJ8ueM7vLk39Xx
         AkP4jDODBKy2/ZlUIgqSvK2+a2GuG80azYfNbLMKW92trX2cHwwHyO+WQjWkJGwkPHnc
         vXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702272605; x=1702877405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4/FPo7bFAl7zW6MvazkOgXX7gr0ydAXk1MyofPK4xg=;
        b=EW3gMU0J7LF98IYwYoVfVtM/Nlu0MLCTXG2hELU5u9fZZSknjHuKjXKQwMMFQe5s77
         SR4aFMR5SCEf/DCtkNst5oqjI+SbO7hGMz7EFpV0zl0iredE0EAfgjo+57fqMHCoxQf0
         vIVOM1086tJP7tVsvlkE7f77tTY+yj/QJVtD0x2h4+fsdBiQObZC/v7zVV+sPcuNvrwK
         nJBpY6fnGyGW4fBmjuZvMWbeWt8WXq6a4KffKIutVNMpnxB9ReEmgdADiM+NzUqsGo5A
         1Ehjuff4ImdfAje/tswEI+qJn/+XWe0BzJkp5cRtLCZJv2/pCML9GaqBwqD1BdyadRli
         mgYw==
X-Gm-Message-State: AOJu0Yz/+cuuOyfjOCEmOoxl1XnDmDbW3JmextC9LAMwQdpOtojYHsSF
	ErDH3HrfZMDN879cM2HMVfkLBdm78YYpi4AA2gc=
X-Google-Smtp-Source: AGHT+IGOWM5ZIJxfPjI9ij7KTOzNN2BdomoRL0vZKbOLSCh1uwNM7N3+CjqgJnmO6aDEKdVj2Bl8bXN1hKOiXQ4ybJo=
X-Received: by 2002:a19:8c4d:0:b0:50b:f4ff:4c06 with SMTP id
 i13-20020a198c4d000000b0050bf4ff4c06mr1430778lfj.110.1702272604668; Sun, 10
 Dec 2023 21:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-8-luizluca@gmail.com>
 <5hln5qd5p6mbg2hpmptkhlrjymgwzf3ioufwqbzmtrrfhkgecb@ew57gxpcjgwr>
In-Reply-To: <5hln5qd5p6mbg2hpmptkhlrjymgwzf3ioufwqbzmtrrfhkgecb@ew57gxpcjgwr>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 02:29:53 -0300
Message-ID: <CAJq09z61TV9skiEEMuLUSZhYs+OPZnBVZZ68zxSZ9VavuRmMTg@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] net: dsa: realtek: always use the realtek
 user mdio driver
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Fri, Dec 08, 2023 at 01:41:43AM -0300, Luiz Angelo Daros de Luca wrote:
> > Although the DSA switch will register a generic mdio driver when
> > ds_ops.phy_{read,write} exists ("dsa user smi"), it was pointed out that
> > it was not a core feature to depend on [1]. That way, the realtek user
> > mdio driver will be used by both interfaces.
> >
> > [1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/
> >
> > The ds_ops field in realtek_priv was also dropped as now we can directly
> > reference the variant->ds_ops.
>
> Ah OK, this makes more sense. Can you fold this into the previous patch?
> Then it might look more reasonable.

Yes, that makes sense. I almost did that before submitting but I
thought splitting it into two parts might make the review easier. I
guess I was wrong.

Regards,

Luiz

