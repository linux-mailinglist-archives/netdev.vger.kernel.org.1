Return-Path: <netdev+bounces-130312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8598A0BD
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26591C25EFC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D418C354;
	Mon, 30 Sep 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RnLbFZfO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DD47A5C;
	Mon, 30 Sep 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695846; cv=none; b=QI0i/CCsQvjNPnKuQbO0CCdldZy9uNOsoomA5DeKW6tSPDy0K/LolC67BoKtE2rpaw6tUlA+z5LGimZ8Ce2eaF23OpRhC5VsKppLyKH18HUE5N0kBNa1ehzJRqUZMNBXNPTsY3d0rwd9oJw/T+eFAOtJgPul35AtX5rAMHq5mS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695846; c=relaxed/simple;
	bh=Rnp3oAKnt7uQbKWYYpMvDD5p8/BQvPa2EK6O4FygSKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HI7Gzh5xW7wzNSzF90yW+YGXmjsuFzXhlbQ639cJIrSnhzIAPBMI1Vvo4aHI2R/Hk01pH81cATkCw0bqP92OX5gwHM29biqUcLpX3IxTcEzeLgyPtR+F4Z/oTwDT2n8Le/HTiPm66P6NL3B9ixoSAOjPzItbidqX8hLC9ZWd3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RnLbFZfO; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727695821; x=1728300621; i=markus.elfring@web.de;
	bh=d0XcTI11xyggZuAJX6mDg2btd5Go79CL4rZ3yZncCLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RnLbFZfOPGtjXVL2FZys7WrLyvVMsOAW6gZVFKGSn8x5+B5WMeyAStTN4pj2JdKk
	 17ZmLWx7MbKyos00D30akxGp+5Gd2XC8LXrNgyXAewYL5GHFc7ZeUHVBCIXLDaupC
	 1CDi90jxwOzgr7+pQyJKE365uWFAAvoZWCsxQUS4j2jyN1X95a9cbOXEo13arSlgt
	 A7T1BHa1BVs/FuHQ8nmDyzbjvuYZ4NN4/vUBigOjpcq8VbyovcMAmlFpNA3XMPMtx
	 Qa5wkrsvVDa9GsrbHCLsOLHZar+Rsd+VPDvG66pVMDOEyvqFtFKH7urzogddMZUvB
	 uLUBDmcEumoemIIJ+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1sMS1D2Bcs-00fj54; Mon, 30
 Sep 2024 13:30:21 +0200
Message-ID: <21be0ed9-7b72-42fb-a2fb-b655a7ebc072@web.de>
Date: Mon, 30 Sep 2024 13:30:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xzvixUKgOXfBCXt699GIb0+mo0u9g1Dvr1cAFr3gmI/VDPsUyBJ
 ZmN5hIryhXzOoDV3nzFt/bUkN1dqfHJNOAy7H+eJ//XMCfSxK3WT+iqYmc3KB+iyBiNaPpA
 9ypaq8r9UvtJ+cGQ/43MswXBwANsINZ3XzTjjWE0yAPZSoiMil0iviJvaRJ7RLW1R9LYyfE
 WGj9dUpN1MpiotC3FdJGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iPuPNAsv3as=;TenYwlrRc2lIEk5NSrZcVPiCITS
 3MKDynz/FL0WS64moCRGyYTQVwf5nbIFDxR/56/7EG5RABpMUDxdaUJ0RCJ3Qas52jf+aNyry
 sMJHTkWq7ZAk5ELLW+cZSV+upXtbsCtNA+c36QG6wszjkiC4/3kqEuMOZrswkyBwFFUvGX9QT
 CYY4DZF9FfhfeGbEBO9NHIxN/uE2rW7OWMVNPjEBxuZb7XfFqzFadrGjtq2N0sbFFxBHfEMUW
 EBpu+NmR0bAUJmyMC44g8zZwq1Y/coFTydyv1v1ZFSa3wITK9cgBviDJexrDH1ERjxd7Lqyh+
 NTNIzYcpxT+5e61HIcryj9kuUdDLxO6hbaEbr4a3pEc9N9JuogrxZkleZt+RJc0wAWYGBROHR
 OOIUAunbcU9/Kc7gh+dNXc5EYcvRto8ARIz6pVdg3qwVTbHZLaH1o3u+5N02tgvcZD7IasXDc
 nH91nIeLG9qJVjA+8OthmGnx7/z/ReWIg9ypQ5v5jJ6T0pUUiNLdIJQrYiDfUhjgYHgzfDkX0
 s1+SbK7NHhLWfwxzshJlSmD5xL0Gc+WdB8qu75D6/8aYg2cU/YhutZLimfTHeOxv93DJ5S6oK
 VV5epPeEgLuwS/kBd0iuW37NcFTiCGEPsYIo5zV269cgNWOSCZ6qJTraI3rEQ2ZZNOQxMMiHU
 E6jXzYD1X4u2ZgvBbxC0AhSB4wJe9PnycFPCP+pyvflJABt4+SO11acOrgap6BK6IL6QKAF5C
 IEuEoaYLUYptVWDXycu2DQse5k44wGP21UIK8Qy4RLf6qRjlUaljHOr7+O+Qy6tkpZQZi8QSN
 dP4gTf7T50sK6HBY8FBZ0yGA==

=E2=80=A6
> Current scoped_guard() implementation does not support that,
> due to compiler complaining:
=E2=80=A6
> +++ b/include/linux/cleanup.h
> @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext#=
#_constructor(_init_args) \
>
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>
> -#define scoped_guard(_name, args...)					\
> -	for (CLASS(_name, scope)(args),					\
> -	     *done =3D NULL; __guard_ptr(_name)(&scope) && !done; done =3D (vo=
id *)1)
> +#define scoped_guard(_name, args...)	\
> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
> +
> +#define __scoped_guard_labeled(_label, _name, args...)	\
> +	if (0)						\
> +		_label: ;				\
> +	else						\
> +		for (CLASS(_name, scope)(args);		\
> +		     __guard_ptr(_name)(&scope), 1;	\
> +		     ({ goto _label; }))
>
>  #define scoped_cond_guard(_name, _fail, args...) \
>  	for (CLASS(_name, scope)(args), \

* How do you think about to define such macros before their use?

* Would you ever like to avoid reserved identifiers in such source code?
  https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or=
+define+a+reserved+identifier


Regards,
Markus

