Return-Path: <netdev+bounces-171850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92065A4F1A3
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7F43A693A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C2200B95;
	Tue,  4 Mar 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="VlYuS0Sb"
X-Original-To: netdev@vger.kernel.org
Received: from camel.cherry.relay.mailchannels.net (camel.cherry.relay.mailchannels.net [23.83.223.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AA1FAC40;
	Tue,  4 Mar 2025 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131398; cv=pass; b=I2jKsZ8jVeRm6Ojhq/WCnX5dp0idWhO3gOR45zGeVoYd268I7OcaiUfDbTpGLjWuaVqLGpLu1cCaop0vFGiOxXTfyX4Vdn5EQc3ILqLqUjUKptQhHPwl1AQo8u7CKlX9DJL2ioTpu2VDT7nSrxiWyiOi8HU4LqmaouDKfEIupAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131398; c=relaxed/simple;
	bh=au4ZHHjqyU6in8xgr/VtU+7ORsPZNbiGMQowSls/TzI=;
	h=Message-ID:MIME-Version:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=iu1PvXcXePXx87gK5fCqBWRqUBxvxLbZPFUiTjx0O9BU9rA3KiXGB/mkn8zBJjuyhVcLGH7IqJMKxxD5FlzvSkMv3gNX9BZmDZe+7JsCbhcM7lSnf8A3DcsrHWPCprGdIYxnN2/7P5IkpZK3PHvLagzrQ0Y/DlwIcAVp21QR/y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=VlYuS0Sb; arc=pass smtp.client-ip=23.83.223.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E9A30782DBC;
	Tue,  4 Mar 2025 17:57:31 +0000 (UTC)
Received: from nl-srv-smtpout1.hostinger.io (100-105-75-112.trex-nlb.outbound.svc.cluster.local [100.105.75.112])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6E6FD7821D7;
	Tue,  4 Mar 2025 17:57:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741111051; a=rsa-sha256;
	cv=none;
	b=4kIyyYpRo4F2Zo5ZlP8/25GUpSfkqmS+oB+5jUpQpJ56D20fMZdK+bbp5UQ9HwrtmajeVC
	Pm9vOeQq+N92OPjYAOdyC8pwCzkfJBH+ZMP5LUrt4mEw62hubi2yLs08xBPUKpU4cjxlpW
	lnD6ecc6UZg+vlldEjcvql/Tmmffo6FHf+z7fgu+fto90pDpJ/FpjsOtkDqBiYuLaVqJp3
	oWQpATvb0+AcrY5n66p3LUxeK2efh7YXUFGYV7u2s9R54zKjDhOV3GeTwW+XCZuu8lGV7a
	x4ZwsnHKrwK/uvCRwf6JKM3tIp4SammQwTIPU8uHACMGSjYxlf+2G6wqqL8YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741111051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uHrANchvNJ+aKAH+dxKPt87xl9/ANWKJQ/Jgn87Orgg=;
	b=voRx0J38LeQaH0gsL85SbJCNy8ycVN24s+g1aYkTYvUurNZsLSeKjupQxWnzBUA0a8jPo4
	vy8pnYIivlUhJBd+wJem3XJOTLwQTR1S3dzhWQzNhd7+nf0cBcjCaTY2rENhtedQNnC8Wf
	m2cvs5vbjzuRWWV5AlIX0sQrhgdfifijhdnW+RibhkG1hLBBd/GLoUPoWS7m1iLiUltUr9
	Ab8sSfDmGFLuj4Xii1A9rogqmhKfACkTHsu7KNmwTTMVba2/TBxGPB7IHGxiE6Od9jYJbU
	NvfuO50AwVj4cVSywytMM90+O7Bn2dlSyxXXu3+Jvh4VuGiSpDh4OlcentC4iQ==
ARC-Authentication-Results: i=1;
	rspamd-5c7b96f5b9-lglkd;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Bad
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-White-Snatch: 6ac490ef0cad969d_1741111051802_1907771754
X-MC-Loop-Signature: 1741111051802:3446199483
X-MC-Ingress-Time: 1741111051801
Received: from nl-srv-smtpout1.hostinger.io (nl-srv-smtpout1.hostinger.io
 [145.14.150.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.75.112 (trex/7.0.2);
	Tue, 04 Mar 2025 17:57:31 +0000
Received: from [10.10.10.229] (unknown [109.228.249.111])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4Z6k0h58rHz35BGt;
	Tue, 04 Mar 2025 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1741111046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHrANchvNJ+aKAH+dxKPt87xl9/ANWKJQ/Jgn87Orgg=;
	b=VlYuS0SbjdEYQjhRibRf6Btba4juCqtPMunmxKouR4Yq5vxsZFsVzW8LiHjC5qAtmXv+cj
	qrddsjbnsb4qC4xveJq9FJfx4vhyVSteYj+MqzipcyB0b100MGUNZCgDaj3TBnz5fpaK+n
	cXFg980zguMAAwaprVd9If9Z5GoY8U+TApHzvoju8j7PuH4Eh+355LTjb0Hs7DwpaaypVT
	eEpy0YRY+8y18Uwpy7jnAoTx/XDQJhfB+1iUGQUjXsDF5cnw0jCncOiTbV4AQ1ZXMFpv7l
	nGTbvvqmF3gDE/+E7FlD267gIbSjlHWs/GbBibxlIH/bAHmbbZi/cde/E6A11A==
Message-ID: <411daae4-0cf6-4e47-9a38-0fe46cf2825c@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dsa: mt7530: Utilize REGMAP_IRQ for interrupt
 handling
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, John Crispin <john@phrozen.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <221013c3530b61504599e285c341a993f6188f00.1740792674.git.daniel@makrotopia.org>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <221013c3530b61504599e285c341a993f6188f00.1740792674.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Mar 2025 17:57:24 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=F4sFdbhN c=0 sm=1 tr=0 ts=67c73f06 p=VT4XjZGOAAAA:8 a=DLgUjxyaX94o89xnTiwHMQ==:117 a=DLgUjxyaX94o89xnTiwHMQ==:17 a=IkcTkHD0fZMA:10
X-CM-Envelope: MS4xfD7S7/gD50VTE/59nwPF/2oV/M3GLXLr6H55NKCDhTFqO+648U8qru2NN9sYDvCLk7Q60Q+9pBkIIp+dNir+Sq6xHl5eEuzwqPFqknqQ32b1xURDDOLW id8NvcuXj9UmMklo4HRP9kR8OpLqlKMf0LWhusUgxQxX3t4VdoDMR8mAWMctBZY1BKATqFcPLSlpB6ypsDNQxsbx2su/hhlWaCr/qKjg3rjbMPi3VQp2cogm dDv9ApnrR/K7zBtFslgXga7Ofq3aW8SFD6QPVQBqld6eBI9JXGEObdiKDO0BE2wxIlQZVGtgMVn/k9e6XuaT26BA/JYKGfnViM/NPkeXA6snaG7iAFO+6R8j HSkoK65c24SlQUfPDYy9Us0msyGIJz8L/AmG0opbxRFmXIlc4AgcYuP/iEDTMGLtYjks71uumOjp0Hrne9vXpgUnRXaNumqG7NymEs5IdKxNwRQuiEVgueMm 0XesZ5FFHKX734zrxglNevX08q0FmJCnyoM5bCP7FawPxPBj1WASC1yzxjAIQq0f7KSWGdPLBfNWjPYrDH5FVHh8XvAV9aWAm8VRe3OLj9OH12thVmv2t28Q jVIUd5Q8FNOrJz4ZgcGqQ3NxNOEf8q2DfEDkhjlsAHJOIZrqKQZnqpiYkbou71uR1wU4CGxFlFz6SeUjo/n1tRZas/9RKyG1F0m4oaiH0fNRBNAHlIc1vERU I8t3G8VATzsNgHtKjkojJniz8F29Cl6fUFqXRlz2ESAzghJJBqMexUddzzj5FXRMNaZbJAWZV3r6qyRXGSd8KlbbaOpmjLXGNNxgxNOuXQYY4e/REeOvgWEp 7FxtfLIZq4xokYW0dgE=
X-AuthUser: chester.a.unal@arinc9.com

On 01/03/2025 01:41, Daniel Golle wrote:
> Replace the custom IRQ chip handler and mask/unmask functions with
> REGMAP_IRQ. This significantly simplifies the code and allows for the
> removal of almost all interrupt-related functions from mt7530.c.
> 
> Tested on MT7988A built-in switch (MMIO) as well as MT7531AE IC (MDIO).
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

Chester A.

