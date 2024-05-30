Return-Path: <netdev+bounces-99416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C38D4CCA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959651C21D99
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0917D896;
	Thu, 30 May 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fXzidWXs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090717D88D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075847; cv=none; b=e4UaI7ZXsMUTLt1+URRTnsM4gQyxWI8sjjN6xCy0gGCNoxrzjfynvacYJXsXKYoIO0XvnI90fUreq9Ef48jLSDKFX6Vsq6KwkkyIW1ZJxaN26WOGiXN43+eABFkf+ZsX0q5xtz8y9WrXWh6VA7ev6KUWH7+vBSUlS28rLmeMIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075847; c=relaxed/simple;
	bh=90b7sEN3tYA7VvMXhlCSJ77ss+2U+2bNczU7vinqsNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1tbSxeVtkQrf4ba0GAT7Y6RRSKD5dDCtaJV/ZzwzROuhZhSASvpkOmLky0gfdV/cLiQeCYS8HN1v/xpjJsMzDf1lC0CAJOlsVKUFan2r0bH5txqrL3DaBCZsjL0sDHmYsjKi2a+Y/iFg0Tmjd89cFu9pyy/VnLf1bBLD+bEHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fXzidWXs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AlcdGR/TNJCJ9B9a8gxG3pQ66piQItU4U9QUNXvULVY=; b=fXzidWXs+T82OikElY/knNbM0r
	vJTLw6E7qCGkp1GyicB3/ZSTEpM3e74owWfkB4hcFiJdjGQIsp/VEYLAPPQ0gS29ysqEca2At7GEl
	f/jiEf3PrD3sug6BhLB+/UQNaG74bct9pohLhSW59o2CLe2HMaRzbfeTKly75Z4FE4zI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCfrg-00GLqK-1x; Thu, 30 May 2024 15:30:44 +0200
Date: Thu, 30 May 2024 15:30:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net
Subject: Re: [PATCH v3 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Message-ID: <eb24812f-a8fc-400d-954c-6bc0d5d6b5d8@lunn.ch>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Thu, May 30, 2024 at 10:24:31AM +0000, Enguerrand de Ribaucourt wrote:
> Back in 2022, I had posted a series of patches to support the KSZ9897
> switch's CPU PHY ports but some discussions had not been concluded with
> Microchip. I've been maintaining the patches since and I'm now
> resubmitting them with some improvements to handle new KSZ9897 errata
> sheets (also concerning the whole KSZ9477 family).
> 
> I'm very much listening for feedback on these patches. Please let me know if you
> have any suggestions or concerns. Thank you.

Since these are Fixes, please could you base these on net. Also
include a Fixes: tag.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

    Andrew

---
pw-bot: cr

