Return-Path: <netdev+bounces-171552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29CA4D95D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E123B7025
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78B1FC7DF;
	Tue,  4 Mar 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="O3QbHPIr"
X-Original-To: netdev@vger.kernel.org
Received: from bactrian.tulip.relay.mailchannels.net (bactrian.tulip.relay.mailchannels.net [23.83.218.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA646481C4
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081620; cv=pass; b=t573y/Ca71pdPoA7wgyc6jb/IbuVf8ndF+i9lymUlQ75oSicDrRvnjNVbkE1yBYmrWGN/5QBcY1BU2+4XuyJSqd6AQqtz21JbsT3I5x1Ie3bATV+fD+QvW2Cg/8PrU2zXtD6EZ1q78URFtEbm6ID9NMR4dBScQfr+KhzT8A7cBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081620; c=relaxed/simple;
	bh=+r8TFsquWm3u90sZ2XVyWKCsWfP3h3k6rMBbkAsqNi8=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=E+7hq5o2JfFsINfpg+e38l+KLci7P1uZtXvcbsNlVaGwBEclFrp1/m1lPA5rksvE4LJIjobsNfb5AXsM34Lu0b6YNGeZ4wZE2EAqR8FJZC54wDtrWOmazigS8JL5LB79EntK/rBsNXgTmXFQmU4eg1bJxTJny+mXF4apnNUFYzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=O3QbHPIr; arc=pass smtp.client-ip=23.83.218.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1B9A78C3E29;
	Tue,  4 Mar 2025 09:46:57 +0000 (UTC)
Received: from nl-srv-smtpout1.hostinger.io (trex-8.trex.outbound.svc.cluster.local [100.101.191.136])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E7C588C3ACC;
	Tue,  4 Mar 2025 09:46:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741081616; a=rsa-sha256;
	cv=none;
	b=af7eV8eu4Ky/VzUdDADBUxjgxKKKs7u3q1Ev7az2ONYZp4OxvPhkZo6tgrdIRJd2itYF0h
	zrPfYU4JGa9mxZneKMiCPXRlWWtEowsV6wH5Si0VGLw+oZi3ot6njAU15PiHufC0VB3FtT
	CGaPVd/WJS6koZnsxf/xUIASrxiJf/+dWTK8OaQtu7mR6vx7DM9wfO2KfZDoYvH1v4A3Up
	/9oMWljF+mmEFKPrTA+ApQHX9ORnLDQDRBWMhjGdM/Nj91Oe6hFssniYCG6IjYPwnGraWb
	itnZqmA1/OyXlms4EQfS2aBktOWTzdwlWvDmeBLyMy2OllmPfIHM7p1uTLbjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741081616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D5t4LO5iZc4495dyi2ppzMU1jd7cqzfUiUSRCJpWlCU=;
	b=GiAtfS43kFwoJr/tRcZ9Zn8Pz6XjVCRaYleWaTx2nTh0ioce/VASeJBkMXIWwtcNX9c1tF
	vl8L1WEnDQuedsCyjqTv9cInWgcUbOI8k+jkuJaxabNhxKBOKUtDHWFu5SN3a1LzORLcVS
	3B5Rpu8xmYavOQmb2Hhq1dXqdjHebCJHaDedcM0rDOgNK8FIfU+2bVB2fJ81Uz2wcGHbY2
	MOz/fWFXHp9eFhvmv5khRrJBUNhIziGHOwk86F2ewRbT2okKv3aQAlrPOVNBHHEguDeh9A
	kliPmYOC9yQKc2Yiuxe4I2mjciRPRxjwV0z25+ZNMb0M5ouB5a7gM7qjadpMjg==
ARC-Authentication-Results: i=1;
	rspamd-58748c789d-w6rjb;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Bad
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Slimy-Shoe: 19d76dbe66a13cec_1741081616908_3888167419
X-MC-Loop-Signature: 1741081616908:8098079
X-MC-Ingress-Time: 1741081616908
Received: from nl-srv-smtpout1.hostinger.io (nl-srv-smtpout1.hostinger.io
 [145.14.150.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.191.136 (trex/7.0.2);
	Tue, 04 Mar 2025 09:46:56 +0000
Received: from [10.9.32.97] (unknown [185.182.236.36])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4Z6W6D2wtsz35BH3;
	Tue, 04 Mar 2025 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1741081590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5t4LO5iZc4495dyi2ppzMU1jd7cqzfUiUSRCJpWlCU=;
	b=O3QbHPIru7AnlxKZ0j2JcvM0aDko5YyybmfATwJ7W6Uyy0cYcrQ0Ay3i69qGkiy1nlWaYc
	1hWpE1a3EaybroRWRfsrOnJnL6kBJ6z5gCnUTJHTMxKVrs9DSkj0iBLAG6y/MkrZuhftMJ
	R++VBdvY03avb4Esfcfg4EWVS0Nn2MnBWTT9KcJruUXjzKOwRs6863OXMnuPxIeELxq0J0
	ZuyG6OlYYkt8NLFn3abG5liwj1OZXhB6AGl2oZgaPbYXoVwpo8/YhNSXLrv/Fg1wtRf7pP
	V8vuI1Pvaxpb3sOMYi/9mm1f2h85PsbKQa10PHLAk6fSnYDG31414GFXiFez+w==
Message-ID: <b63fcbaa-ef27-48a9-885c-7962bd92a8b9@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: Fix traffic flooding for MMIO
 devices
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250304-mt7988-flooding-fix-v1-1-905523ae83e9@kernel.org>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <20250304-mt7988-flooding-fix-v1-1-905523ae83e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Mar 2025 09:46:28 +0000 (UTC)
X-CM-Envelope: MS4xfAak46EaWbKlaQAOOnK1fi3wYW/2+4l5aFepSvjx8uGgOA14qId//toYZLzeR8I+fViXYRlIlNrSjhVYMS07D3LEvzQpZSwyrxo5G9Gty/xvDUy3QReb 81z8mlUhj8RTJim8GAvhYmM6/pF4WuB98DsIwesDXLY0yHpEm/E4voVX2sYx/kRelHjE5ZBFitzVbCH6SbiW/rCQx6pIvy7WNTLecRcB4gK5PUnSvp6bgpI5 Vp8PZG773xMy9cwJSctfC0mHiuA7qSvV+toWfGyhQLx+BXpppAfLFYedocznA8KwlosasXFjoGihBHj2golKcOv0nfcU2dXferx/0xfaoGPlOcIKt7iabktN iA1sFATs9WZO9x3kSxeA8u0HpQbsPUk8JwvXAz/4qP7BTX5Kr6VPd7QoCEyK4d4jZfNG0kpgp9o9ch5t7YboX4IuSr2wCc7FVXkHFFM9wOnRdkfCqygd7Nes qmYirDGRadJL+OcTKysDx4Lkurf/dh8sR6T8eOa4D+633H0+QKjbxlbzKZyIzmaupWPgrbUydGKr3k0sgbv3j5wXbcJRhsyLqW/MOEHYH9wtACwUpPEkJCzM 0lOjmmauEwkKUWVjJhNGMxlojrEdw/Ov4DaRFHwbM0JHZmROfNaKWCZGkZae/Ku8PGSFRroLVy2cTdn+llFe4d+Ok3ttmbSFd85rV+z4OsljPg==
X-CM-Analysis: v=2.4 cv=F4sFdbhN c=1 sm=1 tr=0 ts=67c6cbf6 a=jLKKKTx0pIsUXH9Z8yxYVg==:117 a=jLKKKTx0pIsUXH9Z8yxYVg==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=GvHEsTVZAAAA:8 a=oMYzIxOzatuwx5kPrsYA:9 a=QEXdDO2ut3YA:10 a=aajZ2D0djhd3YR65f-bR:22
X-AuthUser: chester.a.unal@arinc9.com

On 04/03/2025 08:50, Lorenzo Bianconi wrote:
> On MMIO devices (e.g. MT7988 or EN7581) unicast traffic received on lanX
> port is flooded on all other user ports if the DSA switch is configured
> without VLAN support since PORT_MATRIX in PCR regs contains all user
> ports. Similar to MDIO devices (e.g. MT7530 and MT7531) fix the issue
> defining default VLAN-ID 0 for MT7530 MMIO devices.
> 
> Fixes: 110c18bfed414 ("net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I was suspecting of this for a while. Thanks for addressing it.

Reviewed-by: Chester A. Unal <chester.a.unal@arinc9.com>

Chester A.

