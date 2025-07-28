Return-Path: <netdev+bounces-210529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B1B13D30
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6502A3AE7BE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDED2222A1;
	Mon, 28 Jul 2025 14:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A609846C;
	Mon, 28 Jul 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713039; cv=none; b=DVD54Ch2JPucluaIo2pLbyGCHH4263Yhkxjc+XwVqygFw29Tuo3VdUFPrg6Zzd/wBcKnzVoXlGiMxVG8jyAF+aD5etnSiP1c+0z0c6TAk47xEGX1I6Qi07BHs2kDtZZWO8SSwpDeufZNAHTK5+LkLKjNZhhU9LnFEolpk5PlY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713039; c=relaxed/simple;
	bh=6PaRtqi9Eq4LuRAvpNXPtd78EBWa56zGor/v+aDDIpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/GyFjOCSBgxhol11vHHRuyr3FkydyQ71PZkX78ksLH5BNLAknTOLv5UlQSV15u9wwB3wAL/BsM/VmzD4skAPoUfLpdDtttWf+i27SuACf+mICf9eM6EME0g2SZ/43raMqGM2mDzMxwi/0f1TgyObMwmSxTfmuokG4OdW8hxK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d7f3d120;
	Mon, 28 Jul 2025 22:30:25 +0800 (GMT+08:00)
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
Date: Mon, 28 Jul 2025 22:30:20 +0800
Message-Id: <20250728143020.1007374-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727180305.381483-4-jonas@kwiboo.se>
References: <20250727180305.381483-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985171201503a2kunm2adcc85416a3a7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGk0aVh5JSBhDHR1MSE9LT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

Hi,

> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
> and only around ~1-2 Mbits/sec in the other direction.

> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
> seem to resolve this speed issue, however dropping snps,tso seems to fix
> that issue.

Have you tried setting phy-mode to rgmii? (just for testing)
Usually this problem is caused by incorrect rx/tx delay.

> +	ethernet-switch@1d {
> +		compatible = "realtek,rtl8365mb";
> +		reg = <0x1d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8367rb_eint>;

Shouldn't this pinctrl be written in interrupts?

> +			ethernet-port@6 {
> +				reg = <6>;
> +				ethernet = <&gmac1>;
> +				label = "cpu";

No need for label = "cpu":
https://github.com/torvalds/linux/commit/567f38317054e66647fd59cfa4e261219a2a21db

> This series relaxes the realtek dsa drivers requirement of having a mdio
> child OF node to probe and instead have it register a user_mii_bus to
> make it function when a mdio child OF node is missing.

This is weird, the switch is connected to the gmac via mdio.
Can you try the following and see if it works? I tried it on
a rk3568 + rtl8367s board and it worked:

```
&mdio1 {
	switch@29 {
		compatible = "realtek,rtl8365mb";
		reg = <29>;
		reset-gpios = ...

		switch_intc: interrupt-controller {
			interrupt-parent = ...
			interrupts = ...
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <1>;
		};

		mdio {
			#address-cells = <1>;
			#size-cells = <0>;

			phy0: ethernet-phy@0 {
				reg = <0>;
				interrupt-parent = <&switch_intc>;
				interrupts = <0>;
			};

			phy1: ethernet-phy@1 {
				reg = <1>;
				interrupt-parent = <&switch_intc>;
				interrupts = <1>;
			};

			phy2: ethernet-phy@2 {
				reg = <2>;
				interrupt-parent = <&switch_intc>;
				interrupts = <2>;
			};

			phy3: ethernet-phy@3 {
				reg = <3>;
				interrupt-parent = <&switch_intc>;
				interrupts = <3>;
			};
		};

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				label = "wan";
				phy-handle = <&phy0>;
			};

			port@1 {
				reg = <1>;
				label = "lan1";
				phy-handle = <&phy1>;
			};

			port@2 {
				reg = <2>;
				label = "lan2";
				phy-handle = <&phy2>;
			};

			port@3 {
				reg = <3>;
				label = "lan3";
				phy-handle = <&phy3>;
			};

			port@x {
				reg = <x>;
				ethernet = <&gmac1>;
				phy-mode = "rgmii";

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};
		};
	};
};
```

Thanks,
Chukun

--
2.25.1



