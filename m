Return-Path: <netdev+bounces-138687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB49AE8B0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C5C1C21DF3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E51E7C08;
	Thu, 24 Oct 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FWAJDsxh"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E01F8EFA;
	Thu, 24 Oct 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779762; cv=none; b=pEZ9oinEytak6d3vMuCPkFZgMtJcc93CdDaSV8ZL81WSRlrsMehq7FVUFNO6cTajVbW0rTUECqBcS8NtrOUBdSNX5bscly8EK7dhnoGSwW2XtMQyfz0MladgcS85Ws1ZvlDhbM4ZXbSQvkyP3Ibz07D2jPDhzVOwpFviYmQHw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779762; c=relaxed/simple;
	bh=lPV1yWvlooeisusKmZKwVckn9G3uzeBODmUCjqE3y/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NycfzTvfzAIJEc3U+BlmUNVibsxdpAxPYkHNUgDi9bf71zydEqvU/vSl898hFSzKjb9/e7mV3g3pPIHA7yTTvFGH6IyLzXb7Fp8f8SsBvpdNoHZQIFNAsvNtiRwTxSlVHapZN/EzrBGKcDzyqylW6sPNzLFlu4fNcf6ic5ZizlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FWAJDsxh; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBB486000F;
	Thu, 24 Oct 2024 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729779756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPV1yWvlooeisusKmZKwVckn9G3uzeBODmUCjqE3y/c=;
	b=FWAJDsxh66/UfoSazI4jZ2q2PFuwZtTV6l595EnpO+Bz+h90+T+7iHwFcTVnkMwqBcPtaI
	sJ0BL0TysiJTOIvkMTe+Oj1dnACdlz/JMCCN++3ZTOhYGcDWZiOLoj48lmJ1wzwNPXfCv0
	aeB49U7aVx6b76Novs+sDq0jmQEHvXffhyXidluPMf2jrdJ3UhB7hmLsmUezVmGNoGO5qv
	CixrWRvKV6GbxNrhGU7YL4qtnFk1ohNocH7oQ94CNx2CTLInNbfS/sa2yQY2DqhRZuNiZe
	nn3Ww57lZiHFD8xhn9zHuJJiuuFTe1uq9z1CofVBpWDKutDLU3YNxrTvHUUKHQ==
Date: Thu, 24 Oct 2024 16:22:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v18 00/10] net: Make timestamping selectable
Message-ID: <20241024162232.038be0ac@kmaincent-XPS-13-7390>
In-Reply-To: <20241024140422.3okn5lfqu72ncbxa@skbuf>
References: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
	<20241024140422.3okn5lfqu72ncbxa@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 24 Oct 2024 17:04:22 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Wed, Oct 23, 2024 at 05:49:10PM +0200, Kory Maincent wrote:
> > The series is based on the following netlink spec and documentation pat=
ches:
> > https://lore.kernel.org/netdev/20241022151418.875424-1-kory.maincent@bo=
otlin.com/
> > https://lore.kernel.org/netdev/20241023141559.100973-1-kory.maincent@bo=
otlin.com/
> > =20
>=20
> No point in posting a non-RFC patch revision if it conflicts with unmerged
> dependencies. Since it doesn't apply cleanly, the NIPA CI won't run on it
> and it won't be a candidate for merging due to that. But, if you post as
> RFC PATCH v18 instead, you make it crystal clear for the reviewers involv=
ed
> that you only request feedback.

I naively thought net maintainers could rerun the CI after these patch get
merged. I will need to repost a v19 later then.
Sorry for the noise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

