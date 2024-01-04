Return-Path: <netdev+bounces-61713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27445824B9B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A632AB223C0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2352D022;
	Thu,  4 Jan 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJGLYq9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2D2C191
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d899205c7so8724125e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 15:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704409304; x=1705014104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IE9UPnaGGT/cZsRA/D4cjzml+xQ3HOtUhHPLKvjjlLw=;
        b=mJGLYq9JEoWZK3zgBks3qFH9xLGOuzulIhxSe2uoz2ikfvkfcryw7wZ6Ob7Q8BBT1A
         zzibYUpxbzBP/S249Bv0XAa8yVSCu3Pt9BGCEO5/dcyJbxjhGLhkhPcFeZPt29lnrVA/
         ZFKlpAUC71Agb4fPXfeVd65Tb9Lc8GtuwIK6qA6McES3XfEPbzbuqGpTz5WY131XNzkf
         ObYbvFUmWSOZNCQVi2NFa4pfGI6ZDk/7V0GrTZrDTQs4Z1vFb1MCcKXFNuIDCGAsmw4U
         avpRqBihBH/w2KoHb7Crwz/wzTxqtgLb40cCTbDFHvZzi62/hWkZdJlKWR5V8tvdntgz
         RFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409304; x=1705014104;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE9UPnaGGT/cZsRA/D4cjzml+xQ3HOtUhHPLKvjjlLw=;
        b=VdlmrS9KRsqcINQ7oKy+vYGVDJHWm2qKRj9+qHl/yoZhAOax7X4bSNMROIsgKZ7hgm
         YEHKwjLdH3eNRdKhpSBd1F5Iu7T/fnmTXd+MbAZgBLIrbhULHl3T5S4UU1z2V3NidH2+
         +jshXfIAhHJ8lBsnGCGhbJfhR1BkxYiltIDwR7jE3mr8430JuhkDjFZfazkvdzc8pPL1
         NNNkXm86ZUvKO/2svommBhPWGBFSGkaAlEPbx0lSjpN7BlnKWZ/teI7/5gDwZ3IuO7Oa
         V/c/b+Yld3MEcD44gXCw1R/t2JHPs4OqDbBgNX4iJvdyxUDC05dmeH/84tC3weiUvmWd
         EOew==
X-Gm-Message-State: AOJu0YyMhJfgTvrdR3sq2ungT6MiqxK09a20l/hCLzmdKD9TrjlHVSJk
	/qN39dFOxLDRgU2Z8505sAo=
X-Google-Smtp-Source: AGHT+IG7R280el6VlwH1irnTi7QAWyix7UX5H0C3fVO0UqmE7Eaukde5eQYPe7mpYlCG7epcz/yQwg==
X-Received: by 2002:a05:600c:3586:b0:40d:3dd7:46f8 with SMTP id p6-20020a05600c358600b0040d3dd746f8mr739401wmq.127.1704409304173;
        Thu, 04 Jan 2024 15:01:44 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05600c1f1700b0040d2e37c06dsm559018wmb.20.2024.01.04.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:01:43 -0800 (PST)
Message-ID: <659738d7.050a0220.98e66.1df3@mx.google.com>
X-Google-Original-Message-ID: <ZZc3Tq1_Rm2v7Grn@Ansuel-xps.>
Date: Thu, 4 Jan 2024 23:55:10 +0100
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
Subject: Re: [PATCH net-next 08/10] net: dsa: qca8k: use "dev" consistently
 within qca8k_mdio_register()
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-9-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104140037.374166-9-vladimir.oltean@nxp.com>

On Thu, Jan 04, 2024 at 04:00:35PM +0200, Vladimir Oltean wrote:
> Accessed either through priv->dev or ds->dev, it is the same device
> structure. Keep a single variable which holds a reference to it, and use
> it consistently.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>


