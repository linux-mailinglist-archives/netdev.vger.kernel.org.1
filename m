Return-Path: <netdev+bounces-235227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20FC2DE3C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A593AEE6F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFE623D7DA;
	Mon,  3 Nov 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NBaHNTJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F20347C3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197646; cv=none; b=FTjVKEqUkAxL8+GnG7Qxs/i3lXD08CGXSEGwbW5ZkilQdyYU+IT8LcYCK82oYwEpNsoNOyp+YeKn4w901b64msBIDwQya2gd+P1MhicM326TbiF/hlg6TDJbo7f8JbYTGoP/9IBXrwJds+32cNhKB60OM2p8y3FBAg41UPDCYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197646; c=relaxed/simple;
	bh=qJApPG7XIxGH4PDsL8fz5QXej6Eqn07G3voLhlu40XI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN3vmjqt4HBplowWlY/oN4zRn+rluH+AWuFmHsbWAtar7o1cm0Rai5+C5A6uzUPTQcyqUXvbC45unRku6c3zYALibTK5wui6qk5C5YPQHFW5yE2Qch+tHQHEiGZ8q8atT93d+R1Ub+O0qXipcLdCJZ6UoOJQC0xqRGWNxPMls2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NBaHNTJA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 50ACDC0DA83;
	Mon,  3 Nov 2025 19:20:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1ABA660628;
	Mon,  3 Nov 2025 19:20:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36B1910B5010E;
	Mon,  3 Nov 2025 20:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762197639; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=weTI/pW9maFaAf4ecSp6p8DKVpA0nMs1SjMBlDKsDGE=;
	b=NBaHNTJApPAPsviZWlGZCrZcCYFc7LEQaXaA9TJXnvf78iAR57ai9eyc6t2x4mIUeHvkrM
	fdvSx10HlF0jzM5TZD0l3P3pmZXRA1OZTi84BBYq0ff6MyvLoe0j6/Qrznt2aQXtUFuklS
	vOwfMSc+wx3aIw9kRbLzytHc4CdoKyP2mtMeei7tNXtUCvTTFy32ny7iO7uUbBgmdn6vyB
	s+46T+W12HTgnQY3vVC5XruYxaKOcWzPol5T51K6rDgM3/eg+NO9gybFJYdx9tSg3wBZBQ
	70yylJoBcrEt2pAXVLEEO/iFZ35qdKqdag1lNtf9ipO7UZlltpgOe709TRGNnw==
Date: Mon, 3 Nov 2025 20:20:28 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sunil Goutham
 <sgoutham@marvell.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] net: pch_gbe: convert to use
 ndo_hwtstamp callbacks
Message-ID: <20251103202028.12325f62@kmaincent-XPS-13-7390>
In-Reply-To: <20251103150952.3538205-7-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
	<20251103150952.3538205-7-vadim.fedorenko@linux.dev>
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

On Mon,  3 Nov 2025 15:09:51 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but it stores
> configuration in the private data, so it is possible to report it back
> to users. Implement both ndo_hwtstamp_set and ndo_hwtstamp_get
> callbacks. To properly report RX filter type, store it in hwts_rx_en
> instead of using this field as a simple flag. The logic didn't change
> because receive path used this field as boolean flag.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

