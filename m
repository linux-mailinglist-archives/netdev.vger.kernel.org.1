Return-Path: <netdev+bounces-29094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123C7819AD
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5DD281A6B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD51611E;
	Sat, 19 Aug 2023 13:23:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D246B6
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:23:47 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E90D8
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:21:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so2192379a12.3
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692451315; x=1693056115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlxwKd3Lo+momKyLWahfpvHnxwMdFdNkqNGUZuaXSUg=;
        b=XRQc0xQXK60NPpoK/7rIIuZCjiewxXxvaICwNu5Eb94ZDVFTuW5frhaZMYIUEEJ1Ts
         9yWMw6zVB41r7Q11XrZ0rJIYnUb9T9bmCjaBIwQssmrVZ3t2ONDeuPZgQCsVAidR57/4
         oZn/VXXsC5LsrxBTbK5IxBjoKXvqwO6j3tBYjiF089lVzIghjRj5ntnPzm+0DEYFl/MU
         /TizvThjtYKLk1XdMIytFERFZBzDjHBpjSKSvIl4BETmxCSyrtC+jcslLwCULfozC4aP
         sRc3e23vxz32kTWRZicH/zL5DRzX2zZ1hMzfb51mvkyZXJCAdEIvf+nfUlxa6OtQk5nA
         UeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692451315; x=1693056115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlxwKd3Lo+momKyLWahfpvHnxwMdFdNkqNGUZuaXSUg=;
        b=Yb0SBTi5gqJE2odSZfFj5vShX0RPdMUigodr/xdUdHBuokS8r/Vwnftfsmod3JnVia
         UD0oxOnucoeaDIFQyL+ieXrjb0DTDragLr2obtKNY/6HIukQpismImnnVjbKiUv+ByBR
         5brVXJl+U4ebk1G53gh9RR815WgpiT4kUCI128o1q0iR4wSOf9xzIGdJrpAk/12Y68yt
         YxrQsCPZM4/lrjDybdrhtCbK4kRvt296NT/ly1WxZXpJ36Oi8r5yvJ5ptQcZ7hgcZKyT
         hW8lLfwGZI/CWGnxCzRZsjkJpyy5DmhsL/DZn3OoxVDKD7CLGilRrFtoo7B+T7Yh+NuU
         ZaLg==
X-Gm-Message-State: AOJu0Yza4AxNaAaAOU3+8w7YK4G3pZEv69VdzC1tifBDcZQ2dCOT/LE1
	aSbc5GrGcVQg+8RijMtQZME=
X-Google-Smtp-Source: AGHT+IHxdeYeEjqhMQW3TuMWIznFEVvrsqaFC8gRxfbvKVpt5G3Yg/8kWlYbJAZgDpsub9Pv/idt2g==
X-Received: by 2002:aa7:d78d:0:b0:523:c35:c209 with SMTP id s13-20020aa7d78d000000b005230c35c209mr1509359edq.12.1692451314415;
        Sat, 19 Aug 2023 06:21:54 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id d5-20020aa7d5c5000000b00521953ce6e0sm2519605eds.93.2023.08.19.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 06:21:53 -0700 (PDT)
Date: Sat, 19 Aug 2023 16:21:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin __ipraga <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
 implementation
Message-ID: <20230819132151.pgxsgfbaf2jg6u4y@skbuf>
References: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 12:11:06PM +0100, Russell King (Oracle) wrote:
> The user ports use RSGMII, but we don't have that, and DT doesn't
> specify a phy interface mode, so phylib defaults to GMII. These support
> 1G, 100M and 10M with flow control. It is unknown whether asymetric
> pause is supported at all speeds.
> 
> The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
> and support speeds specific to each, with full duplex only supported
> in some modes. Flow control may be supported again by hardware pin
> strapping, and theoretically is readable through a register but no
> information is given in the datasheet for that.
> 
> So, we do a best efforts - and be lenient.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> First posted in
> https://lore.kernel.org/r/ZNd4AJlLLmszeOxg@shell.armlinux.org.uk
> and fixed up Vladimir's feedback slightly differently from proposed.

LGTM.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

