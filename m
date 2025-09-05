Return-Path: <netdev+bounces-220271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF799B451CC
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D139F7AD6A2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B327C17E;
	Fri,  5 Sep 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYjYyqiB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92A277C8D;
	Fri,  5 Sep 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061624; cv=none; b=iDD46/WQhAlLGF9GVHXn3JVocLjZgzJpDEG1gxgk53mQSRjb7JACwNAAJtJXC4YUC6eAVJ5ZGlYTrkimHT7Yfr60EdIgEPQBb7TKiJgf5oUTqkKnKge/jwOih7hnlOkwO3yHvWIaLB59nsaJOXccsFMGNboveefWJE0T8km6Lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061624; c=relaxed/simple;
	bh=3m+oHss1dKrtRtNm486Neak4ylKeTSNpjIilPQVti1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyA+q+7hD8fpE7Wt55wdp8tycyFtGeMstb1afz6fl6wuqtX1qmdzF2p5dHI/laMf9RzB+0K4pcPyhGFPeSsa5bN8/Cu9hnXuFeWbXhAJXnLwEXWejOdt0gwh273TJ/Jyd20H6MvJ+gUe6ZYJ+lDWaKXQv8lSNzlj7Mu3k8yzG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYjYyqiB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757061620;
	bh=3m+oHss1dKrtRtNm486Neak4ylKeTSNpjIilPQVti1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iYjYyqiBw3VN83ZDXH0u7pPq2RjuqgaHuV2aLml3n+Abym3tZvm34XbcHvIrjFC7n
	 bz1P6HCVIHHnZb5zGSQM7vw9I0hidUrgJ7ZLTY2nfKpRArfUzDkPA96/IbYNP3AOhS
	 1iz1ciE0htqvuhGs1QsnQPSKDmMsFOEGdLwXbcWgaYFw1Zfiqu70STZ2YizK2OmHPV
	 WuS5mKUbs526qegmqr8uco9wm/95zmypPFblo9YMZYryuA8KfNwx1JxIs7eDsDjXDY
	 1Cd4p5CMrQXteBA88tFstDk8bDQHXYa2qiss3CaOnr+HvLCfxLkjFYPTGpQsrhRWwI
	 WRcZkAxG3KGow==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3615217E0E20;
	Fri,  5 Sep 2025 10:40:20 +0200 (CEST)
Message-ID: <c044f5af-5087-41fc-b459-08f0a954678f@collabora.com>
Date: Fri, 5 Sep 2025 10:40:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/27] clk: mediatek: Add MT8196 disp1 clock support
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-23-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829091913.131528-23-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:19, Laura Nao ha scritto:
> Add support for the MT8196 disp1 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the disp1 clock driver via
> platform_device_register_data().
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



