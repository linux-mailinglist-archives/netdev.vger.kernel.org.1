Return-Path: <netdev+bounces-234713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAFAC26518
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA8404E03F5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0D2FE595;
	Fri, 31 Oct 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mryXkMDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F02F5A14
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931182; cv=none; b=mm6qvyYxR1EzFw/zWsODIV3EIn2lpvld652fdHzrkQYsyjEMuBs5CWu3G8ppr6CGBkNtsjA5XZQCejY8Wmj9YJ1d3yM2ygc3Vo+T2G77ltlj3GpM9SpxeiEq8/Z8Q0bS9wyXhx7ZJ0y3KdeogWmVUn1ceTWufXHWLu3Lm3O0kTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931182; c=relaxed/simple;
	bh=YIPzSOSmEgSlPbbHnLQTuNk7wFwXE1tCgOgnbQmEXEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsmBu5wqUW464MEL5UUFpMhSwyv50NXUVQdCwPfD6BRnmH8RlM4TVXmE7pbTeltDerU7k5wQzPgsWXW2Uj7b9IJDpYFlYewQvpoK4w7TpUlPWuLXmi7XqzZpjnlvxNjkaj2jTtxBl177QeyqczAKND8I5Jsrkkgsvj1r7UPpEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mryXkMDZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C4B321A17C0;
	Fri, 31 Oct 2025 17:19:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B64F60704;
	Fri, 31 Oct 2025 17:19:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A471C1181808E;
	Fri, 31 Oct 2025 18:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YIPzSOSmEgSlPbbHnLQTuNk7wFwXE1tCgOgnbQmEXEY=;
	b=mryXkMDZusdBUIzKHnaJf9tjD7jnW1iTiBKtQ00qkL4IO9C+Jqz8y3m8jsUlffpprshxPM
	+0nODBHwJNrqBkm0onaBK8Eejo4cN9qix5TyIf+ba89pi37WIBKOQXrTvXSH1v4dbxTf1s
	Cs4kTOkskVRYtlWkkpGImyTgLoXZjYvqM5UbMhbGNlfqoqt7mFxazrVAf7KSc1xBw7RadH
	Sns2ser7H6oT8PCR5c85v+RvqGlN9rRLeZJEWoCMaGwrXLlyQqIJOiog32JhjYS359gVXL
	OX4Xap1bh3ejYJPRHhJkIDwSjgUcKPKBaKndJbAUTchS7342OVOYy1wLwt/OKA==
Date: Fri, 31 Oct 2025 18:19:34 +0100
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
Subject: Re: [PATCH net-next 3/7] net: liquidio_vf: convert to use
 ndo_hwtstamp callbacks
Message-ID: <20251031181934.0dd056d9@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-4-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-4-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:03 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but there is a
> way to get configuration back. Implement both ndo_hwtstamp_set and
> ndo_hwtstamp_set callbacks.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

