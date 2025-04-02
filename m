Return-Path: <netdev+bounces-178888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4450A7958A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDCC7A4F7F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBF1DC198;
	Wed,  2 Apr 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuzbuXa/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87D18A93F;
	Wed,  2 Apr 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620301; cv=none; b=P5bQC04leaxks+zq8MfM718xNMB723SsyecRPxOL2FjAD2HrUfX1fGVi8ShUk9qbAIUtq+9IfmUsI2VJZ48uJrzk0hTMLX7fteOfUbujb+o9OKbFSS0qO4ilV6/RW2NpjXW965e+rb0yqU4sJjosC3MMbUXQ5Z4zr2AZakAfujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620301; c=relaxed/simple;
	bh=h+Y756y/SC+mQDEHLzt1HSHju6agvpfNOY3ng6Pwbxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4wWbOWuG/GVZomKFG/Z4MrRYfMMiizHNs23fZNaFI5C9iMz6PYmon4C0eLYcqR652m4rw7iYytNAlkUhCzo65hbbjeHaCfV7/sRFdpnsMN6GHAiAhrOiSEnX3zv4Ab62cPxJ7UUKxfd2a+YqV91Sl0cEpctW+o1VGrmh8h+H9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuzbuXa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D68C4CEDD;
	Wed,  2 Apr 2025 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620298;
	bh=h+Y756y/SC+mQDEHLzt1HSHju6agvpfNOY3ng6Pwbxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuzbuXa/RMAT5Z28d4oxos4rB0Pms13S1hXOux542JptU7lGOxwTUK6eZ0AaPJ6//
	 f1whKCM55V0eIL82rFit+kTN/4Lrj2uJYwTeM/HxOuJo1veyhQK+cQ1h2P6tSbbGlj
	 9SlbVzGawQLA+RF0R5WjijSa7gG+ExP8w+sQPKo/5ZXAUBt6dl8Mx1dcp+ex6aJk4f
	 LeLfUoKe7qQ0/ssAmo1blovnn8lUbYBlmP2guJPpGN/QBoUjBltBA3/aM5ycO6l4YQ
	 1GLbqOLIdXGn0LP84b1QYa2UJVytKVlsoIdJrk391d5Rzl3FBClPu54XkNAvz3FVvB
	 Ev2KBOGv/KhOQ==
Date: Wed, 2 Apr 2025 19:58:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/7] net: hibmcge: fix wrong mtu log issue
Message-ID: <20250402185813.GX214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-5-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:39:02PM +0800, Jijie Shao wrote:
> A dbg log is generated when the driver modifies the MTU,
> which is expected to trace the change of the MTU.
> 
> However, the log is recorded after WRITE_ONCE().
> At this time, netdev->mtu has been changed to the new value.
> As a result, netdev->mtu is the same as new_mtu.
> 
> This patch modifies the log location and records logs before WRITE_ONCE().
> 
> Fixes: ff4edac6e9bd ("net: hibmcge: Implement some .ndo functions")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


