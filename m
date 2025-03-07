Return-Path: <netdev+bounces-172983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB305A56B4D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4927A985B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7521C9F3;
	Fri,  7 Mar 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="XOYPC5Ty"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768721C195
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360126; cv=none; b=W9E1FpedteCUdsf01jd/FRyTm43CmNdLosMcJCZ3PXq+/HbEhb9Og8YlR3XPIij3xPQZWOmuE4b90Cvo2x19LputwDS37JmU0IvfbeLWZzmjIQjiuUrtw59/RDxW+/ktslPX0PpBzpiotrQFTehI/GiJ4YNxgIwMOKLRXRpTlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360126; c=relaxed/simple;
	bh=EGdJbQmHgc6uM/YYntCrOVZy5ZbW1uwCvTs2CXKesoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+AsHbuayM11CIyr3Y0GrpdfwRF1XOu4o5ixPfG+1i19t2TSUwY2PycWV9I4vnoA07atXwnHXTi1/zIwetBTFXcbPFZQ/l/PbuthhYPjk1GStI88r6kAoDrDQYSYa5pRFfKzrCgRCm5aJKdUiAkNvydTgxpMMED32DPV20vQmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=XOYPC5Ty; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1741360121; x=1741964921; i=ps.report@gmx.net;
	bh=EiIGZUJlacb+0+wvJZfLW7r8IRL83ercsHnL5OvAvQA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XOYPC5TyS3mkc9l7fHGlfthxcNRVUbGY1aGJlhsBqGA5HjNHJrsIVU6MAWvJC/WN
	 Z8+erCWsgGms1mCRehQNLfGr+hkREtQfym+7Xu3bWU/NlaLAiLeqwLlWd2hCUp7jf
	 z/0QGTZY8qaBB8wJCTNMV7nk8LeKzx639YT3YYjW5s25PTOabQ8VvQEclR+ubK1ZN
	 XYhu+mFby1tRxj0srv8O0EQAj1Ewz8MOgD+NhAcLwpk/Yr7Z/UMfWCXk3Ls02IpAb
	 iZC75TbZxJWZC2Zn7sB7xesTNw9UcD3QD9WwtxnHTNbg/Azu5UaVvoEKIo31TyHcl
	 cBe8de2TUvikFaWQUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.117]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1trwt13W71-009oDX; Fri, 07
 Mar 2025 16:08:40 +0100
Date: Fri, 7 Mar 2025 16:08:40 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] net: pktgen: fix access outside of user given
 buffer in pktgen_if_write()
Message-ID: <20250307160840.6e635b83@gmx.net>
In-Reply-To: <36cf3ee2-38b1-47e5-a42a-363efeb0ace3@stanley.mountain>
References: <36cf3ee2-38b1-47e5-a42a-363efeb0ace3@stanley.mountain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jFBdyXVd646ZCInwz/PNr/VPYYfYq2bMydhBRDPMdGNnd5VuJ1+
 IHqdBVwmUWtjyeHaJxMmGKIX33uiSSWra83uJgeENJ74jWs2llKSRfEooKPC1QSPVdjvg4K
 4ggZFRUC1l3HBc5nSqpctN8B1cDt6OptxpfJq5GjWtO6/rnAGRpavRbQ1Zt9pBb9zQPASoZ
 Q4/j2hJOLEuxz6k3VOGhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y2xt6gOpPKA=;LxY8sbLt2OD0LhugiIRa/5G5FWv
 4EdR6KctU4cU8fX4RkdBLw+xrihUgrI3/c6xugI/by9DsdFge3ul6AsPfK6rOMICJr7ki8z84
 6y0kz2df8vZ/Vo00NADZw5jZ1nIrJgOQBlFRI4O+oA/AbDRFXVTU1xvYwjn6Z38gCq/3xiC76
 4TJh5nymqT1Av9j36G/w46ubP5egc0M07ZCGyp4qz+x/W5LV3U9gLGsatUCmwqQxHDGHK5N59
 ZS14eOGzBwOHbmkVdDLlxYhnCv/sae1ufD5RO2maCwL/XuJAj3kCpeJZIrsaVpm1rnMYqAYua
 h73o8amlQrVr/r4pWHoxy6O5xWXe6P5T6Xi/XoHGeFMRN4HQCDs5o+rikaowFE74E8uZnMbz4
 w9GXO33/2blvNeG4bhpaK1oD4FYZdDouKR4HBuS28iTBaqyhafFqigezwocxhy1Gzf3fXc8DQ
 rH2Ocy9fcTXYcY5rScX/2fzc4/DvCTV5lqTNirvzbZx8tHBC1TwRD9EpIOCPfzwZOaPCplZ3n
 FGtmnIQ4DN+za1ScqEu3L2k0xdehNVSHs6tY54zmC+IPJ9Hfw1kZOn2/hsPHpuCpyYzMJG4XP
 +M5gwylVWpcKi8gKdh3eaTiTt/Jmw1QZGYSVJXBD0sUs3cnClY0Zv0c6y7ltSYpdkp4Jjqvid
 0sq2/hejd4ZahZQl8Tp+zn6yO8cZ5gQA9SoKc83ETujWAG3TSm2wcgNQtmTxNaCyq57ut320u
 /QyEAkgwbtOFGY4l6WkpdBT+tjRoNGvwMwScLW4c5yfH+AoYzkZNYEp5AD4gz63hnHsf/vBU+
 ntB03rkGPESajxqEV0rxJgLUmsIPhhPxgr1ZEJTsPfz/Q9fBEkopIWPdFFLrEWt/AgqDxCTVY
 OvdXWqpZsVUplWKfyozbJSW5HSP3ls7W7XBlt/vh2yHm4amefLcpcRQhqSHAAwXKrHo9Hsa6W
 5Kq+E/ngTLVdidqbjV9mJgP1D+oNDMcv+vmM39tOv6LUSTx7V/lgCYubHjm7pabXpFLTEDR0i
 7LGDPOydHvflvARTA0WnXvXhsvQ7JG5xoFlm9vgxGSB5+0QDBNaNr8njL0VzLMnyqgKNP+p/Y
 mIn7OextpyYOS0Boig5gES8tskYciWRBbnDpQmPc4b0z72jmn9785Bep+JPlhulWRLt6y/QSS
 4kLUJn2k04qoo0AJH8k6KPC6QXhsxRBw4NwUP8t3KMEpyZUxG4Cy1RR37UagPf+baDzDwgrWr
 uRV9gNVWFk4Ltk3c6y5A0wedP2KeDgGEUsPs2iZhgoSu5i4FD2+Fsqc1NOal3Lljw6AiP1++u
 AinlvizeLDi8LchqkxWlqQuk3ak9n7N95l9jqdDLGoKQlftRUsN3Or8IpRwfn3DeNQhvANGOq
 4zbFjtlllzu1VlYGx8c+BdZ1d2/ovYuM8NLEbrxVQFaJ6CuwPE9m3TJ5jb

