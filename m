Return-Path: <netdev+bounces-228072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E9BC0C8A
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10EB84E2A96
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E62D5946;
	Tue,  7 Oct 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GHLhGfkR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AC34BA37;
	Tue,  7 Oct 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827235; cv=none; b=PUnUS1vQVwKJRVkQiRFb5IweNCJAnzdSIkCzWliq60iGv1YDCvINVY8/JHMqg/knoqEfCrNWCb5ZJBPkJ4FEEqaPCOLWmp3QhQdCDh0bHFa1AHLccO07bJkN4mHWjbH4QrNEZUqm5ZBuVeAx4NcqjMoBUIe12FRFyZmUsmvbzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827235; c=relaxed/simple;
	bh=XerKFp3BmqnvlTwBJQ6Zv8BKIXwHk/GvCTpWSyoLDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2xBG6HzSZ6ABXxwiVIP9YPNHiAEU5BOKF/j2MpCbvpRYKc4EsaGd0MRNrxEW1vgenhbLpnG3xKuOUPcs3i+dqMzt49cTteXhov4bCnNdnOzWUwcevpU510Bb2YF5i+5HDdRrPJcKqwmo19ZqGa3p9pwtPNhiuRf3dr1qKArg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GHLhGfkR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ED6E11A11B2;
	Tue,  7 Oct 2025 08:53:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1DF2606EB;
	Tue,  7 Oct 2025 08:53:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2187102F2134;
	Tue,  7 Oct 2025 10:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759827222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L2vWVeKOdRdTQKfeaPNnzY9dsfHHhSGnt4F8bj2CIkA=;
	b=GHLhGfkR/r96R3YD9a64i4hWRspHMoKWhMTi4xlU4KqiObY5tsNcahLviKzB2EljsdqUyL
	7N9vQ4oiZUYj9WJi7oJot9wcAs50Z2hxbFtwF9doNzE66zFsxXrOh3g9guZJk3DuotrWYR
	7UFu/OwPgAM6OMBmU+jVcs8FF5swN4KQ6eVCbhhAuG5MuWEHgxcxpu4DR9trp2BopCUqVa
	aDhxYXf+O9E3HXPXxcSailhc4A39m2fjMoXSE9tqBpsGM35Kv5YNpKVljR8R7NQTTXNQD6
	ZJRs7uM4KQPN5VcWCpZCInZTcPnMm1KqWaSHet2H8ngU1BOoBv9f2Ma0QCV+4w==
Date: Tue, 7 Oct 2025 10:53:31 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix current measurement
 scaling
Message-ID: <20251007105331.70f03fc9@kmaincent-XPS-13-7390>
In-Reply-To: <20251006204029.7169-2-thomas@wismer.xyz>
References: <20251006204029.7169-2-thomas@wismer.xyz>
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

On Mon,  6 Oct 2025 22:40:29 +0200
Thomas Wismer <thomas@wismer.xyz> wrote:

> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> The TPS23881 improves on the TPS23880 with current sense resistors reduced
> from 255 mOhm to 200 mOhm. This has a direct impact on the scaling of the
> current measurement. However, the latest TPS23881 data sheet from May 2023
> still shows the scaling of the TPS23880 model.
>=20
> Fixes: 7f076ce3f1733 ("net: pse-pd: tps23881: Add support for power limit=
 and
> measurement features") Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

