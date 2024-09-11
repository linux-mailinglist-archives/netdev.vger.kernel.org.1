Return-Path: <netdev+bounces-127481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F99758B3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A91F24CB4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17E1AC8B3;
	Wed, 11 Sep 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GbCiEzb1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6467383B1;
	Wed, 11 Sep 2024 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073290; cv=none; b=sBKHKKyoeofghj1h44JpDdcjqaIvMiStmAdQCVjDsNikGB+yQBsU/kXnlAvchrnTVg9WQShrk9dA42du7KQ9cxMNo4hG5t49NZdsjmViviTFjkAGiZwidiXV8+2EefaxN6eIl0+KIAyf16uVwpgfQ9SdR4Hzxqk60AAj1ZaGppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073290; c=relaxed/simple;
	bh=da3t3pKkN1QkjPOVrBC4tfTfhtmmdBt9/lF4oKQitWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STBc8iE57y2JNzfJsGtvprQC2TBDrzuw6O8+xOqrTNAicuq8EtFJjQGp/Rpl5tIiNgtSvQOTOiByme6pbZKGkS73lHNB1c4IkOhnzxcWYDQfssZB5ec4zypCy5mkBnZmNG1TAswZTyr4X7SmJfz1SolV+GXetSnPxlYF1nDjt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GbCiEzb1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QEqqui/EvuUcb5mzxZw+mL+6qk7m/Nc8BxnYEiw/05E=; b=GbCiEzb1nKJah1ADUAvlTj7gxg
	ZITITZNPcH4FbGeeJCu3J0NQW9IogztPiqpodmZdT8Z44YWM8jVE6Eu2fwu2F2/24MyF9KGj8bXYT
	g+q9nZFRe5CsCH1HSH7xm6kzuLrhcjtMRajp0L/JG4cYKM5CpGCQCMMdlgyDSbCHpRgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soQVZ-007EXD-0q; Wed, 11 Sep 2024 18:47:57 +0200
Date: Wed, 11 Sep 2024 18:47:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V3] net: phy: microchip_t1: SQI support for
 LAN887x
Message-ID: <a7e330fd-9000-4b23-bec6-ae2bbfe487a9@lunn.ch>
References: <20240911131124.203290-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911131124.203290-1-tarun.alle@microchip.com>

> +	/* Keep inliers and discard outliers */
> +	for (int i = ARRAY_SIZE(rawtable) / 5;
> +	     i < ARRAY_SIZE(rawtable) / 5 * 4; i++)
> +		sqiavg += rawtable[i];
> +
> +	/* Get SQI average */
> +	sqiavg /= 120;

120?

Isn't that ARRAY_SIZE(rawtable) / 5 * 4 - ARRAY_SIZE(rawtable) / 5 

Please think about the comments being given. I said you should not
assume 200, but use ARRAY_SIZE, so it is possible to change the size
of the array and not get buffer overruns etc. So you need to review
all the code.

Better still, change it to 50 and make sure you get sensible values
from it. The accuracy won't be as good, but i would expect it to be
still about right. But with the current code, i guess you get 7 no
matter what the actual quality is.

This is a general principle in C code, and coding in general. Don't
scatter the same knowledge repeatedly everywhere, because it makes it
error prone to change. You have to find and change them all, rather
than just one central value.

    Andrew

---
pw-bot: cr

