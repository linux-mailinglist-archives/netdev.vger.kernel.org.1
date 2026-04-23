Return-Path: <netdev+bounces-280771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM3JGtsm6mnkvQIAu9opvQ
	(envelope-from <netdev+bounces-280771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 048794536ED
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300D83001A78
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512A309F1C;
	Thu, 23 Apr 2026 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="Fmw1vFHr"
X-Original-To: netdev@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFE29D26C;
	Thu, 23 Apr 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952930; cv=none; b=K4qP92MNFeKLErqZTeK+7Vd6jY/681LUuazeFBAmW0Z+0MXTBYq2rsUwSfFYekaQz4wWh8CekFKgctBoETDqpMecXMZSLGj/ipUDFfFMZc2UuRYH+WfU23fvgENu+FT1uyenkD/M/muWTsUFY56Dwk5M/WpBmHTE2JRF2snfslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952930; c=relaxed/simple;
	bh=jI9Q+8KeYN2zjNv72wMIkDsTFIX0Tl19jG7hy2QvQ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO7/Cquz5kITSoJv0JnJ3hOYKS8ZoINNDLRyL3KZzJ2yEVjZjQtTOWG88ncuxS/l9N1m+Ho74OLQ9Hmqtqko4Om68+TlggoJ3mtLTHNGvNyj2ZUQvsRf6e25Z6LrcXPk+g9m2KsNPOGsw/2vgGDfoO453xrYezMMe8MZvGP4NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=Fmw1vFHr; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k27.isilmar-4; t=1776952925;
	bh=jI9Q+8KeYN2zjNv72wMIkDsTFIX0Tl19jG7hy2QvQ0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fmw1vFHrjaDO/kDX2ynRaFAiYgh7flPfA5jU4qCEeKWa0R1f8N67PLatniDUEc7VS
	 JBFMVNgnxtmZOQgtpCYD2un5Pk9fWmpDvo9ZtDwu1rQrQDTtWcfTkuwwduB8go/cFV
	 HQtwbAiPFPWmgZxDEO6S/fbgkQVFRTJ0+oLErjpKNMFJnVW2J8oT2GNeY8Pl0wqd9g
	 +3X5/41+LV4x1BWn0s6tg454BGQ5KSgnPKBKTX02AiMrWu4cbvp3aw8gJMHBTfAQSz
	 yxwjTJLqfUV4C8id3BU61rDl/3aQJvFN8GltkCyKpqs69/jsjzPuPmUOSI5+sNEq9b
	 83/8HCsg64RJw==
Received: from scops.dominikbrodowski.net (scops.brodo.linta [10.2.0.113])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 557FC2008A2;
	Thu, 23 Apr 2026 14:02:05 +0000 (UTC)
Received: by scops.dominikbrodowski.net (Postfix, from userid 1000)
	id B869480066; Thu, 23 Apr 2026 16:01:54 +0200 (CEST)
Date: Thu, 23 Apr 2026 16:01:54 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Fritscher <michael@fritscher.net>,
	Byron Stanoszek <gandalf@winds.org>,
	Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 13/15] drivers: net: 8390: pcnet: Remove this
 driver
Message-ID: <aeomUh5JqFvkLTH7@scops.dominikbrodowski.net>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
 <aemy5Lm9B2dLItdd@isilmar-4.linta.de>
 <97a5bd32-5080-4dd7-91c6-dcb65e154481@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a5bd32-5080-4dd7-91c6-dcb65e154481@lunn.ch>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[dominikbrodowski.net:s=k27.isilmar-4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dominikbrodowski.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dominikbrodowski.net:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@dominikbrodowski.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dominikbrodowski.net:dkim,scops.dominikbrodowski.net:mid,lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 048794536ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Thu, Apr 23, 2026 at 02:04:10PM +0200 schrieb Andrew Lunn:
> On Thu, Apr 23, 2026 at 07:49:24AM +0200, Dominik Brodowski wrote:
> > On Wed, Apr 22, 2026 at 01:01:56PM -0500, Andrew Lunn wrote:
> > > The pcnet was written by David A. Hindsh in 1999. It is an PCMCIA
> > > device, so unlikely to be used with modern kernels.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  drivers/net/ethernet/8390/Kconfig    |   11 -
> > >  drivers/net/ethernet/8390/Makefile   |    1 -
> > >  drivers/net/ethernet/8390/pcnet_cs.c | 1717 ----------------------------------
> > 
> > NACK for this one. This is the most common PCMCIA networking device, so
> > should be removed only once the rest of the PCMCIA subsystem is removed.
> 
> Please submit a patch to MAINTAINERS making yourself the Maintainer of
> this driver, if you want to keep it around.

Feel free to move the MAINTAINER entry for this to the PCMCIA subsystem, as
patches will be handled then via the PCMCIA tree anyway.

Best,
	Dominik

