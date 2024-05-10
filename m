Return-Path: <netdev+bounces-95457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD38C24D7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85E71F253AC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2688487BC;
	Fri, 10 May 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx3aRHRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEB2C853;
	Fri, 10 May 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344117; cv=none; b=VyefwZETBBlAiXBhZYcs+xtDEnvTJMMfj9pXixT2BPoiiO/d0rkx4euvgCkckzkCcBpBCDeZrUuJpWP5coNKxo/0U4mqHu7HiLHNuq3oFniiM9vpDB9+k5MSaK7TisKhOkfIpcMuVD6fAJ5B3Bi7k2LyygZ64e+BnussdoILKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344117; c=relaxed/simple;
	bh=wmvZz0LkD/8tTD1c8G+HvNR5R87lkoYDL7rtF5ljvxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIeKdIq0utYk1qVUGksT0XcLhWUByvYut/BIf0PDeQpxmXepAWZicH0MBa7sj3Ll4bSp1N/66DgrCxLokZtclg2jTiHJiw7u8kusBGg9IFQmwmVfZeCoX+un+67tVITLFKmRD/SetXYRyq2r88o2DBWCZ47NFhRi0OTOrhoykMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx3aRHRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67193C113CC;
	Fri, 10 May 2024 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344117;
	bh=wmvZz0LkD/8tTD1c8G+HvNR5R87lkoYDL7rtF5ljvxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yx3aRHRMm+IhSoduAs3qN3YVC2ugtmSPY/TBdn3CBrKR4rPuOkyav13QvHIgG3JnK
	 eenaN4a9Svrnu0Oe6coi2mFgbnJTqWyIO+I00sEF4GGuYBLNwpSrXs6DVV2X1IAXd3
	 3hvCERoz5jLAq3n+oa50FcX6CGJHKABhy3BqpLiUQgADnlMFVIBy+EJCszn9o39e1w
	 L3eGRXsaiZnIo4sEoGQJADdBkGyh7EB+TLJffjEsfoO5hHFL6NF4ZiC8E+znxsXLNZ
	 8KhG84TNwZFwlPwMtS0XuZh49s+KWmVipcOzEgI+OmCuCJqIsWDQPiueMr+kcrp0qd
	 0BUW/H1w3/Beg==
Date: Fri, 10 May 2024 13:28:29 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v3 1/3] net: dsa: microchip: dcb: rename IPV to
 IPM
Message-ID: <20240510122829.GV2347895@kernel.org>
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
 <20240510053828.2412516-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510053828.2412516-2-o.rempel@pengutronix.de>

On Fri, May 10, 2024 at 07:38:26AM +0200, Oleksij Rempel wrote:
> IPV is added and used term in 802.1Qci PSFP and merged into 802.1Q (from
> 802.1Q-2018) for another functions.
> 
> Even it does similar operation holding temporal priority value
> internally (as it is named), because KSZ datasheet doesn't use the term
> of IPV (Internal Priority Value) and avoiding any confusion later when
> PSFP is in the Linux world, it is better to rename IPV to IPM (Internal
> Priority Mapping).
> 
> In addition, LAN937x documentation already use IPV for 802.1Qci PSFP
> related functionality.
> 
> Suggested-by: Woojung Huh <Woojung.Huh@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Woojung Huh <woojung.huh@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


