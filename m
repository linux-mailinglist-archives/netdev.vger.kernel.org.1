Return-Path: <netdev+bounces-149951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63D9E8313
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD42281B48
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32EC8F0;
	Sun,  8 Dec 2024 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdCdN099"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191693D69
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623603; cv=none; b=AsU55BvdFJaQQxtxdGgYUvITFtpxpN/UHu/Bno148h+aNGxQyK5VzD967/m3TFKhGJrsQVy/QfVGdjQJra1LU1sE5Wo5DGR2Myq0hPQfm/JvDIZhRN6KSj/NAuGSwowAcHlZG9aHAboAJhjJAjSIVURuene32b6OPv8gcjrv2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623603; c=relaxed/simple;
	bh=phA4J7Urf/68Dw0RpJi+JJphxyB5m6zoM88v/T9caSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqe4kTSOlVyvl2BNaN9yJgvdqQUjujYKLY83A5+OuchStv03YDIqMTruY22AtXRJxZ+hL9vbP1icQGoPDNq7KHexg6P5wFcGs7c6wNXA3mVH7XAZgU+ZdvJiCbmlulb9sXVbgeb2JzRJgkVliWcMJnX4Q2v03k5GdVtzDe+U2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdCdN099; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147E5C4CECD;
	Sun,  8 Dec 2024 02:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733623601;
	bh=phA4J7Urf/68Dw0RpJi+JJphxyB5m6zoM88v/T9caSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JdCdN099ZCbpqDwf9nxfilKYQA/DfbxdLKqj1O971juSoZaCSGZ0jWfe2uMev/zax
	 KZO2usmgTJF0lj65d7xuBMp7+MeiNRZOSb+G1ulBoLy6W+u1/R1EL9SiFv1BbXOSF9
	 ru014C58e3ga7pvHANexROhv0uwBTRFhl8x5rNokOfI38apdMW4Fg+NdxNAvK/btcx
	 YpdIbAsqEnuNmPxFUAf9Lm2nOyannIh/VGXosrF9aWuTd3cgoYNgK/7T9gVjPqzlCP
	 Sa0CZxI0WgbBnzg6z4hfPX4hdFVjWW0/hdQzU6TSP1ByLD2HrkLn9oJ89MpmHaZNL+
	 nuGJ/h6gdevpg==
Date: Sat, 7 Dec 2024 18:06:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Xiaoliang Yang
 <xiaoliang.yang_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH v2 net 0/5] Ocelot PTP fixes
Message-ID: <20241207180640.12da60ed@kernel.org>
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 16:55:14 +0200 Vladimir Oltean wrote:
> This is another attempt at "net: mscc: ocelot: be resilient to loss of
> PTP packets during transmission".
> https://lore.kernel.org/netdev/20241203164755.16115-1-vladimir.oltean@nxp.com/
> 
> The central change is in patch 4/5. It recovers a port from a very
> reproducible condition where previously, it would become unable to take
> any hardware TX timestamp.

Could you follow up and plumb ethtool's get_ts_stats thru DSA to this
switch? It has a counter for this sort of scenario.

