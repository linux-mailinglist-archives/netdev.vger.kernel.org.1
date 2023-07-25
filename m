Return-Path: <netdev+bounces-20937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF2761F72
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0141F281225
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF082417E;
	Tue, 25 Jul 2023 16:49:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87A3C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77FBC433C8;
	Tue, 25 Jul 2023 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690303774;
	bh=L4VvWc/XpiKpMxRX4WTAwtabVH7J0IT0oNOuEjjs92A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tl8a1jwSsPzW+8j4I2mT6JhlGUVLWHQEBBw+t4rtlyfhcVkvo95n0oiVHGQJmkYHk
	 b8LjUZEGM0qlPVHPxbk+c7DJpPtCfbcWAbKTgihj+KvBcC/a9Bw4Yu0MbT7EZGW8ER
	 76zq6mgEZ7vzJLIY5xS3OVo1GdU5eS/TbJNje/rWablIwmnAiqO+QlK8iqrsbjUVaP
	 fVZ1nCCfvimonAU++LMLp3eVtMKJ1TZKu/arY+m0eE3iIHVOLI4HyTH2NqYJJ7dZZd
	 DVAAlmiiNqHr2jy/tz6n1YPA+k5+EmtkAd74L4tmD+rNU2/glLSbZPIHMKRPBFABDo
	 CjKFCrt/EBN8w==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Minjie Du <duminjie@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20230725035038.1702-1-duminjie@vivo.com>
References: <20230725035038.1702-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-Id: <169030377267.1485233.13435532825497669475.b4-ty@kernel.org>
Date: Tue, 25 Jul 2023 17:49:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9

On Tue, 25 Jul 2023 11:50:37 +0800, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> dev is not ready yet.
> At this point dev_err() will have no output.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()
      commit: 908e5a3d4e6f60fa2d3912be7087e745639c4404

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


