Return-Path: <netdev+bounces-191978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601BABE15C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E91890D6B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E75258CDD;
	Tue, 20 May 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm6a9w1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17992472A4
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760214; cv=none; b=dIgMDncvc0kUaI2Cj61/n0HO4db1h/xw9MDQWBtnFcl1CKwZ+0qxkP0eXL1CqcJjV3nU4eOP2gP+hsCotcLMA5sFunfAqT4mLpih1erzkCviNPIj3qy8jSQJoBKIrTH/oWpbvHsGwdUVo4FK6vHKDZ6Bk0tcMzIyRmhWRCf01nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760214; c=relaxed/simple;
	bh=V/GNWDFOl7FG6mO8LZheDU0UBgoD4G5z2ZHBBlPlzSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj4l7QRPeYYAmR8KZMXNzuZdXLYpT6EdkFJrUBVzalocytQFGmx/SXh1LSnbrDYRR/cQtpE7fMfix5Weq/WUxq3x2zr6KFSE5P20yk/sEYFOVoNKf9Zmb6dvGE3ee+FSTcnZDE30uNpFcYhuTs2pdoY7cSRosOIodrz8c2N4lRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm6a9w1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE68DC4CEEB;
	Tue, 20 May 2025 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760214;
	bh=V/GNWDFOl7FG6mO8LZheDU0UBgoD4G5z2ZHBBlPlzSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fm6a9w1apELvMKQCHzyLbcfipS2k9DQldRm5Cs5aJuUP9wZhieZOV+MZT69j6WVx9
	 x4Oq5Hlm2nVzZuySUOA1w2XjLya/+zswxFAxkpPI9yCYTLGKlf/7PR3ptPJxpGzz8j
	 OZy8ceaoCE3cy/m0Yrd7JxYdcHytw5DQK8KA8UiQefXeTxb0vCBKVrZ78EzVZ35B7d
	 cIbOmB52CI2LZCCls2mhn5CXYe6Xl5iOuWKkGb74r6cLlKoGZCUiXe6iAl8kMxlXVn
	 eB1kz5OOc93eY1ixjfGjuCvZNA2rQkbic9LyFWCIPUUtW41FnyFkeweDanXv061kjx
	 o7b3S3HTQbBhA==
Date: Tue, 20 May 2025 17:56:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 3/9] net: txgbe: Distinguish between 40G and 25G
 devices
Message-ID: <20250520165650.GI365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <2A092B0D4355A4AC+20250516093220.6044-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A092B0D4355A4AC+20250516093220.6044-4-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:14PM +0800, Jiawen Wu wrote:
> For the following patches to support PHYLINK for AML 25G devices,
> separate MAC type wx_mac_aml40 to maintain the driver of 40G devices.
> Because 40G devices will complete support later, not now.
> 
> And this patch makes the 25G devices use some PHYLINK interfaces, but it
> is not yet create PHYLINK and cannot be used on its own. It is just
> preparation for the next patches.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


