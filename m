Return-Path: <netdev+bounces-133307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B606995924
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3515B280DBF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055A17C7BE;
	Tue,  8 Oct 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="38rrlBxw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84E2574B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422202; cv=none; b=JutMEO1xpqAoHfsWek/s3oWv2W0INlETnvNch2YBKJTHeI33xky+6XY3OVtcYAFJpdxfImdoUEmyYzXDem/T6fH4vXtiWgPHiWNFy9rU7+VvRcUFufafc1qn1Uq+4CUtv0p1pedwbWmaeSCiLcEF6d1Z0Y/DvBRSKcpRpqwoDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422202; c=relaxed/simple;
	bh=/kX+Zm+j0o71BxpwBPtyJSAjKl0KSg4OpDtGA17IIOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inZosdJXeigeX3aVbARXwTUKsKQZZNmad3Itq4mQLR3d6ZeUmSxVBEWCSVd2+7CElvy+7060bzidlMZsj42Dj4g3MoB7hfyREHkoe8gYAlp7+/do1yBSViomvie6Kq6BgNjrqMQosh3Ie05d8n+5hJ1wNbVtub5j/JQqLY4soP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=38rrlBxw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gD7EX2Me6nbxffN8Kbhn07VmENOi9AlNhZYasvYT2Z0=; b=38rrlBxwifmVFQWxSomcXNZxrV
	zZZlH0/sWGV6r1P876CNh9XIZis/s390nJcTAm2N7SkVgxUTtLkM/jtgZZgDUiaBI+U2p5/4e7LQJ
	J1ALMKGMjvN7QYB9ArUQRyki3pl5OeHsaE8A8XbXTPzohWM56oC93i7qpxiNSGcwFCrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHZN-009Plm-TY; Tue, 08 Oct 2024 23:16:37 +0200
Date: Tue, 8 Oct 2024 23:16:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net v2 1/3] net: dsa: mv88e6xxx: group cycle counter
 coefficients
Message-ID: <7b49ecfd-8fb8-4817-be35-14cb9e3bfc1c@lunn.ch>
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-2-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006145951.719162-2-me@shenghaoyang.info>

On Sun, Oct 06, 2024 at 10:59:45PM +0800, Shenghao Yang wrote:
> Instead of having them as individual fields in ptp_ops, wrap the
> coefficients in a separate struct so they can be referenced together.
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Signed-off-by: Shenghao Yang <me@shenghaoyang.info>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

