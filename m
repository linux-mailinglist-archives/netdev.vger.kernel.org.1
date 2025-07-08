Return-Path: <netdev+bounces-205010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B995AFCDC8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244F3580CFF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017C289E2C;
	Tue,  8 Jul 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dQ8yZRHF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3813957E;
	Tue,  8 Jul 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985303; cv=none; b=W27El1kHOXPom6UKbOYIUmjilsBylh5ZHQbO5mDfMo5Kt2EoMKnPKndKY0EULpoMIFC9SVEbajaub91Bz6UWDoaihe0U0O2rKX+EgUVU/ZTngacKegtDKEnAqO5zAIf8YAACNN4bf5GpusDeh3XPBPipaPQcCEdNdKj3a6x0lUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985303; c=relaxed/simple;
	bh=ECOKHVhK7xDoHwg8uSR2SY6e10kX8TNbz9priKpMX1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt3p9cpXmdb9Qwu8z2ieShZZ4XsKdd5QFgF9Mm7qksOW7zAnFsWXjA2cbS7OkOXxXNAAGAqfbdP+UjSb24lLLfUmlUNUIqrjgTjBfuRvY1J9k0UwCr/opJtLISiY+lZiZjMv+uhvNr6doz6hckAbUW56NoR+38UHCrzIRSpNMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dQ8yZRHF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gdz0beR2fzyal7iK8mhUOStwe9TumUdajoByiuklz3M=; b=dQ8yZRHFNtcfSGeJj6SQ7JDVuG
	suIPtCRFF4ysnj8g7sjhNEz+s6oWh6r0ynFF133iuOB4ddJ6dZHCtI6LZrvt+/wcUxEDU3Q/3EyXL
	NcLcd99cVs3tukVBskxrS0t/JyHCSr/nD+VjAOx79e1WX0ec46XmmXN0zRBv6kFrLiLk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9PJ-000pVD-3v; Tue, 08 Jul 2025 16:34:53 +0200
Date: Tue, 8 Jul 2025 16:34:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] net: hns3: use seq_file for files in
 queue/ in debugfs
Message-ID: <2cae4f9f-9191-4e29-8204-23332b9ad55d@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-4-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:21PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> This patch use seq_file for the following nodes:
> rx_queue_info/queue_map
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

