Return-Path: <netdev+bounces-178818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94BA790A3
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077463B73B5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB323AE70;
	Wed,  2 Apr 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfOh7KLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E51367;
	Wed,  2 Apr 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602348; cv=none; b=RrlVJoUz3dHBp1YtwRzN1S4aWvK+Hd/uDKHs7yAHkFDB4y4FEBUKp+8ZiTI4Fx5Kj7SdS18+qMoFeNMpc9tv1ZwiWqYREqyKj+5zK26UeE/3lEx2BdBLaiQBrtNJ05IUGXAtiaYh3Lgedu2ZMhMt3Z5zNcH+wHXGP7+i+N9XnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602348; c=relaxed/simple;
	bh=Bfcpqxsqd/s7V3vO45xfyUV4yhS9x4qtX1sIyQYFhtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh4B9LRrq2+TZIjiCGsClfipsUibrS/2t/QsGey7t+FvVgIm51RWIFje2tGhBUr7umlFleFicTDo6nLri7WQdoIX38vz9PgF7M+TKzqrQtHx4hjqcwDOUBo6Le/OJwd/E7EYKq9UO710HS7q2Pigg78D9p1pDw2VeYPSyoWGcow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfOh7KLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBAC4CEEE;
	Wed,  2 Apr 2025 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602347;
	bh=Bfcpqxsqd/s7V3vO45xfyUV4yhS9x4qtX1sIyQYFhtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfOh7KLQfrlDMVnyLA923CgaJ1FcDHX5boafyAbIV4eCPCYIPjulzIfKbbA5dtEys
	 69lQ4SbSnHBxNqvpm3NdzAQpXG97e/Y2aEAJydo7853fM0xb/W+CbTbuarxtt7xrkB
	 8NluAYr688aMfJR59wCcXfekswaNu5FfQrQIhhHCdDWpraXycCmvpepTnafiC6d5og
	 wacaOspyJ5IzhnJg+buiSB1g1Ic7qCLOawky10HUo/1oiuozI0ajGAggLwQMabWIOv
	 7YpyJqiMoyPMmFjZCNW4f+5xuvC3Vy7mQzgzRIUwLZHnq58IX8bSlr4qxzoeEWAP1e
	 P70R0l6LYBJXQ==
Date: Wed, 2 Apr 2025 14:59:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: hns3: fix spelling mistake "reg_um" ->
 "reg_num"
Message-ID: <20250402135902.GQ214849@horms.kernel.org>
References: <20250402121001.663431-1-shaojijie@huawei.com>
 <20250402121001.663431-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121001.663431-3-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 08:10:00PM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> There are spelling mistakes in hclgevf_get_regs. Fix them.
> 
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi,

I agree this is a nice change. But I would lean to it being a clean-up
and thus material for net-next (when it reopens) rather than a (bug) fix
for net.

...

