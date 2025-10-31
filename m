Return-Path: <netdev+bounces-234710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18468C264A5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F22704E1E99
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2F2FBDE7;
	Fri, 31 Oct 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q7UtPrSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DC2FB09C
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930639; cv=none; b=icKQ0YSX/QV5jTGR9rd6DBLVTzzyJxFBOBDIsvsj1D+05Eg0+yJ1JtALqw+19yi/Evm5C0sHlkhkCy7A60B+qe+hvgI3+Yq1Xkrnn7QbPRywOL5k5PUrOwMSB7h/ocjHzU1mGkugO/P1Yv48/DhTXzq+DyV9zsUyFSuADeMC47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930639; c=relaxed/simple;
	bh=s5jzm5J2pLp2vYvMg8Z6xUudWYcwTs6jUcdf3df1wLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnpfT1lq/a+/YSMFemZc3XBUUE9q/x3QHEsx1FS1WDLm/wswxMAVEcI9JSZUwNaZgH+tjr7gJvao7NT/q/0cHrZPwzmJFPnDLbtpf7w09+plVnHM+3QLD7nKl8jPljgDj2sopftit4XDY++QtGT7cxxa9soU7xxKDbNYuc+WOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q7UtPrSC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9FF194E41442;
	Fri, 31 Oct 2025 17:10:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7654F60704;
	Fri, 31 Oct 2025 17:10:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05DB11181808E;
	Fri, 31 Oct 2025 18:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761930633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=32nDqmBKVToC5XZjIn+9lDUzqkxmv73uD6jiIMAifEE=;
	b=q7UtPrSCEVe6YTolk8YtAHps+syWlcEE0fjbjfAyImsanNTBjJxJD/Ms2oq8lWLMVZrw7g
	7yt4hRbZmehfTnKvbu1Rta39jM60Re2ZQ32GJsLP3am7E7c1Vnee0VwRbxarZBXt0DAjow
	++gVUsNRZQRdvR/aeTV6mtkR3WYxFOVb3VpE3pRAEM3LOloWWKq40/34tyboDHshRh7xwE
	x1UNZjFZwszaUw+TlYXLvldTPJlyQoSteV+CrZIGEBwm5NPBO95cTcx3EMZ1D4AEuDr5vf
	T3uTIrtStrR63KhTj3kV8kS4iKEgYix8kDKJGAoR0Doq+7ZopMHgKMAVmdPsJQ==
Date: Fri, 31 Oct 2025 18:10:27 +0100
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
Subject: Re: [PATCH net-next 0/7] convert drivers to use ndo_hwtstamp
 callbacks part 3
Message-ID: <20251031181027.1313b51d@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:00 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> This patchset converts the rest of ethernet drivers to use ndo callbacks
> instead ioctl to configure and report time stamping. The drivers in part
> 3 originally implemented only SIOCSHWTSTAMP command, but converted to
> also provide configuration back to users.

For these 3 patches, maybe it is better to split them in two to separate the
NDO conversion from the hwtstamp_get support. I will let Jakub with the fin=
al
word on this.

> Vadim Fedorenko (7):
>   bnx2x: convert to use ndo_hwtstamp callbacks
>   net: liquidio: convert to use ndo_hwtstamp callbacks
>   net: liquidio_vf: convert to use ndo_hwtstamp callbacks
>   net: octeon: mgmt: convert to use ndo_hwtstamp callbacks
>   net: thunderx: convert to use ndo_hwtstamp callbacks
>   net: pch_gbe: convert to use ndo_hwtstamp callbacks
>   qede: convert to use ndo_hwtstamp callbacks
>=20
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 53 +++++++++-------
>  .../net/ethernet/cavium/liquidio/lio_main.c   | 50 ++++++---------
>  .../ethernet/cavium/liquidio/lio_vf_main.c    | 48 ++++++--------
>  .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 62 ++++++++++---------
>  .../net/ethernet/cavium/thunder/nicvf_main.c  | 45 ++++++++------
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 40 +++++++-----
>  drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +------
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 47 +++++++++-----
>  drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
>  9 files changed, 191 insertions(+), 182 deletions(-)
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

