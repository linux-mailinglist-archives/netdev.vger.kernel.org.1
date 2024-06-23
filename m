Return-Path: <netdev+bounces-105927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D3913A26
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA471F217FD
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D71474D4;
	Sun, 23 Jun 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZKOQtbdR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5E145B2F;
	Sun, 23 Jun 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143049; cv=none; b=A6O1ARNndEIM30UuIFiSK5VtxDvhMIowB9PHmlfwTiuxjASv8csmWAbY/E+7glPfKk9eD9FnYQ1NjtbnhvqsaJsSJsmC9r8QuxSxOGz8o7EjqoAsKNAuSgd+rzlrwsszv60dbPRG0sp0A8rH1E7rtx+z9I0Ixdp4Zg299zzO5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143049; c=relaxed/simple;
	bh=wT77QYgBvgfhwTUeUy6d+WpkpCPIcYyZVdrxO4S0lmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IijIhD+a2ai9y10HCbwUGEmlug2jIvsobvPcoO+cyX82Ti3IL8PDC9lkhb/8DgxEbFM+bSjnZjE8cQZ1CFWLpiibA6k/0cBHtGeV4nuZttlFHjspmOn2tq4hd7qT1HlSnx9x2NoAlTqxiYDt1r0NLRn44JEXst56YNFW0NspmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZKOQtbdR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719143021; x=1719747821; i=markus.elfring@web.de;
	bh=wT77QYgBvgfhwTUeUy6d+WpkpCPIcYyZVdrxO4S0lmk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZKOQtbdRfPMjY/lhu7q7qN2SZ7II0Q0T9Nmq9iPl9QWO7qTBjEgtYbw/hwi3Ek/N
	 daiwbIu7w3363DB66P+10Wc657NUe6sSGuiK3MeE+vRp3uv8jtcTK4shMYJxO7tIV
	 GJY+12lJJt44qNROTK/tmpDqrTNLiTjIjHoAb7PxeKTVc9+HtJemdzsKaod4opqpQ
	 GtCJz3SZUdPzrtC4hdvGaoT9kxsn/0J/UiaQ8KkXg62RwNDUB/rNhXNPhpEbk6BIx
	 04LjBRXGghUOKTRicpvavXvtKWfKhASLDfXBbb/ffdp2IxMb0uyENEmEpAA4VbNYP
	 BY5n1yXFNfenj2/Bhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrhU-1sawdh1awq-010ZpL; Sun, 23
 Jun 2024 13:43:41 +0200
Message-ID: <db3396e9-aad6-40d2-9d1b-0fd7fd3fceac@web.de>
Date: Sun, 23 Jun 2024 13:43:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: fec: Convert fec driver to use lock guards
From: Markus Elfring <Markus.Elfring@web.de>
To: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, imx@lists.linux.dev,
 Andrew Lunn <andrew@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Shenwei Wang <shenwei.wang@nxp.com>
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Peter Zijlstra <peterz@infradead.org>, Simon Horman <horms@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20240511030229.628287-1-wei.fang@nxp.com>
 <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
Content-Language: en-GB
In-Reply-To: <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rfK3u4LB6cSHr1yenNSUPC6oagIs4Q/4qMo7loYiEsVLiqOk0+i
 Ka2M62R6udHDhvTAAXo4h/4LJJs73y3n8Q2h+TK9mFJZeAIL7vIKkV8QCi5t0i/hhyV1Nvw
 emsyOf7T9GEuIwJeuxgj+tDT4n8v9JgujbZvaOhqOXzkcDyx1KhLOd8mnnZSD6P17eV55Jn
 jAeEHIPm5LVsqz9A8DTQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V7i66Ufscec=;lqGcNLZ6Sm8IL8Z/e2tzD0aPyXl
 s0i/vGIZifA83PHOGDJuzTTpwupGv0qlgE3a1miUCwqyOX+WKhvZpBf3jzCWjB4ZROsSn6zUK
 uVKZf5BMw5cO29JrqCjAcG+dvdswAHIkQkxPpiSlH6ss34ho5auu1EHITd5kavkgz8a39jWUh
 llM/lwWqkwW9loZUF1BXT6ntA1JicSYuu2j8ozUPxX2bjQyvcQxaaZBc7rNdie8++9JiUVGW/
 XbpF5yim5VaNAgjtP0HXkb+WnrT76zw55fw90W1h29iWNy7sq7hbJ7hfjes9HbwDFvutSlGGE
 QkFcmz/+LovU+SoIE7znWN/JoyrCb6FRMReXS3KMFxtOLS74f4tJiqehr10nlCLExvG+Ku14T
 sodUhh4P3SvaciU6IERXcRWK+kghT66PT1YrnC5HTlbSlnR7PbESckQsUF8avZM/+67nWJmYO
 bKJZS1TnfsRZEOqZMCYKaPFBg1IQbiGhEKfkSXUKItuer9pRexjPJg1hutzOV+hmPZeF/xFms
 V2Jz7iZPaAUA7tLMalVkP9Y1mKLBiuFVJ47hsJqVS1M+ovmisqeccdTdNSBmhzTjizOAGIayQ
 oGLA7BLwF5cOcjCtZlfEFz6shBcEsHof0IhrUhgn/IWMA9fDsMIUqWD5meHOZWp2G4SclG6EN
 EAzmKtniE9ckPKCoKymA9phlngZ7//AGtTMhUeBwWSePNOa/KF0Kk1FPH8v0b7OAc8PqwkTSH
 6mm42NIgcnI0U7lAm9QjglLjiH5lPOAlo65IU1rz7yX8oWk9Uxq8D4Ec9Fn5Ts6pfUiNheFVX
 IQyNkevvlHskcUsvRqzC/9j1W26+nOebBz33UV0M+mViM=

> Was this source code adjustment influenced also by a hint about =E2=80=
=9CLOCK EVASION=E2=80=9D
> from the analysis tool =E2=80=9CCoverity=E2=80=9D?
> https://lore.kernel.org/linux-kernel/AM0PR0402MB38910DB23A6DABF1C074EF1D=
88E52@AM0PR0402MB3891.eurprd04.prod.outlook.com/
> https://lkml.org/lkml/2024/5/8/77

A corresponding software improvement was integrated on 2024-05-23.

net: fec: avoid lock evasion when reading pps_enable
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/net/ethernet/freescale/fec_ptp.c?h=3Dv6.10-rc4&id=3D3b1c92f8e53717=
00fada307cc8fd2c51fa7bc8c1


Will further collateral evolution become interesting accordingly?

Regards,
Markus

