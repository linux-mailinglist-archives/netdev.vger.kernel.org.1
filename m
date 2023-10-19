Return-Path: <netdev+bounces-42736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FF7D0047
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8029FB20F15
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42932C6B;
	Thu, 19 Oct 2023 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6znQmKa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDA32C62;
	Thu, 19 Oct 2023 17:10:25 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EECF;
	Thu, 19 Oct 2023 10:10:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so1352058766b.2;
        Thu, 19 Oct 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697735422; x=1698340222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3EG8voekuiDu8+1WrOXrX0b/udoq4F/afXtMElXqbE=;
        b=S6znQmKaaKY8rFw4hGY3y7As2MONtPbPGLYbZbOJfw5Zje4w+QiTTiVf5yjHi2Pd9M
         ABErBCeZe6SjvS4MVJmzRUP/Zz/DYxrHwRpjpmLEq91oX+px9gZY5tqRzDY257PBicBk
         WteJY4OcHDROx4RW4tFxcAFhcHwaU7cePpG895PAVf2IsP3ddStOHjo8SuJgoJ8OgLyr
         43Zv0iPL59yqz3wgIkHYVFP5ooxbWB2OmHclYXho7NIaA9D3FUNbWKMGOGZ1sXFWD+35
         Uh3jqFYcBY1ofHYomFZXvwwLlIaNQTprEmRH+6tXT3awoQecjMRkdOked2KAKRWBW7VG
         OXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735422; x=1698340222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3EG8voekuiDu8+1WrOXrX0b/udoq4F/afXtMElXqbE=;
        b=p0ecfXIPnUT+P8qyn8xMLgAkOqMKpIgDQ2SYr2zYmEkgmfChS7GLnKbZZN149hteh6
         +uam0AklZsHAAdapN2yl94MN6wsLbSvkoRt73163/VXRdGqYI/zGfCmHA5j2ub9ZHaON
         XdQKsut4FiqOS7KqQFRc3dp+GIPDYLyyjg2171tgR8NzDP5ZFgn6Fp2iRTQkHMZ4phoW
         6sF07eZ6SqMXTf0SaA0wdM8ZD+tYE8jyTiaw3eidzCTu52DyeQU4J6ya/okRaGN2iZrR
         Q5ZJTqnCil5ew1lYdbK3SLtq2GAKeHlFi4i/oTroR9FP4ck4wTQA8oLuB/1HCCi7i79n
         +zZQ==
X-Gm-Message-State: AOJu0YwPcK3oKqYzqwwIF0r3fJge/WfjUmqIiuGQexIs33WEr88KW8XW
	l4Vr4ZwBK9kUiJNQElHOses=
X-Google-Smtp-Source: AGHT+IGb+lVx1YdI/MeXvJ0XTmH9AvemAYqYeJu16szeci0NKpPRvdgw8ZLbOdJXBsSavccDYtT8Og==
X-Received: by 2002:a17:907:980c:b0:9c7:5186:de1a with SMTP id ji12-20020a170907980c00b009c75186de1amr2669932ejc.8.1697735422441;
        Thu, 19 Oct 2023 10:10:22 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170906a0cc00b0099bd7b26639sm3966785ejb.6.2023.10.19.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:10:22 -0700 (PDT)
Date: Thu, 19 Oct 2023 20:10:19 +0300
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
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 6/9] net: dsa: microchip: Refactor comment
 for ksz_switch_macaddr_get() function
Message-ID: <20231019171019.h5er2mdarrjk43o5@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-7-o.rempel@pengutronix.de>

On Thu, Oct 19, 2023 at 02:28:47PM +0200, Oleksij Rempel wrote:
> Update the comment to follow kernel-doc format.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

