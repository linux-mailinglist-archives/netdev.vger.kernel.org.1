Return-Path: <netdev+bounces-12846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19193739194
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486411C20F4E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313F1D2A9;
	Wed, 21 Jun 2023 21:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504619E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:33:41 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712901B4
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:33:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso6345275276.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383218; x=1689975218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mtJxu2dDNF02+pBprjp3JwCVt0pkUhvAR6JSdjzgk=;
        b=mgtth32W59FwEqC/Km5G2zehnzpp7m2UioIe3CZkBFFGFVGG3pmEc8DCbMGiWn+gOQ
         duF2oUW1s8ZjqzoLMQQVDC1dxpXQlWUkHBEL232UAykVCvgKKwYkOKBFOcUvZY4cUCfe
         j1qYJf7X7DPU8aulo/HefJg2wMoJU56sminRD3teMlZSKPVbEh8UWGLecCLZ5peYUqRt
         2RxGcMDdt2NsLJI4g0qHQbQCQylXYUIoJ1rk27ZsDjj6WVKU8tW80Tb/M9Re9LFrGgUj
         fWDyNSMtygFB6mQ+6OR7YdnYbwm4AN02uuBlgCxreM2I3kLDuTbW83TniXT5MsBlmERs
         V1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383218; x=1689975218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6mtJxu2dDNF02+pBprjp3JwCVt0pkUhvAR6JSdjzgk=;
        b=XXmd/cjgxstRaHCeB//b78WfJkHYKkvVFUFMooEMpl0F8joaREVG+3ir+KLJHx/m/U
         D7UKPZKPsAPR4vSu2G3tk/tkHPsOqPJM3AVcorwdlzzawBVdngBuymwBkEU0p9K/gXkQ
         GxKzM5eqGmktU5/jTIuEjzJBtOGnldICCyouk+3kRA+XgOK/fQNrO60dzBC8Tr2px6f0
         Kzj/A/94NlsHIzP106Sri7g73lx0E7hC2oBPExIA+OGlrGheO2LuKeupE138tHuId+9j
         L2WdH42zjBICubB5KQrzKTmeipG6p7KDUh0PbfZdleFozacacehxcxpy5SFpAl1u2zPq
         zjaw==
X-Gm-Message-State: AC+VfDzuv6gPgHyAdnPt73sdCzZg4g9LtG5hTuEROCWfFv7JEFknvpYk
	P1YvF90q9T1zvGsa25BKzdctubDw2f+uatVbuYTjmQ==
X-Google-Smtp-Source: ACHHUZ6YRVQLnj7llg9bunVwb1q3jiG981A5NXf2WhraolhbxfGJ49nhqWzWPwCW8k9lL42JxNfT3RZ6EwT5MlcrFsw=
X-Received: by 2002:a25:ad1e:0:b0:bd6:8725:2258 with SMTP id
 y30-20020a25ad1e000000b00bd687252258mr13318133ybi.60.1687383218657; Wed, 21
 Jun 2023 14:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-4-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-4-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:33:27 +0200
Message-ID: <CACRpkdaOUp=4h0g_aZmLTtij5SuVu6_n1N_xUS_JvLidynKerA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] net: dsa: vsc73xx: Add bridge support
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

> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
>
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Given that we use the approach from the other patches, this
makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

