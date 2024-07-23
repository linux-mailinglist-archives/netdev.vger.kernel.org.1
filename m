Return-Path: <netdev+bounces-112622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7793A37E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9560C1F2359E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EB154BE3;
	Tue, 23 Jul 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="awQ2ya2b"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA813B599;
	Tue, 23 Jul 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747277; cv=none; b=hG2OTJTBuyYI7Hkr+b//aqFGMSO/B8LCuKgwtEy4+oZM9dXLEAZ1XJ+e61ZD25NYn7WIX8fWUbYFSRPTKo0eKqq6kjeN3JHlrgx3z6TQai1qtKEoQ8CIKjTTQlykSu1tcNlV+0o16Wiawa+i8sSY/nE3ykAMHSCh8fMTZVlsLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747277; c=relaxed/simple;
	bh=/lVStPkNk6XMmx3e7OMYCyn50o2TQ7gMZ+zwB/HKA5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sbg7YtkNWog2iLV4ipjDENYMblnSYBGQRq/Hb1N0K6klE6KMToAIW1OtHf70vFX/I6262+lieYpkgSJ5Oc4+X9rCSatHWJTXxcyeVCbotpNx2BQALmS2cCbZ9fZyuidzlfh59d36WEfv2LkO2AGh8n9ZqeFdyz382MESZnRFS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=awQ2ya2b; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721747273;
	bh=/lVStPkNk6XMmx3e7OMYCyn50o2TQ7gMZ+zwB/HKA5o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=awQ2ya2bSQM5g4rMsgBwjcHpedmVWy7S2vn4I/TlEgxgZmYVllKmGg5y/ecKYTzg4
	 VQmlGS1vEwbDLnPwgCjAsw8Qx7xjJYDMBeB4JrE4sIJcDYg/xWfYMSQk9GXlTj6dWl
	 sHi0on4OcVmNFC+fZDH77dfogZ2J8kwqHfJiEkrbSSknw2JxAQLK06Nkn4GQu1n8BD
	 +KgG6Xy4/R9SgtMJihlJve/mvtH2Bl61svU+/xRIeHLfGscvrfZx0UZcD5wZq/LTFP
	 jgK1kFazgmp2AwFucis9Ml2nLm+MKmtqx2jUHxwQu5R6IzLGsQImhpTXxGUKS7MO2i
	 aprAzUYDaCbHw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B0D637804D4;
	Tue, 23 Jul 2024 15:07:52 +0000 (UTC)
Message-ID: <207e558f-6f36-43cb-840c-7548d04d180a@collabora.com>
Date: Tue, 23 Jul 2024 17:07:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/07/24 15:04, Daniel Golle ha scritto:
> Clocks for SerDes and PHY are going to be handled by standalone drivers
> for each of those hardware components. Drop them from the Ethernet driver.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



