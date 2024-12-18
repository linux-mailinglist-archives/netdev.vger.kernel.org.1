Return-Path: <netdev+bounces-152812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BB9F5D50
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D581B16F42C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF9126F1E;
	Wed, 18 Dec 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVaxJ6vN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6835956;
	Wed, 18 Dec 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491656; cv=none; b=jtQlLU/TBtumgeu+ZhOjGRLYO0Ju4RKDJCKzcYC5ibPoiA7X3AXgX8c3Z1TK03sofH7M1fdasWRytanyb0mrAwLH9Ft7d9IbAtoyTDbJS5CH5jnwlc0sB6ExuLUgS6CYnjOkQ87obZxGJgvfYwTbuCvEb8kL+5FGYs+GWFmWk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491656; c=relaxed/simple;
	bh=DhMX2LikUFBfcQqYrJllCJfB9eVq7t98QaAhmecP/Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyYFH2IQJ2doqk7/PB2V4FUMo5EverV3CSFAOIpI38Bbg2OAIzfE0axWSHIr9Xn+YuxAQLNe6EsD6BVSPGioTDPIZZ8wHGYrQi6pWkmCnvAahzqDQ43aFpZ8jWJha1DER6tsZiourKhAjrQkB/OI8jlEje9fIY+F9qaDSZ8pXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVaxJ6vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A873C4CED3;
	Wed, 18 Dec 2024 03:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734491656;
	bh=DhMX2LikUFBfcQqYrJllCJfB9eVq7t98QaAhmecP/Rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gVaxJ6vNAEcFugvtcTDFgmpuPuYgxi+60UiDIWV7NF3qCYObBqi2pMjuGf+jBNehh
	 q8n5feMv/dT0cTgpK7hJe9Xa90ZfN8RvPyM07p0G74FIOfQJY4WMlon3343pPY0jx4
	 DrgXQrP9+ge1oIbuiFm/093VWFybQ1DF+/ZG6nSJS8CRJnL6keB4iyy/ggvZs1LSW8
	 FN9r0SGIzeYHRKDloQWQ7q/6voGpLwwKpRZYKCC/VfUg7tTtzX00AdutYy94JNNKhr
	 qSQUj2kpcmUSkMq3c2uE41FOnT81BgsdG3tuNp/X41hkU+nQfb6QKdKpvK6X3Tvcst
	 B9tMbNgimzTIA==
Date: Tue, 17 Dec 2024 19:14:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v7 3/5] net: phy: Kconfig: Add rds ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <20241217191414.4d4490cf@kernel.org>
In-Reply-To: <20241213121403.29687-4-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-4-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:44:01 +0530 Divya Koppera wrote:
>  config MICROCHIP_T1_PHY
>  	tristate "Microchip T1 PHYs"
> +	select MICROCHIP_PHY_RDS_PTP if NETWORK_PHY_TIMESTAMPING && \
> +				  PTP_1588_CLOCK_OPTIONAL
>  	help
> -	  Supports the LAN87XX PHYs.
> +	  Supports the LAN8XXX PHYs.
> +
> +config MICROCHIP_PHY_RDS_PTP
> +	tristate "Microchip PHY RDS PTP"

Since you're selecting this symbol you can hide it from the user.
Remove the string after tristate.

