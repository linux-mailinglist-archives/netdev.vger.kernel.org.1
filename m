Return-Path: <netdev+bounces-96610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD698C6A7B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451B71C20CA2
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB8156649;
	Wed, 15 May 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAQ2knWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3815688D;
	Wed, 15 May 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790156; cv=none; b=gWgDFZvqcPxOjNy1ehZmQZb/H0cakYmiNXDGHstMIeRE+wlOll4VIzGYk2t9XYdIoCL5AK4hKwex9xNHTD/I860jMP5Q3sYlh1FErKlob6ivMD/Rxfxtlrf/C2YHQEKf3UEt7zonYzCQX/+Il36aBEEPrAqcvs6EMCiziKHbtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790156; c=relaxed/simple;
	bh=JbaUawzAtLfVLWnydG48rPnAAzX/4m7Cu4UsXoccrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmIySgrQkz4nzi1KCVPr1rncu4YPa8I+89tonXiJS8M/vKS72PHoGTjdT1n7xHqparIrlPPObgq+CNoaEVfdQdotcpCN3xrTrNp5meUiiB4Cd2zhEOyzwgw819KW2FXrt1yJkGw5PsC5eStCxQyE3wR6DU/BsbvgXEBkcMcJgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAQ2knWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69090C32786;
	Wed, 15 May 2024 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790155;
	bh=JbaUawzAtLfVLWnydG48rPnAAzX/4m7Cu4UsXoccrJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAQ2knWGGd1X9Cp8D4i+ehAwhjyHZOf4vB95CNLqelvb7Ux5QKc+SB1RpKeUOl2pv
	 Uoim0FWpLkxMSV2c7HmYFlzcZ9MUjcHPyDffszXCm2oi3k94kZ4Tb7ByxoxrI/H68M
	 /CQIlEG+09Xg6JyKMzCY3YbVKr46srN44WVDekp8B8gijP8mulbSsVfT1v9axtJn/i
	 nAQntaXmjBqH7jwPgH+pZPmjjXTU0+xvqdhMtou1iBFGSpWdJ8rpeGvrgFi+0mcVCg
	 DWlDpAGuw8a4nZZJE/SM5GIjsw68G90ds3JYi526ua0duGdWIfHsLf0WPTflbAgVbk
	 C01kRRQ3lVpIg==
Date: Wed, 15 May 2024 17:22:31 +0100
From: Simon Horman <horms@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] lan78xx: Enable 125 MHz CLK and Auto
 Speed configuration for LAN7801 if NO EEPROM is detected
Message-ID: <20240515162231.GA179178@kernel.org>
References: <20240514160201.1651627-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514160201.1651627-1-rengarajan.s@microchip.com>

On Tue, May 14, 2024 at 09:31:59PM +0530, Rengarajan S wrote:
> This patch series adds the support for 125 MHz clock, Auto speed and
> auto duplex configuration for LAN7801 in the absence of EEPROM.
> 
> Rengarajan S (2):
>   lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is
>     detected
>   lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801
>     if NO EEPROM is detected
> 
> v2
> Split the patches into 125 MHz clock support and Auto speed config
> support for LAN7801.
> v1
> Initial Commit.

Hi Rengarajan,

Thanks for the revised patches, they look good to me.

Unfortunately, net-next is currently closed for the v6.10 merge window.
Please consider reposting once net-next re-opens, after 27th May.

Also, feel free to include:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: defer



