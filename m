Return-Path: <netdev+bounces-234712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D8C2652A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D593B1D5F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239902F5A14;
	Fri, 31 Oct 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jXuFGPjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3526ED55
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931111; cv=none; b=qLDc5R7pROvG20U3BYKwc+RwQNlcefRTEbTT2LwXeh0UxV51thGRIuhu5J07a/KBj+Js0v0esk5qMPuQYPCrHkILfqnU0BUIgRf3FjbXMkvYu4HPxfYUyB39+z7bgIQFvi5H5TpH6jkKNerNnT9k7HuxvAgL05UPwxI20gLhZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931111; c=relaxed/simple;
	bh=Iq9Qs7TAm7VWsOF3Jc9Pi05pYb5NqTrkfRimiYCw2Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kflt0apGA7EGT27wVwRgt1VDtbE3BHJFN5n9XploqBJLPvnjwFfq/YXRsW5GHndnXqTdoDKqWU7INFcZQ9GIHUZWWIGTrWITHH9KlyTJ1oKpDX7SkakQ0LA3JUIU4uf/9NjkK4rxBFdsxkYx8adtdieTlLz1ZmV5UdLzwlMlwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jXuFGPjn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E8AC21A17C0;
	Fri, 31 Oct 2025 17:18:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCB9060704;
	Fri, 31 Oct 2025 17:18:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A87DF1181808E;
	Fri, 31 Oct 2025 18:18:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Iq9Qs7TAm7VWsOF3Jc9Pi05pYb5NqTrkfRimiYCw2Ew=;
	b=jXuFGPjnDWDwM2IKJ0l6cHSjokcmevow6/3uNexN76zTdrpwF4bajZ/zt2hXIeDhg2J4VE
	FwEwPwp4e2DIM0eo+TpbbUv3+ipY7pfHhwY1r47H5cSkqNn5ADDiqU99JF66oHyxROzHFM
	TH2fIzbDSAsm5ffk1AQZEOJCp2FzeMTdBpLTY3t+XpQ7xG/TS3RpoY0w5P0G6Tl44naMyj
	WzlzlfiC8f4jB4HKG171sHab049fzjSav3Bb2RBKXMJVkhxee8iwl17aUfxd8mx2uQsQYf
	KyBCrdvPybUE1Hz7N6Pn1MS0pkrdGDNBtwY+5uUwDLosplsWY70avI4/qsyvOA==
Date: Fri, 31 Oct 2025 18:18:17 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/7] net: octeon: mgmt: convert to use
 ndo_hwtstamp callbacks
Message-ID: <20251031181817.47cdcc3b@kmaincent-XPS-13-7390>
In-Reply-To: <20251031181653.2832b992@kmaincent-XPS-13-7390>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-5-vadim.fedorenko@linux.dev>
	<20251031181653.2832b992@kmaincent-XPS-13-7390>
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

On Fri, 31 Oct 2025 18:16:53 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Fri, 31 Oct 2025 00:46:04 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
>=20
> > The driver implemented SIOCSHWTSTAMP ioctl command only. But it stores
> > timestamping configuration, so it is possible to report it to users.
> > Implement both ndo_hwtstamp_set and ndo_hwtstamp_get callbacks. After
> > this the ndo_eth_ioctl effectively becomes phy_do_ioctl - adjust
> > callback accrodingly. =20

nitpick if there is a v2: "accordingly"

> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
>=20
> Thank you!



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

