Return-Path: <netdev+bounces-69388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3584AFDB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB34A287B85
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7112B14D;
	Tue,  6 Feb 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="4GIDjXME"
X-Original-To: netdev@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17712B151
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207844; cv=none; b=NIM+EUpWHzSNsZ7KKzFTqpeVwBe4pDq5zPEs+jVI3Cec+dgitHttu2owfQ6M2/Yv7U/lUbEEqKDzLjyU8tgZsv+I7B/hxso9+pcRHsByqujbG3DGmirIZthkhkhCU9fJzoawHX9OkhmaN99M6ZcXEI2wK8qKa46s5kFFZumj5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207844; c=relaxed/simple;
	bh=4+cI03idmQA5frM2jJnYqQ3MRhlOQF8g3rHw+hxwUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeoVo9xZT8U9nmtqVjeVjGD1UYZ1cHMsYcbl9mRyOy32655MejdnsT4NIyH0XWbOvJ/4lHRZT0q8eBwKyGplz/5Sj81XZYvf29yUO9GBb4jXyp7vssjzGQKfAnWUhaGQZlNxKjOjSvk/LwxtG11wwAcvGPvUwFl4lkhmnyT19Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=4GIDjXME; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (88-101-101-77.rcg.o2.cz [88.101.101.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 50AD51AA826;
	Tue,  6 Feb 2024 09:23:52 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707207832; bh=4+cI03idmQA5frM2jJnYqQ3MRhlOQF8g3rHw+hxwUe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=4GIDjXMEr6VkzE6kskJdyB1NxOCBRkRGd28+L+1BZCHakWpcjqzw+AsEwuTYjZ1bG
	 J7GNO8hnxEj7M+B6/tn+pIX6peISO5RD+8NfRxAko58Du5kpaofTvhkWaCfOXqm+iB
	 jgl+mqiiO5gJKVZ1DgCMwpT58ZAMhSyaSCterRtoDh7ze7JoQ1+r2JP+vaPaubGXPz
	 lEG7I7BBLPr/7lo+pzuK4i+yTislYWKnU7LqLCT+lDZ0LaUXunKZvAriWeKRcYH1Lf
	 NeiWY+FxYVogWMyFZGjSyPf0sCqSemfRr9PWNjGV3EZgGeUGsiMTN5tLKa5t3b7Erl
	 w/Tuyen75H7yg==
Date: Tue, 6 Feb 2024 09:23:51 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Marc Haber <mh+netdev@zugschlus.de>, Andrew Lunn <andrew@lunn.ch>,
 alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <20240206092351.59b10030@meshulam.tesarici.cz>
In-Reply-To: <0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
	<8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
	<ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
	<229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
	<99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
	<20240126085122.21e0a8a2@meshulam.tesarici.cz>
	<ZbOPXAFfWujlk20q@torres.zugschlus.de>
	<20240126121028.2463aa68@meshulam.tesarici.cz>
	<ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
	<0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, 5 Feb 2024 13:50:35 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 2/5/24 12:12, Marc Haber wrote:
> > On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> >> Then you may want to start by verifying that it is indeed the same
> >> issue. Try the linked patch. =20
> >=20
> > The linked patch seemed to help for 6.7.2, the test machine ran for five
> > days without problems. After going to unpatched 6.7.2, the issue was
> > back in six hours. =20
>=20
> Do you mind responding to Petr's patch with a Tested-by? Thanks!

I believe Marc tested my first attempt at a solution (the one with
spinlocks), not the latest incarnation. FWIW I have tested a similar
scenario, with similar results.

@Marc: I was able to reduce the time until hang by running a "ping -f"
from another machine on the same LAN and running "ethtool -S" in a
tight loop on the system under testing (over an SSH connection, so it
probably contributed substantially to the network traffic). The
unpatched kernel froze within a few minutes.

Petr T

