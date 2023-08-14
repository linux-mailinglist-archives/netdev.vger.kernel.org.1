Return-Path: <netdev+bounces-27210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39477AF48
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDF01C2098F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 02:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4B15B2;
	Mon, 14 Aug 2023 02:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356915A6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF6C433C7;
	Mon, 14 Aug 2023 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691978398;
	bh=r6ZV87dHJlPryQtydJaXw0IWv7LgBZ/Q0qiqeRCWWzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubEht/wJPysAQVOUfai+CD5DOxQD9Ok2tfV76r752mCN5PMnd+Mvik13ZmsrqtJps
	 lw2wUL/gR7akk0cHjYkuT0p+g8vtDx7iN81wjqTW3K7GLgSvZLoBJDFAVoeWraLHDO
	 hZM7idoIMR0DNa+bOE8YszAt0WPtUaZPNslO6UUBGyEvBlNEVKCKNNe8U7D5WmTq+O
	 PQXP4Iply0fj590VtjBLKwXzHr4jimXJTWnYMHIq5Is8tg9ZjEQluijahX9IJaj0qV
	 yr4AbLOiJ0t7dtyHf2vDLE59zBOLP+9UM8Q3/demwuuWZnfWgb14yykrIPbM6qQwt4
	 g9hcg9g0CSkOQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
Date: Sun, 13 Aug 2023 19:02:42 -0700
Message-ID: <169197856183.2338511.1152285828374094675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 10 Aug 2023 10:09:00 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This series contains changes required to enable EMAC1 on sa8775p-ride.
> This iteration no longer depends on any changes to the stmmac driver to
> be functional. It turns out I was mistaken in thinking that the two
> MACs' MDIO masters share the MDIO clock and data lines. In reality, only
> one MAC is connected to an MDIO bus and it controlls PHYs for both MAC0
> and MAC1. The MDIO master on MAC1 is not connected to anything.
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
      commit: 31cd8caf0cbe191c0157c1581a8f0b82b891960d
[2/9] arm64: dts: qcom: sa8775p: add a node for EMAC1
      commit: e952348a7cc7b35883bdd43d73b8c9b296936547
[3/9] arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
      commit: 6ca89cc6803b3895a0b2caba458dbece9b6ea52b
[4/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the PHY
      commit: 5255901fb26efcb91eee1739aded174ff6c6443e
[5/9] arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
      commit: 1e7ef41b5fa7de8de746a5d6cb7c96c409888c53
[6/9] arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
      commit: 1a00a068de4a657a2af53943d446b7b7199b5871
[7/9] arm64: dts: qcom: sa8775p-ride: sort aliases alphabetically
      commit: f8be0c50ce0e5bc38938fb1a7405288cf3fc96ac
[8/9] arm64: dts: qcom: sa8775p-ride: add an alias for ethernet0
      commit: fdc051e3926ee52b43f16dc3d6f35f40f8a5d3c3
[9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
      commit: 27eb552ef585c9852d1d04afde9fde34f8b69dc2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

