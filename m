Return-Path: <netdev+bounces-125706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C996E4E6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7564E1F245C3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423361953BD;
	Thu,  5 Sep 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xfBPjH+c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9D186E40;
	Thu,  5 Sep 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571081; cv=none; b=sNm60yhpUKu2uuwZKec4K1wuq7rEPyZ217gSveADb1ExcL5WKTtgLvHTzX7kcWrkRiHybjuItiEeE0rZMOt5gv/KHVItpfLKxoy2s4SUols9jRuErzxI68sxcCSd+2L31z5dH9OoZ1HO+bkev7K4rC9VZS0X9wDEMuQefFx4Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571081; c=relaxed/simple;
	bh=OqC5B8OouhbBVHL40oRcK03WJsr2939PGvFkXjrJRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoqKxvM7mL9fJPc3qTlLVzU/pYwf4k3ucZ56/89faYHjbaEe/2WvSb4rf4NvAoUqtM7ZBpB8YFXcdSgIqOybdwPQNGebNBH++hB9kROaSfTKaNankmgm7v9icrN+H0CvVsLZTYBwVuOISdlXC5JzAbqwEwHKfdUWpwXoFSFclrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xfBPjH+c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b21HIYZm6HYG7Fh98rTyEYRXq9TeogIcLlkz2zq1CSs=; b=xfBPjH+c8rkR4Sm31wTHxEIttD
	at793VFdQBAPcakNHVbzWVJrhtUmPzldnOvFC6I+XH+E3rPfqaK8U4awa8ga+tbSe2PdVyv1oZWTG
	Kria+o9p3oPL0vjmh6irQmrJDzs6/FntJl2r8zHhVXT/jkduNSLGH3njAMWWN4Cf0/0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJrV-006irB-Np; Thu, 05 Sep 2024 23:17:53 +0200
Date: Thu, 5 Sep 2024 23:17:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 3/9] net: ibm: emac: use devm for of_iomap
Message-ID: <1ce202c5-d154-4527-bd93-2f47124a82d1@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-4-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:00PM -0700, Rosen Penev wrote:
> Allows removing manual iounmap.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

