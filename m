Return-Path: <netdev+bounces-131080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C498C83D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E0B1F24CD2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C231BDABD;
	Tue,  1 Oct 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZQu6jqaG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926019CC39;
	Tue,  1 Oct 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821844; cv=none; b=KCi3r9SB5TRf0p6bYgyORNYo2QgEbozF+S5tJXwdqc5vQzpEp8DWV5vxezK8b/whH/rYjN4fDvoO5ibltt6DfpMJN/oCLsS/MpiDezwIiep5yChtE0q+VSZpDhUAkFzXuNYA9vF+g990SXwnO2tX4uikN3S5W+swjavT5k13zLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821844; c=relaxed/simple;
	bh=mC9GWVkUMROhmPLF905KkEjI/JVFZauOQdwqcQligi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1KsYi2grIAA8cb3HzeNzKj2WNN0QNDIx7V1ZZwhPA0qTzEQikSTM2Ir3b5jBTUMfAif3OnwVjpWX4WODVVRDpooW2Xe6pT4si28XdWVW4kBidw9yE0yHvYOVGFv9Fpjk52kmxmdja3iBO9mj2EC49atsdyb+nL64+1Q1OwjpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZQu6jqaG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qt5DasCpkkpHuYfGX3h/I/adOG4EI+BosrPLLAQ+wAs=; b=ZQu6jqaGFhUwgr6XlUAzZ+gjcc
	WZP6O4oyTzHGIg0L0Hjzf3K/KX2Razd3i0tdurSqKxjNcz3OITna6OY49gXJsteRR7/PxrVl0RQXa
	nUL15P/8A6OF+yAas8gOAt/G8WJlzIn9rzv1Bbu12vXOc4vBWtOjD1STZkiNYNZSo4S0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlO8-008mYG-BX; Wed, 02 Oct 2024 00:30:36 +0200
Date: Wed, 2 Oct 2024 00:30:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 6/9] net: smsc911x: remove debug stuff from
 _remove
Message-ID: <aaf64ee0-09e3-4069-bb04-d7f5c41fe8e4@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-7-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-7-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:29:13AM -0700, Rosen Penev wrote:
> Not needed. Now only contains a single call to pm_runtime_disable.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

