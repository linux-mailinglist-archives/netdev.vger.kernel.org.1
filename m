Return-Path: <netdev+bounces-45347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC67DC2F8
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA29281513
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F9156C1;
	Mon, 30 Oct 2023 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpF0uSS5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B15D289
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:12:05 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578CD3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:12:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7b3d33663so50934537b3.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698707523; x=1699312323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGr7gy8kOteEp5Y91mfSF0OEQx3erWbimD8/Mcv0sFY=;
        b=PpF0uSS5isybsFqiY9Wj/wQu1OimTVd1wcrpeYZk4SC8V7951zvtLa2KRZGcDEeSUT
         bxUpDqnQrQUEoJ4/1Cktshv0ovouyStaGscLXLYTRUoG6PY4lbiZfAxrxWoKkpPTXgMb
         GHmDuVcN+bqsTSfC/BLuhSQ/9ctAgDK+jiMmARhoOpX40bR17bQ4kO6IsQlrHn2n7aps
         r697GZgq+JztDKPkuEu8xgaaf9rxFiGpJJzAta6G3doEVWTgOMn5DtVfmvKBNuYvGd81
         PQlXxmm6XTF1mR2TVv3k7emaICXZEN5G2MGhv9IRQid2T99qUuzaygMAVyT0DhymswUR
         aPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707523; x=1699312323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGr7gy8kOteEp5Y91mfSF0OEQx3erWbimD8/Mcv0sFY=;
        b=SHURIMV2nQjpXvQ6vLL0jNRngYrmX2zg8kcXpiVuPFMJIMI7GBPN1oNKNeZyP3zWkx
         mMp/9t4u/dOjKP71k+gDcSUUfduNpTxlkyrjWDDkt8t8TsrI6ZM8bLg7+fqNGYKz1he8
         gV31yoDxcpsFFtcs1oPnZiNXUud5JzOcV04PuTmZ5TRLLZ44PV114P77QIUJUdHdO33v
         hbpdgPilARRB+iNUycwBaWNlXP3I88VdIwLrSmXQf6zHkRDS1EdzGEl3JdUnR19jN8XS
         C/X+sY+sC+w4H0U4d2SlNjOSbq+lOe1sgCekWDcgfB11j7XeWw1pnKW5Qgic6t10tXI+
         3l/Q==
X-Gm-Message-State: AOJu0YySJHscFolegXrRcr2ZC7DW+km4rvqVDDngNfjwe5pVZTIsNbG7
	meLID9M30Xxh58KXkYFGYOafQeoJDBxCqvdmE9iTeN6y7PikmDPB
X-Google-Smtp-Source: AGHT+IHzh1T19az228TAdi0hy2EN6mS90efMvKloneYEnAGZRzkBhLFluz6Vij5HYrvkFtXmDQ378OncfN5m8RJQ40o=
X-Received: by 2002:a81:c64b:0:b0:578:5e60:dcc9 with SMTP id
 q11-20020a81c64b000000b005785e60dcc9mr10288103ywj.10.1698707523065; Mon, 30
 Oct 2023 16:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030230906.s5feepjcvgbg5e7v@skbuf>
In-Reply-To: <20231030230906.s5feepjcvgbg5e7v@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 00:11:51 +0100
Message-ID: <CACRpkdZ=Y3wnnUtBVbzaOsA6bLm7nOwXoi7qO3=n_K=xpqofjA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 12:09=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > This of course make no sense, since the padding function should do noth=
ing
> > when the packet is bigger than 60 bytes.
>
> Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn't
> work? Could you add a static ARP entry for the 192.168.1.137 IP address?

ARP appears to work, and also DHCP then (I reconnect and
restart the interface before each test), so it's really weird.

I'm trying your suggestion to skb_dump() before/after.

Yours,
Linus Walleij

