Return-Path: <netdev+bounces-35050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAA7A6A84
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B660281945
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AECB347A0;
	Tue, 19 Sep 2023 18:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026A1865F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 18:14:27 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7333D19A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:14:17 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6564fe1967dso479786d6.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695147256; x=1695752056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sWB4hsSQtOfzra24JPzxBuzE95llUqx0szMabmq74k=;
        b=C6+dDVxB5KJFbE7HU+MnNT3hkV6QnqaUr2pBvOtHM98ZTI1SbdjVY937YdqxTXAmZi
         fbEAaqAiOWlWDBoL8vs7s6SD+kl6UleS2uvp3SeSssH67jzzliPaLyyoeuMw4UARXjcu
         H2ybVp45cKI5V11mc4yx56kfQqcH4QxJfPTbgAeWfDf12VEuGbLXD95K8K1947JbMN/y
         Nj0DqhbXyuux3petQVHcRpURoOlxXMRF217s8BuFKG+41mLL+/yE+7+bnk0eGgDATEHf
         QirZTjBWl96lLbOffdHFmlPlzzYEH42Pwzahv+E5yjOivIeR2heUO6XLDbFO56wLVLXn
         Z1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147256; x=1695752056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sWB4hsSQtOfzra24JPzxBuzE95llUqx0szMabmq74k=;
        b=e55StxOuVIDegYMNlV8h0+fNaDi9bmXB57Vi7u3OBbd/urexeBEoL9NHo5GZcITnsC
         tQ11yM9l2sa1adRIx0nc9Ws0PY+dmqDg7HI70/BkiAZgg2TUdp1IhqcThUjga57QU80y
         gDYyNvzpVE17qYl38z3LnaQ6/RbbMJjqQc2MXN1+FqEjWNVMmuNb+NvxuPoscbsoNOmN
         AsOUKuziGA6EqtXUZFH/qngal6nsQg+bFWS9wy+jJkLf79kfDFcHHwYyCgkqlXnzh4rD
         5dunQX2J3fnNqeQczY+gCCHLc1kwalwaEFTF2Z6SYDZj4ujLWnIEzsW4eevVcvnyqNbi
         T83w==
X-Gm-Message-State: AOJu0Yz2zKZFdBvBuePp5MlK4diH0tepkwJs5CByzohk4cwcBU3lsWq/
	TG9EeJBn6os5oCDc7joAbyy2gSXYI7EqPlQm2QI=
X-Google-Smtp-Source: AGHT+IH/b23I5RIvEtuQMrVRhrM4t7CQdNtyNR//Jh8TZoJqUs/ngUBQAfUJi168TLj1uEiuCUos2CSj6ykOByxI+MA=
X-Received: by 2002:a05:6214:5002:b0:658:24f0:6d91 with SMTP id
 jo2-20020a056214500200b0065824f06d91mr4331519qvb.30.1695147256552; Tue, 19
 Sep 2023 11:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com> <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
In-Reply-To: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
From: Alfred Lee <l00g33k@gmail.com>
Date: Tue, 19 Sep 2023 11:14:05 -0700
Message-ID: <CANZWyGKqdejR1pdw1bcVXwRegJ3AtGEXao6SzQzc5Ggq8mWWSQ@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 2:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Alfred: How do you have the reset GPIO configured in your DT?
> GPIO_ACTIVE_LOW?
>
>     Andrew

Hello Andrew,

It is indeed set to GPIO_ACTIVE_LOW:

    switch0: switch0@0 {
        compatible =3D "marvell,mv88e6190";
        pinctrl-0 =3D <&pinctrl_sw_reset>;
        pinctrl-names =3D "default";
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        reg =3D <0>;
        eeprom-length =3D <512>;
        reset-gpios =3D <&gpio3 11 GPIO_ACTIVE_LOW>

