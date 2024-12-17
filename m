Return-Path: <netdev+bounces-152629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318E9F4EEB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1BA189487C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D011F666A;
	Tue, 17 Dec 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X9N4AyXO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DA1DB52D;
	Tue, 17 Dec 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447995; cv=none; b=hHtR8YgmKFC3ekglZ2qie0r28ePkwpurgseLxt6w4XcbZ2GrHyDrym2bdvIDvgAZtbLsJGGeOENhGRh5Z614CeQZcABrWSzhOB/zTxF6QDjXXwZpwio5DhNQALgE+c9+1S+Q9IRYhyHblPXHGuDekYI5pB1ILTq5eGeitOUrVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447995; c=relaxed/simple;
	bh=cGIa/uaO+1uTfdWbfiKTpdFm+uA2N8ZZqrPAqEBij8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVmGxTZpIISHyY1ogHxDlXdhLs40KtdE0WSruD4995f1TczDW4jCP8OpuY1EBrlQ0nC3EYMjchSk2IhDGU2l3ELbaUkVAbVtg0cYeYRBPNj96Tq6xsmzAzW/XXyVt6Bp/AiI8AvsJyFKPZIWkXSqlEfTyVDPn8TLcU8AdYXk6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X9N4AyXO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1FaxqYCFDz18EKz3H2SAvhpcfz8v5Vr7flOtujTRhRA=; b=X9N4AyXO0YHk5KJCxqVWSCAfR3
	kQVSh3mrS4iJZmJlFBKAW00BAR415ZF/H9E8bwGJG1yBdO0a+qe5x/Z6kqOWrAwq+i3Nxfjk+MSXV
	fDJH8xSW/Nzy0esRK/kVhAF/lVQeJmwDsupekkTzjcwBGevskcubWRFRbPeN/ug5sWUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZ9V-000yzV-2Z; Tue, 17 Dec 2024 16:06:25 +0100
Date: Tue, 17 Dec 2024 16:06:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 3/5] net: phy: Kconfig: Add rds ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <131df3f0-eb87-4fe8-9fd6-098102fe7d42@lunn.ch>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-4-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213121403.29687-4-divya.koppera@microchip.com>

On Fri, Dec 13, 2024 at 05:44:01PM +0530, Divya Koppera wrote:
> Add ptp library support in Kconfig
> As some of Microchip T1 phys support ptp, add dependency
> of 1588 optional flag in Kconfig
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

