Return-Path: <netdev+bounces-234455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73BC20C5C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952E54EF2E7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B627A917;
	Thu, 30 Oct 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4/5bWrIe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FC2773F9;
	Thu, 30 Oct 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835887; cv=none; b=eqQyqPKy0l7/Q7scl98nbw6adXM6ocW+Dr3xvdtkUT6ZrcybajwZSywnsFS5i/y+bY1wLi5zzPmVUXWQY3OsHzt56nqPb6I7SufC0d0brESm+NLuFTYRV+ImGBGEw93afoNMWdmDyEGDHI5S3ey13IyOQIbCvm9pKs09ckWEFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835887; c=relaxed/simple;
	bh=LoETMS1c+topmi7wnFkE+p5PlZ5sDBSw+/LMhXUamEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrg+CIJJSeYIy5PEGE2t5ohkuqJmCMatTghBEJNEvaSaQtmMH6goBmdkDhPO10NLGFAbFJuokWFQnozqtntjLMkVf107P4u/HfuISjcm8A9OifDn3M1XO0cHWsy3veQ6TyTFArwu+xjFP5PeR8y69ffGdfUbr2Xhk4GeBI3XwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4/5bWrIe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AH18Mr74uKXqYaFCZnuFiBSqwNz2NyASq4NwYKMGLh4=; b=4/
	5bWrIek94NXeEWR0JdwJgJkLEdJqS0J7J0iTabzDVXIJdfjS7lZExbNpSG9kcUfEP+hDQITQ5wfzh
	dRRHHxTpHqmKInRosziK1torC1IIiyq/yljXh17BuB5tOhvIeH5qof5ooXGfcZrDwVwzsJFMDgy86
	uCOAubQNFWBwHBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vETzc-00CWH1-RQ; Thu, 30 Oct 2025 15:51:12 +0100
Date: Thu, 30 Oct 2025 15:51:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: microchip_t1s: add support for
 Microchip LAN867X Rev.D0 PHY
Message-ID: <cde45605-f942-4404-8764-727ed5a22d2c@lunn.ch>
References: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
 <20251030102258.180061-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030102258.180061-2-parthiban.veerasooran@microchip.com>

On Thu, Oct 30, 2025 at 03:52:57PM +0530, Parthiban Veerasooran wrote:
> Add support for the LAN8670/1/2 Rev.D0 10BASE-T1S PHYs from Microchip.
> The new Rev.D0 silicon requires a specific set of initialization
> settings to be configured for optimal performance and compliance with
> OPEN Alliance specifications, as described in Microchip Application Note
> AN1699 (Revision G, DS60001699G – October 2025).
> https://www.microchip.com/en-us/application-notes/an1699
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

