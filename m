Return-Path: <netdev+bounces-42726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123357CFFA4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430DA1C20AD9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F8225B0;
	Thu, 19 Oct 2023 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbgzK5ab"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173432C6F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:31:14 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FC11B;
	Thu, 19 Oct 2023 09:31:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99de884ad25so1315072266b.3;
        Thu, 19 Oct 2023 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733071; x=1698337871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTZAr1cnfcoGHNUrr43ZLEwZz1lO4sl0DD9HhHYRkpE=;
        b=MbgzK5ab2GON3hXlJVCrmpz+KjVM1UiDGlj5G140HWBeaO37rQL1Z3Y7UrQtoSg7d7
         2WtQSjJMFg5epfs2FXl5AqMnOY4h50Gpp18Islbjxru1fhNoboIEK8Jbm9r0nFDFoIZI
         EbcDps1BuW2/VuaVUX0AgiiKaZ05+bD/Zxlzx5AMjjEV2wsnSObNODLl/LqEenJ5QS9y
         MB0t4hy8rzq1CtrDP2GPSMOeKQ+okUWe25ooBy5GAbxXF1J2XeRNisVPcColKtbb7BAS
         ntyXGO735U8JkTfSCpw7AXoipyyQn0tXLRBXexBFJpUIKfS2lJLFAkB5DPrRR1Knq9DG
         PywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733071; x=1698337871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTZAr1cnfcoGHNUrr43ZLEwZz1lO4sl0DD9HhHYRkpE=;
        b=E46pxvgUpt+tbzQxpZqJ5Cx6pbZ0CZo/fLhuMzA1hvYaQcTx+rn2iV4uf7kaGF772o
         VsDDX4LQrV/Fr0+UtPaVg5YjjIIW2ry6K1Mi8biP1Vy7e5AoAbe0UP4fHlAVQ6t9nV5x
         FhyeQbdCZ089K4CazbRgJrAqoPDxqUv8Ca1TKSNzLVzue6i+wCaxXJUTFBpjmWlgT7j1
         ubaWvwBlg+ZkEe2cW/jXezvat8KdaSakuOJv4y5PbR3tSoXqxXwwy7gkb6cGvLSnzeNS
         Z5gr25dcvXsirc4AlHk+yqEWdRYT6nN95kiSkC1cPgu7gLObI9ej2ZR++f3GyfVPN2zW
         iM1Q==
X-Gm-Message-State: AOJu0YxDxM+mq3AsiYQWeuNv8QeO0QrqguS9u9Ap3NP7k/EorsV/4Le7
	Vujj22bZKhvyIqqIV2ujQVA=
X-Google-Smtp-Source: AGHT+IHu4NX4lTfVYW5Mc3XTdZI8TznH+5TA81ijmWPdSqxoQbU+d9tL9ZQR3ziKCl2fRpT1Q3uopA==
X-Received: by 2002:a17:907:320d:b0:9c3:70d5:dc57 with SMTP id xg13-20020a170907320d00b009c370d5dc57mr2321101ejb.40.1697733071264;
        Thu, 19 Oct 2023 09:31:11 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id c9-20020a170906528900b009b28ad521f4sm3879943ejm.4.2023.10.19.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:31:10 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:31:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v3 1/2] net: dsa: microchip: ksz8: Enable MIIM
 PHY Control reg access
Message-ID: <20231019163108.h3acqb7dhqswscpj@skbuf>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
 <20231019111459.1000218-1-o.rempel@pengutronix.de>
 <20231019111459.1000218-2-o.rempel@pengutronix.de>
 <20231019111459.1000218-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019111459.1000218-2-o.rempel@pengutronix.de>
 <20231019111459.1000218-2-o.rempel@pengutronix.de>

On Thu, Oct 19, 2023 at 01:14:58PM +0200, Oleksij Rempel wrote:
> Provide access to MIIM PHY Control register (Reg. 31) through
> ksz8_r_phy_ctrl() and ksz8_w_phy_ctrl() functions. Necessary for
> upcoming micrel.c patch to address forced link mode configuration.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202310112224.iYgvjBUy-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>

These tags do not age well if you add them in response to a kbuild robot
notification on a previous, unmerged version of the same patch. They are
for when the patch gets accepted with issues.

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

