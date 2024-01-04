Return-Path: <netdev+bounces-61715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D326824BBC
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F9E286FBE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 23:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C1B2D045;
	Thu,  4 Jan 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlBcNfig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2472C191
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5d898162so7578465e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704409984; x=1705014784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=263D42JyAWLzBfOys0kapTK36JC/euenM9n/WSpsCMw=;
        b=QlBcNfigwrdORFEo1+/nnfi/u4LrX4RGQQpsE52zy4GaxVHjxOc5shfY1CHXdDC8cQ
         OGqVDXV6gAbFGZsgibKhjK6UAwWk5Hd1qgC9Vz6aY6ta+1zkyZ/Nmv1IZqX+bZLBv7oK
         VxIAo1/FQDGjadEcIN+sLA8/XBMaAJktHZ96FCyCYoUbFO7seIZVSLcc54TD0FnJMHaZ
         Vizub3TRVVW7/KgfNQjR58iYRtgbi9xMkr7QccJgdU/vMZ52w3VGhr6M5jRRHJaBUIt0
         ug55G/CXncTeWRs5m9oE/vusAVGDWsk9q9hNyvRRNIH23yxzYQ6vFpm/T6pfcf/H6xU5
         1P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409984; x=1705014784;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=263D42JyAWLzBfOys0kapTK36JC/euenM9n/WSpsCMw=;
        b=IBSiL4gK5DBR6UVQ/lKZA2YfcIHiMFytLgooPs70NAMrX8U9LbbW7jDuZRMegm1hae
         8xODCyLOMW7VBzF9MiRAJFg0/6G2Dj7ZqBVisH6oHUpKVEwizh9R0D3xVBVpeMejNgC8
         roLy6w5o+TXhgxlUuMi7f7Tfo4RRRRemP7m/AVp286om7M7ZoayQxhTIxXAHSiKbud7Z
         cygQokCNQ7lYEx1hfVLktPdUXybN4T5TGfY5N+iVfnaZO+FJlMNAXjD7+TM0DH1fL9oi
         hQj/vTLnKQICOjWfH7qmxbJicgAD9S0i2h1cYWLAttFy1E8Ukor6wO6V0DYCaLzk/9oL
         9OtQ==
X-Gm-Message-State: AOJu0Yz9i1CphxRV8ngOkI4wfbNIMYwnYf1kDq8CVdGXXaNhfvmpckOv
	2puWG9bT8iOiUnKX1+3r30M=
X-Google-Smtp-Source: AGHT+IFYek9qLKAuq6/sK3D6e3mcvS9OHQmMG+3y6yf1Yh89f7s/QN0aCyu0nKNX/hQEvqQXOS9gwA==
X-Received: by 2002:a05:600c:1d1e:b0:40d:9485:b3ea with SMTP id l30-20020a05600c1d1e00b0040d9485b3eamr806608wms.19.1704409983764;
        Thu, 04 Jan 2024 15:13:03 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id df18-20020a5d5b92000000b00336a1f6ce7csm260387wrb.19.2024.01.04.15.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:13:03 -0800 (PST)
Message-ID: <65973b7f.5d0a0220.1eb1b.0cf4@mx.google.com>
X-Google-Original-Message-ID: <ZZc6Lm7gFoTHTtZS@Ansuel-xps.>
Date: Fri, 5 Jan 2024 00:07:26 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 07/10] net: dsa: qca8k: consolidate calls to a
 single devm_of_mdiobus_register()
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-8-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104140037.374166-8-vladimir.oltean@nxp.com>

On Thu, Jan 04, 2024 at 04:00:34PM +0200, Vladimir Oltean wrote:
> __of_mdiobus_register() already calls __mdiobus_register() if the
> OF node provided as argument is NULL. We can take advantage of that
> and simplify the 2 code path, calling devm_of_mdiobus_register() only
> once for both cases.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

