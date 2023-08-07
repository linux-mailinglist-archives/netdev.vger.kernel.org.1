Return-Path: <netdev+bounces-25083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D0772E9A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FEA1C20C89
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC516409;
	Mon,  7 Aug 2023 19:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3EC15AC3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4C3C433C8;
	Mon,  7 Aug 2023 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691436310;
	bh=HBhmn9HKnS8/O4AzZaFEuYjZPHI6Gi65ywDrGFhu+O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iSgi+eNKKTdMVpyW4QT8CWFt2D/ck3D8JFsVcpRQZt8qC3K8iW0GNCQ74ZjKY3T1x
	 RXHFscGL/uKRCEYjTWZAIS8fOSWf7o3y8HJgai22AzGjxiPMVyOpfd7F/b0NcRD1DP
	 Y81MHqQ/P+pWUDVfZ/VRfbQSmf3so9ouxkxbnj73Ra0LZdZtG6OzzRAwtreCoIk2MJ
	 24kI+jifaiY98fTAlm4iRCFGDM/V23pCUMCBi8RT5oWkSNVMkMwcPDAfbgi0pB6qcg
	 ubCVJkTca1I6BDmxeBqCoCLxOm2hRMnmqerH3nGEXqRfboWZ92AwjHsfs9tdm8VDUN
	 NfDqeClA+N67w==
Date: Mon, 7 Aug 2023 12:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nicolas.ferre@microchip.com, conor.dooley@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 maz@kernel.org, srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, sre@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <20230807122508.403c1972@kernel.org>
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Aug 2023 08:00:07 +0300 Claudiu Beznea wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Thanks for updating the email!

A bit of a cross-tree change. Is there anyone in particular that you'd
expect to apply it? If nobody speaks up we can pick it up in networking
and send to Linus on Thu.

