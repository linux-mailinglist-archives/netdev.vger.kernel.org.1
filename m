Return-Path: <netdev+bounces-167707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD2A3BD70
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ECD3A8B63
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301C1DE2CE;
	Wed, 19 Feb 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JVtfwhf7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D01C700F;
	Wed, 19 Feb 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965886; cv=none; b=IhvRfHPIhcAXqx6gYGfugnef/GocqRZU/moeXLQzNQvuxef1clLT20tHJqlDsuZaRgOhZIzHld9DsYBCXUzsiTXTuRg+I/2U6wAA2YuuG7H3Sd9VGMvQWIHMAirmWIKDjsVVitXFAFVpFaRBy9jfeHRfZ/0WgJBT8s4pSRYdwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965886; c=relaxed/simple;
	bh=IDthTVL2Wrce+0if7DYoKTu3tMYLsxDFclMAU0Fkw0Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=H+QLZVkzpd/3wJzxismmYoKG8aUrkawixPnh9wO0KcE8OUyE3FyjRwDdJEk2LW/pTc3prSP6DFWhb4QJ5lAKklCG5nZM8P6aPznkUvFn7sVk8QKtthzbRnX2UgqzpaU+yT/DaxHEWi9isuLI9MEeBgJRowisenb67oBUYUOYPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JVtfwhf7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739965835; x=1740570635; i=markus.elfring@web.de;
	bh=NvehylpXKAE4GsvHzvdLLIOowgvyYMRU7kGv4X4UngY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JVtfwhf7WFgQLaTkRfW+vr+Dp1wv+41F9lKvulOLukBQgpVvjU5rEHywyPZekY5t
	 Yv9l01MUfOpf8C7AjgzoFWERlB+i9BCSphMtCTHxMi9sjT0ssqcHtuWrrwPJ7zePg
	 kieLsPOjrbI/Iqm1XcNCs3wZITk+gCZqJELZfbVj8cFgOsEz9/EdMHNbYLhSY0Kcw
	 lJHTZKphj/EVyuwDftqcIFp3TRrUUvL46i4wNnNYtBFQNRCfzMfGkhpd6FlmKNT/l
	 q2yDBbKIWhXEFYk8StPvJ/kGB3m/bspxT8PRj/AJ8y27UojLRg4QOwkv8upEc3WSX
	 Zsj5uF5plzUrN9n0oQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQyl-1traNc1Mbr-00U394; Wed, 19
 Feb 2025 12:50:35 +0100
Message-ID: <899a68e1-913f-497b-a8ac-12af94e776b2@web.de>
Date: Wed, 19 Feb 2025 12:50:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org
Cc: Kohei Enju <kohei.enju@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gilad Naaman <gnaaman@drivenets.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Joel Granados <joel.granados@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Li Zetao <lizetao1@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
 Pekka Enberg <penberg@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250219102227.72488-1-enjuk@amazon.com>
Subject: Re: [PATCH net-next v2] neighbour: Replace kvzalloc() with kzalloc()
 when GFP_ATOMIC is specified
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250219102227.72488-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6pYanJvVoy3kjf8nHZT5X5BQBTg2kZHu7XAP+a/tNgMwt6VV1lD
 4PkDbOMbQcuSxm9hcK4YHklHWqG9LNerp8R7CosuCXsnF3SFJTMHFhS9Za8Royu82/Z3rud
 x42rQ4Y62z8S4bRfciuTmuFNZ65FLipTPQYX0tyMqUizR6zScpBzt63z4fUxMVJ3UaEBBIw
 CKOzEeKTXFAGrcmMDtg1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Imyo5+kblPA=;IZtplPX/5S2Xl83MO5rkyCWJv1b
 vRCSupZHsFVntUGeJia5oTYYNPv/LYDS7lYcEB7rnNFN29hNVEB+jNNEIRQ/Cgscq1GCqJOC9
 9KPVl7LHCub/qfAQG1bzZP5iLrOmRzXErGcH/73Lt7H1/ZQW2cK1b7spq6VWojrh/Xvz8KgXs
 UCMyE4JDae/nPJpoc/4TRb4MXBTySH53oJ1MixVqX+6p7NEpokRHEpIqssdLNCbJDTT2XE23H
 sDFIVjXIY2Oya306/4JFhN53LnTwhCGnXSyvVbJs52ns+R3nTAFLbGuJJW37yJY7NugTAfT4+
 +W12omY88KwAJGq3T9KEtlseumhkJwVCPvSjKt6f/b1LUFiplTrXEpY8Da48LdXhswKFYyUjd
 zt0Gg4aHJ1jeFqsoxLEwI5tD2uNK0Ir+OIU4M7L8GvHnGWZCcp82+FjP/ttZ2PYJS3HxdSsgZ
 4W81gsHJlFWj2vKseeXNEY4Sas4aPZoDVrp2cfget5uk1cjW+wAf6Th81JWyVDHQQCKuQa/at
 5vsCbRYFw2rkGjd7ZuvE3IEc3/k11WCTEOkrfy+GGftDyoMIbVDdtB1v5mrrgILFIlK5FUlVe
 frV+cff8aNZBnJs20CbRG+qtfFw65ODgJz6HT4Xd/KeaeJvlQp9yUnzHxa/r6GtRHIMvYzD9t
 nYbqbnD8SYHYjwZNNGi8PqyqOynl6x/LEpG5mqW5u1RVOS65qCUXH/fGaCvt4OQVXf4PF3AW/
 IHv92lP0Ix/iWoQoG459iniYWvZ7cxu7AKj8JdAccRNHiXg0CSoOsYxcJQN5RD3zRrZQnN7Mb
 KQb0OWnIc1ihPNs9lyrjm5DShGrouvZKP3cD2JHd1I89ozo9+AmvOd/XCaS7jagf0XHumZ5EZ
 lsgbn4ReougJCUrAkT846TBODkCFfjaqEnyX7johm0aBsNTmfdCCcr3966aethhzllp/wRxVi
 axdQhtAxBJOCsZyOwVmxGKioHoLGjbElbKKWVfjZVNAAvcoGfdiluctvp5mioS/O7b5SN2ptA
 OcDJTiasP2fpuZBaAiSYGRHHvvxwfS9TAIgcyMi/LkwnwX3aujiu02AFtyGdwKBQebpJEkast
 g2SGJ8FHjquoR6Kx1a8Ldpy7msvcfwi/DEBtAlSChCfGtFvycJgqcbKXUfhW79XU47pcSH/Tj
 DOfrAent/Pom7jjmDC9dvHIVGX8ib4CA9RI37VLMobwzf7vCaI+054c416XH3UvqBkqbKUi1H
 WzmJW75yKJA/jxPdSi9MhjVvJST7I4sMgubSSgByR1rQBe3W0yq90sy78hxF+yTrgzlh589pP
 ddLo1AsNHNGCmCSGybWcd1hecGwszYcNPYL9Q9ih8ldsipxHODhcJ+Na3yDwEr8VKFCHFyIZu
 6anil/ps9Tl2OARMp061qAiSIULmstvQUozQgiSXB1PQlO+65gHqWOa3fHDAkurEcEfp/jfzk
 3wQ5cVh3a54gTfI3YwExFPgQL1HI=

=E2=80=A6
> This patch replaces =E2=80=A6

  Thus replace?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n94

Regards,
Markus

