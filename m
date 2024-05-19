Return-Path: <netdev+bounces-97137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD18C9503
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3005B281330
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA8487BE;
	Sun, 19 May 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hsPoZwPb"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E5282F0;
	Sun, 19 May 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129101; cv=none; b=fvOC+G/EBKxhtNhk7jO3QRknlFwhq2e5RX+t4eZadZj/c4UkKBLqlDmNyxAOO4gm+P1EtTdqFjPL8+bCH+CROLqSnd0a4xWsIvZ50LFMNv2TtDFfCeeh47hmpLxyIK7TYFJFbvflAZd3JUxAH1DNTBW4bNWtzGECg6Zr20h92lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129101; c=relaxed/simple;
	bh=Bo0hkkNb6n0GtovvowUCH9XaoMAubly47QTAmugCRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s621FQX9ZNFVNq98i7jMDtymB+zEiEYnMFK2N7ZK1ZMParFqsBbzhAswyG0V2KmZNAUTpkKNsUHWxYMOmq4OZ3h/zhh7/thMlaOTyJIa/oW64zglqAdYWHqeXIai7hM5PxaUfdZsOP8SfVSNleEbR8NWLEI+kyTBcjGMjf+77aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hsPoZwPb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716129063; x=1716733863; i=markus.elfring@web.de;
	bh=okgSGZhPXLzsKcF0XXQXyYWpYhHobc+okPiEHtdUg2Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hsPoZwPbyl9kHz9oKkiVu5F5hQDrX/uhpttLkGq4gkskP0mIvN+u6qQazEN6bfC/
	 w43xpBUftsCLM2XXNgxDG1y9sBiHoGuhSq10V0/KoxjHQuIGWtB+7ilSSykmWL3Jp
	 8ERJ1VS5bv0Mv7jwXZte9olZWwz3ixQbqL2gLXK+QKuHpoOhzYXfDak0W1ML+DerU
	 SShKVwM2QtpV/OIefLftCWKA/sI/z3EUROSkm1nVDFvYqmRZ+SmaS7wqbU26EMezB
	 f6aBh2MXdnjMta+mDlUKkEL9kCxZKwPHxuazKdVB4UGduFzAp8rG7F8XtQxxet4Ea
	 JywBbyAtGSfdxkUPCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1sYnFk3to2-00x6CV; Sun, 19
 May 2024 16:31:03 +0200
Message-ID: <13c9cf99-48e2-4638-b40e-e5b065421ff3@web.de>
Date: Sun, 19 May 2024 16:30:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 12/28] net: ethernet: ti: cpsw-proxy-client: add NAPI RX
 polling function
To: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Roger Quadros <rogerq@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>,
 Sriramakrishnan <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240518124234.2671651-13-s-vadapalli@ti.com>
 <f9470c3b-5f69-41fa-b0f4-ade18053473a@web.de>
 <ZkoGCpq1XN4t7wHS@casper.infradead.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZkoGCpq1XN4t7wHS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZOR+qvZzRR+ttY7PuL03hVIwkfO7x7y7RvXHXJuDeJUFFg/+vou
 BwVgWAInZI7x7d7oE3Dfl/rE7iP1T/eLVCvjjfayyrwhEuhxhwE39O8tzqt3roh2BpMqkGi
 aYy3QlFzjJqzlz3/9G7agOFYGgUOyXJrtimGjGkb4vKKCKR7EUy6tmNPRBVAaWj+dpIz6vc
 aAEpAcp10aXc8VNXn3i0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p3njCTGZjQU=;MM/BtbTKdD1/cFkV9hDHqUuaeAA
 R8CSId/keq81wOpxwHGT/KQ4/EMc9EoKDoFt23MwMKcwbX0IuDzl6HNuffNcsR6AlDHighzfb
 2B+cutp2WbiKUvJga7TBKBM4przF3nvvKDYzJmSZlEJ2O24l/wZoSBk+S9KLD3Qhl+JqLp0Em
 1D3zuB5amF58IKbdQDVQ7Pxcf+Y1RTTct+Ayv8q7I9D3GoSbkiRw5K97Tv1ryT0qwrlOGgHFS
 eEy7+ebyN1tir8hvfeVLk1Qys0ls3yvzpSvRFqpEqgdQi44G7Nadm/k0shnia85KtpxgxlKpW
 DthE0qQZIe3mtkDaXSv/xCmphm94gZ3n4/aqVbarmLo6ou7IW4UAbUhALG1dPG0FZNM4JYjey
 cg71B7xYHPic7aLYL7fHJZk5VCXGbcTx1aF003t/t/6VSfGZYRTo+dmAiCWl5RozkCrgIbLYZ
 QkOhjRi1J+a3APsPw0obs+FQOxDy3HXTbW28RPwmLhYvoc/Br1gXrJjcBulS88IqHyWQviK8d
 U/LeOlPk5asXdhWhlkJH2QpJv1u63peW9/GNboafj2B7flO0toWBxDcrBxrf7tPz8juacvrrW
 nVfBGcU71xJdyVS3sr9iBIjat028YQsdef86mkhzfZ6mb+YrBftSIpyQrlqzUaz0PxTAYJKtQ
 ow/iuIjcM6UgdqQPm5kX9tFvzUcPDxqWuzdx8YyHrqIo9gSf/aJuJff9epK0jjydIcxA1vtN5
 ZMzWwujjFG46gOhAZyhKEVjPxSSlXZHk1yH6F/w9vTrNa4jByh+yImhvHVTPa8bqIeTQjSJKp
 iviOXkUr8ycRer9OPgCgyULquV7EQb8P5RSH7uOa71E94=

> FYI, Markus can be safely ignored.  His opinions are well-established as
> being irrelevant.

I hope that views can become more constructive somehow.


=E2=80=A6
>> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a=
+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+reso=
urces
=E2=80=A6
>> https://elixir.bootlin.com/linux/v6.9.1/source/include/linux/cleanup.h

Do linked information sources provide more helpful clarification opportuni=
ties
also for undesirable communication difficulties?

Regards,
Markus

