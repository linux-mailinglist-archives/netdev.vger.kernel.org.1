Return-Path: <netdev+bounces-105925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E6E9139B8
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2472819AD
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D427E0F6;
	Sun, 23 Jun 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UnrEALRC"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36472F25;
	Sun, 23 Jun 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719140514; cv=none; b=rZe151K7hWlYCtdznrsWORW22pfqi2NICqZy1lL55Jn9vMh4G0ru84lEx1I3hQLzN6iF+1+kQa8oxddh5R0ws4HDos95bK8zLkKhvr7zrEzOsyX62KITQxD13s5kUDrR8Nx8sE5AVu2g93nwk4aFCNaXT/CZT96jAPhZ7vbubLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719140514; c=relaxed/simple;
	bh=jA2qe5AZogCjbl9IbAFVpirimD78ae76THm9qAsC7Vc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Qv9LZg4xlWaHx5pxL6kZnOogLEV+g4DJC1z4X9EWCvasaLv9QTJaWthBp7CIHf6cPkJcBD0vwgVmZuE0a+jta8krDtoETbUHUJFeadaVC87ml7AM74zzkzgFgn1Zi+IdRuxjKax9Rox6WEN5XrkjCC2eaFxrSc9ibeyU15WPQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UnrEALRC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719140471; x=1719745271; i=markus.elfring@web.de;
	bh=csftI6NjKYpBjRUO4MzTMZDIUeKT+0DyU6evFuhDjn0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UnrEALRCv5EFq4W16tdamLLRhWIa5I+tBdPWylMHS68OWKqJ3wcs6I/MUUOndZiz
	 jHDxPJzk8OlmVK12LHPoEuvvUlutuHaVwYB8VgtyPv2mWU3w7aAikN5a9Cfb9o4/y
	 JTS7SoacxJbrHKn9dLEaVCUjpIgfGT3jEHs2qyta7/2CqVJxtOIrcupKNNasgovLv
	 ToX2XeiX4FQ2RwuBWpnMqEG/bL40qqG809KKox4KqlOpghH+I2RMLkUUPTc0DMcFA
	 k4v/Ia7yVrCZhh2l63G28IJtMjuaJ/+yyS/jKVjoCJ9QX6X4PgeWJ/gbdiXITSgrP
	 FHvQJj1P9O5nqb7ZZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIkg-1staOI43yO-00jPYW; Sun, 23
 Jun 2024 13:01:11 +0200
Message-ID: <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
Date: Sun, 23 Jun 2024 13:01:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Subject: Re: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240511030229.628287-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nceYxAwQIJBGBZ7hqj2vF269GF4C5ScdiWl63QyR/roUC5hgzKG
 63sgpGqrhO9kIRDieTZQz4aWrI+PaDHtKvkf5ki/Cfrs8DI3VxeVdtSbMMdDOJd+QPRR3OD
 FoOFC7iBrvf+aXPnNQzmAOx5LgvBKuInLcdYi0wszjxbwBZpg7tOLQ9Yo74vnn9n1ciEhUC
 Wq502cQ0CA+wpklIKJhNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WftciS5HYck=;cQ1cS/xibwGzoKW1JT9qH66yusp
 SYZ/Vo7ToQuOsc5l/FEpzvoUOO3TKii6L/7+QVk/ZRUGzgq4Ago1OsU/TWx8MBoTtHx9Mq9VW
 C6aPplKM9Np2Q2WMwl+BSXIheBTDWBQUDGwm+nkAw4aTqTTPXM8H1Q/IQGOZpjcf2LeMOwfpH
 IP01Q2hzJlwac06rxQRLEzerr+5nBSMgWP3lgt4qAduMSx45UR6LQ2lU4VgE3UJ93TXKrfY7e
 iVYJsRDQ/N62pZGywdg4GWs4z2BqZyl9sPEX++0FZOga5+89husEjCjJ5E8xCW68dw0nPkVOk
 h3krm1T9NFQ2+HS5nRIqFH7eF3j+oG1oa6YWxFjHBRNgyOI5KcR7ZLvYqodA7dI2XIvLlrJdK
 /kRaR4c070hGvcAxsWLKPPG4LY98MrnHpngggllConiD8/3QbT8xHa6L2o2VFdoXYJLAoG3lq
 IJ3YhUbuF2ijloGuqUrs2KnQw0zI8LBC7Y+PaSp1aXTlQIQRX/HUZ/QVwGPlLpyPwP/xsFoaR
 GvpTIDowQEN2tEmK86cs6iPjd1S+NbEsZ5+IDq9IAAS1hBg8CCY4GOQiQxlZ5VC9knQ4P3wBY
 CvV0dcO7WFhPksmCjCgMLiGQPwg0xCcFT80FrpPD02dAL0iqYQZc5xgRZhLAYujtf7K4Glc4P
 QsUa+AefY1wFa8dghxk/8yvvwgtadElF7pHDuq6AZdawVNsrnAi/B6yOZs1dvkN9V0/w+4aSC
 f0E7sY1XDfBL0ggQkQM1dtlF/b1f2oOVJaadqt+jlhwS6g+7h3MstFV27+QZafxY8rS9pK9SX
 6t61DqQZbxrM2ueoTpJ7+u3lXDoXuezIWu3Mv+EpoJrwA=

> The Scope-based resource management mechanism has been introduced into
=E2=80=A6
      scope?                                    was?


=E2=80=A6
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -99,18 +99,17 @@
>   */
>  static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable=
)
>  {
> -	unsigned long flags;
>  	u32 val, tempval;
>  	struct timespec64 ts;
>  	u64 ns;
>
> -	if (fep->pps_enable =3D=3D enable)
> -		return 0;
> -
>  	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
>  	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
>
> -	spin_lock_irqsave(&fep->tmreg_lock, flags);
> +	guard(spinlock_irqsave)(&fep->tmreg_lock);
> +
> +	if (fep->pps_enable =3D=3D enable)
> +		return 0;
>
>  	if (enable) {
>  		/* clear capture or output compare interrupt status if have.
=E2=80=A6

Was this source code adjustment influenced also by a hint about =E2=80=9CL=
OCK EVASION=E2=80=9D
from the analysis tool =E2=80=9CCoverity=E2=80=9D?
https://lore.kernel.org/linux-kernel/AM0PR0402MB38910DB23A6DABF1C074EF1D88=
E52@AM0PR0402MB3891.eurprd04.prod.outlook.com/
https://lkml.org/lkml/2024/5/8/77

Will any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D) beco=
me relevant here?

How do you think about to take the known advice =E2=80=9CSolve only one pr=
oblem per patch=E2=80=9D
better into account?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n81

Under which circumstances will development interests grow for further appr=
oaches
according to the presentation of similar change combinations?

Regards,
Markus

