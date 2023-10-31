Return-Path: <netdev+bounces-45428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6F7DCEA3
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEEC1C20BD5
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FCE1DDE0;
	Tue, 31 Oct 2023 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijI6iDVF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6145255
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:06:28 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6AD7D
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:06:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5afabb23900so45814807b3.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698761185; x=1699365985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gOGBDhGMAomhjgIfG+7vYKiHbH7aSl3HXwGenxwfd8=;
        b=ijI6iDVFyTBszIfnye6I+ujsE0YOatWd8xEUAI1wG3U43K/sEZsdVz7YcNXkVe+upN
         N1d2Dl6sogtAAxdjSC1Pl0vMHz9ag1mV8u45qWoSRTAkYn3V+g8KiRwgacU033TB9MVp
         YxuT9OuFphXJGGNg/gkEZBrbmDoMfAwqCUZF0PoJV1mOKONO0bmdPyJwL0VZZoVyB28h
         6hQvXWn6rWYfwAklRz6NfFIwbjDX64YwdVUhz7xZgn3s7LrGOukjH6vlWjxaBGbj54hr
         cnKnNri0w7fRilzq4tzjeoAAxrbzx0Ee2W9xT/O98vsNdxlnY5tuRMA4znn7SvY6xU5O
         lF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761185; x=1699365985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gOGBDhGMAomhjgIfG+7vYKiHbH7aSl3HXwGenxwfd8=;
        b=b4tcoXiuC28Qnt+4V4+daCj6GRlQErBqJg8URbhfH+QUBIFpXDnP1NFls/ey/7I4Lq
         izKWz/9DbqSOp/37/gA7hzQo6gPT+JeZjbSSlqseXwBa1XWlbrpjgMj5AsDu+vY2L9iL
         cBghLkr91rGvlXgVVPLlb28W0Zg4uEpictjpeGCcoRmbrcF9QlmDK0g9jSlUbxE98iBO
         qU5LP4SIU5UuFDVo0H0lpUF27L+ORv/Qbl1cPm0OAZFgonh5TXJMYiI0y9v40qdWaWD7
         tFNCcYG8NiEUsUGg1iqtDds8/wznLkavxqakRGI0HkA964OW5mgk+rB1H/LJtlfZDfGY
         HIKQ==
X-Gm-Message-State: AOJu0YzhL9DCFrJwd3NuxushE8dNGxZhRR//V3PmPjkdRcgPF46zpBUS
	xLXcuJVbDTXSWOUrI+VqtpRd7eDU3sp/bk4jV2HDjQ==
X-Google-Smtp-Source: AGHT+IFAF+1pNuBhT8QPm7zdsASqDKt4L2Oe1ggSuycAsgoCY9HikMB+AQxiuokR6DYWJQqj05y50Dz1fqKn5q7VwUE=
X-Received: by 2002:a81:8b44:0:b0:5a7:af89:c4a0 with SMTP id
 e4-20020a818b44000000b005a7af89c4a0mr13078152ywk.23.1698761185232; Tue, 31
 Oct 2023 07:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030230906.s5feepjcvgbg5e7v@skbuf> <494a8bb7-7ca1-40bd-b3a7-babeadfd88a0@lunn.ch>
In-Reply-To: <494a8bb7-7ca1-40bd-b3a7-babeadfd88a0@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 15:06:12 +0100
Message-ID: <CACRpkdZ8A-Yz-8itXzaBuLHfFLpmwGyg2gUqyNMpx3NbjR+KPA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 1:37=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Oct 31, 2023 at 01:09:06AM +0200, Vladimir Oltean wrote:
> > On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > > This of course make no sense, since the padding function should do no=
thing
> > > when the packet is bigger than 60 bytes.
> >
> > Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn'=
t
> > work? Could you add a static ARP entry for the 192.168.1.137 IP address=
?
>
> Probably the ARP, since they are short packets and probably need the
> padding.

It seems correct: the reason ping stops working is not that the ping
isn't reaching the host, I can see the pin request on tcpdumps.

The reason is that the host has no idea where to send the reply.
Because it's not getting any ARP replies.

And that is probably because the ARP replies are short and needs
padding to ETH_ZLEN.

I notice the code is probably borrowed from tag_brcm.c which does
exactly the same thing (ETH_ZLEN + tag). It comes with this
explanation:

       /* The Ethernet switch we are interfaced with needs packets to
be at
         * least 64 bytes (including FCS) otherwise they will be
discarded when
         * they enter the switch port logic. When Broadcom tags are
enabled, we
         * need to make sure that packets are at least 68 bytes
         * (including FCS and tag) because the length verification is
done after
         * the Broadcom tag is stripped off the ingress packet.
         *
         * Let dsa_slave_xmit() free the SKB
         */

The switch fabric is dropping smaller packets when CPU tags
(DSA tags) are enabled.

So is the padding to ETH_ZLEN OK or should is happen elsewhere?

Yours,
Linus Walleij

