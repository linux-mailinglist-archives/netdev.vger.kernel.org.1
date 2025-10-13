Return-Path: <netdev+bounces-228779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00ABD3E2B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70ADD4FC2D7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847EA3090D7;
	Mon, 13 Oct 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuGA2kXH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B6296BBC
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366999; cv=none; b=N1s4AVb55PGX5z1bWzPs7bLCLq7BAhXrY8XN+UTtmY648rzY3MAoc6Wx2ztD+wDtBozg1JOFSzcwKdzUveDwTuP8b6M6ZcZNp672dKiTgM9RwCeKJdSJDuOvBPIJf1BJBjFU8GWNlD/tRNEAknjn1yg4+/lxtlkI1VH7szg2dro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366999; c=relaxed/simple;
	bh=ttbcMJDJ9CNYqlMzsBh1BVS59IrP0IZnyanSVb3u/xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhdB1xvxHkQka2BByS2oMirE3wVEYCcvUAAr6rjSYZkLCyntkAfqF0+NpECGpZ1VJpLtilqx0HztlF2d/yyWG0XYb1pCWfL5o/wG1yFA7c2mN4JQEAPCy6Hsb2GD+AU3lnMWA5IcNsLu1iuj4ie1LbLdw8IPwA5+zCA8VCsFWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cuGA2kXH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2qKxErbeKsELIXeWVirY4FlojRrGvEUsN7SYeWPCecw=; b=cuGA2kXHja13naV529qo2t4NQd
	KKPD3if8jNkfykGKPZU9y0o2N4bOWs3JZO609thXeECjVz/U7mmq9NqYLACzRDH+C2JMQkUytABmh
	8PifESd/sq7yCIbOQfrI0fVL7lKRp8tzLXJ/2weSkOTKajX8FVQrdGfgPINXrhR2arkQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Jru-00AnSe-60; Mon, 13 Oct 2025 16:49:46 +0200
Date: Mon, 13 Oct 2025 16:49:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: airoha: Add missing stats to
 ethtool_eth_mac_stats
Message-ID: <76070c7c-38f9-4a78-a550-61825895fced@lunn.ch>
References: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
 <20251013-airoha-ethtool-improvements-v1-1-fdd1c6fc9be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-airoha-ethtool-improvements-v1-1-fdd1c6fc9be1@kernel.org>

On Mon, Oct 13, 2025 at 04:29:41PM +0200, Lorenzo Bianconi wrote:
> Add the following stats to ethtool ethtool_eth_mac_stats stats:
> - FramesTransmittedOK
> - OctetsTransmittedOK
> - FramesReceivedOK
> - OctetsReceivedOK
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

