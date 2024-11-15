Return-Path: <netdev+bounces-145509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033699CFB25
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8FCB32FC5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644719D8BE;
	Fri, 15 Nov 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsV4sVdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EE18DF8D
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712915; cv=none; b=WVaq198W2IEjY6FZhuHlXnRzotX/LDN8SjyCbi/9lKFkxdpulFWLiQ8xsXb+pqRaCQWx7NC+sQVFOXRs8IjG+inJwIdNw3fYTisVvZ3JmHe1enQ4qCFm7HSNdgqvW1fGSl0ZUEvn5LKVd5DD2QekoNGNSOQ/WrbuTKSgZ01NcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712915; c=relaxed/simple;
	bh=UKfURWwDvtWSqqeHm5kKHmniZPeJPhF6XTUSjfdoVwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV1tw29yHRXHUOBWfj5tNi0j7FlJgd9YU9Cfs9g0UfWLjxRIXFxOVKye8oEo9iVuA2R3sG+Kya+fwHdWh43DJDFoyCHEh4moGtYOwNXdfKnwqGbys16zzUy4UeHl0kUpKTKTc5okQSGlXiYEONmJ6cemvVnDJGeUmrNJGFxwzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsV4sVdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1E6C4CECF;
	Fri, 15 Nov 2024 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712914;
	bh=UKfURWwDvtWSqqeHm5kKHmniZPeJPhF6XTUSjfdoVwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LsV4sVdgpvW1g76R/yd9MXfJEdFvLvA6ONdP9sjLPJWwKVY2B2Z36R5MBp+gwF9ZN
	 kuRlA8FP6ylyfXC3I0oPgy61b6Ag2Eh4XET2nneCbC4+4q/fdPNNK5HVt0+BUEyMhw
	 qPvllORMrR/W4qkWdmYMgYU1PLVFg4Ctz2rbKUhuoVMos/V8cVsy6iz7gm46EZZBo3
	 eCrx7/tJcDhroYFCfunXAjgT61N4wIYlUqpWch8WvYrKDCU9QcbHy6bV6L0UmTBSHs
	 X+YB2FLmBPk/NiYEMyT8J+Su611gwsawps9JC5tYG6gYJv1xJ/DZwC/9o2YTGF0kTZ
	 mO4ildP/MiIOA==
Date: Fri, 15 Nov 2024 15:21:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: wojackbb@gmail.com, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
Message-ID: <20241115152153.5678682f@kernel.org>
In-Reply-To: <6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
References: <20241114102002.481081-1-wojackbb@gmail.com>
	<6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 20:54:20 +0200 Sergey Ryazanov wrote:
> > We tested Fibocom FM350 and our products using the t7xx and they all
> > benefited from this. =20
>=20
> Possible negative outcomes for data transmission still need=20
> clarification. Let me repeat it here.
>=20
> On 06.11.2024 13:10, =E5=90=B3=E9=80=BC=E9=80=BC wrote:
> > Receiving or sending data will cause PCIE to change D3 Cold to D0 state=
. =20
>=20
> Am I understand it correctly that receiving IP packets on downlink will=20
> cause PCIe link re-activation?
>=20
>=20
> I am concerned about a TCP connection that can be idle for a long period=
=20
> of time. For example, an established SSH connection can stay idle for=20
> minutes. If I connected to a server and execute something like this:
>=20
> user@host$ sleep 20 && echo "Done"
>=20
> Will I eventually see the "Done" message or will the autosuspended modem=
=20
> effectively block any incoming traffic? And how long does it take for=20
> the modem to wake up and deliver a downlink packet to the host? Have you=
=20
> measured StDev change?

He's decreasing the sleep timer from 20 to 5 sec, both of which=20
are very high for networking, anyway. You appear to be questioning
autosuspend itself but it seems to have been added 2 years ago already.

What am I missing?

