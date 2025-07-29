Return-Path: <netdev+bounces-210793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F78B14D35
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31518A2472
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C528EA72;
	Tue, 29 Jul 2025 11:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFD28C5D3;
	Tue, 29 Jul 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789829; cv=none; b=Yh8EWPlVEubmNJjinvlPVTVWI3rLf+6gcShbX1J+QZOoY/ml+tgjfhhTskm286x7NGYUerVfqidstd8a2QOS8zNOOa5O4nljjaTQfLYhrcErfFX+gcrj0/WsqWdtj0L2DmLk1/bZoYwSXYu6ENLMYIKyeWiKqRR4O4xCUDtiViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789829; c=relaxed/simple;
	bh=PK4ml/xEq0jzjs5GtAgAMRnH6WZy4V7erfxj0M4xcTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYLnuvu5pg3e3HAPt9Dd/MsPkathHJOg7SeDaD9AfzxUGryZ3eq0n4HSmQaBfo0O1mX/GkE4xV78KkK7IcPLmJkg8YXdcF/5lmgPqzYEChNrXBVDqHPPoxcHD9WyypurJSiuAOV2TnVQTj5avU4j7ZlzX7TpFTrBE/GhOsmTsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d9d0f96f;
	Tue, 29 Jul 2025 19:50:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: alsi@bang-olufsen.dk,
	amadeus@jmu.edu.cn,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to Radxa E24C
Date: Tue, 29 Jul 2025 19:50:09 +0800
Message-Id: <20250729115009.2158019-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
References: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985604d4c503a2kunm15728bea1d0da6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGktDVkhNSxkYQx4fT0JNSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++

Hi,

> The issue is with TSO and RX checksum offload, with those disabled on
> the conduit interface (gmac1/eth0) my issues disappeared.

I did a test today and the same problem occurred when running the new
kernel on my rk3568 + rtl8367s board. This problem does not exist on
older kernels (6.1 and 6.6). Not sure where the problem is.

> With a 'mdio' child node 'make CHECK_DTBS=y' report something like:
>
>    rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
>          from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#
>
> With a mdio node the driver is happy and dtschema is sad, and without
> the mdio node it was the other way around.

On older kernels (6.1/6.6) only realtek-smi requires mdio child OF node.
Commit bba140a566ed ("net: dsa: realtek: use the same mii bus driver for both interfaces")
changed this behavior, both MDIO interface and SMI interface need it
(rtl83xx_setup_user_mdio), but the dt-bindings has not been updated.
I think this needs a Fixes tag.

Thanks,
Chukun

--
2.25.1



