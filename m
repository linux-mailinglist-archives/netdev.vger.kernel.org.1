Return-Path: <netdev+bounces-42923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52407D0A7B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5581C20ED1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F041095C;
	Fri, 20 Oct 2023 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZZcR/b2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D59B67E;
	Fri, 20 Oct 2023 08:23:59 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF724C0;
	Fri, 20 Oct 2023 01:23:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f61312eso4375525e9.3;
        Fri, 20 Oct 2023 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697790233; x=1698395033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CpDwt0mIHXa5SjKWHCoaE9qIzOGUHJct+s3WKSwVDU=;
        b=YZZcR/b2XLpmxvb+WnuIB1QiG1U+1anE36FLntSWz6M0gqKat5x3e/3rFzX7Ax3GXW
         CXbGChWGTvkttaGb0GdGFIM6c59IMVsk1ZqvN+AYzf+35MxJt2W8C1od6jK3i46YyNRe
         dkdNL3axJ/EVTSY+WbWk4PyjgtYyb6dxA8mXliXrTVFnhsiIEYEr2FebUnexiqLjz2NZ
         10YncTYJBRSfr2yeOOyF9Pf0HsIRsV50me7y1G85ADvqdvK86mlmox5d27/P3qL3hpqT
         z66++UPgnpg07vNqM5FSF8dlEwqWWwxQrOaieC9cD+GZuPYUjVAtB0YphY0UKOrbVVCv
         LrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697790233; x=1698395033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CpDwt0mIHXa5SjKWHCoaE9qIzOGUHJct+s3WKSwVDU=;
        b=NHVvk39VEbPoobmRwbGzWIztUVjDdiN71JPkyytTZ/zWfOgJotzNpzxM8tLz1QAFp+
         IV5QxbXqOSy6C5Hh3t9Svxd8xKNG4zQmVpggbrQOTDEwtMdULHNz3Q4k1S259y+FZ39V
         xOZULtW66eUi5GsNqlfBZfTXc4Ul3I2bgFgOR3/1450sp77Rd5WgWdLj4ws8ywZcxCKP
         9bPPwuL4cZKqcr61QsIskfDB6ZAEpZ4XR2oZs4TV5UYYe0IqjG6JxJ5Rc/RUsWUHaAxU
         84+bp7iyTx42C3IByG3efeKD+zUsTEhgI9yWKnSgWv0Xr6lGzOvQbn9C0Ie9yTGk8Yjv
         I0Sg==
X-Gm-Message-State: AOJu0Yz9h1gX5qPZ1Fw3ma0/n6dphD4uZZhwEyWcWTm8qJedZgfTorLq
	KBfPNoMtJvA2P95YUStDqwYgug6bDZyTKQ==
X-Google-Smtp-Source: AGHT+IHnnC4mklZfLAW60TnEnNxQtbqdf2yOeDlAPmk6S0FQh1TCdkL68HteMTGmVS8PkBhdfMIxRg==
X-Received: by 2002:a05:600c:3147:b0:405:4a78:a892 with SMTP id h7-20020a05600c314700b004054a78a892mr806944wmo.9.1697790232887;
        Fri, 20 Oct 2023 01:23:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b004063ea92492sm1607389wmb.22.2023.10.20.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:23:52 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:23:50 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231020082350.f3ttjnn6qfcmskno@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
 <20231020050856.GB3637381@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020050856.GB3637381@pengutronix.de>

On Fri, Oct 20, 2023 at 07:08:56AM +0200, Oleksij Rempel wrote:
> On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> > I don't get it, why do you release the reference on the MAC address as
> > soon as you successfully get it? Without a reference held, the
> > programmed address still lingers on, but the HSR offload code, on a
> > different port with a different MAC address, can change it and break WoL.
> 
> It is ksz9477_get_wol() function. We do not actually need to program
> here the MAC address, we only need to test if we would be able to get
> it. To show the use more or less correct information on WoL
> capabilities. For example, instead showing the user that Wake on Magic
> is supported, where we already know that is not the case, we can already
> show correct information. May be it will be better to have
> extra option for ksz_switch_macaddr_get() to not allocate and do the
> refcounting or have a separate function.

Ah, yes, it is from get_wol(). Maybe a ksz_switch_macaddr_tryget(ds, port)
which returns bool (true if dev->switch_macaddr is NULL, or if non-NULL
and ether_addr_equal(dev->switch_macaddr->addr, port addr))?

