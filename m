Return-Path: <netdev+bounces-127340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2110975173
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B41F21B7F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338E18733C;
	Wed, 11 Sep 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PilP3+G6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B973477;
	Wed, 11 Sep 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056514; cv=none; b=fQ3Pg0C6vPswU2MDG0thOoSLsj0ki7NiM+Yq0/yD64zKJF5cUCan4EselVMNWGh+CRiigQbUvdPZ9tnDPohTQyiyvnKBFKsC2DtyBogh5XTwwiB8rLdbd0YJ7JghYgJOJZ5pijUta+nmNCbwLFJzGVrZQUGZol9lyq6Bk3Eg93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056514; c=relaxed/simple;
	bh=QLNnXWWCJuxLHShYf3yyFq9X0ONNT3DDkry63vs9LW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ+0m4LVEtJNZCc66TTx04nT/HIAW6DZiqdwNP+rioJPtpVyA2WgmwKHSK8+B1iKTyaB30G8y2jbOvChOFWKNzYiW2lhNCokjs7FMTuNVR57VyU9WoeXiqEI9cPbnhuaR0rimnXROIkraUGIS7AEf1hH7GZdSaqL2go9xFlvQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PilP3+G6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UcnSSS5sRbFX0joRIuOGLRbcv8l/EOFUaWyvL+VtAak=; b=PilP3+G6Zom03ujXLIAxQBJ/qi
	/6aw+pkStQIo1qMMhJxujyZfFPK0z5YQHk0Uph41N6mBmv1UJXV0iXemI8DWq87SwkGjX+OfmGJnN
	ycxd9PeRJPsxEm5vdG+vZGeOlVG61teU6iM1/Kg4RPqEBBY+2B04yf193PWjgYrw4URc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soM8x-007CXl-Dx; Wed, 11 Sep 2024 14:08:19 +0200
Date: Wed, 11 Sep 2024 14:08:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	netdev@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Message-ID: <0a7f2282-cbd0-4f27-bfe4-30b0c1a4705b@lunn.ch>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-12-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-12-b0d3f33ccfe0@linutronix.de>

On Wed, Sep 11, 2024 at 07:13:38AM +0200, Anna-Maria Behnsen wrote:
> Function descriptions in iopoll.h, regmap.h, phy.h and sound/soc/sof/ops.h
> copied all the same outdated documentation about sleep/delay function
> limitations. In those comments, the generic (and still outdated) timer
> documentation file is referenced.
> 
> As proper function descriptions for used delay and sleep functions are in
> place, simply update the descriptions to reference to them. While at it fix
> missing colon after "Returns" in function description and move return value
> description to the end of the function description.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v2: Add cleanup of usage of 'Returns' in function description
> ---
>  include/linux/iopoll.h | 52 +++++++++++++++++++++++++-------------------------
>  include/linux/phy.h    |  9 +++++----

For the phy.h parts:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

