Return-Path: <netdev+bounces-14296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5F740002
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92211C20B1F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDAC1993D;
	Tue, 27 Jun 2023 15:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448419938
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 15:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D65C433C0;
	Tue, 27 Jun 2023 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687880858;
	bh=iOmrAkhjLX9xnz6JUTR1rf5gnuLt/p1tz+zTtU5dmN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WylWbNrM13jPdjcWK0ovzaRxib9u4AFi3hhaFYlu/eoz1xlZnSGUR7TnUTC93WFjG
	 HHDCYkiNSC++Vb9xnfZXZBMO2sRi/TW/cQr9kCPrVnkitzmQWGSYa26DulFJz1R6Ba
	 r+2ljkfg+SFnsnrKwh6rD2CRNtLGAw5Ofiau2rYq74oZPrd9Gcu0HitFjI3lLUmvsK
	 rkRrXdzBfmUsBFH+STKaKkuvFHsWNMbWW9B4Dx+nYA3i00YufHop0Sz+yWiV2hcasb
	 rCdQIcaM4p7e96/ZPohV20ARDrIZ4MYiJ6286RPi/aNBiNhg5PJIzzzWyH4Pvik02L
	 nmLmXHPz2ZYaA==
Date: Tue, 27 Jun 2023 08:47:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v3 00/12] Add TJA1120 support
Message-ID: <20230627084736.592b5f34@kernel.org>
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 10:18:41 +0300 Radu Pirea (NXP OSS) wrote:
> Hello everyone,
> 
> This patch series got bigger than I expected. It cleans up the
> next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
> automotive phy).
> 
> Master/slave custom implementation was replaced with the generic
> implementation (genphy_c45_config_aneg/genphy_c45_read_status).
> 
> The TJA1120 and TJA1103 are a bit different when it comes to the PTP
> interface. The timestamp read procedure was changed, some addresses were
> changed and some bits were moved from one register to another. Adding
> TJA1120 support was tricky, and I tried not to duplicate the code. If
> something looks too hacky to you, I am open to suggestions.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


