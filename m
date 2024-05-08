Return-Path: <netdev+bounces-94460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAF8BF88F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DE928682D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353775026D;
	Wed,  8 May 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aaXBsLvx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2B47A7D;
	Wed,  8 May 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157169; cv=none; b=FIngEPfuuG2W4Jipq9b9rh8DVkidczSOazS6cbiUcoCDZD0vWAYcYBm5ONt16QX4bkm7TXIwKLmHvnPLf3H6/a8iVmFaXLHnHyo6wdU/spXlhIeqfgxGrCqUjdq9DvBQ/4vziEgwwA6PoQ35ZZQydpsok557W2CLS0dL9khMAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157169; c=relaxed/simple;
	bh=X1F71bqUTtnwDXgkh1tSC4NNTNLQREiEi0F6wYWTtJU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=u0jOswOWfNV/nH4+quRtj/ieBLQLPjAD8gFwzRSRcYf0d0ehyHD9WR9GFTVwezLihtRNN8Apd5v6e7+Qlmcwz1dUyz0TSnpF01xYN2dg1yRGPEIF24g0qZEU4brotbS2/y9U6UMJIPjms+2mtcNd2aNepauPEGFwmmloFpokaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aaXBsLvx; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715157143; x=1715761943; i=markus.elfring@web.de;
	bh=oZq37vWiGR286Tk/fZJLDQiM5qL995HLhi4rMYm4rMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aaXBsLvx+tLaMWB8G5Z2hqM4X8WdzCPD27gxIR8yiW1636fa18jeF0RbebkVhi49
	 0i/YYyP4zL0pVHs1o3mPISDbhH+wJEANiQX2sfGqTFtaD+yAszC2lRqUK+tp7n2to
	 M5EF5cDaYzTsa9B14SeTbbhr8uvRnVJFxzHrlxVPH2eX4EObBT4MoqrmZ29Ww0VyB
	 HusPK6krbWuYXslsTqXg+5UhXuX6Xu4hOfVuBD6ffT7Xb21bePsxQwSFwmkndWQGJ
	 djR4i0Q9rwArLc9+mfhgpH4zancmdpnHDiIkN9qLtktskXtHVjpc+oIxbnlofnIIf
	 bW+41b6IM8eg2R3+MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1skaH046f2-011vUc; Wed, 08
 May 2024 10:32:23 +0200
Message-ID: <f9c7f7ba-fa82-422a-be3c-fd5c50a63bfb@web.de>
Date: Wed, 8 May 2024 10:32:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <20240508070935.11501-1-hkelam@marvell.com>
Subject: Re: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue
 index of HTB class
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508070935.11501-1-hkelam@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hb9y0tp9rjg17HHnW1+x8wRVtZ65ElgYZSlLkpFxUps330sVZvJ
 oQQUmV7oa5j/CpWReGwkMfFVmSDe0WO9RyEscWdTYJIQZ/a8Qni4JBFnjkLBF1g0lHzfZ5w
 5baPMh5R4DhKW1KKQp1TRbZh/szGxeMDY3y57WxMOMwqCSGibuuYzmOwyEAFJNeHWHmgRWU
 gMGN+aKYzBeCnykATsc/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6fQw/0olnSU=;t43d8NKPSWZy3gPseridGy4BOx+
 c9LmDvQWnotDKUktUXgnnji0TL2usg1Jxp2JGoCi1zi3KMm5hkGOYa2kfIpWc0aosKO3+/F2z
 Xj8PFHa6QH1hoyCSNLXJ0KwWCQigIQJ/gs43gszCNnSQUpypDkaBmSSehNHz6PDiJzsT6IG24
 RBSQFdJ3KbCdoGRBRnBIWFzbFZJpN+gMn6SElOWTN50T4l/4LkOI2mNBTmZKpWTcLjTd7eqTz
 WRP1Bw3QrdA/xezGhSAfmv8HPOGZv+IL7qjhBlrydomx89B2xCB11dQQsq1ON1NL26+PwGEB/
 jyr7fHasG0pNfmMQTK7QU/qcw/WEUlN42Ir/SeqEhgGDTR0pThMR9Tlfp3yTl0x7cqXpCFF9v
 PdPGkvf0c3CmygNYFHZbTUJ/CZ4FP30SBF/Dubr9cW+JehRTTIyN9pl0dOUS04yloPybQCL8n
 zB8DGGIVAqFGOmx0fIVjxSyR7qoVDfcjU//WP2shKaM2qfFdeu/vNIPD15iqq/9Y2whYJqz8d
 MrjA8VEZtRAX2Vf0DoHbhgg4rOFBJ/GWfcAc5rtqDlGc5nMxnRiJUpPaUFdJbV8zy+nGk9YBI
 IpPG26aM22OC63TkwNdohl1G3TSYHi9+BEc0pGzRdZoogAKNLu8DNIn8T4I2IavWefgVNZ0Co
 ip4F6xjpqkpFam3gX9zjJZh4V5vVM332IH8nTj+CMMoqXrQT6/BwE+4Hsh+vF59gL5mfVIQ69
 tItgNqa4bo+bKBjWInhhFlDMY7oWZwcy0o0GmuQs3Q6lNiDQL5oQfAN9ywpjC0UGXR0jetbfl
 5x/calVUK4JwWpi18nVUF6T4o7sSOc5pmAT090LsbRqWk=

=E2=80=A6
> This patch solves the problem by assigning deleted class transmit
> queue/send queue to active class.

* How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

* Would you like to use imperative wordings for an improved change descrip=
tion?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

