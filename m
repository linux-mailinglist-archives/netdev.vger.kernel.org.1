Return-Path: <netdev+bounces-132637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151F992977
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8881F20B63
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750071C2324;
	Mon,  7 Oct 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ei1hjgVK"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62E189F45;
	Mon,  7 Oct 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298057; cv=none; b=EpgxFaU5tEvD9BSYNN8OM/Lm3qI4x7vfyQVv87Hhp9TBPbbHIvO/3q2jXnJA+8DnTPche+mmDNecX94qH4aTNwb/WyC63jFEq5IOE+q1LbOErZivV/t70lcrE9rboGZ3hnAkUGJDxilPIcus71d9j3pCc9oKZeejpGL5nLWuLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298057; c=relaxed/simple;
	bh=T4rVdt7fcZiMlQMxDbv2/yloGN/2xnjJVah8iklo5Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi+oIVenaMk88/bxUtZcFIibxuXW0PYs/3nXAHOJVAr+GxTahK0DUyszx+s/uvvHTqk7oJRldpVKfRyBXCtTWWQ4tMExS53+YExs00iCXbrMkJUJ3A2ZnYutq3Fe1rDZ9x2kC3+7NO64WGJGBmjjXXmbRQ7B93fdGLrub53wxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ei1hjgVK; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728298017; x=1728902817; i=markus.elfring@web.de;
	bh=T4rVdt7fcZiMlQMxDbv2/yloGN/2xnjJVah8iklo5Qg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ei1hjgVKdDnus0cZhlbu542K/e2NmOvEiW5vjvC6OHaGDOtFzeRtZAEKMWVxRyGW
	 WYnPY2/jeZSUQX+2z56gsnFz/q2zQyd5m+grdvuzRXACT8xe/oThzbWqnbEFF22UK
	 dUeRKqcKg+X+GHj/W4X6p5gDlDXNi2fI6WANyWCCxXBEk/SJSJglx6XUnMaW6bkqN
	 q6AbcMkDOQNMb5tiO/or8f00A6XPA1NCb1+GxZkCpIN2LGd5TNzcfvHUlP8HipaQV
	 x18+Sr7O2jQ5eoJpNMGNVLrbzmV5ZKsikAO9HZctngAsLZ6FKag+rNdbagNh8XIvX
	 Lb/UKudPZ8MyEreByQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1swwJm0Ru7-003bcf; Mon, 07
 Oct 2024 12:46:57 +0200
Message-ID: <f5296465-b160-4cb7-9a19-7cabd100e7a1@web.de>
Date: Mon, 7 Oct 2024 12:46:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cleanup: adjust scoped_guard() to avoid potential warning
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
 <Zv6RqeKBaeqEWcGO@smile.fi.intel.com>
 <c7844c93-1cc5-4d10-8385-8756a5406c16@web.de>
 <ac59684b-37fc-4e47-b496-e6f9bac87b8c@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ac59684b-37fc-4e47-b496-e6f9bac87b8c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZZiKSbmFNoiK+6VFDwjwkd1Y9TYsd8yg+Bxp0KLxVPWuTvoJ8rl
 vx7Fgl8eQG0cozX+0cnOBtJ+j1AAGkICN33X2ZkLq7T2oB4NRyPIQ4nM2QEFTsuG6PX94KV
 pi6Psxwj0Kp1ZdsISsZAHCDFOAd6OPAHDWlZAoco02gZ0/bIT0H8xaZELsxq1JEvcAdCpoX
 +hig84hT/H7gRaEtwd/pQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lxew3tJEJdI=;65y2aPgwxFUVZXS29CJmiVrFvNB
 fA4ALIdA4TOKV3+rLNQM0ttEsgDjLCOpajxI6fKrDyYxZmdsu4bD0iUjWCDbTuzQdmJDEGEeP
 CFrUzCKnEI9a7HuHwJVzJkbSErs7WA8ocQ83TTKNND9XDh/P6g3mqrXzaBg/IkkFcpHKpB5d8
 x+xWYpFHNYBDjtP8+cGKzzP+zZomp1DyHIB2fxije67LVdMs7OyYI6CEh1inh0Y2kNh/xbAyB
 IweB0KTjqPn8su3Y1el+izHOakxTivDe1LDQvR7eNnu/Rr5PS0yp+7YVnYjHa9sgzdJpcqvEH
 5YFvnVu5OpnoE+hn85MuHp6LJxPO1vtnfYOqM3LoQED3ovKZklgo9Lb6aKRnCt+9KyTKSRNEh
 wODHp95szFOGijZWrYjTIHAc6kSJ44Iw/HzlL+IHOHMzLos3LkUC+GchklKLzEKzWbaXmfeoQ
 OmkNCcbfJcSEX4Hqs9YmDTOZEil+2L9SXiK02VQMmlS3zEtVXahav3EnarGvLIBJ9/Y1UnLUL
 h9eOfvNS/yYq5MvtJjQcTsBbCLLqVaxd1TixECwyTPce0ryI4xU47e7zNv8xNzCsonxH3gYUx
 3Fm6YIfyEIX3HhQbrr3uggzo8ceiriXXCdzKvoo7U2DvbWctlSXKR3Tia/D+OiHx97CjzORtr
 QrsHTv5JjCi8KIJDnkRyhDZaLc3vrqHVC5vNwKC6ww23872nIILrinx8u5e1bmRbMItt4NpvD
 GrkYXh18XeG91Ph6wHau7fm/VQ4et7bnzvnONKngJPxje/h35BNQ+hy/bfbO2YLe2ul9qDoQH
 Qvjg1hloQk/nwt/Fld/l/Llg==

>>>> Would you get into the mood to reconsider the usage of leading unders=
cores
>>>> any more for selected identifiers?
>>>> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare=
+or+define+a+reserved+identifier
>>>
>>> The mentioned URL doesn't cover the special cases like the kernels of =
the
>>> operating systems or other quite low level code.
>> Can such a view be clarified further according to available information=
?
=E2=80=A6
> could you please update CMU SEI wiki to be relevant for kernel drivers
> development, so future generations of C bureaucrats would not be fooled?

How do you disagree to mentioned technical aspects?

Regards,
Markus

