Return-Path: <netdev+bounces-125708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534A96E4EE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A0BB21E16
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385D1953BD;
	Thu,  5 Sep 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e5PyCDd9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636541917C9;
	Thu,  5 Sep 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571198; cv=none; b=ofJ4mO4mn+OibmUFy+eQ0bOF52VTgjSluxq/i5A0jI0bzXptWp7a9Wa759t0nXv96mXH8z/TTU9nM5VJzdHG4M13/JpRKSKp/jH6xyxR0zvJjeY5xMBKHvAJBeQeLv1klb3Rh7eTSZE3EbwV4Yeu1WSTrvI9pf9wZXavMkWO6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571198; c=relaxed/simple;
	bh=GSQrbIw+97VRwYE+8LtN9BwnHj70hzHj9LqbXMe+jrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBhW1duSHFArflmCarLwRAXu/b9RPM0udF5XR0RP145g/Ml7dPe7JkEnZ7x0zDdWZaZG7vG7GIW6L74foiSLxwbbxpO7oq0wVKzAoxTZ21cyiAo8p7pMlKRXqVhRKx/0TpJoDt11TFbZ0AoH/XO2qluxUQ4rZr8QSIUOVvG3Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e5PyCDd9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bUEZy7YmKS0+4uj2AwGhL+hJHmmu+8wwHsnMQJVzSGo=; b=e5PyCDd9Ej9bmejW6n+hL7IUhE
	hjiHeTqrHSMnSuM1pA7rSBV+PHgbjSVIAfSs5iGxo35q2d1cqEJLhIlb7WrjGJtTMdn3XjFEjDCg1
	EvNO/torju19DFevWuBREMvlNgoY65gqHrtphqexQOXBzbvKnM4qFNr5HINEh5U92UM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJtP-006isz-El; Thu, 05 Sep 2024 23:19:51 +0200
Date: Thu, 5 Sep 2024 23:19:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 5/9] net: ibm: emac: use devm for
 register_netdev
Message-ID: <83f8b5b9-40bf-446d-9326-294c22e4733d@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-6-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:02PM -0700, Rosen Penev wrote:
> Cleans it up automatically. No need to handle manually.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

