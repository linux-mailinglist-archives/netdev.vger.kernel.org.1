Return-Path: <netdev+bounces-53219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F02801A6A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EE1F210E4
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E58BFC;
	Sat,  2 Dec 2023 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="antRZhyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C9619A9
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E470C433C9;
	Sat,  2 Dec 2023 04:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701490307;
	bh=1+nNWFO5K984/3PjlBg4MbMZtLgdAePl/arFcHZyCBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=antRZhyW9OJFc8PJ7MCSBpl6Dv69m+q310z41f5BZ/8TllOiIJ62hf3xpm+XMpn+h
	 47BwXTTORiE9/QXFF8aCeCV6KhfJ6Xy0bh9mj4zVjh8kqeKEODT94iwqph+tuX9zyq
	 6/O4dDG/hVM4Y06aH4THs12QwoToJGi3fnOI2kkTuDZM7asYag+tr0TZdt+oDn0M/A
	 TPl0W+piJh+vojH5+VC+MFBWZCuDBQjg3X4oVYp8qlgr5PevF7YMB5xel3ZLvF23Rq
	 INA9XYXS5/kS+CXxkUjC2L1jNojvnAJ6XoRcpQ6i6Y8Ms52bPyvbyC/Pj68upurhtD
	 9uV4BuIuqvocg==
Date: Fri, 1 Dec 2023 20:11:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haoran Liu <liuhaoran14@163.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 heiko@sntech.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net/ethernet] arc_emac: Add error handling in
 emac_rockchip_probe
Message-ID: <20231201201146.12aa16df@kernel.org>
In-Reply-To: <20231130031318.35850-1-liuhaoran14@163.com>
References: <20231130031318.35850-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 19:13:18 -0800 Haoran Liu wrote:
> Although the error addressed by this patch may not occur in the current
> environment, I still suggest implementing these error handling routines
> if the function is not highly time-sensitive. As the environment evolves
> or the code gets reused in different contexts, there's a possibility that
> these errors might occur. Addressing them now can prevent potential
> debugging efforts in the future, which could be quite resource-intensive.

Please skip this pointless boilerplate.

>  	match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
> +	if (!match) {
> +		dev_err(dev, "No matching device found\n");
> +		return -ENODEV;

"device" and ENODEV are not right here.
-- 
pw-bot: cr

