Return-Path: <netdev+bounces-234707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD1C26460
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4924034F9C6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137E8286D4E;
	Fri, 31 Oct 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sWLyeBW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4102FF151
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930273; cv=none; b=g4MpAoUO/6gG8VqI3eC0UYPQ2G3CENVK/WEJelHAUvcBe6c2cQBgGCdcJG4EjkMHt4TxlpBi4AssnTVwn5UnDUqkTbx8Gr0SeDDCN8EBGeD5BfleKVWMt6WBo47+M7YCsj754OOAJbDulIw8mmczSq+taEcbBucC/PsPeUS25U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930273; c=relaxed/simple;
	bh=apCb/lOGJpJj6QhRZ9UR59jodDVlImpMOMOiYYU0fVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZ7TrOPJYaUqq60IgSnOr3ukJfgyc5s1wnUUm+1s+zKymJt7BXgcw0gaKprb6VGdKlBtLUQsm1QLAbUPgEZBKJFupTOF55j0jS35V+AnVMt5ydTGypl17BuWY9vDDOv/3Q/SgljjoBrerDmSQyhbp1hTlZLx0CP2JtfLUsmTTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sWLyeBW9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A7E54E41439;
	Fri, 31 Oct 2025 17:04:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B640A60704;
	Fri, 31 Oct 2025 17:04:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50BD61181808E;
	Fri, 31 Oct 2025 18:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761930266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=apCb/lOGJpJj6QhRZ9UR59jodDVlImpMOMOiYYU0fVk=;
	b=sWLyeBW9gjPE0OJcGkYS7oKbR6cvjMBE6OruelYFJc7G73m/L7N0STTO1vBSngYjR/+Tfk
	4RIDG1afC09Qo1QYtkY6f111NRHjQ1FGYAv0cmKH5Jb91Ow5ro+huY83C80KD0C2Xh17jQ
	xX6hn7ljMj/u43LzGD9EGNpx3emnEQkT5sNbZrkEGiLlTBrewYhCFQdOdDaW4GEZIn52v8
	VVuiz9BzrqjKAclrGkaM74UOR6fMM1MDldajoznNTF+X1zH0/jPcBW4wYQzNYD/3G3l/qP
	bEKO74x6jmBXTR1X5nt/cGVGu44BQ6ToondbswTGjNj10i64MyZ+/4ZcdO4UBQ==
Date: Fri, 31 Oct 2025 18:04:18 +0100
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
Subject: Re: [PATCH net-next 1/7] bnx2x: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031180418.5047c65d@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-2-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-2-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:01 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but at the same
> time it has configuration stored in a private structure. Implement both
> ndo_hwtstamp_set and ndo_hwtstamp_get callback using stored info.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

