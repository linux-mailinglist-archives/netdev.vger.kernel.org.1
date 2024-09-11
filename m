Return-Path: <netdev+bounces-127447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA997571D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EDA2826F9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261691ABEA7;
	Wed, 11 Sep 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SLpYLMWA"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E91A3055;
	Wed, 11 Sep 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068410; cv=none; b=EDVHdvgGYlcTSo59FziLpwRPndK/Vhy1bEF0j9JB4NdE9NlXgjtojsg+rHdWvKKFMZcL/n/vrQJTP0mQV7sUguT/BrxPWHBWigDOUtrNbkqrImlCr4sXvTtZKfPssBiL5Dk3DrKRV9tUxhfFkI8pgnzzy3RLbH4mk+pp/I8q0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068410; c=relaxed/simple;
	bh=i5ZfnZIZHvNGti0+/63muvmz2AcEKBTMi/9XHRpOmg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYE4pR2tl4NuE48BACoRYKyspU6iVcMoOB4Q4TLF4aVQ9EuPobHlQHh0WiyOjPwA/00O3Kfa3HP6TIQnirdIVFAgTAs3glz2uUG2z4B726uPst0mM9giKqMCdXDT31YY2vttFUmcXW7hFJ5QpwXGXNU8VztiCo9RFq9IqcJLA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SLpYLMWA; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6516B40004;
	Wed, 11 Sep 2024 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726068405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpgSvr4q2tPSBkTFpj+s4HBz32nJx+isEIcaFhq6+1g=;
	b=SLpYLMWAeR92h3xEUOqcWOFqTxrNdVJYJkxMjLiSuIvhBRJYLvjrO7lOStxhEEa9fJSLq3
	htO3inoR412wflFnZLmifHmM7WXo13/Qy/Ci0E2P1IljdFhv6SNfc6RgLYbE+NgwaFwsI5
	Itpr6VhCfwG5pdnzKqXsRZe7c6QrTaft3OJ7wCTcDfumaUkbdU18+0RtkW7v0Doz7fcllX
	c4PUdFF5hxawRYNFVvCZ4s4Rb3rOp6hE4qPP7M/gDUcSP3FR2dU1gR4uSxbPy1oNCgsiGd
	dfuFM/vhFnAtWs5cPkxztJ9VlqwZQx7LEozHEvKOCaR+jXjNSt1raDuSlKd8wA==
Date: Wed, 11 Sep 2024 17:26:42 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com,
 ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com,
 idosch@nvidia.com, maxime.chevallier@bootlin.com, danieller@nvidia.com,
 aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
Message-ID: <20240911172642.28c7cb96@kmaincent-XPS-13-7390>
In-Reply-To: <20240911145555.318605-4-ap420073@gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
	<20240911145555.318605-4-ap420073@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 11 Sep 2024 14:55:54 +0000
Taehee Yoo <ap420073@gmail.com> wrote:

> The tcp-data-split-thresh option configures the threshold value of
> the tcp-data-split.
> If a received packet size is larger than this threshold value, a packet
> will be split into header and payload.
> The header indicates TCP header, but it depends on driver spec.
> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> FW level, affecting TCP and UDP too.
> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> it affects UDP and TCP packets.

Could you add a patch to modify the specs accordingly?
The specs are located here: Documentation/netlink/specs/ethtool.yaml
You can use ./tools/net/ynl tool and these specs to test ethtool netlink
messages.

Use this to verify that your specs update are well written.
$ make -C tools/net/ynl

> diff --git a/Documentation/networking/ethtool-netlink.rst
> b/Documentation/networking/ethtool-netlink.rst index
> ba90457b8b2d..bb74e108c8c1 100644 ---
> a/Documentation/networking/ethtool-netlink.rst +++
> b/Documentation/networking/ethtool-netlink.rst @@ -892,6 +892,7 @@ Kernel
> response contents: ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag=
 of
> RX Push mode ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX
> push buffer ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of=
 TX
> push buffer
> +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=20

It seems there is a misalignment here. You need two more '=3D=3D'

>  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable
> with @@ -927,18 +928,20 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` io=
ctl
> request.=20
>  Request contents:
> =20
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
> -  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
> -  ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
> -  ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
> -  ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
> -  ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the r=
ing
> -  ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
> -  ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
> -  ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
> -  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
> +  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
> +  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini ring
> +  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
> +  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
> +  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on t=
he
> ring
> +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data sp=
lit
> +  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
> +  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
> +  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
> +  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buff=
er
> +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=20

same here.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

