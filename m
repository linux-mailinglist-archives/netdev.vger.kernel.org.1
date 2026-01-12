Return-Path: <netdev+bounces-249023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25651D12CDF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14420300253B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808021CA02;
	Mon, 12 Jan 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pRuPEFht"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CC1EEA3C;
	Mon, 12 Jan 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224613; cv=none; b=UydgyLmiecJK9MjjdIct/UuDWi2lq757iWUEDdA1GSQPKReXf3jmjmgbBFGmMg5JJb1E+36fljLDH+IsJStRrsuj+KS0Ir23vmP1Ig+f6Pw/KP0z2rBMoDv6gO7ZAl+fr5mhxT8h1iWw+lQRy9YWNk8qp/S07b3zyHKHIbZV/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224613; c=relaxed/simple;
	bh=bQ7Kcy9ixF5o6sO8BCPeFyQgEI8iOT3N0Bp+vysVJxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z74QMXQmnuRabFqJqe8kOznatmDdrv+jdUM7RCZLjaN7Eonspj4hFilk7H8IqsbuBK1kuWSeDXLlq6tnNptA42Py2ykjMJo5efF1VQIGdx8+PIgFE3vcQEOTtco2A4t4EnZ5ALCvuqHxNH5xir1QIKKOv8dy7RMVTi+0zx6Nkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pRuPEFht; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fsJh8E8UiJycX/1KxA58q5x+ZruCt4gSs5ZQlOLdQ4c=; b=pRuPEFht0wctbrxahkRQ8mXek4
	zjWENWO8/oFBWF4txBJSSIi3//MpC4LQhV6ass8io8xmHGNaW6krvBN0INt2Rc148W1LpmY1ww5L0
	i8bdR9Wwk0u7p/eeMrrT68z8p2ecaHT1wLxAdECRk3ekvtcP57ggHrT6aghIDw/yrKBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfHzf-002Tk1-4i; Mon, 12 Jan 2026 14:30:03 +0100
Date: Mon, 12 Jan 2026 14:30:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
 <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>

On Mon, Jan 12, 2026 at 11:00:08AM +0100, Lorenzo Bianconi wrote:
> Introduce the capability to read the firmware binary names from device-tree
> using the firmware-name property if available.
> This is a preliminary patch to enable NPU offloading for MT7996 (Eagle)
> chipset since it requires a different binary with respect to the one
> used for MT7992 on the EN7581 SoC.

When i look at

airoha_npu.c

i see:

#define NPU_EN7581_FIRMWARE_DATA                "airoha/en7581_npu_data.bin"
#define NPU_EN7581_FIRMWARE_RV32                "airoha/en7581_npu_rv32.bin"
#define NPU_AN7583_FIRMWARE_DATA                "airoha/an7583_npu_data.bin"
#define NPU_AN7583_FIRMWARE_RV32                "airoha/an7583_npu_rv32.bin"

static const struct airoha_npu_soc_data en7581_npu_soc_data = {
        .fw_rv32 = {
                .name = NPU_EN7581_FIRMWARE_RV32,
                .max_size = NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
        },
        .fw_data = {
                .name = NPU_EN7581_FIRMWARE_DATA,
                .max_size = NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
        },
};

static const struct airoha_npu_soc_data an7583_npu_soc_data = {
        .fw_rv32 = {
                .name = NPU_AN7583_FIRMWARE_RV32,
                .max_size = NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
        },
        .fw_data = {
                .name = NPU_AN7583_FIRMWARE_DATA,
                .max_size = NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
        },
};

static const struct of_device_id of_airoha_npu_match[] = {
        { .compatible = "airoha,en7581-npu", .data = &en7581_npu_soc_data },
        { .compatible = "airoha,an7583-npu", .data = &an7583_npu_soc_data },
        { /* sentinel */ }
};

Why cannot this scheme be extended with another compatible?

    Andrew

