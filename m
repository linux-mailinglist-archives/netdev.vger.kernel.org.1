Return-Path: <netdev+bounces-188611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B62AADF3C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AC63A1934
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137071E49F;
	Wed,  7 May 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y8MMpzSD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8BC182;
	Wed,  7 May 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621052; cv=none; b=R+4CsNH3qE42P8r8XgZJ7sexRUVrBfeMvVMxvYrFS9gEP+RZ2qm7iJb79BUr81OlyfFFVDtIAFgI/tXgVy9koX3z3j4izyTKuZxYMdtRkFJ3jdYqhCejwq4HyaHQVBHomsoSCKb5RQhYIARlD9ujmWYjvoEQHI1ckpOh3GspPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621052; c=relaxed/simple;
	bh=Vxx0ACGp24sVEd5SknbWJ5uvARr7Cg9cs0xZD85ZQPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOlOzuYVew+ue/AuoPgMSMqp+o18ftxZ+1t5LH//17CJCk0jQNMEAzbrauAexxNpEHp5cg9UYHpKHqMT87kL4cdjTN4te7XlxuUcZrM6SIZCdnv9B02HlBQSNrXjdXwO2vgv7J6OFy6Cli9ztDOwvFeB6wJk+tzssVA3ioEiJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y8MMpzSD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cPP8m0+ZommNldXRYZax/cEqIRhtEpGo2CITzC/JUH0=; b=Y8MMpzSDzRMbLUu84SadJnxduB
	ePjoEcOS7thXdPHJO5F65rZWdmdbWL2Y0gNkcRXc7o4LOSANkwZ0zevQJ3ih9RSpDYIOJoZfiNJzo
	Z4M66AORgEhpb3VAxghF4mOgk+oXGSPMrhxwGblYTLg3242EOaupHg/keO/wM686Swn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCdv8-00BsVe-50; Wed, 07 May 2025 14:30:42 +0200
Date: Wed, 7 May 2025 14:30:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: remove MDIO support
Message-ID: <f4221c9a-751a-4ab2-8544-7d90b2f320fb@lunn.ch>
References: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
 <aBquZCvu4v1yoVWD@finisterre.sirena.org.uk>
 <59109ac3-808d-4d65-baf6-40199124db3b@gmail.com>
 <aBr70GkoQEpe0sOt@finisterre.sirena.org.uk>
 <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a975df3f-45a7-426d-8e29-f3b3e2f3f9e7@gmail.com>

On Wed, May 07, 2025 at 08:49:15AM +0200, Heiner Kallweit wrote:
> On 07.05.2025 08:21, Mark Brown wrote:
> > On Wed, May 07, 2025 at 08:09:27AM +0200, Heiner Kallweit wrote:
> >> On 07.05.2025 02:50, Mark Brown wrote:
> >>> On Tue, May 06, 2025 at 10:06:00PM +0200, Heiner Kallweit wrote:
> > 
> >>>> MDIO regmap support was added with 1f89d2fe1607 as only patch from a
> >>>> series. The rest of the series wasn't applied. Therefore MDIO regmap
> >>>> has never had a user.
> > 
> >>> Is it causing trouble, or is this just a cleanup?
> > 
> >> It's merely a cleanup. The only thing that otherwise would need
> > 
> > If it's not getting in the way I'd rather leave it there in case someone
> > wants it, that way I don't need to get CCed into some other series
> > again.
> > 
> Understood. On the other hand is has been sitting idle for 4 yrs now.

It is something that a PCS driver could use. They are sometimes memory
mapped rather than being on an MDIO bus. Using a regmap could hide
that difference.

     Andrew

