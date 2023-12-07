Return-Path: <netdev+bounces-54867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CF808A8E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4821C209B8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFF42ABE;
	Thu,  7 Dec 2023 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXBkyx03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4A41766
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ACEC433A9;
	Thu,  7 Dec 2023 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701959348;
	bh=TqlKfFKOLLV8/pff7AZHnAMNzvKwpCh5nT2X8mByeJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXBkyx03W4Uuv9404zBCC/K1KLScFaO4qf3eWS4PQNfQfe4mrafoBjEt1pGH74/+G
	 2pOWvzS/4lCCj46zVXsrM78Emf3o+4xWuGYZEwfiYJ1Co1ptYNOaQ1FWMSVD32tdXr
	 sdhS9gXAEZMhYQn93jmEDMaZw90Az24dFJsV9asJmmVR/Ka1pIGXWrRVGVqDCcxUyx
	 fkKS7HJ304ESaPXUtKPJ19zblqOneEbehpEx0gfxHqHuobLIZFIAXMrl5RNcIsrhDi
	 7pX48TbcOJZY0aP4ZJppFrF8uIh23mculrE5n48KJdyfc/7DkDRuYTZNl5hwbVsMwj
	 v1X91WTWd4oUQ==
Date: Thu, 7 Dec 2023 14:29:04 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231207142904.GE8867@google.com>
References: <20231129204806.14539-1-lnimi@hotmail.com>
 <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Wed, 29 Nov 2023, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
> frequency translator, and clock synthesizer. The device is comprised of 3
> digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
> noise fractional output dividers (FOD) that output low phase noise clocks.
> 
> FemtoClock3 supports one Time Synchronization (Time Sync) channel to enable
> an external processor to control the phase and frequency of the Time Sync
> channel and to take phase measurements using the TDC. Intended applications
> are synchronization using the precision time protocol (PTP) and
> synchronization with 0.5 Hz and 1 Hz signals from GNSS.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/Kconfig                |   12 +
>  drivers/ptp/Makefile               |    1 +
>  drivers/ptp/ptp_fc3.c              | 1036 ++++++++++++++++++++++++++++
>  drivers/ptp/ptp_fc3.h              |   45 ++

>  include/linux/mfd/idtRC38xxx_reg.h |  273 ++++++++

Acked-by: Lee Jones <lee@kernel.org>

>  5 files changed, 1367 insertions(+)
>  create mode 100644 drivers/ptp/ptp_fc3.c
>  create mode 100644 drivers/ptp/ptp_fc3.h
>  create mode 100644 include/linux/mfd/idtRC38xxx_reg.h

-- 
Lee Jones [李琼斯]

