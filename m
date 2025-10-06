Return-Path: <netdev+bounces-227962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBCBBE1A8
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC04E5A2A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8728489E;
	Mon,  6 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PF395J+j"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66534BA3F;
	Mon,  6 Oct 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755609; cv=none; b=hE8DeBIezZTVQkWd1NBc8a5rn348kODfF1GkuKolYiliIYoHZcroyaZmfRVHXFYxH3euBC9tS/6q/0CP4oBYTYh7AxsR/E15Xz5KLnz+WfBSr4QvhbE58QWYTUlEi9pDwWYXHlPgo2N8rdX7fqkHvnrAuOWbM8itZmb5iFxdrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755609; c=relaxed/simple;
	bh=ZXpSi9q9F5BjRkTG31nLlX1zalzXYWg6ibtx+OI6e3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjxAgxIsltTr18eO+DMw34haA76BUNcsYfby90a7e53/iTtSez0jPNGRxuSAjwSHEyrAFdDR9tu0891t22g8Za4IYKvPGKGIfPpICk/3GPirHd8z9kNyJr/H0BFPUc1FbTr96u6gS0SvnIt+DEmOq1ZheU+X+Xe0Ay9k6bmtiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PF395J+j; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2FBC24E40F1C;
	Mon,  6 Oct 2025 13:00:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2014606B7;
	Mon,  6 Oct 2025 13:00:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AB58102F1D61;
	Mon,  6 Oct 2025 15:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759755603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ETS/CXHgTMRay5Bo8kJAmJVx/WmDhXe3DP4ABIDVz14=;
	b=PF395J+jaQQ1TNCkRf+ecRUn+0mvw0jrUhQ1ikOnyBUo1BKjXRGTtB7zemmzF9qXXE62n8
	X1twQEaK3ewlMgKtY+LkZJyA9jgh3IxApAw6qeajh0yqrRXgTmMEwd4D/0lY/gUS0qeLrd
	wRsvzSM9HNylV5Zz9LKguJdf0Faz0ygQnjO4UktOcq2NBLPORHGgyyQjaJ7OAu+xXwMmC6
	nA0tEaIwUhvrB7uKcZ+fnoC4BVxJS4Por13cgFYi47gzVQOV9s8L0Q7p+RlJ0GfPNTYezI
	LJ+uWo6B+FQWkndnaB3BASOHHtKHSIBpi7poH9KhHwGwWDbKxRvLh6kUKxKCcg==
Date: Mon, 6 Oct 2025 14:59:59 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: pse-pd: Add TPS23881B support
Message-ID: <20251006145959.2358c9f0@kmaincent-XPS-13-7390>
In-Reply-To: <20251004180351.118779-2-thomas@wismer.xyz>
References: <20251004180351.118779-2-thomas@wismer.xyz>
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

On Sat,  4 Oct 2025 20:03:47 +0200
Thomas Wismer <thomas@wismer.xyz> wrote:

> This patch series aims at adding support for the TI TPS23881B PoE
> PSE controller.

First you are missing net-next prefix in the patches subject. Like that:
[PATCH net-next 2/3] net: pse-pd: tps23881: Add support for TPS23881B

See:
https://elixir.bootlin.com/linux/v6.17.1/source/Documentation/process/maint=
ainer-netdev.rst#L9

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

Only patch 1 which is a fix can be posted during the merge window.
=20
> ---
> Thomas Wismer (3):
>   net: pse-pd: tps23881: Fix current measurement scaling
>   net: pse-pd: tps23881: Add support for TPS23881B
>   dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
>=20
>  .../bindings/net/pse-pd/ti,tps23881.yaml      |  1 +
>  drivers/net/pse-pd/tps23881.c                 | 67 ++++++++++++++-----
>  2 files changed, 53 insertions(+), 15 deletions(-)
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

