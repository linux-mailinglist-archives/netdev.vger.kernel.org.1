Return-Path: <netdev+bounces-133240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CA995622
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD861F2463D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E820CCE9;
	Tue,  8 Oct 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVwH9eYy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAA1E0DD1;
	Tue,  8 Oct 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410553; cv=none; b=RsDieWk33+AqIuzv8rL4d+yTS96QK/xF1UB7mH6SGdHTWAYM/8XK8ycdJQVzexqBtJ8MU6DkV9CwChtMryLaHL40Cf69R1ZicXp4oucd+0AnLVUkE3IkkDt7NksVyGf8BbagXaDCs8qKuVn7XxVNNGBHg7WWUxINwmO0EEvrkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410553; c=relaxed/simple;
	bh=8LhzIlqbry0wyBJm2MMcd7k466c82N7TM9CsZHHqpAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYJatNkxsxtkyi77hvldh7dYf+IMiQBpne+hHubpsF2TP/+DMrLEYGlGDzK5wo9xK0c9K7naugSs83FTYXgtpjVRYX/HQtM2nzzbTSQQauv09GzG7o9sXrWBKpGMTp58ho5U2klxBZk6HpLrcgYnaKjxlP2tQaQh6ZAjo5ywd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVwH9eYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BFEC4CEC7;
	Tue,  8 Oct 2024 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728410552;
	bh=8LhzIlqbry0wyBJm2MMcd7k466c82N7TM9CsZHHqpAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVwH9eYyv4EL6szMPSGellO09GB/n/turXLKHcSOgHONagrttIvSW5VmTK4XhpQFD
	 Vk7r2l4WlwLn0w36lFyQwCLxNISF5V+hzdenbsvGnTAvNOHRA/djuDbximRwCh6aRS
	 odPSJJm8KEHJyXw0gGhE7NAPjuDDcZrGlUs/nNN/+Xg5MVQkGt7Olq4c4HHPunOOcM
	 Oq1FF3HaHnbcG+1oBDUxPlKR3180ZPzO3Qs01ketJpFHY/YdkJaO6Nw39YhBIhOVPR
	 WQj0SHIqfrzoMBV8x4I7GJxyNff2LSRjvjDEDXn1GK0LUudiGjUsqiq20j5p0E3243
	 03otpXUz9UGuA==
Date: Tue, 8 Oct 2024 19:02:28 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Palmer <daniel@0x0f.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: amd: mvme147: Fix probe banner message
Message-ID: <20241008180228.GE99782@kernel.org>
References: <20241007104317.3064428-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007104317.3064428-1-daniel@0x0f.com>

On Mon, Oct 07, 2024 at 07:43:17PM +0900, Daniel Palmer wrote:
> Currently this driver prints this line with what looks like
> a rogue format specifier when the device is probed:
> [    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx
> 
> Change the printk() for netdev_info() and move it after the
> registration has completed so it prints out the name of the
> interface properly.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Simon Horman <horms@kernel.org>


