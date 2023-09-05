Return-Path: <netdev+bounces-32139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC479302E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0BB281061
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E1DF5B;
	Tue,  5 Sep 2023 20:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1567DDC2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EEBC433CA;
	Tue,  5 Sep 2023 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693946593;
	bh=596bIH4ANHD6bp46x19FKqJe+KCWuiHOsg2nWgtC1kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbIL6+SJAgO5/BwU2AHrksaqe8jYFJ/l7c2VCgfKHFwx9OzVhnHh1nE91m+nbGtPd
	 3J7Ix+si4xxkY+Yr5QSVkXjBNvxEwIdMmQ3VoXp7chNwPy0UAxMxpe+pOWx0Eo82+P
	 ASwvjw/MjGCkFyHbKdlXxmzOUQkFAxud+Djf+Jm9NUIPkXUpg6uSGC0NjakRYeA9yz
	 +67VsB1P8QexDJZKQ7Egh6JL9BFNNYue322bBDxHANrRMO1PRLiFR4XpPSzfP/85rB
	 KOVZRmAimLeWlRknbRmlzQ8PrFgvw0CuzMVkXRPETEvLQgzmQNvgKoyhFWnmlh0Whd
	 deaUv1iNLe5xw==
Date: Tue, 5 Sep 2023 13:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net,
 chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nmarupaka@google.com, vsankar@lenovo.com,
 danielwinkler@google.com
Subject: Re: [net-next v3 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Message-ID: <20230905134311.6534e0eb@kernel.org>
In-Reply-To: <MEYP282MB2697DB3C2C854F72A78BE7F4BBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2697DB3C2C854F72A78BE7F4BBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Sep 2023 19:26:32 +0800 Jinjian Song wrote:
> Adds support for t7xx wwan device firmware flashing & coredump collection
> using devlink.
> 
> On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
> tx/rx queues for raw data transfer and then registers to devlink framework.
> On user space application issuing command for firmware update the driver
> sends fastboot flash command & firmware to program NAND.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


