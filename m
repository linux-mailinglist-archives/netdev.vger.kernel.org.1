Return-Path: <netdev+bounces-104654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE190DCB5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5961F23BE2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400514C58E;
	Tue, 18 Jun 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ONatoTr5"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74D210EC;
	Tue, 18 Jun 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739955; cv=none; b=lZzxnfz+QIw5PuGxOcY5pXtRyxgGHprQ0wqwvFFWuJhV0RfuQqvSuDvWxPqnx2adN0Pt1Lixmolq+oZ2TzwUYDDYPdQVeFpXG+0m1JCmWUnPj90S/CoY9Fhf0a4gXqWG9PrFTXwg+oSmPAOfCWP6fTUgG5pgoxO5Gs/6tSPKO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739955; c=relaxed/simple;
	bh=ZcyS2aedFrBTOzUQWPMBfmbdD6XfoC9oL5m2d4LzaaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+TeKloN/1KhvJBWdxazJT+YRAr/6QQd3qpzyWigQqJ2Oz3FfzKIEwrvxmSOD9cnObkH3mrxTocwWPXK2Zs5zbB6pvMX+DyUOioC2beqVE0dQaH8aRePU+raJur+a8s86IV4CDf2Kp9r68iKxVji7pPkuKUeQpWGaA97wanGOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ONatoTr5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F80860005;
	Tue, 18 Jun 2024 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718739951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuFZH3mA3heT0Lg52N52SIqXngyM9XRruerZhqmjgPE=;
	b=ONatoTr5auORsRR6M+opH/ZKTYexrJGegtk2isFpLjGtCTslOWea4YKS2AsJtgGMrEHYP5
	aSuMuN0OVU4y0eJPH7VKMncAJ4BFvrK/St6S5m8K7l7ZHbCc+QZD2+D/vuIX59wLYL8eRW
	hBa9Ibgo761ySe+01sO8cqspr/nKepWeWKLAD5Gthxv3U1fpYgT/JeVBkjUuzEu95P1CV6
	uWZo9rCiuS1aEwiIs5aNa+80q+ZDJ+Ey79UXw3Rg8LK9ceHcKUm+hf9Ek/1lq688d5EDOC
	GCjfAor9SETQsoSpGLeSIN14/lTQiir3AEN0ufnnLIe/WnBwY4xgHwVYAPXHnQ==
Message-ID: <c1417feb-d677-4e4d-bd1a-7ccb0d838630@arinc9.com>
Date: Tue, 18 Jun 2024 22:45:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: dsa: mt7530: factor out bridge
 join/leave logic
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 18/06/2024 10.17, Matthias Schiffer wrote:
> As preparation for implementing bridge port isolation, move the logic to
> add and remove bits in the port matrix into a new helper
> mt7530_update_port_member(), which is called from
> mt7530_port_bridge_join() and mt7530_port_bridge_leave().
> 
> Another part of the preparation is using dsa_port_offloads_bridge_dev()
> instead of dsa_port_offloads_bridge() to check for bridge membership, as
> we don't have a struct dsa_bridge in mt7530_port_bridge_flags().
> 
> The port matrix setting is slightly streamlined, now always first setting
> the mt7530_port's pm field and then writing the port matrix from that
> field into the hardware register, instead of duplicating the bit
> manipulation for both the struct field and the register.
> 
> mt7530_port_bridge_join() was previously using |= to update the port
> matrix with the port bitmap, which was unnecessary, as pm would only
> have the CPU port set before joining a bridge; a simple assignment can
> be used for both joining and leaving (and will also work when individual
> bits are added/removed in port_bitmap with regard to the previous port
> matrix, which is what happens with port isolation).
> 
> No functional change intended.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Great explanation, thanks a lot!

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

> ---
> 
> v2: no changes
> v3: addressed overlooked review comments:
> - Ran clang-format on the patch
> - Restored code comment
> - Extended commit message
> 
> Thanks for the clang-format pointer - last time I tried that on kernel
> code (years ago), it was rather underwhelming, but it seems it has
> improved a lot.

Cheers.
Arınç

