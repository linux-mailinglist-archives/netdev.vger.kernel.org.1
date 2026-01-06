Return-Path: <netdev+bounces-247428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C35CF9ECF
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 603F63052442
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331C36CE00;
	Tue,  6 Jan 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0saUnUTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC136CDEF
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722319; cv=none; b=XiU1QCyuYh/n+o5uj3qXrwpT9l8zwvgAAkvpZevSIy2Gl6vn3V6Gh2TL87j6eAkQUSHOK/GUPvjIReJ7FqzWEabw0cgDyLlKNHIf+gOCsW8fjnPGamgJosvXChsr146gA4MzzHdBfSfEXHva+10lUN7BVq+hAtuSG4T5IjDUWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722319; c=relaxed/simple;
	bh=ae64ZmpfFXEFLS3nILt1xT9/HZrFVVWEHqZBXE+spEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLS1bvJ8k8OSzefwzUAprH3UDDfd4a3rMWJY/eyQFWTFSqE0SeXSonVpoP0Fb4UC38gYpYKaF3CDLNMUd8eVt1zskNC/WX/sPX32+3VeiY/3IrhGBJ4gvU+luREPUpOhoXYDOnl4GhR7NiE7pqjvX96GPFmY7QgZoe/argzYg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0saUnUTN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 48BC81A26A6;
	Tue,  6 Jan 2026 17:58:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E17860739;
	Tue,  6 Jan 2026 17:58:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE52A103C813C;
	Tue,  6 Jan 2026 18:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767722315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RsrxbQh4TaeGXzFpi8P/cp+GVGeb7gPh5+m+hLDkfC8=;
	b=0saUnUTN0BHnTknqxAYwYNCo7cAfDu+IaqXZpsnyN/ndt5UiL01e8P5z542AkuUGdzvU07
	MO1yk2I11m5w+jgJbStdfsqtDGRfXVp4hkSVEWGTfxG6uucoOhJ9kuOtkPI63PqfG8wkbd
	cJxoHyCabefHCMfsHji3A7d2BVOYDH4l5xJe3AJhEqXIjIRVjccaldkwUxe5RTbMXU06d8
	zMxFJTDSRw5EBnoYhCvHztYdOeDyWUzyCrolh7LRvb3ctjDPPOmlDJDFs01zv3wii7iw5H
	YxZ6r712+RRaHjjcUe7gJIQZ/1PQ/8glnc8W1xtSALeH9szkL8N8dO9xQDaj4g==
Date: Tue, 6 Jan 2026 18:58:31 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] net: phy: microchip_rds_ptp: improve HW
 ts config logic
Message-ID: <20260106185831.5142c061@kmaincent-XPS-13-7390>
In-Reply-To: <20260106160723.3925872-4-vadim.fedorenko@linux.dev>
References: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
	<20260106160723.3925872-4-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Tue,  6 Jan 2026 16:07:22 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores new HW timestamping configuration values
> unconditionally and may create inconsistency with what is actually
> configured in case of error. Improve the logic to store new values only
> once everything is configured.
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

