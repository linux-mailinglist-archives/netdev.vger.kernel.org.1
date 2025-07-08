Return-Path: <netdev+bounces-205017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF35AFCE07
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CFB1886E6D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25452D8DA8;
	Tue,  8 Jul 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="15WFTcOz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430342E0926;
	Tue,  8 Jul 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985674; cv=none; b=qF7lyR7e4T/lMTvH0cEchVPIt12ubTLDJPXSmR0XnXfKIbgmx677L/PPsYfTwuNEQ1fsg88FY9KzNhgTusSGV2+IrG0BFXUtg5WGXEht2KP5jixxzxwka90N8Z41NcYGLvzhvk4VNYdWHlJsbACog5TJsB7Ik6j51krhG0IRaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985674; c=relaxed/simple;
	bh=SBYuxgpn53YByMG+NT+wodWf7BRz2gp7w0yJzQXU6dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxAaneXvse3/gbPtGGnIZu9MsK5EJB4gjVHJ4g1cNTIxQDPwXa+nBwgdWrE/LhcM/vkIMlQfZANSYpPw9J4am4U15TgTGmvEiyle1hAVECkZBgSkqy3BCqIDUFudLqakRXJV/BL4Z8O812DY7xTJCfELEEx4HvL3jNVKaSetvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=15WFTcOz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oFlHmO0kg7Z95mwjgL5L8PgShiRlnMpv0Ab5A4lrcNU=; b=15WFTcOzyGr6h3jQDPXxDfF5rW
	GFKLf6OQGJo6BT8//w+TNlAkBoCyb2u/MaLKerrAcOsLWHcI0nIbPbLLEfpyKVW+aNaOO7dHavab2
	mmYe4p+OICX8y+2uwcu1J1XbJoUKcPaHiKJ/qQwNzB/JGj+8Xl2lHRBOfLuHasduHJRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9VI-000pal-D4; Tue, 08 Jul 2025 16:41:04 +0200
Date: Tue, 8 Jul 2025 16:41:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/11] net: hns3: use seq_file for files in
 common/ of hclge layer
Message-ID: <4ec9894f-1d02-4f13-8772-d7cf0eabdd22@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-10-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:27PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> This patch use seq_file for the following nodes:
> mng_tbl/loopback/interrupt_info/reset_info/imp_info/ncl_config/
> mac_tnl_status/service_task_info/vlan_config/ptp_info
> 
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


