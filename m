Return-Path: <netdev+bounces-12845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F473918E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CC21C20E15
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891F1D2A7;
	Wed, 21 Jun 2023 21:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1D1C77C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:32:26 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B91BC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:32:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so5169016276.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383144; x=1689975144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pU1mAMfIYrrV/zE8Re8kOdWl7lW0D3T201ge+UaFck=;
        b=Ik11VblBlSOMYQQNi+QzzjQS/OQZ1aRSLSvA4m1sj3DFlGMS0yTLkhu1iuz8OIl+AM
         JMDceKxLl+nR5gFkoONVzmgYKWMUD9pkbiiU7K6rdUoMOun812SPDUn3KGGSno6CTVXq
         ga4SqOTXVE5SbGDULGvH92xzn4fKzs7Ls5qEVZVQVCMO8eWnpd3Rr5/IPb0nNPU4TRRG
         bHvSgv3F7fKiuUyt5f4yoEpwlb4js6nkFkJDZc9KYFvPG+zkDDSZrzXLdFP62z77vkBz
         mVzntB0W4hgjW2oPkYZcxQv2KZdAYeKQ/4V2nzAMxP9iIu2FDGnALVT/kPOYhsrNCnWy
         7LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383144; x=1689975144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pU1mAMfIYrrV/zE8Re8kOdWl7lW0D3T201ge+UaFck=;
        b=HjLu8ZXvwVGrZ/xtyKPZ1+RxFnjUatuh+FhU6WSCJflYBN0L3IzdGnFbDFP0uzZb/J
         IlJ1riM3Mk36dwu/+/t+KDkZGXTZAuyHpNqw2wnfO8WXkC6ndVBDL55N/wdcX1QkpY1L
         zaNigqQrPBpCncw1lGNp+ZxoU7cm8xSsChFbYTR1yu8UdKJ+jcInbsp4uWcaCVXPFgRL
         KrjCTdmLWqOHeZcwCLrp+eXywBzE7yNXg/hWF/StF0zmm9agnCY1nsCYdH+2sO9QYfmX
         Xd0rI4IvWpHOMSTkj4T9BCgu045klpBLjKM1U/TrQJV4Sc5AGW6cP29neDQTCYNPOZQD
         kw7g==
X-Gm-Message-State: AC+VfDy7uC7MWu+mE/lXVRSz1ALaUzahWJLAHPzB4GKdIGUaFNN2kqBt
	guJo5yk6xsamzCrEvIGe3zjwi//MjQJ5YIR+faPIfw==
X-Google-Smtp-Source: ACHHUZ6G/0prVJxe9tzmmIsm6hY7wbKnUzbja9dYcN3jPGmB15a3wAU5ScWlFR8rpPu3DCRpMq8aYCYow+SD2sKDn3k=
X-Received: by 2002:a25:2102:0:b0:bc8:914b:c83a with SMTP id
 h2-20020a252102000000b00bc8914bc83amr9233735ybh.22.1687383144183; Wed, 21 Jun
 2023 14:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-3-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:32:13 +0200
Message-ID: <CACRpkdbYzXcw6dbt2YpkOOuYiEqGgOM_+K0t+HmwPtHzowOhZA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: dsa: vsc73xx: Add dsa tagging based on 8021q
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 9:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch is simple implementation of 8021q tagging in vsc73xx driver.
> At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> family doesn't provide any tag support for external ethernet ports.
>
> The only way is vlan-based tagging. It require constant hardware vlan
> filtering. VSC73XX family support provider bridging but QinQ only without
> fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
>
> In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> frames.
>
> Tag driver introduce most simple funcionality required for proper taging
> support.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

From my point of view it is the best we can do.
Admittedly I do not understand the implications of using the 802.1
tagging for this, so I leave that to the experts to review.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

