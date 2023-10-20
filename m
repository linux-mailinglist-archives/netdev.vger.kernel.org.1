Return-Path: <netdev+bounces-43043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98C7D11B0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B75B2821CB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BF33EE;
	Fri, 20 Oct 2023 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTQMGTIz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0861DA20;
	Fri, 20 Oct 2023 14:38:05 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9B114;
	Fri, 20 Oct 2023 07:38:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso1326716a12.1;
        Fri, 20 Oct 2023 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697812682; x=1698417482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjBwNWpR8uoTt7yL2JwXrNyMkZDaAsBp9vs5MsXaXcU=;
        b=OTQMGTIzrAWeHA4Fbnq8BJzSAj/+kqztQ30eJsy63bozcry7GpvrrjUqYhj6ouDcRi
         WP/YTCeXDcoNhN1hyyyw96eh+aXJfNpEJzAUH+F6/7TgtXHiXL0F8gaADmmCqjSk2XHK
         e8PKsOwW9q6e5r8KDLdegvnr5faM5GT7MXlGZU0ZxG/bzbRFPmXg4brl9g0kEwuNMpb/
         cCDYlYgRUJ/KMGmqb3Jm8P/Xt11rwxgRF4rFFF4uXjFAm+3P9caVFc9TIpNaSSG9uajR
         qFq9xUy9vTRcf6V5BqxWvnCT081TwyklRR+MBNDw7hthsqX/OguyWvpFvfcWpGuKwTRu
         L2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697812682; x=1698417482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjBwNWpR8uoTt7yL2JwXrNyMkZDaAsBp9vs5MsXaXcU=;
        b=slkk5MMg3mFxzVB88eyHLg5ob0MUrOYfBAOFGiYNqWPUwcqax/3EgdFnkJy/MR+TGb
         M+3jsHo99xuKdJKrR18VNCMfn0GsYPygDsSTa6aUUUpEaj8yt2ICpI83RLyQHS7HRvJ2
         KU481Zuf+npoNDX363I6QUhepezKNSTN7GWnJw7VsaIEZPVztz74iNp5gGKiHm/hW/MF
         GXxvGK13O65+PKGH54kyCewYEm4uorzM4xRP+Ipnc/Qk+d0BgtEnwzOZQdYs4tu4ZLEt
         beZV0LMvFd1LmlyzAoAWvcsekTZC0oWvUOgPvMkz4QChXurPoodOCqxGIk2w+CY+yg0V
         BtXw==
X-Gm-Message-State: AOJu0Yz4EDwdfpOPrE1R9AaUsFhk3equDDsIE2MJ//GvwvEQF/HJODz6
	o7HF6GO2SK+pZi+nH1/aTxQ=
X-Google-Smtp-Source: AGHT+IGA0b+ydD3hEt71z4EGORuauwp8TxwlVz6PlNd2I2R0WB/SsXZ0sj01ayHkYrvI0lmhAD/rPQ==
X-Received: by 2002:a05:6402:518e:b0:53e:332e:3e03 with SMTP id q14-20020a056402518e00b0053e332e3e03mr1923675edd.4.1697812682378;
        Fri, 20 Oct 2023 07:38:02 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id s14-20020a05640217ce00b0053e625da9absm1565214edy.41.2023.10.20.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:38:02 -0700 (PDT)
Date: Fri, 20 Oct 2023 17:37:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	o.rempel@pengutronix.de
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: add property to
 select internal RMII reference clock
Message-ID: <20231020143759.eknrcfbztrc543mm@skbuf>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
 <492ba34018bd5035bcc33402746df121df172f73.1697811160.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492ba34018bd5035bcc33402746df121df172f73.1697811160.git.ante.knezic@helmholz.de>

On Fri, Oct 20, 2023 at 04:25:04PM +0200, Ante Knezic wrote:
> +static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
> +{
> +	bool rmii_clk_internal;
> +
> +	if (!ksz_is_ksz88x3(dev))
> +		return;
> +
> +	rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
> +						  "microchip,rmii-clk-internal");
> +
> +	ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
> +		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
> +}

Sorry, I didn't realize on v3 that you didn't completely apply my
feedback on v2. Can "microchip,rmii-clk-internal" be a port device tree
property? You have indeed moved its parsing to port code, but it is
still located directly under the switch node in the device tree.

I'm thinking that if this property was also applicable to other switches
with multiple RMII ports, the setting would be per port rather than global.

