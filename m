Return-Path: <netdev+bounces-19581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB775B434
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D47281F13
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929C19BC5;
	Thu, 20 Jul 2023 16:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7212F25
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB00EC433CB;
	Thu, 20 Jul 2023 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689870601;
	bh=pSklfHHYcqHyi4RyBg5CJnMHtj0gpqlgmMi2k7ABK6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bx1rRBq7nkBNIq8z7hCBxpjKB12bZ9JefMj6Lu9GRdq35jYv2QR9/PN8wLkVFLYQA
	 N4W8vHJBh43W5Aubz+5/iFxCWioXitG52h3Ep83COBJk1ZnPSgz15tHvKcoxqEdA78
	 XmPWKZAhgH9/hyIaQo2uTnp4w1pYXMS31GyyssbjYX4HnpgNZbv3FIqK5DOQPAmw32
	 AIm7nbnYJNMafpit8o3eyTnRGjSt08Jue/TXUi2GdoWSkh1oLYMPnCK6pwaWTnx60i
	 bfS/HphAUqlcyOJYKMTJOeYCHXbMHzPASRnAh1jHG27tbo+LchhS2Z1HplYfxi4Jc5
	 sKlSy9p/fVdqQ==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	Samin Guo <samin.guo@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Yanhong Wang <yanhong.wang@starfivetech.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
Date: Thu, 20 Jul 2023 17:29:49 +0100
Message-Id: <20230720-cardstock-annoying-27b3b19e980a@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714104521.18751-1-samin.guo@starfivetech.com>
References: <20230714104521.18751-1-samin.guo@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=dbZGJNQzpf96UgKTgsx7DaoXenliAf7+9rkgIIDEu8A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCk7E/5ILJl8yHqKiFdT38ele/Qmzv23K2ilcsqWfgctq 6LrG84/7yhlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEJm5hZHjYl5zcZznn+NaE mxFLBNSatrUfa1672ODINvfMrE1P7ZYzMsybuvV4Tv+hbU6lGVbfyhaHKX1/GO4qYDNz4+RiKxP fblYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 14 Jul 2023 18:45:19 +0800, Samin Guo wrote:
> This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
> and has been tested on StarFive VisionFive-2 v1.2A and v1.3B SBC boards.
> 
> The first patch adds ethernet nodes for jh7110 SoC, the second patch
> adds ethernet nodes for visionfive 2 SBCs.
> 
> This series relies on xingyu's syscon patch[1].
> For more information and support, you can visit RVspace wiki[2].
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: jh7110: Add ethernet device nodes
      https://git.kernel.org/conor/c/1ff166c97972
[2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy
      https://git.kernel.org/conor/c/b15a73c358d1

Thanks,
Conor.

