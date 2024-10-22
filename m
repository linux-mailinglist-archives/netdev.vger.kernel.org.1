Return-Path: <netdev+bounces-137901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E130A9AB0D0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973AE1F23ED3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347951A0AEC;
	Tue, 22 Oct 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u5HFVfzv"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC91A08B2;
	Tue, 22 Oct 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607257; cv=none; b=cfbu7NTL2nnQllbrWHcKD55fhTM3YhO3rKPAv186pz51Pc+OWqsXvZLgXHpsu7s3RtJWNJXqMvZ9FrTcqtIcKADIxqGxPqWQqbAux3kRCQ7gizcPCxBYzIPIz1Lr1csaMpkJ6TuxMEHx4+rSWldd9ivrE4ZVwqpXtPXh++TojZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607257; c=relaxed/simple;
	bh=NRUPQmN4OcgHB4PVgUuGvN6fgIxE2+tcBaXaRTBXpyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/YN5RyPqqLZC8pZEP0fXfSxsnM7tlhHKdiimVLn66eKi5tRs5QubaiiUxilV+ZdrVHS50KeQI4S6QjZf1QlmiC7gxTF1cmY4sMDX2jH7hWs1eQw1oxkTq1VCHA8BohmzhpaH3lJkje4fhd2m47si7SZJDIyTJ/ngtVtMUZILqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u5HFVfzv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NRUPQmN4OcgHB4PVgUuGvN6fgIxE2+tcBaXaRTBXpyE=;
	t=1729607255; x=1730816855; b=u5HFVfzv85yQEgCPGdxJjrOW8phqlZfcO/pRmoeTz7jZ+UP
	yhpkgvD2/xsup5NEaTZX2E4K5nWEcj+8rROpDS0a2WFCKAH2J9grKJdMQ63NggiGyFLUTS/6Pmiff
	E/bcXHOjxRemm5DKxVDEwqP0i3pKj+0vffbB6N5f4vEPfN4PL3z0shas0t0LcCrgmM3qhLDlVkOte
	hjUYuKlbrObsqmnGqqAJeCybQ6uiTmV+Gp9LeYujqCDmD209+McOqlwGy62jFPxGj5MEi7TmOxkiW
	WvQih/toLugDFYDK+7tWrjg+dhCY7xf9WdqCyTj6pxTCnlFCx0X9U14rsrjujcZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Fr9-00000001m4w-1zp1;
	Tue, 22 Oct 2024 16:27:31 +0200
Message-ID: <00c844ed88ef42de355ccc2da28846d7ef0a4e3c.camel@sipsolutions.net>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
From: Johannes Berg <johannes@sipsolutions.net>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jakub Kicinski
 <kuba@kernel.org>,  Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Martin Wolf
 <mwolf@adiumentum.com>
Date: Tue, 22 Oct 2024 16:27:30 +0200
In-Reply-To: <cc949ab7-b5aa-4812-9c4a-d50bfee92de0@leemhuis.info>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
	 <20231023032905.22515-3-bagasdotme@gmail.com>
	 <20231023093837.49c7cb35@kernel.org>
	 <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
	 <20231023185221.2eb7cb38@kernel.org>
	 <3a68f9ff27d9c82a038aea6acfb39848d0b31842.camel@sipsolutions.net>
	 <cc949ab7-b5aa-4812-9c4a-d50bfee92de0@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-14 at 10:22 +0200, Thorsten Leemhuis wrote:
> >=20
> > Anyway I've BCC'ed him now (Hi Chetan :) ), but he had also said he was
> > checking with his new work about this all.
>=20
> [reviving a old thread]
>=20
> Johannes, if you have a minute: did anything ever come out of that?

No, I guess I can try again, but everyone pretty much moved on from this
stuff... Would be surprised if Chetan were interested in any of this
now.

> Or did anyone else step in to take care of Intels's IOSM driver?

Not that I know of and I think the business was pretty much wound down?
No idea really though.

johannes

