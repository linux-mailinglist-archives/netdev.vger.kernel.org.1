Return-Path: <netdev+bounces-175483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F6A660DE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9467172AC3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B232036FD;
	Mon, 17 Mar 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sy4/vRmt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B6AD4B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247857; cv=none; b=RLrVL7d3tSIIjmrBc29jAyhulXNfPEHZKcGjbXo7fo/lxoRv0374dazVMBn9hPZS1rX+3hXiwKcpUot6x84UWwXFlkJuYHlnYyrRTmxbVTAj3Jnw9Y0MU5bkvUjK6vuMw9U7OereYrwD+WKqWioMK6G2GkQ6xb1C7UjVzjg3EVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247857; c=relaxed/simple;
	bh=MgD61bsd+ceTQkYarNK5jmG8yp10ThCPwM4xpHDZ8bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usu3NjQL6bV95R0b4Fl3rbQrRPk+ijysIUzQnKFteUcMT5g4dWkzhhTNVWP5yW6O1IuJ8MmvUOqL/do4gz6afa/z0S8s9wB7NGT2dx0IVN8qxJFhhY02HcE+0ZMYt/cb+kMK9l9LQx2JL0WJNTWGTOve6RN//N3JCaiffZGJ8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sy4/vRmt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mrVVm2ifC57WbJBvntWC98x4ddOWzXJxHpnoGlxXJZA=; b=sy
	4/vRmtIgZSXOWJ6xzFmA4LMJWLfXrllVopsWChpKQ64bASQGsXHb1WlyiJSoxQmRDWVZd1Y1Po2vJ
	V/VsiTizXYeYBja0x66MTBKaPo9ZTr31xXPOAdJZOFG11ZKBnz7Xt29oxX2l8uT+VlfK2ixMrh9r3
	8NfmJP6se4KB1dU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIFm-006BX1-J5; Mon, 17 Mar 2025 22:44:10 +0100
Date: Mon, 17 Mar 2025 22:44:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net v2 5/7] net: dsa: mv88e6xxx: enable STU methods for
 6320 family
Message-ID: <1840e2f5-4d31-4fc8-9a11-fb48804e2965@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-6-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-6-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:48PM +0100, Marek Behún wrote:
> Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
> supported chips") introduced STU methods, but did not add them to the
> 6320 family. Fix it.
> 
> Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

