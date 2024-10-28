Return-Path: <netdev+bounces-139584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591E9B35AB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862381C21FFD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FFB1DE4D5;
	Mon, 28 Oct 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LnDS4jMo"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF81DE2D7;
	Mon, 28 Oct 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131409; cv=none; b=PIdKn2Imf8R9cQpFOO6ZvDLKY4/xhKfMSjK1YBibX/tGi/i4eIiNVBYu6Yv0gbdZLO501Sty9QO2enC2XqQUQxpoj3YVw7/K85lZPvXdvO173KlZzoK+DlHphclSVns0NGTh0FuQpdRWGTrYqenqg4L/V05d1RdH9lyMTa0zQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131409; c=relaxed/simple;
	bh=UAtXx8qAoDQ9W+4K7wOWE4RA1ILQKmo8M8HZpFnFRl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N8FnAuX67LSeRd14xSfh1qiyoFQwn0E0L3zLgfrLE9Zn5PQUX9nJ8KkbzV0Xt1AwXYau1qVcfeRPgqaMwf7r3/Kbh+6E81U3BEpjECHqVOH0khNTKQYWGPp2li8+YQ3ZlzXHyogltHjBYWA5/4J+yNIRqhJ8Zzp53/IqrO/5rcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LnDS4jMo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730131405;
	bh=UAtXx8qAoDQ9W+4K7wOWE4RA1ILQKmo8M8HZpFnFRl4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LnDS4jMoeFC0t2aQWoYE+GGV+R+znjtyR+I4fqlUdFzXDENxMbydGAO+2AYQ6JujI
	 Nrus3ld2aPMBWrL5IK+hiwv9Tnf+UHNun5BVByxU/cV+zj0JHd0Hw+j9vvSTrxXdpT
	 d2OpMK9x5FqyOO43J5pNqMvU76QPmJPNVnHEWVlfvD5vjgwMzGoj5CxXAyAw8KqGG8
	 dH2YpEjOQA6U6uk1o8H1U8pU6CiS27rQp8orw6Y5FsVx1PmRQl+mpNz/h5l/vmGvAu
	 MiiioBuJJugeblyO4DOgrLb4dM9hYf4Me0vc8rapDwJf+qj6lFA7V7oEdt7pAo5Dka
	 KOIOWXVeIi8hA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95C2517E3662;
	Mon, 28 Oct 2024 17:03:24 +0100 (CET)
Message-ID: <45d10ac1-6c00-47a2-8024-ab97ebe6a6bc@collabora.com>
Date: Mon, 28 Oct 2024 17:03:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix path of MT7988 WO
 firmware
To: Daniel Golle <daniel@makrotopia.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Sujuan Chen <sujuan.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>
References: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/10/24 15:52, Daniel Golle ha scritto:
> linux-firmware commit 808cba84 ("mtk_wed: add firmware for mt7988
> Wireless Ethernet Dispatcher") added mt7988_wo_{0,1}.bin in the
> 'mediatek/mt7988' directory while driver current expects the files in
> the 'mediatek' directory.
> 
> Change path in the driver header now that the firmware has been added.
> 
> Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



