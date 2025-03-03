Return-Path: <netdev+bounces-171113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F9A4B92F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C78188AACD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815321F2388;
	Mon,  3 Mar 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IHyrl3N8"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8A1F190E;
	Mon,  3 Mar 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990191; cv=none; b=NtY3V1uKyVUjGnFEfFZ//HFQ6Vh2hZUevvMdOssRIaHDzv+CMdeqHi0aWFdg3cP+wKkZeESQ6XhK4I5t7FeSyAdAqHEmFj1iG1ZrGKJPj9+pyVFYcxysuZItspxjwGmPg84hSL1PA2/sh/cjJKInO+KKwQvGkKRALcMy1JArO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990191; c=relaxed/simple;
	bh=YRq6oVQqeCdHKG5sea7pdbS+m9m7qFjktB2rPbJHuI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecmIYiUT/CtRLt5I/ihH2P+sq6Qox0xYjOTSnQ87KOjCyJJRlprRJzCoP184+9dFXxKkGdD79AsH8Wd4GKX9DOLjmdNs4HfYB5Rf/FK1f2JRam1/jtUcz6qqeM4zrts2wdVNU9Mmb3TteUH7ObDuxWYHz0qXUNbFexFth3Uk6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IHyrl3N8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740990183; x=1741594983; i=markus.elfring@web.de;
	bh=pQr1WZ548ecZB3xoVxnsW4k7x9sHO8xZY4WGSA4vMwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IHyrl3N8nH/24Fv2D59sEna66ZDL6YcZx1VuTjYlv8zOxC6kfM+Hn4Dzqg9oOzhK
	 k9S3xBw8V19ADKeFb8D3lG1/azmFLeKXxgimfL7aEDePqPgOHLVTnnfV3HD4g8lB+
	 D0yD8Bpby1Hsx41T/KE7FS5tuurVvcN4IPMx+jAvLghHyhLTuaycUqNc76zK7fAM2
	 t86Dcok96zxz7qU2Z3t3iLdw/Ba76G2fKm5qXt8jj8XmcBe0T/bQFMUx89AePKhS2
	 XkXbdtVyhEYb+AVxIM3BtgNxnEA9+LzWOH4sqNwmxqT+ZkcP7lH7dvxU/MbuKO6TY
	 m1mxmHHEoDMS++nMlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1t1bHv22Fw-0171x0; Mon, 03
 Mar 2025 09:23:03 +0100
Message-ID: <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
Date: Mon, 3 Mar 2025 09:22:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] qed: Move a variable assignment behind a null pointer
 check in two functions
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ariel Elior <aelior@marvell.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYo4KR0DHw8kUBrjrDdkOAm8f/u2tVyaWSQA2DnGNc9JQQ86MDa
 bwKKYeavDxHfWlkAduCnA25E+m3vTJHha1KI0SBitDv5vFfARQ5dauvVrFkfEwldr6cbXGt
 rQCLvY3oVIof17p3AwBXCexkZzFqAr/NbbgHPUCe435Or7d5J5W3ZbwPWaQ1l8mwih/Qifp
 C0Slqd/P/qBIyY3LvcXTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RCqRm2Eproo=;ZlnPkZrhZ60vOLSzosM2YPI9Wto
 3AmsBSv9KLN+XyU0X1LyjqAKQErpWV7K6f05wETBTPAZ58PzopnFENYzawmjl1X/VJKmGLojS
 2gI2KS0iET6vrphGGHhXKi1Hzd7UTG7Lj39AHYffLz/t1iUOGLHlOWsI8GFWdwmBzMhOxZ936
 jYsVdJjPsUKRoTMKQOvziv+Mix+NSl631TqKmwCd8F3MqQRsafqZN/j8A96UMPA+u/hWgspI/
 9BFmyqSk8N+rtYm6BbOlqYeGPM6dm7F+s8L/R04JR0fGXVLPmWHCtci/efVhlIZ2VKj0Kt1Cy
 MZ5iIzxadso6cB0Eh2vnv/jnbWdxxK8JvKB32CK7PFz7BOC72Um0Mdx4Mwb4iGPgdCU3Ef/5o
 4VWXjwFQaDqGBf9oxZkyIK92y24Ybyj5px1tl3SEoN2GsyFXt4LYjQSTJlgKtcHant1XcaBKd
 z9T23ZxWcLPomObRfxz9YgU3ddGaCWfX1CD5eabzjnXNeBYkB7V19WFsf5M4Bh4mxYjbF+g9B
 dOPVAUUiWwzOjW9oT4gBl2m4nlOvthkrYx+2uERqnvVmuNCJFkcIdyhNUHIeWtbo4riP+coH8
 o2bMu7Yj4Vt2tMl1Xx+uJ702p61Z9m2sh28JanSW+YB1ReG8jWmulP6cex8cFvIf5YgpmPceM
 z2kn9sRul/TcxXewJUsiZ4fdBQxO3nj5o6W0vDB/3zkQtBcFs80op67pZc4ARQYIZKGCFwcZv
 YWV8xMIHVpy4+ByUeiwCpSwlACl6HLN49KVgXKgR738RfUxjcFwe8DoaJlywHbGDP2j8einMB
 tzEb+f9Emed0rVpPoyce8yguveZDnEPDQcXWDkkXblFxKzP7A8wFsbkMM7mgi04hIt+b0W6Do
 ot/IgkptfQSXr70rj0yADvh9OsOfeTw9qnm34ZW0xSPk/laeR6qCudvliP9ZI5EIlUpp7ynW4
 IalZfSiycRjcPxf20I/4YC3YpTkeOf6YBbfQCTnQ7CnB5Uv8gDVrG2mwGlJsh91ew8AQVxPjU
 ZN4fqMenZfLLuUHdrURqhYgHJcUYdTIiRjEsM09zj8qgylPtdJfrLSN999h5uF2rsvUK6ZfZH
 QxNmHT2jYTH4y7BkMNEpMYBNwfVV0aexJkcfZJFuuMAp9kxLqy6GV5CsI+K4IsDtvzyjqum2v
 yYZ/H+KLAoXzWRB60R4NCTPpVyRzW4u7m8hqQOEa2Hs1diHLgvYsaaHnDCycHT25ag/Dc5oJV
 ALfintfOGP14oHY+hM0pjag4b1Z5c2gCfof8jFqfEbzRoSDAJwJtLnqVzKMwX2cxWYRy6GUG+
 lr/aBRLLD+XwerMop4uYGSUXvpDHJzevnvAOL+/dx5nGQez9eJiTFeV3qXsk8DR+lTcqBijvd
 JvvjGhM4eJ6sY8FOKdVMKc46vz5mYYJCU3jp9EwmyKr9e0Nm9G7IDXFqT+M9NgKMnptPfcxZ7
 447OJIA==

> The assignment:
>
> 	p_rx =3D &p_ll2_conn->rx_queue;
>
> does not dereference "p_ll2_conn".  It just does pointer math.  So the
> original code works fine.

Is there a need to clarify affected implementation details any more?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers

Regards,
Markus

