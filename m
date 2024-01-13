Return-Path: <netdev+bounces-63380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EE82C8D1
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A111C21B49
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21814A88;
	Sat, 13 Jan 2024 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYzdu8Y3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173014001
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 01:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E05C433F1;
	Sat, 13 Jan 2024 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705109796;
	bh=8BU0xLetTzsKfY9wc6yPxWohDztko9pGzv4iIL7WBu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYzdu8Y3TofXL1mSZI3vbt7ee94bS/c3KiBa/fqWJv/ChtuJuNCSccJSNFQ5cl0Ug
	 2D04GBzCpUVnppsnoBrNvyWLSURTkRufqmX6crhnfzTpD8WYTWE+iKRQxGW94PHmpD
	 B4zPKKr6VqNBLScz+bYWBDGnGxdUt83w41g6TUWGBIz2OVkeaYRMl63esaMSW6SRd8
	 N1tBhPINZQBEw0mHtPQ/RROlqs8f1f0AKBF1obbD8adb7S5m69zZudz4p26FuBTViG
	 Z7JlWVtR94R/tQ6iXxuTWu30DqQdT1eaF4Bo10D4pEFW2nucoaQHF+6s1yKEmRATqg
	 iZOctrT7yMAdg==
Date: Fri, 12 Jan 2024 17:36:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com,
 nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com,
 felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v4 0/4] net: wwan: t7xx: Add fastboot interface
Message-ID: <20240112173634.0acc7798@kernel.org>
In-Reply-To: <MEYP282MB2697028CB05CA6D1C9C7B9C9BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2697028CB05CA6D1C9C7B9C9BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 20:00:10 +0800 Jinjian Song wrote:
> Add support for t7xx WWAN device firmware flashing & coredump collection
> using fastboot interface.
> 
> Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
> support firmware flashing and coredump collection, userspace get device
> mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

## Form letter - net-next-closed

The merge window for v6.8 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after January 22nd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