Hello Dan,

On Thu, 6 Mar 2025 12:48:51 +0300, Dan Carpenter <dan.carpenter@linaro.org=
> wrote:

> Hello Peter Seiderer,
>
> Commit c5cdbf23b84c ("net: pktgen: fix access outside of user given
> buffer in pktgen_if_write()") from Feb 27, 2025 (linux-next), leads
> to the following Smatch static checker warning:
>
> 	net/core/pktgen.c:877 get_imix_entries()
> 	warn: check that incremented offset 'i' is capped
>
> net/core/pktgen.c
>     842 static ssize_t get_imix_entries(const char __user *buffer,
>     843                                 size_t maxlen,
>     844                                 struct pktgen_dev *pkt_dev)
>     845 {
>     846         size_t i =3D 0, max;
>     847         ssize_t len;
>     848         char c;
>     849
>     850         pkt_dev->n_imix_entries =3D 0;
>     851
>     852         do {
>     853                 unsigned long weight;
>     854                 unsigned long size;
>     855
>     856                 if (pkt_dev->n_imix_entries >=3D MAX_IMIX_ENTRIE=
S)
>     857                         return -E2BIG;
>     858
>     859                 max =3D min(10, maxlen - i);
>     860                 len =3D num_arg(&buffer[i], max, &size);
>     861                 if (len < 0)
>     862                         return len;
>     863                 i +=3D len;
>     864                 if (i >=3D maxlen)
>
> Smatch wants this check to be done
>
>     865                         return -EINVAL;
>     866                 if (get_user(c, &buffer[i]))
>     867                         return -EFAULT;
>     868                 /* Check for comma between size_i and weight_i *=
/
>     869                 if (c !=3D ',')
>     870                         return -EINVAL;
>     871                 i++;
>
> again after this i++.
>
>     872
>     873                 if (size < 14 + 20 + 8)
>     874                         size =3D 14 + 20 + 8;
>     875
>     876                 max =3D min(10, maxlen - i);
> --> 877                 len =3D num_arg(&buffer[i], max, &weight);
>     878                 if (len < 0)
>     879                         return len;
>     880                 if (weight <=3D 0)
>     881                         return -EINVAL;

Smatch ist right on this one, num_arg is called with an invalid buffer pos=
ition,
but at the same time Smatch is wrong as even in case of i =3D=3D maxlen, m=
ax
is calculated to zero, and inside num_arg the invalid buffer position is n=
ever
accessed (for loop capped by max =3D=3D 0) and a zero value for weight is =
returned
leading to 'return -EINVAL'...

But yes, checking i against maxlen after the get_user/i++ step (here and a=
t some
other locations) is more straight forward and easier to review (and easier=
 to
check for correctness), will provide a patch fixing this the next days...

Thanks for providing the Smatch warning and explanation!

Regards,
Peter

>     882
>     883                 pkt_dev->imix_entries[pkt_dev->n_imix_entries].s=
ize =3D size;
>     884                 pkt_dev->imix_entries[pkt_dev->n_imix_entries].w=
eight =3D weight;
>     885
>     886                 i +=3D len;
>     887                 pkt_dev->n_imix_entries++;
>     888
>     889                 if (i >=3D maxlen)
>     890                         break;
>     891                 if (get_user(c, &buffer[i]))
>     892                         return -EFAULT;
>     893                 i++;
>     894         } while (c =3D=3D ' ');
>     895
>     896         return i;
>     897 }
>
> regards,
> dan carpenter


