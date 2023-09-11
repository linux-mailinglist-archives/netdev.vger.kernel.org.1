Return-Path: <netdev+bounces-32843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244179A96D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613731C20961
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3B1172C;
	Mon, 11 Sep 2023 15:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C11172B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA0AC433C9;
	Mon, 11 Sep 2023 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694444901;
	bh=QQhUsR8kda3/hj6CcImnvWnHoUxICmdWDtUfw+d0L2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oMnmqdvCbB/b9eUNHcCKrZgBIXAfEa4l3Ut8F+Krr/A+TO4Qp5xFRdmhtzOYMkOQW
	 98qwiW7ihtvdhmXn9/JMY3cAkCWfkf2RS329FQiqevC0xj5zMYEDcJaG1IoD/tdcm4
	 kpZWOr1Vyd7e3Vmm3u4QL91seR/p4ZlqPgFodnlHBoxj1eBGPhSgK/yrDWOIq40+f5
	 aUnUpUTw2aMPaIA27iibLEyT3mePx5Lnjot6mQy4HcSMzruUmZLyKo9qd8lzteD46Z
	 2M1fvO80IowMc9BrQIeMCwHpPKkPdDJZ3fzLDWpXm32vUmqUZe+eAU80MyQvPY7gmH
	 AOdhADl4GZdow==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
 Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-media@vger.kernel.org
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/11] add missing of_node_put
Message-Id: <169444489227.1851820.10212594180854433279.b4-ty@kernel.org>
Date: Mon, 11 Sep 2023 16:08:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9

On Thu, 07 Sep 2023 11:55:10 +0200, Julia Lawall wrote:
> Add of_node_put on a break out of an of_node loop.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[10/11] ASoC: rsnd: add missing of_node_put
        commit: 28115b1c4f2bb76e786436bf6597c5eb27638a5c

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


