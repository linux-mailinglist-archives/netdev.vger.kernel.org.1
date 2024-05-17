Return-Path: <netdev+bounces-96961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391328C873D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F571F216B6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583C548F8;
	Fri, 17 May 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vhJQbr1t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BB3D546;
	Fri, 17 May 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952797; cv=none; b=s6AVrVijnWYTKHCLOwW3ifJU4mxJnnjyknKFq5riTmH26jjN34A74+nfKHWKlFGCueV1HnBVtR5+804dtXIYHq2HuweGriwSek4WW5ur7r4T+gUEA+Ezbv7HJ3mmw8uS80CUKKR1olw223gkFBWn2tE80x2dDwkTvahQ0Z0KYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952797; c=relaxed/simple;
	bh=FEJ7VYcTltbuBUeDpQ4Pfaz5g39S0RHd/vUI5DSCup4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Cc6UlgPhJLP0StlT99rQkpz6JN30QvfoC6ZNXf3A71SM4Yaa1ZZDcnFMu9bAqgCdzuWfxFU8bL+p23NRlVFzW43QMl2Isi+NP+efSLh9zaIWVlkc5yR+td0h4OFC1mY89qjsu/WvfVr/cgUCAv0Z/V98RlfDzoYaiRknI/s2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vhJQbr1t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DAiq0Zuw2DSXFwlz5gPCyIKCVaufkvs3yykltxFwvHo=; b=vhJQbr1tJDlWxg8P6d+NTU9gPc
	sAsueX76HTbgkGr8eTUXHOS2KP4vHPfbR8B0NeDX2a/CRhv0RcCN2bhitePMpibVrGl8M1Ih6Q9b7
	QjHJrf6tU3mR5qPAzxJHOBln9uVDUj71/3Tjvomf4L2JzyKyt98/b9b8xNQugqqWak8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7xhs-00FZpm-1r; Fri, 17 May 2024 15:33:08 +0200
Date: Fri, 17 May 2024 15:33:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v19 11/13] rtase: Add a Makefile in the rtase
 folder
Message-ID: <0557f92b-6dbb-498c-ab27-9a511763df2b@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-12-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517075302.7653-12-justinlai0215@realtek.com>

On Fri, May 17, 2024 at 03:53:00PM +0800, Justin Lai wrote:
> Add a Makefile in the rtase folder to build rtase driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

