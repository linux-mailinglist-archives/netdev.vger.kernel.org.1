Return-Path: <netdev+bounces-145667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDB9D05A9
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47723B2099E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4A1DB53A;
	Sun, 17 Nov 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F4q/y+bb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4852433A0
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874196; cv=none; b=NET50QiuQg/ONriaqGF4zmIdSShoocLK2fuI515n6Bek9F47oiWZ5u0WWD++1SBN0p1X8XF/C9uEGjSWhgjNZAJ8NVT4pjC+diJsb9buxG2srBQ9g06UP490DckYpT7GYR9lgU2qHkSf66z+RQ7GTLpo1CQtWSoqfn8D+2/ogPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874196; c=relaxed/simple;
	bh=3zjuRyxHVvvl/m8CLkZxONhvUrd1sf/Of04D4cXNARc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNA1rr+Z/d3C3WTtYyWswUnvkslCPHgCs8kzzAAxKmcL0lXx3xuA6OPmwVGue7l45lyA+8P7hWMSUJLAZ7AQEEtyGMcNYXO3SosGwagfaaI2jr+JgCFdia+2FOT8tNB5Mf4dVGRtMktYcHV112IyifKBNBfXpCtPdV5zIiP64fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F4q/y+bb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i7iugpwsF3ZCw87Mf4m6rAPtaopwjmaZmeVEifhRxdE=; b=F4q/y+bbsJ6dOvnHY544MXZvzO
	rbpBevvSmVzqxtO4vrKrLWjiYa4vvzOCV/qlOE0tzSwbu2Pt5SLzMx6lQ/50FoJnID5VRZ89AwMmB
	NGRiL6sTcuwajv6d3IwEC01yLZSSUjYx6oZlyhLDM6A4J6OOdlYrTY58tS1G5sekM544=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tClah-00DbIh-FN; Sun, 17 Nov 2024 21:09:51 +0100
Date: Sun, 17 Nov 2024 21:09:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 1/5] eth: fbnic: add missing SPDX headers
Message-ID: <9aa64b89-a82b-422e-8d59-221148af59df@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115015344.757567-2-kuba@kernel.org>

On Thu, Nov 14, 2024 at 05:53:40PM -0800, Jakub Kicinski wrote:
> Paolo noticed that we are missing SPDX headers, add them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

