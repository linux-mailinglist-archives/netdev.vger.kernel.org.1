Return-Path: <netdev+bounces-175482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D6A660DC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2617115B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B52036F5;
	Mon, 17 Mar 2025 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FWO7g7SN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C3AD4B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247820; cv=none; b=rSoZ38bkYh4fr1eKFr2bD9zRxnWTTvCu99xY5GeztVo7eiHDYuPOBUcN1rB3DVkUAn141kfJz1T33EkdeAdL7/+Y1nDJVXPbvyeDQEUm/ErpKrUD1ApNhLqKVONO2M5HR572Dd4nETt7+qSw09Vynmyv1wGNMnmN94G4IHdXydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247820; c=relaxed/simple;
	bh=+SLWpRs1tcUhqdQH4auVcR2mm24C8VUKwxYaggYcOk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K82SaZtGb4Vp3x1mqR6Hy2Sp70SX229LaqWsBCOMDLQ06VSmSZUbcoS6oYZuToLkvSD//SamkEzATFWkiJRYHqV68u5b9fhqdMIcX/wBe11UMKmv1rnmaJ5FsX16p4UUxOLYPtCFGSymD2jfCcCdubzh6kQq99ACqk0ftaT9ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FWO7g7SN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vc9d7h6/cFmvJrYQDnXkjGjlvy5uE/eA9cMJ/NDibn0=; b=FW
	O7g7SNuZP//miQLby/7vRBLekjrxpWBlh0+AzTaCwlvkSEwgUKMxb73rXC/SMB/axuYcZHhYuyOy5
	sGmuSrKpA77Fl2DhJIZSQtp8ecCU45BdCd818JxB/abTxh7l3eEUxlmy0ekltvcpzOLjPkghY+FGt
	UAgUG+iS9Ge1aS0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIFC-006BWA-Vo; Mon, 17 Mar 2025 22:43:34 +0100
Date: Mon, 17 Mar 2025 22:43:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net v2 4/7] net: dsa: mv88e6xxx: enable
 .port_set_policy() for 6320 family
Message-ID: <7bdc9ebf-53ff-48e3-ae66-7ccac5dfc72f@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-5-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:47PM +0100, Marek Behún wrote:
> Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
> did not add the .port_set_policy() method for the 6320 family. Fix it.
> 
> Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

