Return-Path: <netdev+bounces-45080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB667DAD01
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E182814EE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A822CA5D;
	Sun, 29 Oct 2023 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elKvagR+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA863C8CA
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 15:38:18 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85DBBD
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 08:38:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a86b6391e9so32220157b3.0
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698593897; x=1699198697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT43Nf94mF07rnV7CrLvxuub2Ca7aEi64+U8CyL0b3g=;
        b=elKvagR+t77xfpkmWelkGAt9q/K6/ipzvvpjNMG9HNLEq+AAqckqpJP8yQzR7Sm90U
         6a8Fr9tIpFYT+OecNH1TStn2w8g6nVk4z/63yUxaH8yRoRFafBHqb9Xc5vdKm9lkppmN
         cul1g9JyEMIHlB+PZWhSqGtQTZoljHYl4Rru+MprgmBzrT1b2extbmbodGdnfVaDaqid
         b5n8hhtw/6EdyB+l5XitgNGGC2pREvkBcAhj0eFIhCLjLs0lhLSyHhOSaNLAfVjTkfJt
         7a8XSWMpXnh6BZJQ5k4yoDKq5gr+I8qNatnBw7iXTCcV4vhgxgtQer4YJzDH09g2tcf9
         kftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698593897; x=1699198697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT43Nf94mF07rnV7CrLvxuub2Ca7aEi64+U8CyL0b3g=;
        b=mq0agZxPsUTXWGl3KIMxGTjQnOMeyLItg7Qy4WS/pAero6DYGp/UEXkFfWmgIONKfz
         JARxKmZsL77ql2k8D5XA/aaJEL+eN6iPZptYMUYWmKNWoal0tkSpCm2iNSpfrfgcahkx
         48u+yi/LMcyz8qYNS0oDJQk3sXsarL18S80EAIm2IRtm7iJmKfrqakY0WwLEiWXEgpML
         SzhcBQjlFBAmgFPqNhecQWOJL3tPkY9x7spY6fNg1yal1+sU4HdnvLumrCZWy5Zga3O3
         LA1slKSuW5sHqUlO73dZCvMe4XyiPM2K9E1AK8PHsS0DkqdCWR3E6Fnhnq68/qxitIYG
         TUlw==
X-Gm-Message-State: AOJu0YwyOzRHdBtOWaB1jhpRfhW9093snUB8yzIJ9LESbdlvdzPGibBS
	Mbe+6OXZsdWYGlRwQreiUZlwW13cK85C/GMKSXI9DQ==
X-Google-Smtp-Source: AGHT+IG9mfhQQbXcGl8AcijtrKNfwYSt3oDBm67fZGoetZ9+aWcXQ2nRVhfuKvMzIE9tEEvaJNYpsV9CoFfSaSnzLeU=
X-Received: by 2002:a0d:ec47:0:b0:595:9135:83c7 with SMTP id
 r7-20020a0dec47000000b00595913583c7mr7285708ywn.47.1698593896903; Sun, 29 Oct
 2023 08:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org> <95f324af-88de-4692-966f-588287305e09@gmail.com>
In-Reply-To: <95f324af-88de-4692-966f-588287305e09@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 29 Oct 2023 16:38:04 +0100
Message-ID: <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 11:23=E2=80=AFPM Florian Fainelli <f.fainelli@gmail=
.com> wrote:

> > It turns out that sometimes, but not always, small packets are
> > dropped by the switch for no reason.
>
> And we are positive that the Ethernet MAC is also properly padding
> frames before having them ingress the switch?

I don't fully follow, this code is the one adding the padding isn't it?
Then the result is transmitted to the switch from the ethernet
MAC (drivers/net/ethernet/cortina/gemini.c).

What am I getting wrong here...

> > If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> > (1518 bytes) everything starts working fine.
>
> That is quite unprecedented, either the switch is very bogus or there is
> something else we do not fully understand...

The switch is pretty bogus, all documentation we have of it is a vendor
code drop, no data sheet. The format for ingress and egress tags
was discovered using trial-and-error.

Yours,
Linus Walleij

