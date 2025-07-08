Return-Path: <netdev+bounces-205007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C01AFCDAE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840A916BBFB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640020766C;
	Tue,  8 Jul 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="30V4KOM4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6114883F;
	Tue,  8 Jul 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985092; cv=none; b=HP7h/y9HuKjPbRK3Fs2cCENhEYYkYGglgfq8bHIp4DYCRGwqoVFyCObLKjC/5Vid+c029iEnnnuvXiQnYjD8XoB5yVthfG7LQR7MK+ICPuIjc6xSO8pANu+ONXsryR/dlfHSt/BEVX4SBgG6vyUxmSFjMFL9+Cc87T+59ITIguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985092; c=relaxed/simple;
	bh=1ketRAonw+nds+B9/d9tWPUSYmxAlZ213SEZLor/+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoFvm9Q0+mYt7on4T2B59dQKsDW2/yx7zmmpRNhs5G3kd+qtOAA1LO6/XOtQm9TY6QGuC4jzuTFABCtKfThNWvSkD4xsv/x26Wng7Klh84YRVQhqpl432EMjsxoRcFfzJwXcxUOddQqvtuBHgXqWgbMydFFTe+dCW/6TPQ2Bogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=30V4KOM4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6YosJ9IIjSfXc6/a4TEpnmPlVpcINsCf9PQb2JSD508=; b=30V4KOM4c36mHqpiViovvlfcSs
	H7jnDtGR6mWLsD5lJwwns6LFCIwCqB/KhOVPq7uv9PYwOh/mQh2+PTsLXy7nhXJ7ZIy+jHChyvFGT
	z36qMW4RW9mABEO43ga8JAxR7Tj1n7C6alg6Vy4msEyVdMpNyg4Wb5WufTdD1CmODRU0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9Lq-000pSW-4X; Tue, 08 Jul 2025 16:31:18 +0200
Date: Tue, 8 Jul 2025 16:31:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] net: hns3: remove tx spare info from
 debugfs.
Message-ID: <bb90f701-afaa-43c0-a8d1-9624bd46f07d@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-2-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:19PM +0800, Jijie Shao wrote:
> The tx spare info in debugfs is not very useful,
> and there are related statistics available for troubleshooting.
> 
> This patch removes the tx spare info from debugfs.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

