Return-Path: <netdev+bounces-12842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813E739166
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF211C20D85
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB131C77A;
	Wed, 21 Jun 2023 21:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DF19E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:21:40 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29749198B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:21:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso6084947276.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687382498; x=1689974498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJhQ30NhWl7/OdcQCb1MHwxXooSD4x+4fGnUYsMhMUA=;
        b=Kaoxs46Myw+gTIY7JoDCzA4dtBwXCgc373+VVL+dIq7Oj5waVGo3c03H81SlwqplpZ
         EM8MaYG8b4A10sVSATHlaL1VCYY8s6gx68AiwiSmedCnZEofbFE+CKL+QSMMZsoNUxMe
         lkELCTen+n/oI3zy/91IdoKUGgaNRBzWyAAJo7aT1NfjNd9MDvUTviChBIda6T3PrBbR
         zozKQvGIWnaR3Yt9hqy71fB79o43fdkf84VutOEZL0yYyI/aVdWLENVIN77doiUWfJQ9
         t+r59kXS/Sr8miohDnwe/V219KJWXdfuD0Lf0/tE+Dqep13kOSqVlyhRv/JupT5BldZz
         Rxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382498; x=1689974498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJhQ30NhWl7/OdcQCb1MHwxXooSD4x+4fGnUYsMhMUA=;
        b=hwje/IU1a6Hmaquv9QE5OyAH5WuqGVA4LhGF3VNNx5qm1LL28HPXbGA7UDBYlOzymY
         YCIASWsGJgzYDkKkbx80785HPWEjJaFymZNg4krNVJLtdJ0Kb0hTHxvfoD9INxBG/DM/
         F/NyEIRILbKr4I4af1L7F4t65Im8sTfpSj/Di7ybxvj/LkjPrXiGzR8PMyxf7oF+IQ/T
         yOUmOiL91hn/YDvmd9fvjRMmSF9Ax3I6TapOmQHmi6bnNvLJAjJS3VmgRVJlPtTl5qmq
         6oPZYqy/VsaWsuiveT3GOOLlLYtCsLGYdDx+gFozKoKycB66KNrTSkid4weLD2Mb2E20
         XL+w==
X-Gm-Message-State: AC+VfDxWQxaP0SBakx+1VKOmWzny2QNaR33ozgYct3U9cv5VppfDeAVV
	UC9v2dr/qdhdfbO/QAWA/05pzqhw7nYF0QsQsaLp1w==
X-Google-Smtp-Source: ACHHUZ7u1AWWojXutb/GAoUzEygsCOrr+vVHH4++h1ueHhmP4IsLVnyaJCcNPk+wFTdOdGUCah53b1tymvnSmBRNANE=
X-Received: by 2002:a25:d791:0:b0:bc4:78ac:9216 with SMTP id
 o139-20020a25d791000000b00bc478ac9216mr13482172ybg.61.1687382498350; Wed, 21
 Jun 2023 14:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:21:27 +0200
Message-ID: <CACRpkda4N4U73Q=qqkAh4QmcXjM3KuZK_Mp3DzZPCMATy10PMA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 9:13=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch replaces the adjust_link api with the phylink apis that provid=
e
> equivalent functionality.
>
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
>
> Removes:
> .adjust_link
> Adds:
> .phylink_get_caps
> .phylink_mac_link_down
> .phylink_mac_link_up
> .phylink_mac_link_down
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Thanks for doing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

