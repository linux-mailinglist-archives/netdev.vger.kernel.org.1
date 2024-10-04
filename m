Return-Path: <netdev+bounces-131931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592F98FF72
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A85F2821D0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2561465B3;
	Fri,  4 Oct 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN5QeAqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D513F43B;
	Fri,  4 Oct 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033309; cv=none; b=OacgObVKIBaeNP1TB99ziSXAaFeiurhhGJj8xgCt1LB6ZlxmXkFQ3pqO23N4g5ayZD5kHNli0uxb27T4edKk8ejHv2/OU/tXkl/ub2XU60noqkDwkmprQchu8zvyK0VqzG2x5EyVb1sQoPJ4uAzjpldDdTMjCyvxzSKnj+5tM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033309; c=relaxed/simple;
	bh=tm+1zIioYKE3BIjVPiXN0fmqWViNiymIUgwTepl5wiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJzHYFi5G5nr6KMT84M+lUT2Tv/0U84El1saVOaBHHSKEB1uoCCr1KzaPqWXkAoVy1BGnmzLtjf96DNGWT+2q+ER6/XiMBJ3m3/XPLpqHrCFeZKzRUU4Hj8U9/WC0OiaxZyZbkSAi9s08B/Pkq4clTTjQpy1bXHU4yIPLo/JBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN5QeAqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA51C4CEC6;
	Fri,  4 Oct 2024 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728033308;
	bh=tm+1zIioYKE3BIjVPiXN0fmqWViNiymIUgwTepl5wiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN5QeAqCxV1mem1qDfcSupaxpwYUt5z39In+C0rcLYS/H4xfD9/XnONFFYdQs/zAt
	 3gNzciJHMWFIMeq4zXmC0mKrI7mMsGthApi4/9ctn0Fi4fZs2qELw5mIyYenzeWTjF
	 JIT1aR7Dxpg2Bl1hA5pFnB4RcsZ/jKSbkCeXhvG4sArqcx2kuVJJ1BJH0pMPmDrqEU
	 ydl1cef7ruxIWm00nD/tvAENPARcmqRxbBoHZkyknHoCS2dNrpdK1XjW/Dt/+MFjId
	 O8U54DFWakrn6+wKgH8bBE6ji5sL5gd+a8xL1bWHWJ8gvnkp558IMOmIoXPtcuq5pc
	 PDgMTKWMdPc9g==
Date: Fri, 4 Oct 2024 10:15:04 +0100
From: Simon Horman <horms@kernel.org>
To: Liel Harel <liel.harel@gmail.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, mailing-list-name@vger.kernel.org
Subject: Re: [PATCH] smsc95xx: Fix some coding style issues
Message-ID: <20241004091504.GB1310185@kernel.org>
References: <20241003161610.58050-1-liel.harel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003161610.58050-1-liel.harel@gmail.com>

On Thu, Oct 03, 2024 at 07:16:10PM +0300, Liel Harel wrote:
> Fix some coding style issues in drivers/net/usb/smsc95xx.c that
> checkpatch.pl script reported.
> 
> Signed-off-by: Liel Harel <liel.harel@gmail.com>

Hi Liel,

Thanks for your patch.

Unfortunately stand-alone cleanup patches of this nature are not
taken into upstream for Networking code.

Also, if you plan to send more Networking patches in future, please read
the process document, and understanding of which should help with a smooth
review process.

https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: rejected

