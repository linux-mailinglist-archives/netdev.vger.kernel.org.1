Return-Path: <netdev+bounces-96962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4298C8741
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3541F217D2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CD54911;
	Fri, 17 May 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oHuMDPhn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9D548F1;
	Fri, 17 May 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952848; cv=none; b=XhbuQ0g8r8ReBTnhHQ+yOKOv5iDozX+LqyqinnXmfWI7nm+XP49xIQcw11PI3ezPbTEES4rp8GgP3A4paRcfTK3SMFliuuz88K7K6kFZEsZLVWtVhrWe0B2czfVpqo34/bdB2Aa0VnND2dJ4l3OEqQGnF8aMZbYGjoqjYnrU+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952848; c=relaxed/simple;
	bh=mSlJs8vptArJdivCbMCT7gFBuXMCAS3di5kemeigX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adIRWZIKX/vFZU1UuIFe/i+0nEfrX5bPg6Z0o1kwMBgW/1Cmw3m/Hoyt2MzothDyxdHiFAZA0ivyG0PZQRzKBr0+OfU3P9L4WCDwtKbyNA2PhEhj6L7gXOsMO1Gs0XAWgpX81LnMNWpBn7JAvBkXB+XsDtW3Ij1I7Ckjt7AKCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oHuMDPhn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O2iwCGhnAnVaSClS4jWlyfnd77E8wl0qgKPPK50kjEg=; b=oHuMDPhnYVX21KtNWf0zu1uuYf
	mZITEx7TQRM+3C3U4idWBLgWLeK3ArPq4zG8QGDt05IK++SF9Y0KklgsvCxKW2HlfEp3ITlaHgXTd
	Ola48SslEjdOwN26939u46wPyicSZ4IYEvCQer6sXsAHsdOgYNsY0KeoqPT2kOdXS+YY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7xil-00FZql-51; Fri, 17 May 2024 15:34:03 +0200
Date: Fri, 17 May 2024 15:34:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v19 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <c695c61c-318f-4926-b276-f95e65e4a8ca@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517075302.7653-13-justinlai0215@realtek.com>

On Fri, May 17, 2024 at 03:53:01PM +0800, Justin Lai wrote:
> 1. Add the RTASE entry in the Kconfig.
> 2. Add the CONFIG_RTASE entry in the Makefile.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

