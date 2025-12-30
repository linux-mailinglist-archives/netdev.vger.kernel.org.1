Return-Path: <netdev+bounces-246350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21DECE9855
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8FF33003FF9
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B62DAFBE;
	Tue, 30 Dec 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dpoVtzTX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EC1EEE6
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093269; cv=none; b=Q97y5mh+vMk12vH+kKbIWq8QRumSTAYZHMWOI5+UYbnfjzXAgXCA91OEr0A6KzmXr9PheRbg9gsn83tELJRBTXFH9d7/lEYHVbzXhunNnY3+7TB2DagQNWe+1h6XD/P8I4nwIBujObgrIq5gk26jbkexUZDdm4vyNMPRQZNlJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093269; c=relaxed/simple;
	bh=PsDOVr9G171kxzNyWjXrDjlPgqkr6UsUSrS0jrQr8wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDV1DFKbmt9r1OQ0j8jZqtl6piVJQfKtsNENukLg207UH3RGFwBFbhjwPwpTT5oOWhqndOj/m6u8LyM57YOP5NtPYtS6SitsOQIbL7g/htwENcan0nqCs54C2/ldPTPu+yDCh1+cLcDM4jq1K/rxTYe6cPcJJ2+HtKaQr/gAFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dpoVtzTX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OGXDGY2WSqwww84tPSLtu55THonmBMVDWSj9x6kTX+0=; b=dpoVtzTXnCTxxOFMoapqen4ZCV
	LlZzxLy68SbXGYu2Mzz2g6e35k++6JyH52cyZgqzjCZHbTR8lU5yBDu1IUiFmEaeBNyecJCwgILak
	4r6mnYIdjn8ux2sf48jpa4bIARNzuqRJSuMlTxdIIKv8SxVZYEf6xTQ4wxfSUqeIC2E4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaXg8-000rlj-Km; Tue, 30 Dec 2025 12:14:16 +0100
Date: Tue, 30 Dec 2025 12:14:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	Vadym Kochan <vadym.kochan@plvision.eu>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: Re: [EXTERNAL] [PATCH net] net: marvell: prestera: fix NULL
 dereference on devlink_alloc() failure
Message-ID: <5537818d-054f-4765-ab70-ac7648fcb2ae@lunn.ch>
References: <20251230052124.897012-1-alok.a.tiwari@oracle.com>
 <BN9PR18MB4251DB54F86CFD7CA792EECBDBBCA@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR18MB4251DB54F86CFD7CA792EECBDBBCA@BN9PR18MB4251.namprd18.prod.outlook.com>

On Tue, Dec 30, 2025 at 10:12:23AM +0000, Elad Nachman wrote:
> > 
> 
> > 
> 
> >From: Alok Tiwari <alok.a.tiwari@oracle.com>
> >Sent: Tuesday, December 30, 2025 7:21 AM
> >To: Vadym Kochan <vadym.kochan@plvision.eu>; andrew+netdev@lunn.ch; Taras
> Chornyi ><taras.chornyi@plvision.eu>; kuba@kernel.org; davem@davemloft.net;
> edumazet@google.com; >pabeni@redhat.com; horms@kernel.org;
> netdev@vger.kernel.org
> >Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> >Subject: [EXTERNAL] [PATCH net] net: marvell: prestera: fix NULL dereference
> on devlink_alloc() >failure
> 
> > 
> 
> >devlink_alloc() may return NULL on allocation failure, but 
> prestera_devlink_alloc() unconditionally >calls devlink_priv() on the returned
> pointer. This leads to a NULL pointer dereference if devlink >allocation fails.
> Add a check for a NULL devlink
> 
> >devlink_alloc() may return NULL on allocation failure, but
> 
> >prestera_devlink_alloc() unconditionally calls devlink_priv() on
> 
> >the returned pointer.
> 
> > 
> 
> >This leads to a NULL pointer dereference if devlink allocation fails.
> 
> >Add a check for a NULL devlink pointer and return NULL early to avoid
> 
> >the crash.
> 
>  
> 
> >Fixes: 34dd1710f5a3 ("net: marvell: prestera: Add basic devlink support")
> 
> >Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> >---
> 
> > drivers/net/ethernet/marvell/prestera/prestera_devlink.c | 2 ++
> 
> > 1 file changed, 2 insertions(+)
> 
>  
> 
> >diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c >b/
> drivers/net/ethernet/marvell/prestera/prestera_devlink.c
> 
> >index 2a4c9df4eb79..e63d95c1842f 100644
> 
> >--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
> 
> >+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
> 
> >@@ -387,6 +387,8 @@ struct prestera_switch *prestera_devlink_alloc(struct 
> prestera_device >*dev)
> 
> >
> 
> >            dl = devlink_alloc(&prestera_dl_ops, sizeof(struct prestera_switch
> ),
> 
> >                                            dev->dev);
> 
> >+          if (!dl)
> 
> >+                        return NULL;
> 
> >
> 
> >            return devlink_priv(dl);
> 
> > }
> 
> >--
> 
> >2.50.1
> 
>  
> 
> Acked-by: Elad Nachman <enachman@marvell.com>

Hi Elad

Thanks for reviewing the patch, but please could you play with your
mail client quoting settings because it is making a mess of the email.

Thanks
	Andrew

