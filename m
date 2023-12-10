Return-Path: <netdev+bounces-55650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BB80BCD0
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18EE1F20F02
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861251C683;
	Sun, 10 Dec 2023 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VQUL9XDr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3AF1
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k9BvOQCDihWFs6btfwK8gJPhn3WeEDmZpDFy9mNdRjI=; b=VQUL9XDrVFYlCgDik2qKn24zN1
	dNBh8BK7ljUqy2QbXpWKOpavT5DLACF5HV71fFBrbs6EU8dgeHqF7O1yqN7QSICylVRHwbb3Ct64c
	85OF9l/GVVzQWH6Sg05m7rgl19OhQ2du8CXjlAhI+YC1Q5YrS+JB390+sY9384+M5KU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCPrw-002XvX-8P; Sun, 10 Dec 2023 20:53:40 +0100
Date: Sun, 10 Dec 2023 20:53:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	thomas.petazzoni@bootlin.com, netdev <netdev@vger.kernel.org>
Subject: Re: mvneta crash in page pool code
Message-ID: <f297f634-329c-4e6c-86e7-3e0db9ebe4ba@lunn.ch>
References: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
 <871qbwemvb.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qbwemvb.fsf@BL-laptop>

On Fri, Dec 08, 2023 at 04:26:48PM +0100, Gregory CLEMENT wrote:
> Hi Andrew,
> 
> > Hi Folks
> >
> > I just booted net-next/main on a Marvell RDK with an mvneta. It throws
> > an Opps and dies.
> >
> > My setup might be a little bit unusual, i have NFS root over one of
> > the instances of mvneta, and a Marvell switch on the other
> > instance. So i included a bit more context.
> >
> > I don't have time to debug this at the moment. Maybe later i can do a
> > bisect.
> 
> is it solved by
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=ca8add922f9c ?

Hi Gregory

This problem has been solved in net-next by a patch from Eric.

     Andrew

