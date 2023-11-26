Return-Path: <netdev+bounces-51148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB317F9541
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F48B20A5B
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5012E6E;
	Sun, 26 Nov 2023 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jbk6UNHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39C102
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:17:20 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cccd2d4c4dso32901617b3.3
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701029840; x=1701634640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGQxMQ+7TPzoJGNme16X7jOyAmsWmKBeIpeI/o460JY=;
        b=Jbk6UNHtgzHaulz5zHeqtXbdbLFh0LGyvo3x85bWBXizAERXSbGPUi96KpHepJpLfR
         dv4iPcjvcWPmdE/87HloCuBf2W2uc7EkLB12PNgO2J3B0spoQ3koUCMKKWqIvj5ZNOBb
         14dpk8Nn2fg14QhMVyU3l+dXm3wGo5zqlZj96tcYa1zmlVz6qGXrzsKM2dBM6o4NrCtU
         KJXLszDKAZY7uGtexeH/BQQ2s7dWqsU3EaoBlG6SSUrFQlec716hyXs2rlOaDbvUMvYl
         nl8sL/vqMQQ+sz1XuV9noEE7FruytItH+MulfertHRViU0D30KWwwSLOIT4imC7qyWkQ
         jBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029840; x=1701634640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGQxMQ+7TPzoJGNme16X7jOyAmsWmKBeIpeI/o460JY=;
        b=D6Y66ABj9bEqzX24HvNzPupon4mJSp5igBJY387Z7EpeFn3dVB+hd3G5gZX3Z3BFH1
         POM1nheE8uwjpKpmUi+UBucUUMDQPOvIu1q05LO2Po/wl9GHObK8zETGeug5W4V+3tpn
         RJhO1Y7ub1X1+8CEIGAGi3w+P+QgACvM27Iwtm0DgMD7s4Adv9hczWz2ESa2UepXyG4f
         mhyUl2+I5q+5WUQfxz7fUdUDhE72hv+BCigi2Atidz/YFWm4bI6hvqz6y5Gxs9ttqqqA
         3rizFQ1JFbYIQbjUypPACZbVCtcyF/s4GcsLTn45wdM8pFblXcObx6gsRbL6e8+9Zd4j
         NUKw==
X-Gm-Message-State: AOJu0Yz3m4PfIxCfejXlYFJ2pbkkzunM33oUNlfKNRApr6Uy9L1Squ8z
	dXxbt387UWho78QdW5MwiPG0ZKbUurN0maLcouJmwA==
X-Google-Smtp-Source: AGHT+IHWzWgY6G+ZpHJvXD08LVNLOaSle54xXRVOSyGrJ8hGvRW+fV/RwdUxWsfmEXDi6UpYj0b1xGi7vi7sbiQg7wY=
X-Received: by 2002:a05:690c:c09:b0:5ce:7ac9:d10c with SMTP id
 cl9-20020a05690c0c0900b005ce7ac9d10cmr8206213ywb.32.1701029840087; Sun, 26
 Nov 2023 12:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch> <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
In-Reply-To: <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 26 Nov 2023 21:17:08 +0100
Message-ID: <CACRpkdZvMRXHKktM-HPZZRCrV0JgErqDOHmkyKAcB36ObwOX7A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
To: Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:50=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Tue, Nov 14, 2023 at 10:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
>
> > So i have one open question. How do we merge this?
> >
> > Can we just take it all through the DT tree?
>
> If we don't expect the affected DTS files to have orthogonal
> modifications we certainly could, if the respective subarch
> mainatiners are OK with it and can ACK that approach.
>
> For Marvell that's you I guess :)
>
> For NXP VF that's Shawn Guo, Shawn are you OK with
> these changes going through the net tree?

Shawn is busy I guess, but looking at the activity in arch/arm/boot/dts/nxp
iIt seems pretty risk-free to apply.

An alternative is to simply apply all but patch 4/9 (the NXP patch), becaus=
e
the rest is Andrew territory.

Yours,
Linus Walleij

