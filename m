Return-Path: <netdev+bounces-42683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30987CFCBB
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539AAB214AC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B332C7E;
	Thu, 19 Oct 2023 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcyTi2u2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B2321B5;
	Thu, 19 Oct 2023 14:30:08 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8011B1;
	Thu, 19 Oct 2023 07:30:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso13564608a12.1;
        Thu, 19 Oct 2023 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697725802; x=1698330602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wX4f50XOLEee00Srtb8FwAKFIgUc/Wj/C0qtW/ywJag=;
        b=BcyTi2u2WTzx3cIK6nPk9Vq9aaj0kIQ7ntVxfPrR0lyUSBCIA1pmkKlinUhkX7zbSl
         mFEksiEEwEbXSN6uHMWbNqWJkGzaMpDkqhZ+zGWSp9GkET8o5H8n2u3Bepol2yhYm/Tb
         Sqp1dZxunKXslPSUmtIqccUBfrtw42XwgE9galj6hliUsPJVqfkHflRNdDwALWMKOMU/
         CD05R67MBaiLZ381pjKoZ0rQrl2vY6WHBJ1x7rMR87egK6l4qj8nduru1PIKR4IXofGJ
         KomWP1Eyg9KmLHRKW4Pm6FDicZ7aFu1t/lhdUJnyPYgPpLZfVbIPp9rTS5jlTfgJnvCb
         t0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725802; x=1698330602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX4f50XOLEee00Srtb8FwAKFIgUc/Wj/C0qtW/ywJag=;
        b=RiVTrVzyxWBL88NWRKN5amwJZiLoPjLWWbwofTxbCZHYNtc8+SOK0aiN8gkbRk+0+A
         ieK5QY0go+kufSyKbBHdj+J+YistH8iVJo8Dy3DsJ7VwjYc62zsVvlQiT7ymlEFiL6/u
         8CqHMRWiHhKVVij9QKe7D3Tguz6lwc8h/gi5vjO/9JmZ7yJuL5F9SIi4GSwfSdlqRvEX
         9eu7cgYdz7NThNQnGcoUMPFxnDLAVxv6mBquYDCy7XE9KyexM3gpd9KDqlJSpEWMuUHX
         ThXLCfLIcthKEJm8L99/H66wGRlZDwpjlz3YdfQMqbvwCE5L3umB4KRfzD3CKVn3774Q
         YWDw==
X-Gm-Message-State: AOJu0Yz75EM0IQ8cX3VkbLxzt9lNQluZOFH5dhqiQTSXYYubuwe8oYtI
	f3i4DlIMIb7nTrTh9HXBM1I=
X-Google-Smtp-Source: AGHT+IFsJj8OuUADqu+SUI3NdXBcemhuiA1k26KFrGqr30sspr3z516YCjG0rPLm7A45IR+YTKJIBA==
X-Received: by 2002:a17:907:7e94:b0:9bf:10f3:e435 with SMTP id qb20-20020a1709077e9400b009bf10f3e435mr2237055ejc.1.1697725802098;
        Thu, 19 Oct 2023 07:30:02 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906594400b009c7558b39fasm2427690ejr.194.2023.10.19.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:30:01 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:29:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/7] ARM: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231019142959.qonrf6cfqoxe7uun@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-3-3ee0c67383be@linaro.org>
 <ZTENTqAMf/6ZWX2i@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTENTqAMf/6ZWX2i@shell.armlinux.org.uk>

On Thu, Oct 19, 2023 at 12:04:46PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 18, 2023 at 11:03:42AM +0200, Linus Walleij wrote:
> > Fix some errors in the Marvell MV88E6xxx switch descriptions:
> > - The top node had no address size or cells.
> > - switch0@0 is not OK, should be switch@0.
> > - The ports node should have port@0 etc children, no
> >   plural "ports".
> > 
> > This serves as an example of fixes needed for introducing a
> > schema for the bindings, but the patch can simply be applied.
> 
> In patch 2, you mention that things should be named ethernet-switch and
> ethernet-port. As you're renaming the nodes in this patch, wouldn't it
> make sense to use those names instead now, rather than at some point in
> the future a patch that converts to these names?

I agree, and I was wondering the same thing.

