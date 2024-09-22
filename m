Return-Path: <netdev+bounces-129198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C400E97E2D9
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D0FB20E95
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249F2A1DF;
	Sun, 22 Sep 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L7oRpyYX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAD2C6A3;
	Sun, 22 Sep 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027758; cv=none; b=Gk6mw8MJuMeZ5aPptpun0xO2Fl3xSa1qgcR2G5VMUOVm4lnDnXKmsxf2h1rBQMcpJAJOPaItn4nVaZG8RcNCFFwW07YvNh6rVMz0qcQ43wYs6W6Jg7DBzHlIGboTRPxoiVnZJV0UoMu6/96pmGgdjrRfeN+FlOh+RYJmnre04F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027758; c=relaxed/simple;
	bh=rQdLXE6SJslozte+20DMd3ULCl+9niKgzb7QGtWzBH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsVp+JcAjzWVlAwZlAAJgG7b3gqMVguJWSDmLWwjvEZ6uJZY/bDAibWje4p5Jg321LihR1bHh9Y+AUTHtGKPpgD7iQp44VQ8qvoc/3iUpHvLlsXmjtOws7Gm0P+2TlWhmvEHc/GkcLikAezJ4RSMZ2bznUZzzhdPtQ4arzntJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L7oRpyYX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727027717; x=1727632517; i=markus.elfring@web.de;
	bh=8Xi69eSUzOhZdivbJL/GWaVVhyX+HV7P0O/k/Oi2vxo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7oRpyYXoQIF7GKMBVvEZCTuX951Dwj1FeFDaXA8KA3J+8o/daKaOFS14+hcCW/B
	 Ii2L9UCV3p8qcSKou0Fiqv/4KVitsBuKiTa/Xe6qXcGQgw/0YeOWLLjqbSjn1FMA7
	 9B3D43F9z8eV/r237/tvixRyNxUBHZM0TGk8+QZwRqJTw0YIXK4WwV5jpzFejCS7q
	 ygehR7gkpYW/x2m7pqaf2/op23Q+ThTq2hAt0iJTiCNrYTzBo3UVVc5dM3MzaCOO6
	 1iAso01FV6m1mMQiopA2Iab18M/d/9GI3bq9spJuM3g86teFyVReaKJo6nNF+CfBP
	 JHzr24BXhtb4YTmV7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1sbrt30ZRk-00IOXU; Sun, 22
 Sep 2024 19:55:17 +0200
Message-ID: <3aca8eab-f4d2-4474-acc9-c5c94dcb9162@web.de>
Date: Sun, 22 Sep 2024 19:55:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: xilinx: axienet: Use common error handling code in
 axienet_mdio_write()
To: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Clayton Rayment <clayton.rayment@xilinx.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
References: <330c2b9e-9a15-4442-8288-07f66760f856@web.de>
 <20240922170507.GD3426578@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240922170507.GD3426578@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BQfgsFRLT2S9FhcY8igdpU/vi1LOYwCsrB93WR1PBKVAH2GultZ
 gVpnTvNWtu5Tnf2ztuXKyhCHTxrE6EFPHi2ST1GzuL2x2rSWZIynHAvTGE0MAOyV1GsbvA0
 uwz96XyFI1aGl5M8UlrQBnY4O/WmaoA+CaMqmHf7mzJumL/ZZkSbQf0MsTl6UsI5ov910GX
 oTsVdX0m/6+PUvPOgu02Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TMuK3USvNnY=;6/YoGWwgLpZ6/85IYs0BFG+23/g
 0ttnj3BFgUg/EXE+hy6e/asHDcEyTWZIeUX8Qloj/1sakFC3hqu54Na5sVCORM2IgYtUW9gOL
 k+ehxXvop2fhZkgINoL6Gs8Cqc9fdbmMcCoCt3BqdDwzykvSJofpxCk3f2mmsvFw7u2hRyZjk
 8MZjSDHkAfIQeDP3HBZnr2gQ+YMKvgCUCNF1SoyH99fvBeaFubFNQi9SHlS0ov7QYE5ko90Du
 G3jk5VazTSPofI7aBolLEdE1pGQdKUOfaLnycaJN4yc+5PllCqzLViVIesexDZ+37m50etK4o
 +d08ZOxdIzqdIJhIs50j5A0Cu4uuKAktEhFCmqGNuDoxvKyvDEXvbB6pvjZAfz9Jm7ygbkWfv
 m7d9OLqGUpOIwLpNqYfYBX1Gjvdr7jOBULcXpgy4TM5W6UpKp8Jqxl4di+81TY8o5PJq2EgLT
 1jcAjINi5e16rRRsS1tqDuYwlr/J4fNww8BD9j4SWnL1EUPdlixrJTNKaLRrB7H02cwgVGvky
 aEYyfwNZ22dwyxLCgq80bRVWMyUpOMslo+mJkOmK4zSpVPagQw5UFe+cXyVc8GgBfFrgemst2
 fo6ngc0tyas+RRsJYWjo6u+IXOI5yeKFKSvEdzpODxAWzFU0bjpF5m5Q+cqCD1hb3DAXY8c0R
 DkUcNA401iNwoWEdT5L0lym9u1krNbH4S4sFp1y79YX9SLqd9qeX2q9KrnQ/thIteSxn6XJLw
 z6FNX1N72SPyL3+46fzqTNbGELJW+LzLwvG3MWldqJ4aBw3toeTW+zRlKJ2E8dWPRM2rxIMhX
 iQPV/n6h+MjDR2unXStgoRXg==

>> Add a label so that a bit of exception handling can be better reused
>> at the end of this function implementation.
=E2=80=A6
> This change seems reasonable to me.

Thanks for this positive feedback.


>                                      However, I am assuming that as a
> non-bug-fix,

Would you like to categorise my update suggestion as a correction for
a coding style issue?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.11#n526


>              this is targeted at net-next.  And net-next is currently
> closed for the v6.12 merge window.  Please consider reposting this patch
> once net-next reopens.

Will a patch resend really be needed for the proposed adjustment?

Can both development branches benefit from this refactoring?

Regards,
Markus

