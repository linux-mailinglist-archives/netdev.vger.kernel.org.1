Return-Path: <netdev+bounces-117460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0EA94E07E
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FFAB20EC8
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945671F61C;
	Sun, 11 Aug 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E0O4wynd"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943C11CAB
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364736; cv=none; b=O6ElXh/KQmyjATB+2QsfshMbO5TLdRHC5JOW/El66z2glN9TT0KoPA8FbL8XroZB/H+W+4lfYQdvUJhoV5bcUQCPOkVM7GnMtr/v4tkw1jBvVQVv+kZMxcy52TQugRVY/vaQT1tA7QBa2htvSYCjM11RdzXjpz6D8cJf2NrWaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364736; c=relaxed/simple;
	bh=FyKicFAgoyF/aNYKRC4DeztVSA6e3vu7eKknB+dVEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPEpS2OJiRgq/EYDq+FgV3gPxi8LYI04dwDXRagBk0Dk53ktcuGkvjlnCqgHtluX0GiZP+FiOnir2zDDU9LADeW/cn7YxGbrWpPJ88PhiXZkRYCXB5uM/kphQvnr529DUePnQuDZ+NVP/2Pb1D0nuNjmVmQ362KY4E6MR/ABa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E0O4wynd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C906AFF803;
	Sun, 11 Aug 2024 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723364726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyKicFAgoyF/aNYKRC4DeztVSA6e3vu7eKknB+dVEQE=;
	b=E0O4wyndxR/IrFoY6CgVuXwDiSKS3klH2gvYqLTdeRczyWp8gxMihbyK3dWKEdenEl7+07
	yBz8pdYwwlJxac+dCAEeh8Tm20PhK1f4ymlOafYIdPcnhJtoRW0mR2a+/17lOOsoJPRnvO
	EaHkumatX9OlEws5QJPqHEmhhgjFpND1YqKNjV0lvRvLgqeRQVNVB8/YJgkJSEwqxhOsT6
	LNS2eBmbsw9YsnoJstVcBAun59ILIwAHMLV/51rP5To4Uvu0Nrk+Pmp8kd+Sy5FiwBb9mv
	LRfZJY0Pq7yc//W1inHP1rsc7uglkhRZTgvGYWpS1LKCcfm8tEWgzpjHv98bVQ==
Date: Sun, 11 Aug 2024 10:25:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me
Subject: Re: [PATCH net 1/2] netlink: specs: correct the spec of ethtool
Message-ID: <20240811102524.1d016a38@kmaincent-XPS-13-7390>
In-Reply-To: <20240724234249.2621109-2-kuba@kernel.org>
References: <20240724234249.2621109-1-kuba@kernel.org>
	<20240724234249.2621109-2-kuba@kernel.org>
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

On Wed, 24 Jul 2024 16:42:48 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> The spec for Ethtool is a bit inaccurate. We don't currently
> support dump. Context is only accepted as input and not echoed
> to output (which is a separate bug).
>=20
> Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

