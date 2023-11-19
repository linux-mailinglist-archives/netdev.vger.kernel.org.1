Return-Path: <netdev+bounces-48973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAC7F03C4
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 01:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA491C208DB
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0A36C;
	Sun, 19 Nov 2023 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oATT8xp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E818367;
	Sun, 19 Nov 2023 00:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA873C433C8;
	Sun, 19 Nov 2023 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700353428;
	bh=V60ZCbQw/VscUoWlSULCrP5V5BNoqEvg6B+bmvnfU+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oATT8xp4EVfNPEIfP0BVmfLN3VIpusAJ274bozQGBStcdQLrlaK6l4he+rzSDAEk8
	 29uTWkXIVYeYF44C0egMrO3tjSyvG2Zv4eljYROYTR0YaPu3V7Ittx5Bx2mSduJOxC
	 KSUuyxs9MfJUfjLR+N7DcqzOLKy0WpjnQAEtEN+ZVMJkU5KoscdK7eXuNOOs8nvjgJ
	 MSdZ6E8mSXLpYieYylUzxh9av24FyJW8TKhLirVa9EON0pVGoDvGrmURr76CIdmbTW
	 gE7JXIW96/8jdYAR4hF9Ag8aJKc4GKQQ/0ebBaQSgTdxzOpBJPJWad+zcX9ATCAcwL
	 hnOhHWa4UnzLw==
Date: Sat, 18 Nov 2023 16:23:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231118162346.0c66226a@kernel.org>
In-Reply-To: <20231118062754.2453-4-quic_luoj@quicinc.com>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
	<20231118062754.2453-4-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 14:27:51 +0800 Luo Jie wrote:
> +		/* There are two PCSs available for QCA8084, which support the following
> +		 * interface modes.
> +		 *
> +		 * 1. PHY_INTERFACE_MODE_10G_QXGMII utilizes PCS1 for all available 4 ports,
> +		 * which is for all link speeds.
> +		 *
> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the fourth port,
> +		 * which is only for the link speed 2500M same as QCA8081.
> +		 *
> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth port,
> +		 * which is for the link speed 10M, 100M and 1000M same as QCA8081.

Wrap the comments please. 

Please use checkpatch with --max-line-length=80

