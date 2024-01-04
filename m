Return-Path: <netdev+bounces-61427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD77823A5A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805BA1C24956
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5917F8;
	Thu,  4 Jan 2024 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3qaj0ft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCD1849
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C926C433C8;
	Thu,  4 Jan 2024 01:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704333099;
	bh=1xpTWj8MB85wE/tUP72AU+iOgP50c2oQNff/NnT0dYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H3qaj0ftNvx4JJaJH5Yjs4uIZxc6kcXo1iGfaXKGbGYUwRYWcCCAAt6C7loFW7VZ/
	 Sm7kCE9/hJVvHmxml5x9ZSpiRMH3cVtJImmpy6NHZjfbH0QRuvPS5K60bHd0yp+a5y
	 samJWPIiZC3HpH5IbUG4t4g6k+w/K7RGiE+j3L1N9uPjaAl9K4C6FCHojufHRGtyjw
	 uOLx4wBlxSRCEyDkh1dGh9Irxz9DuM93JE8XrylazCU9KVyY/4hxzPqhYJH0OZD4u4
	 YMyh+NfQXOBl8G9k0gMQsiZoLJKUBZ7/Qfd/HtpzpZnrtLpxGG6x2CCxlw60lP66Cu
	 egvrL5icOkzaA==
Date: Wed, 3 Jan 2024 17:51:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jinjian Song <songjinjian@hotmail.com>, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.com,
 vsankar@lenovo.com, danielwinkler@google.com, nmarupaka@google.com,
 joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com, Jinjian
 Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v3 0/3] net: wwan: t7xx: Add fastboot interface
Message-ID: <20240103175137.69c267bd@kernel.org>
In-Reply-To: <MEYP282MB2697AB1903F289B38F25CC5ABB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2697AB1903F289B38F25CC5ABB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 17:44:08 +0800 Jinjian Song wrote:
> Add support for t7xx WWAN device firmware flashing & coredump collection
> using fastboot interface.
> 
> Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to 
> support firmware flashing and coredump collection, userspace get device
> mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jiri, do I remember correctly that you were against this functionality
using devlink? If so could you review this now?

