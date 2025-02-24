Return-Path: <netdev+bounces-168937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE956A4195B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661577A3459
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356F204C24;
	Mon, 24 Feb 2025 09:40:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595B244195
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390055; cv=none; b=XTS2pKvgVA25gN5hpJK+AVjG3aDQyNpauBMQdmysnQZNGoQIwPK7OdIfW5h3KHuYidlVSSTmaJT/vSFe/MfY2TrNeIp2Bs1D9+fCtUksIc1l7JBhl/7Xuj1wf3ZZFmJmd2ZNZ2YTlU+6wv5kwUiJayFtVjklaVM257/L2H8V3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390055; c=relaxed/simple;
	bh=77EzYoZUF43HBB8Dl3uLZFOSIXC97HG5NNlM1an3LAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOsuFqIH3nHD9kYUPvy/kzrMXqsMt6Gm1aP02jTvOVMeHpyVz0OzpVK1N2G6ReicfSC+rLW/BanBoD5lwgu34F3GvxDosrvwxX/NuGDkT4utqUWUj6SGUzn4cTOweSBnkNU+9omNZfmomSo21p7AAeHB3XwKobTMBINuAyP5oSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8E501508AE;
	Mon, 24 Feb 2025 09:34:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 2B4DF2F;
	Mon, 24 Feb 2025 09:34:37 +0000 (UTC)
Message-ID: <26d2832ce7aba1c919e8dcb4aeb8fa2abacedb01.camel@perches.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate
 setting
From: Joe Perches <joe@perches.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Jakub Kicinski	 <kuba@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Drew Fustini	 <drew@pdp7.com>,
 Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>,  Guo Ren
 <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Date: Mon, 24 Feb 2025 01:34:36 -0800
In-Reply-To: <Z7w3QhcYhrzQk_5K@shell.armlinux.org.uk>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
	 <Z7sJHuiqbr4GU05c@shell.armlinux.org.uk>
	 <7bf9577f4b6dcb818785be73c175bcd19b3b4f0c.camel@perches.com>
	 <Z7w3QhcYhrzQk_5K@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2B4DF2F
X-Rspamd-Server: rspamout07
X-Stat-Signature: dzm4ebumxtwbyyqoo1qbgsybk7dqegac
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19mBx6pJ7hyud4Lf2EQyjPbmTA3e2vOugg=
X-HE-Tag: 1740389677-133558
X-HE-Meta: U2FsdGVkX1+5N1cDj+qw+umh28c+txKOgSUaaH0dqayci6ieB+Ae13yavbq9POxom5oeQHC4HdNuhPPmPXsSLd6Kpm9LqlFkdNzx1GkHImNhRB13sgX3E9525FyqznfvneP4+hF++evJu6CNqffpmVg1w5vIQJ+eSmDnBRBIPwqGHQV6wa9+r8Hijv8uD4Dfo1v9G5WQdMJJm96RAmQlvhjafuvnyZ1wBKpVJ4TTz8WQv82S2MqdXywz7IMMkS6J6OyG/v4gKkMIIPJ5J5Bnzf00AFODjrS82yb8FceibNoD+TOsaVTYKq/b47q0Xaxbrvvw8gvOLc/eYvRxvrTBydl20Rd4LDryFoqCticI/znHw9PE2ecmGNR9vjhgtjLr

On Mon, 2025-02-24 at 09:09 +0000, Russell King (Oracle) wrote:
> On Sun, Feb 23, 2025 at 06:33:44AM -0800, Joe Perches wrote:
> > On Sun, 2025-02-23 at 11:40 +0000, Russell King (Oracle) wrote:
> > > Adding Joe Perches.
> > >=20
> > > On Fri, Feb 21, 2025 at 02:15:17PM +0000, Russell King (Oracle) wrote=
:
> > []
> > > I've been investigating why the NIPA bot complains about maintainers
> > > not being Cc'd, such as for patch 1 of this series:
> > >=20
> > > https://netdev.bots.linux.dev/static/nipa/936447/13985595/cc_maintain=
ers/stdout
> >=20
> > Additional maintainers added or missing?
>=20
> Let me be clear - NIPA is not something under my control. It is a bot
> run by Jakub on netdev patches that are received by patchwork - so
> patches that have been emailed out, and thus contain at least the
> To:, Cc: and Subject: header lines, possibly all header lines that
> have been added such as Received: etc. I don't know what it actually
> does.
>=20
> Now let me restate the problem, because the answer to your question
> is in the problem description. Here's the short version:
>=20
> 	K: entries match email headers.
>=20
> Here's the long version:
>=20
> If one runs get_maintainers.pl on a patch produced from git, it
> comes out with a list of maintainers. In the case of dwmac-thead.c,
> this includes an email address that contains "riscv".

Yeah, I got all that from your first cc, thanks.

Which is why I suggested that the nipa bot use
get_maintainer.pl's --nokeywords option somewhere.

I don't use/control/read/write/care_about the nipa bot either.

cheers, Joe

