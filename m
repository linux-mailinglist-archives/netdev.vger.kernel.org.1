Return-Path: <netdev+bounces-16324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205B74CB7E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2971C2089A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED467210C;
	Mon, 10 Jul 2023 05:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A3179
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 05:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9DBC433C8;
	Mon, 10 Jul 2023 05:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688965457;
	bh=p8YNjR5FTTbYpldel0JyzfCWG3L7Lf5CN238TGr/nxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJTx68/Zxf/bU3IANW7O+cWZUDIolnUEvYVYDSDs3yx+XAgGWvbWn8nQBOCdKOpJK
	 rl/AmC5DvIy/PM1OJmYgvWR0datPINSx0nNZZIJcg1g0+GpbPWxR2YHp+MQjgmfgvx
	 7FdiMG9tI3o/vz/cf0bdEDfqGo/NodVPiK8qyRuNyPwzJtxDzGVkZRtmxLHE6eM4iX
	 skG6awDb1RF/wlU5DkOAfWIPVQVkWTVxPCZ4spZcaMGWVZEavHJabuZe1x/QUnWbgL
	 zrroN06K8Bc1/jTNPmc4j36bYxjEEcRB+ibdWQjdBIj7OoE1MkcnNOjLKVnSTZaTZ+
	 GFDAc5/7bs0YQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/5] arm64: dts: qcom: enable ethernet on sa8775p-ride
Date: Sun,  9 Jul 2023 22:07:00 -0700
Message-ID: <168896565968.1376307.18127304044280221873.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622120142.218055-1-brgl@bgdev.pl>
References: <20230622120142.218055-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 22 Jun 2023 14:01:37 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Bjorn,
> 
> Now that all other bits and pieces are in next, I'm resending the reviewed
> DTS patches for pick up. This enables one of the 1Gb ethernet ports on
> sa8775p-ride.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sa8775p: add the SGMII PHY node
      commit: 683ef77158cbb56ede2a524751b150cec340128a
[2/5] arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
      commit: ff499a0fbb2352bff15d75c13afe46decf90d7eb
[3/5] arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
      commit: 5ef26fb8b3ed72cc5beb6461c258127e3a388247
[4/5] arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
      commit: 48c99529998026e21a78f84261d24c0b93c1027e
[5/5] arm64: dts: qcom: sa8775p-ride: enable ethernet0
      commit: 120ab6c06f69b39e54c949542fa85fd49ff51278

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

