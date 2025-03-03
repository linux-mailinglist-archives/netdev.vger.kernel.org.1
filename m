Return-Path: <netdev+bounces-171169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4706A4BC07
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D16166A5F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFF1F12E0;
	Mon,  3 Mar 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bd6TKmoX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C81F0E2B;
	Mon,  3 Mar 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997576; cv=none; b=oDWdRD/VWIoaRrL/Ler9tgmrFpsh2NOUlSw+FQFuxB/69X80mXCyax0pXMj8Y/udppsrvthr636J34187aRcgc4p+D8hwwIqLF+mn8v+A6LupIpKTFdUIC1Hp5+4O0Kj70nXWBEEHqxzTRU5vbR+lvNG8j70WoEgqHWDpF3aKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997576; c=relaxed/simple;
	bh=B47tZAOLgSQfFBfvc+j8LaaNdo54v6z5VBeEmRjLZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezmtKJaK8iEMoFLBaI2+Jw23SrB2Ehl/OAj30HTzi0wrdpeZkkcRQMXUQfeBlVSBvaDVXOIDsIWdGa0BSF+kC8cbI05S9ANFdM1RchRN46RSIT4PjH42eteSm58gl1CDRNYnhTkMkS1p2qAIUtV7KSgAPg2QNwc6zcGv+bG3/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bd6TKmoX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740997563; x=1741602363; i=markus.elfring@web.de;
	bh=jd+52AX5/piObKdzzA9/9SXvFOM9JdZ0fKfhSwOzzPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bd6TKmoX3VCx+K8pzRAkR6zDAiJPvB/N6Kx0szJn1iKNr14hSRAzUUIahlcmKw2C
	 OT9nGT7QIwCVc/a4/X/YL6gQkxRyH3NbG4vxQh/Z6QbwUV8Q882t0+OHrjK/4KWK9
	 0ntCKz+239JWuvXaApQs3tDsgesRqX5uKXIrDjDGkvnxPl6vP7UQLJyj+Sr2BsXnp
	 UyElQpO136tU/xgP1XidRdjXCjN3WWNoVTo2gkg6InypTPzelocWv6MPt/B08wTmH
	 zC5dBF9ygWqosaySVWF0jML4U6ytgpf3IK6uCUnTtqOH/zuD/hfMXDYQEqFzyTRwn
	 BDOJp9vkRQPRn6Fk+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1twVdn3hu1-00EsYP; Mon, 03
 Mar 2025 11:26:02 +0100
Message-ID: <79df6406-72c3-4f5d-acaf-9129b08ef404@web.de>
Date: Mon, 3 Mar 2025 11:25:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qed: Move a variable assignment behind a null pointer check in
 two functions
To: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
 <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sFY4lNudEKPt31p/OofSHuUe2r+pMZ9PoMkfiipwtJeNiIi3ot6
 ROhkegUFPVYWImquRud5jz9IRQ6MVTELXnCC4MKVJOUSx2ZuNJm3qPS3kuO2snpyCaJVRO5
 eLgp9prn2PPIT68u1vNcn0kUD1MSxNQnqTv6rEsnu/mAOXdaDDasPJpZ3hGjxxLgpyYz2+C
 HseknLEcrxPoV0VIFQfaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g8CJMAUTc50=;kqgVeauKUouTGLBH4WBo+Qu+a7h
 ARKWrZqQ+S+u6Bvs+zp4n/cP/zyYMnoX25InH00cmqeOmwHHWKTogFzZLgbaZvBneDf/b33ho
 w8FKysGeKNxLnO/dHe2aprA8hAEEE3sPtHbH8Oi1ic6MA4h1dzmJZikWuYWBnVXSTayV0/tCs
 jdL4evJD1E+HWdIvhXIlPhvd0pA6jEAGfmvvjO1n+QeusPf9ChWvnZb1nAlbPFes6rs64b9kT
 XD/+KE1O9Ds0QmqvFIMnjYb9CfZUFTsM7sewMCuKKtciwP9xBklOeV6TZCIWcBzWlVupkdQeJ
 8oAgq1sR3LSe24J2IvSjcRHKQzbxLcdehvibjok5SpPT0DGKGS5OKrheHI+flMXTLxbe31q5x
 1zN+NpI8bGGSrhKI2ciNgYpHsnfZGJIXSbhuuPeV0fs0Ue7MILxmLagE4MvDzlZGpLtlVHqIo
 3nmDdDhQ4C0+Kbw5+WEeYMmNV5mB5Gvt4zqzC3BK33xVeC40GgLMVxHcoCdxxzgzRKlQka6MY
 lh4GVtwd145gTqjvsXzNUXBr/WeiODdgjemFL52t0c6+O9Ca6vqr3cOzB8Vv41nxwgctM192U
 JJ0TqVPpltZmfbYVg1hKjgUjC8kA2cSA18dD3USXhZR6/DpbVsi/24Y26Be7hqiq3bNoSoZLb
 7+MPcVsA54xyKX/Lpse0nhOs/U8aYtbBjohrnYWztMfVs370jagISiXq9LhYgdjekRbXzLuEz
 VaufmDZ/zZt7PVbl0JSNt5c5YkBALZvGcnspVWTlYP0KsZbVY6REE4m5MaOwIMNGuV+mgruv3
 O6MONXhg48NMi82koNyyUdoVWEvciQIwWaqsCCiWuG8broWOIK6UDczOknzJeREnoYQ3CutRE
 /AOBjRZgjCrS6cuB+Nr7x2OiT5TD7HqZTKh8DUVSdQn0yjzYTvoXDMUV8+wcjAaImY2un21ly
 LXAX3NaJokG1iePftL+09y2pnl7j/ktD0DCYuJD3WI1+Ufa/9npBOJY0fMx2386NrwuRL04dl
 2/Co7j8VtV8i6/dwy/RtgTEHnJ6DUqLCksnZP5rr14+anVD3VsUWaw4y3R9k7+A3ZaEAFkw9q
 x65mOTGly+y3sntF58PsraztAiEPI7VzbLNuFf8LBPR64fUVeC0c/W44DgAIWtzG/iold7zir
 Ry8DCr/qWbgm9QTGmFC4kIjoVtheQj+IgX7M+C7gv5eF3Xp2SGZmL5EnnXEvT/au+hBVDOW/U
 +KHm1UTn8zBlvpS/0JARPu7U32ZnD4kWLokPT/fJUyK8nU+3kgT9YqahXgJB98sBNpwl7rDK9
 3stp2hAqN7mr2WqfvfE1G17gqNqA0fGUDw1uaAfhfdmQpzjmBCgFKMDgvQ8/HDCoJzj0ycJji
 GB5iO/TSN61Gd5soPMqvhtgTWYRyy7TEKfe8hcGgSIRfGEcWlHwz9mI7qTwbhkITTwlP+Np7P
 fQSlqyI7pCevqZEdp3kJjiye3IwI=

> This is not a NULL dereference.  It's just pointer math.
How does your view fit to information in an article like =E2=80=9CFun with=
 NULL pointers, part 1=E2=80=9D
(by Jonathan Corbet from 2009-07-20)?
https://lwn.net/Articles/342330/

Regards,
Markus

