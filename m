Return-Path: <netdev+bounces-202380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0098AAEDA80
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E157A73DE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089722459D7;
	Mon, 30 Jun 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVGdMSXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8733226188
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281798; cv=none; b=uLGKqZCzUnzi1nwXHdl7hnee0AixuOz0ch8csIjxrtAHNgUg7S4DenvjQGPwpflssWB1TquOpmWFWKnbvj9kZMAKsti6mfHDninRaHhBrV4ctoKZxooXvI2br4sexEGfjrTD8ZRe7E4W4lonGzQ/emoTqybcbDXhKF3xe1SavfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281798; c=relaxed/simple;
	bh=Z7RaH/zHoejIheWXv39PKihpKmi4WpMDGX4n9lr+LlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5z7JvnXNu41foHQEKqIVp8ZIqabAVIfpCw8sPONvSUSo5bvtLWHoy4RQlsia/z6xP3olx0RhC/oHymsLcfy8LHQMUl4kfTC4qEYC8T/WESukAiFzpw1upwheHmuTuEAMCeGPBaoX6pFO8OJd/r9FjiJumLGlCdilCnTmKhuuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVGdMSXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4431C4CEE3;
	Mon, 30 Jun 2025 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751281798;
	bh=Z7RaH/zHoejIheWXv39PKihpKmi4WpMDGX4n9lr+LlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVGdMSXQa1HOEZ44TcXavlTkw59qfsjG3A2YRoIPPGSOwNXlqj8Oy0FIxPVe+FPGE
	 z6pEQdnroLt8dtaC/Jm3Ce0hPSU0oKxrpAZn3dqBGveGuzHfl9incFNU/gKYEsTSVk
	 uvVN6WnsDardZwoBnMeI/EoiJxalNMXd5MS/oZhOopTYQrbgdrzzux9uqiC4A3STYr
	 tyAR1iWw+z3DliTmaEQromaDiBqQeiQt8hrtXDxZXEwTZ1ib1xDeuZ2PpWRQuPs+cc
	 jAZvHJEmuTkVwFefFeNJNq60NWd9uZoi7Fjf0Yo28hyVPoV2wFKKRcEZ98xEKhhnEU
	 p2qidaUREj9kA==
Date: Mon, 30 Jun 2025 12:09:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
Message-ID: <20250630110953.GD41770@horms.kernel.org>
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629003616.23688-1-kerneljasonxing@gmail.com>

On Sun, Jun 29, 2025 at 08:36:16AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> I received a kernel-test-bot report[1] that shows the
> [-Wunused-but-set-variable] warning. Since the previous commit[2] I made
> gives users an option to turn on and off the CONFIG_RFS_ACCEL, the issue
> then can be discovered and reproduced. Move the @i into the protection
> of CONFIG_RFS_ACCEL.
> 
> [1]
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10703:9: warning: variable 'j' set but not used [-Wunused-but-set-variable]
>    10703 |  int i, j, rc = 0;
>          |         ^
> 
> [2]
> commit 9b6a30febddf ("net: allow rps/rfs related configs to be switched")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506282102.x1tXt0qz-lkp@intel.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Not for net, but it would be nice to factor the #ifdefs out of this
function entirely.  E.g. by using a helper to perform that part of the
initialisation.

...

