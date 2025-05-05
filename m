Return-Path: <netdev+bounces-187862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F73AA9EC1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 00:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AB01A817DD
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51C2741CF;
	Mon,  5 May 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="byIUF+O8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD511A2643;
	Mon,  5 May 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482780; cv=none; b=Ii+5lFGjBxspActnGlIGCYKX4Z+7e34EfhAFntLGvQcRGJokwjUcMLzaYhmmpPve9BszGlhljhJEBtfvfp1GAL4DwfpeszbzH5h7GKDlrMzkedTGtUhLY2B1SG07gAlJQRGMcSkCf/tEmd3DkAzXjs5sA1q2OBUomyFtzLm+Umc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482780; c=relaxed/simple;
	bh=QeYxcZ620nIqsAAulu80rzE9jrLBS6DmQ0WJHctbUGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX/Yl3WplWp4+y0sV1bckrJNe6Xbf953+Fu+BHWe7vb77me2XdU999xMp1Uyajj+kHwrr/y5Y/9yaPpedv0ZHK3eyPq+Yi4Abd7zFb/+rRESODcDl75YvfDdekEjz9sNqxODwQSZAIhm0sHA799ZWZ1eH4w7Zg/IrDgkAaPB3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=byIUF+O8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qf0Fru7cE//Ye6JId65UaMwa0EBbb7eRuVit8alUl+c=; b=byIUF+O8/dLC8WTrmq+XtoILGg
	DsY5BqPTRbXLyTiDFWPpHIo2kL6vf7y8eHVHd2sVm5tsfwtlrjQsyUoJ1Up3pGqGHJxvV79bCLsAw
	/rCaj3wSB5iXvkhN+6gERQ6PElSfF3L+wE9BxHFIsn02zKIsj2sWHNeCgN8OIQQ3RQAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uC3ww-00BdoD-Jj; Tue, 06 May 2025 00:06:10 +0200
Date: Tue, 6 May 2025 00:06:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v7 3/6] net: phy: realtek: add RTL8211F register
 defines
Message-ID: <7bf39790-5926-41c3-9513-fe1738d6ebdc@lunn.ch>
References: <20250504172916.243185-1-michael@fossekall.de>
 <20250504172916.243185-4-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504172916.243185-4-michael@fossekall.de>

On Sun, May 04, 2025 at 07:29:13PM +0200, Michael Klein wrote:
> Add some more defines for RTL8211F page and register numbers.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

