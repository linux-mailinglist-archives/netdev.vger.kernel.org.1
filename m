Return-Path: <netdev+bounces-104973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343990F55D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D961F21587
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CF158203;
	Wed, 19 Jun 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiSt8ffs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66A1586C2
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818874; cv=none; b=QOhWTcD7WEtjHK5aOu9rcGcxtwvqCdV+5pNmxxAumzxtYW0tycY3GBmZHZ9vgmjF+uziJlEBfFwLHAkFfqvsKRePTVg8L6eS75V64cG++Ng27RpVN/MPkRSAeTFkisCHrtPKilBytJLj4sEwrrNSOxP6Qw0gb0FTIPKLQHJVmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818874; c=relaxed/simple;
	bh=7OAcMZSwRbJ3rPdb0gUEp1/pSOxcNN6MDGcDbRcTSMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBAYZQ1BwYYnTMq3qa2EXpQP2yCJelDkKscIrSL23nJiwEK0483UubAeqvKuqt+OZDQ4GmECYPXJDrd5kySPNZ9++N2VDnAKeCM4bmvBwg+LoAOY5hRb6+ZnwNoKmEjf1rLr897bpuYX8W73QqbAxGEEkY/F/5L29j8qgpThdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiSt8ffs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE48C2BBFC;
	Wed, 19 Jun 2024 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818874;
	bh=7OAcMZSwRbJ3rPdb0gUEp1/pSOxcNN6MDGcDbRcTSMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiSt8ffsKQz2+jP9UIyr4KCTK0hWmB20Dz12Z+OyG++wq2SjudVGenuBqEdOe5ycn
	 uzG/MH1T0vuqHGw8owKUSNPVhej6cTO/p7KidSKJpK1eSNJPffQ3l2021M4Nqhd9ZC
	 Euxmy1Rr3dYXazJejHOj6QOdYjadBVY6r1AxQTMMpztMt0WqemUvhKlaD32ilD4mhE
	 K9FbkKW5lp4O8i56Cj5vJ5Rk0owvkPlJnNkzp3bKs3KiOuDuqmKQ/4jUELCDdAc2K4
	 KmKsj8BsXEQ1ss2dyGcFcM5EYf8H72m6SYek0WFC4wO52l4N2MruT/ZcFvm3oiiFQq
	 RNMq0+cpbsIdg==
Date: Wed, 19 Jun 2024 18:41:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, dumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 3/3] net: txgbe: add FDIR info to ethtool ops
Message-ID: <20240619174110.GP690967@kernel.org>
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
 <20240618101609.3580-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618101609.3580-4-jiawenwu@trustnetic.com>

On Tue, Jun 18, 2024 at 06:16:09PM +0800, Jiawen Wu wrote:
> Add flow director filter match and miss statistics to ethtool -S.
> And change the number of queues when using flow director for ehtool -l.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


