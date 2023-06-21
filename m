Return-Path: <netdev+bounces-12847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F847739197
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BA31C20F88
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91331D2AA;
	Wed, 21 Jun 2023 21:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB619E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:34:41 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527969B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:34:40 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-784205f0058so2059878241.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383279; x=1689975279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERhjKrk8uNuT8fJftN6Wzv13k5nYu7dMLPTKhrBK3z4=;
        b=aYGnvnNXHBjMNbmulhIQhX8SaBIFKZ7yqzr1tKO4nLxmy8HFg6SE992IK7obG5rzCX
         jCUPt3cDMPKNPy5VyNefi/qW8u6xg8+lwSNyuf4nD6xlaeNRYlVPiiI/RtQFnIoHu5E1
         XzubqUR3Dl/e3+ExdXUqdvmi++G3kxt9ABtmRHD6WSP7WSuCtnGSwmBCW/HLnLqQDmPu
         P6UEpiMLCtflVbUnB7RSeZMSB2skbjC+L7XwusnWiBOxWUZCFJrrOzd2A8ciwEi0EyeN
         pm1DS4rka5jemYVxM8jUxmFZwMdUMJ5XI5goq5HOt8i67BUbRf4IDhhdvwFxIg7KRzma
         XPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383279; x=1689975279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERhjKrk8uNuT8fJftN6Wzv13k5nYu7dMLPTKhrBK3z4=;
        b=gv0Em7C8oMqWrkNDZKyMxdviRsiKkztqQsIGG2bLcMT0hOl98eFzGEdI470XglcCpg
         o+8D0VwxRyOXXnPO7nYjlY1YBXEiY8sB7y5zF5QIoaul/TonCqs6l9OyXieI2il++Zs0
         l+4QwdLx7PMTnYCTsY+pt3hujk7EK/Lxj7FagLNSKRapwquGCl5eFgKk3DY7ZGJjPvvh
         HsvZ73A4s+aSMsOVNNNC978gF5LzKinphjb7445pEJWOj34xqxgf4iC3ppC6JI6NZOY/
         EN2RzEcOuvu+Ja7ZH2oFR0Z1C7nR81HTjNDF2vHvIN1iwQCFX3dxkTFkNVj3ZhGDi0Bu
         n7Nw==
X-Gm-Message-State: AC+VfDxJMxZqJOzKpsMwrn32EoEWpHVExzKTi8uTCglXce6AHi2pf85t
	0aJMNmcbNLHb+mtI2Dcxm2/wS4zlDRblXurjqiZtFcOag5MES3F4QV4=
X-Google-Smtp-Source: ACHHUZ46aDuspJOarRL79lYzMGYqEwkTT5JRnSSANc5yEURsqqhVLj46v6MxmEOQjpuP2GHM1lq45BhbCoWHJISjTgk=
X-Received: by 2002:a67:f6c2:0:b0:43f:58a1:b22c with SMTP id
 v2-20020a67f6c2000000b0043f58a1b22cmr6794552vso.16.1687383279464; Wed, 21 Jun
 2023 14:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-5-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:34:28 +0200
Message-ID: <CACRpkdaZC9AWRMv-=sQH4DghD3H6WO_9JTdJ4jg+EbM+WAEeKg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: dsa: vsc73xx: Add vlan filtering
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

> This patch implement vlan filtering for vsc73xx driver.
>
> After vlan filtering start, switch is reconfigured from QinQ to simple
> vlan aware mode. It's required, because VSC73XX chips haven't support
> for inner vlan tag filter.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

