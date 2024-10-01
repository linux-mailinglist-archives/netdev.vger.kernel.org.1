Return-Path: <netdev+bounces-131078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2198C837
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BA51C22D7D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765C1CEE90;
	Tue,  1 Oct 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GQbbtLQQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28918754F;
	Tue,  1 Oct 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821714; cv=none; b=BTNtz3xkMviPWKC6WZahONmp1vHNiNr+CzaE+vR74m02mVzHe0qrni6g+2LIF+l6IqW9lHA8vQshffhlNHpxmIMCjWLMdzSpjc9Lz29g06sbdXeM68G16ZlrEaElgng1dDxR5BWEh4rfiRabTRaex+0jgkEaBQGBkXwIQqy4PKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821714; c=relaxed/simple;
	bh=kcywU23HrM10Xgxv2T9wmypA6GpX5y8UnG2oPvrp8R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EazwlObFJl8AikT20fxw3C6EVtUdSf7jY4Vh+/EASvLIpFgd8MO8C8luYuD3ZjYADnHY+mp+jVKIOYR+X/SW6Z0bS9USR67kkJv5YGAxXAEp39bvJhp7alUccov/HvFn7lKlxSiTvrUrMTs3kH6YiGl/uSF2xv8A39ief9W7gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GQbbtLQQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fCVw4mQO+uWbj1MtaObEu5U4ShO1xo8nZubB6hdye7k=; b=GQbbtLQQIkbEVd/Qkd3jqxt/6e
	tCWhwU6LB2euspWNFLoZ18jScaD50B2ul+3wqWfOGukLoZzd27awzWz0Id2zG2RGgxzPRtp1zF0PW
	myjeHYjm2N7LgYNF6lDUqLMEWHLtPjUbhzMBwxNFdsBUPYuTxm9zwM1ETyYBZivDrcFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlLz-008mWv-An; Wed, 02 Oct 2024 00:28:23 +0200
Date: Wed, 2 Oct 2024 00:28:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 4/9] net: smsc911x: use devm for mdiobus
 functions
Message-ID: <1fafe33a-ca80-4e4a-a1ea-9d2ab4ecac07@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-5-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:29:11AM -0700, Rosen Penev wrote:
> Frees are missing in _probe for these. OTOH simpler to use devm.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

