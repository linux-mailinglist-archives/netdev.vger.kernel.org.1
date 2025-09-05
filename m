Return-Path: <netdev+bounces-220272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29133B451C4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C3B1C82AF5
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA227CCE2;
	Fri,  5 Sep 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jLAzdPzV"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B699229B2E;
	Fri,  5 Sep 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061666; cv=none; b=JqvHWYXY0G1HILL+r/Um5Wg/CvllZODCCwIrrKuX8Vjq1T02yUfXYu6WWHqIK6+cJ7FfTBuu9zYhkP1jjp6vE22v4K2sIpCJYgsGC7Zxqf0bcYbhTClB8+2e47z4xljV7V6faXNEJ0jI/Cwb2Z0Hsqg7eIzTWjc90ByD1Jl91kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061666; c=relaxed/simple;
	bh=0ZLjfCgKTzkozbgbd8XMdFHbNJtpQPMF/G3+eXv83Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu7t/gJdOyTjIkpDm4ABCuhw/QjfGF5OlNsP7FUv0EwSMbKCLf8wYwstiDyg5VnfLb87BjdIwNJIzhldSrlW/3QpoWcXkydPSjGjH3Lswkesm8tBkwkgqx6lateynfphiIZt8ZDOTWM99y8vAOQjfFT1pWCL6Vxmmbf89/K5VRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jLAzdPzV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757061621;
	bh=0ZLjfCgKTzkozbgbd8XMdFHbNJtpQPMF/G3+eXv83Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jLAzdPzV2aXY044w5Se65gc002FZnkX5GP0OcEZBizFhx64QUSMbaZFFfkpIloE6m
	 PaXwFQNwT985zicojzEdy4oFTVf29K64oQVqPQrzCl2SaXLjKX/jRBTvgCCOHRRe2V
	 CqHo6zu1ELGT1ZQEw30jg9jAsINbSLd/WPekZ3bFWpGLbIIjW/Y+uQTTBMkh2eHr4t
	 kUz38aE/GHGKqbgQXfkNLj1N0Ez7mL5eFOGcx2+9DgxWqSx1l7YXEJU9H6KApRjWWH
	 LXThhsVTqyB0BNld+n8KOu/+gtJAovwCEQ1cgQ+RCKJAhL971pN1t5TYxfWQzaicax
	 5eTR/qdcQyiwA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 329D317E0EB8;
	Fri,  5 Sep 2025 10:40:21 +0200 (CEST)
Message-ID: <649362e6-5743-4cfa-ad9f-6b828540ea78@collabora.com>
Date: Fri, 5 Sep 2025 10:40:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/27] clk: mediatek: Add MT8196 ufssys clock support
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-16-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829091913.131528-16-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:19, Laura Nao ha scritto:
> Add support for the MT8196 ufssys clock controller, which provides clock
> gate control for UFS.
> 
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



