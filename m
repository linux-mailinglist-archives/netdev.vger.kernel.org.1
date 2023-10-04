Return-Path: <netdev+bounces-38068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913417B8DDD
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9B56C1C20506
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00950224D1;
	Wed,  4 Oct 2023 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5kYhPFr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F551B27F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33F4C433CC;
	Wed,  4 Oct 2023 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696450199;
	bh=bQor1saGeB+PRL/MUNk1VQn208AY2/DIznHoyUEXTvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G5kYhPFroQtnJr+8UcqoNuc4kbyXsULYUd1Q+Pi/yihOyBNXqnAHL3b3X64zzkOoT
	 f45Hma7sDMmyWaFH4TWva4cOzzLQUBNh8Wrd+MoWHXi8VGXrFipttbQHNiJJVaJAp5
	 xKOFXxDlVjsPJOt7d/VF9HlAjEM1nD0v01RY8x8HfHfl+hkCkWgNvUgnwofSLZPDP2
	 RL5zO/z5RxiUxiOHbkhWfe9cHNedjjRxqZxTCZw2Lumx7pQcSfz2ACQGT/ShneFeT7
	 5xIq3sgQUaEHtCFeLBHbeMBre4gj82DBQBp5ZgpEvYVfVUwhkm7i50yqwjpScuGlaW
	 eX1ADmqhQVSaw==
Date: Wed, 4 Oct 2023 13:09:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, andrew@lunn.ch
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Message-ID: <20231004130957.2d633d03@kernel.org>
In-Reply-To: <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
	<20231004122016.76b403f0@kernel.org>
	<b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Oct 2023 13:02:17 -0700 Florian Fainelli wrote:
> > Nobody complained for 5 years, and it's not a regression.
> > Let's not treat this as a fix, please repost without the Fixes tag for
> > net-next. =20
>=20
> As a driver maintainer, you may want to provide some guarantees to your=20
> end users/customers that from stable version X.Y.Z the performance=20
> issues have been fixed. Performance improvements are definitively border=
=20
> line in terms of being considered as bug fixes though.

I understand that, but too often people just "feel like a device which
advertises X Mbps / Gbps should reach line rate" while no end user
cares.

Luckily stable rules are pretty clear about this (search for
"performance"):=20
https://docs.kernel.org/process/stable-kernel-rules.html

As posted it doesn't fulfill the requirements =F0=9F=A4=B7=EF=B8=8F

