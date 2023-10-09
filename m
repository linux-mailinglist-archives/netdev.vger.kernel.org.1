Return-Path: <netdev+bounces-39081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D87BDD14
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0A928159C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55818AEB;
	Mon,  9 Oct 2023 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iska8TBN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D352EEA7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:04:54 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C894
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 06:04:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8673a90f56so4690170276.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696856690; x=1697461490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzSkhCT5cUhzCbtHrPausVyIGfFV8ZS7ofCWJFepWZc=;
        b=Iska8TBNQrk6C8VuUjfBJXjRc6DXKst10vPYI5ChjOWvYvCmhqkZ8Ou05XspY7LdWi
         9GY40DEHkJSdOnrblvvNyNX6jPyg5LIFmnL1hKs38zeI/29YSguFhkjsnpLKbbLKDLz3
         nhHU7tjrJEzOuOrYfG0L1lRQ3e3ZglpLamqStI8bM6HyGKhl1A9U7PO2iUMTnnlfkoDP
         cu2MBHtGHhGgrgQLm5RGvMW8GFwhPAxxVoQxlTF1HwAvDW+T6+2l4ZviG2FQGG8/8BjJ
         Bce8zzO7i7P7YhlWvFa7gxw2ZnXeDCpJw+yVgrYlllqkoBXT1KDiBxYis5I+41c/mVcG
         FUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856690; x=1697461490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzSkhCT5cUhzCbtHrPausVyIGfFV8ZS7ofCWJFepWZc=;
        b=HttOF6/odkyV0QEEkFlcDHcVS/+6k9mP37cDRvMSuZf9c7PybpyrmSQFVZx6k3DGF9
         P5daFOExrLCDunWhWVOFFadjqqK4boBCfMu5c+ebP3lMBUWtEDTPRFUYd3PPwQHqrh4K
         +TQqiyZkzNYLRD0KfbKQiFR+bAzlfqr+X9thiP3oxhTeBXYBJk+ijjHSOrCJnHkAwqyW
         M1vxSy+uDl7Bfqgil6d/8lLIasQbkdHUQHPq0FU5yWaEZ1eWDh6SFVbZZQO1jxzgDKM2
         AdEbArk83QXUFOUrRzTm52k6N/VVxbWzBDVWL1jyBIDvWolahislqXy2wWtIj8r8PuH0
         Dkiw==
X-Gm-Message-State: AOJu0YwhCDrKkaMppU7VxfX7yKWqEerHPhYUnqeehxFZ3iQGcAhRdBpS
	phTcA8CDtIe1nhRKPsrsel7WY2lxXGIkKIVOVs/Frg==
X-Google-Smtp-Source: AGHT+IGqGaI2d6r4zW1ZmPwfbHWCbv8rAR8Y2dd6n+i55KkZjANEncx+lHQ0MHbDhslaFn4zCKOHJh5792UMM0Cgj2I=
X-Received: by 2002:a25:da8a:0:b0:d81:97c:c01e with SMTP id
 n132-20020a25da8a000000b00d81097cc01emr14161594ybf.5.1696856689575; Mon, 09
 Oct 2023 06:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk> <E1qpnft-009Ncg-3o@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qpnft-009Ncg-3o@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Oct 2023 15:04:38 +0200
Message-ID: <CACRpkdbH-7zTdTMu2M1MesDJB7KMs1nzJqNYJWFcLuMrXoqsuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: vsc73xx: add phylink capabilities
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 12:39=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> There are two different classes of switch - 5+1 and 8 port. The 5+1
> port switches uses port indicies 0-4 for the user interfaces and 6 for
> the CPU port. The 8 port is confusing - some comments in the driver
> imply that port index 7 is used, but the driver actually still uses 6,
> so that is what we go with. Also, there appear to be no DTs in the
> kernel tree that are using the 8 port variety.

This has never been tested, I think the 8 port variant is mostly
used in stand-alone configurations without a CPU, the first user
of a Linux setup will have to deal with it if the need arise.

The patch looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

