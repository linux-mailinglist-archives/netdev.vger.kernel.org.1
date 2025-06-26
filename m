Return-Path: <netdev+bounces-201444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0FAE97BA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A417B2BF6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606BC25CC55;
	Thu, 26 Jun 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jdnyfye9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qdyH+Vf8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8C25BF02;
	Thu, 26 Jun 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925502; cv=none; b=dv2xnM6dqJ63t0GvuPRAwL0W8jWw0v3WsaBA7PNNQZhwO0VuL/Y6nq4l2I09qaAiMieJ1bgqLjJlJMAMmXuXw38GOfAqEe86iLxDbgX4XkZaDgDvsO+pYp8QP0wSddwwTMPJ6Hh5q03VFbgbYaHDSlnUjcbiWtRDkvwhjfGZqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925502; c=relaxed/simple;
	bh=j9u46I69AlTko3jmPEDR06+yT1EO1nEQB3WZ7fdbZYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L6WrOtp9Vp2Gy31Tm8/VoSWmX3IArWzFESLabOTEUhmL2ggKYWj2epD9J14Oun5jIagQvxvAe7idAtAwlbZb/c7F8n13Q/CWiBGQ0GJ/nn+fMeEg+PnMPOkqbpD1/tzQTFhaE5T4E+wzRwPNh2mlvLfBhENkx+xt3GoXGeYY9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jdnyfye9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qdyH+Vf8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750925498; x=1782461498;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5o0zE2Ql23MwZK+6c1i+ITLVgBdNKn0CMalQ4FgHLcU=;
  b=jdnyfye9rykMK2DO2ef9PalbRar8ADssvl9Vuwye1b2v/retZaV5/Usv
   MlRwgspPkbLTM9M4nK7SFt+1AQo+o7GqU6NyyL73cXkQ2r281a+yuAKhV
   h2ywGxmwuySaEYdiNghNZ4uO9exYrV08sJRwmLFDT7LqVvd95fwncFDEp
   IWL/KhLnsK3hzDACj17Tijy8RP6481utEeWDM5JOyx1j46ZfpVmgtZ0Ve
   1Dnfkf7eIO3AyAph3TdgFO1Uv3+6po02bcbEIC21eJJ9WSnX8ArLhlzZ0
   6oIts32aW/nV9RYCimuKCZssp/r+XSB7LwLCaz6mCTRXu44FFFq/50Wu5
   Q==;
X-CSE-ConnectionGUID: 8Mcq54x2RQq4JTkCC9tAQw==
X-CSE-MsgGUID: dDrWJAs0SQuNM3nCxllHBg==
X-IronPort-AV: E=Sophos;i="6.16,267,1744063200"; 
   d="scan'208";a="44863704"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Jun 2025 10:11:27 +0200
X-CheckPoint: {685D00AF-2B-468F1319-EAD2FB43}
X-MAIL-CPID: 71DAA6DCB64509743559210ADBB65D86_0
X-Control-Analysis: str=0001.0A006368.685D00CB.0055,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6DF4165D19;
	Thu, 26 Jun 2025 10:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750925483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5o0zE2Ql23MwZK+6c1i+ITLVgBdNKn0CMalQ4FgHLcU=;
	b=qdyH+Vf8l2KyL61bCy0nIgFKLs+w3cbh2J4qbwl9+fDuZDZIMwHZRzwHvgezrKsZQcPApP
	DrUXNNHyZNo42WJdllDwILcuqjY8JlJX+AnbhAjhyHF9ERITBMVvcI64rVBnGlrVTJeK9c
	fShkgbqPLKgNH2+rj8woL1uptCA9QK4+aF5FJF73ijYjzzjQjz/T9d2YEH3A3mHYPyJXPl
	tzoEgMASp7pbHfCRvisreMIj9zCtINDLE/ovN2ckD2HlR9nEfcGfibQNTenhNX+sywrZdN
	kHePOizgXpT196B7sZZbQ1dI4tdkaB2yDRz3R3bQDFVh/ejgQhUytZRyq7xbeg==
Message-ID: <f593ed6162e34aa354eff6cc286cb24294195ee1.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next v2 3/3] checkpatch: check for comment
 explaining rgmii(|-rxid|-txid) PHY modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>,  Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Date: Thu, 26 Jun 2025 10:11:20 +0200
In-Reply-To: <c954eabf-aa75-4373-8144-19ef88e1e696@lunn.ch>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
	 <bc112b8aa510cf9df9ab33178d122f234d0aebf7.1750756583.git.matthias.schiffer@ew.tq-group.com>
	 <c954eabf-aa75-4373-8144-19ef88e1e696@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 2025-06-26 at 10:02 +0200, Andrew Lunn wrote:
>=20
> On Tue, Jun 24, 2025 at 12:53:34PM +0200, Matthias Schiffer wrote:
> > Historically, the RGMII PHY modes specified in Device Trees have been
> > used inconsistently, often referring to the usage of delays on the PHY
> > side rather than describing the board; many drivers still implement thi=
s
> > incorrectly.
> >=20
> > Require a comment in Devices Trees using these modes (usually mentionin=
g
> > that the delay is realized on the PCB), so we can avoid adding more
> > incorrect uses (or will at least notice which drivers still need to be
> > fixed).
> >=20
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>=20
> One question, how should this be merged? The two DT patches might want
> to go via the TI DT Maintainer. And this patch via the checkpatch
> Maintainer? Or do you plan to merge it some other way?

The first two patches should go via net-next I think (the first is DT bindi=
ngs
only, the second one modifies the AM65-CPSW driver), although I would prefe=
r to
get a review/ack from a TI maintainer, too.

I don't know what tree checkpatch usually goes through, MAINTAINERS doesn't=
 list
a specific repo. The whole series could be merged via net-next if that's fi=
ne
with the checkpatch maintainers.

Best,
Matthias



>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20
>     Andrew


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

