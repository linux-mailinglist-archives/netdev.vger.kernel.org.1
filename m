Return-Path: <netdev+bounces-148672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345FD9E2D40
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130CB163C55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3F1F76AB;
	Tue,  3 Dec 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jMe+1BbZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F68205AB3;
	Tue,  3 Dec 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258217; cv=none; b=e45yjlCKIYy+rURmK7+TiJvynOEnTairEFnLoeUFUwCvkefR1utWenOX7l8Cv+YnuWJUIGDM2X4A2R1/EdJSxyZcpzejriQPi6dEmq3YyJNsdGgA730Zvm6sY38UA4WEoaqX86EDJtteVEou89T9VYY0S+xWC5kph9nq4K9joKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258217; c=relaxed/simple;
	bh=brbCmjPpCDFBiYyuAzGALwEsrcSOoaf4rvyO532Rwk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtuSM2jyXRnVNwnvoiG9qbjD+JIjOkFjh90kHOlQZRtE8bSlwmT+WI5YnxfFE42OP2ImnxnCvqKC3Q/ao1SBKX16N1v8keU2n3rk0WL0Q7sjVh0mpZw80RtRFlRSGGzgm3KCmFdYNgoE4OFHNbpbChWVX1BnqU41gQAWujXfDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jMe+1BbZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wf+V5agvOfx5VoqcyHZmUeVKHTnzX4XiCC/HTzsEsjg=; b=jMe+1BbZfjDHL/kOWH0bQvQTlu
	JsG/3CeNzrOv0b5p1GXLaXuEpKvidxEIffGYytVthtLfwqYJOEW5GBa0swjtv0LVQaC8nw/utUkLZ
	Vig4O8ycsyheFEVRCvRhpqp99sO1F9AUT6+XMMJ80j2nmWe7QcS0TBIyMvTQd1BG1YUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZda-00F8C9-D9; Tue, 03 Dec 2024 21:36:50 +0100
Date: Tue, 3 Dec 2024 21:36:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 07/21] net: usb: lan78xx: Add error handling
 to lan78xx_init_ltm
Message-ID: <b1c91593-2a45-4a95-a9bb-562d5b01e477@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-8-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:40AM +0100, Oleksij Rempel wrote:
> Convert `lan78xx_init_ltm` to return error codes and handle errors
> properly.  Previously, errors during the LTM initialization process were
> not propagated, potentially leading to undetected issues. This patch
> ensures:
> 
> - Errors in `lan78xx_read_reg` and `lan78xx_write_reg` are checked and
>   handled.
> - Errors are logged with detailed messages using `%pe` for clarity.
> - The function exits immediately on error, returning the error code.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

