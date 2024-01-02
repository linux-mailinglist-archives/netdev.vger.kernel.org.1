Return-Path: <netdev+bounces-61046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDA8224CA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89A51F23505
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A90171C3;
	Tue,  2 Jan 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsvskS2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4F17982;
	Tue,  2 Jan 2024 22:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C7C433C8;
	Tue,  2 Jan 2024 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704234844;
	bh=dzt2SwyvJkT3cWwRAztqs6RAYo3+uR/xkztEwtRwNKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qsvskS2Mw0W0xcDLDb8xYjmE5BCJNQKbDW7ZKsvrwwuHZnjXjSRLmpG4JWMbLhR4D
	 BQvxTdyjYrTtAAnhF7iIqZBQv7jzPGqoj5UXKG6LAy7JEQwk1rfdreexqPuvXQnLn1
	 8mWYl25V5GTlykfWBYbUxZvPXtvxgvmV8eNOUADAd9BO19lO+GEhWwi5pO9Zh6wbTB
	 r+jrsBD198mbSjRNLEQr1a1pztn6m0g6SNAvyFdUy7ICJEZaj4j4upPGs1XDBgDvld
	 Yy4EFHeDTx/+verYZ5MA984TEkRAFijC8pxkA75mzHWjDOlR5YafkmB+HfhOyWXLWR
	 k5gproqazy/KA==
Date: Tue, 2 Jan 2024 14:34:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Frank Wunderlich
 <frank-w@public-files.de>, Bartel Eerdekens
 <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/7] MT7530 DSA Subdriver Improvements Act I
Message-ID: <20240102143402.5f639ec3@kernel.org>
In-Reply-To: <20231227044347.107291-1-arinc.unal@arinc9.com>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Dec 2023 07:43:40 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> This patch series simplifies the MT7530 DSA subdriver and improves the
> logic of the support for MT7530, MT7531, and the switch on the MT7988 SoC.
>=20
> I have done a simple ping test to confirm basic communication on all swit=
ch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.

Posted during shutdown, rebase & repost, please:

https://lore.kernel.org/all/20231205101002.1c09e027@kernel.org/

