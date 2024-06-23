Return-Path: <netdev+bounces-105908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C991385D
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4041C21A53
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DDC364A0;
	Sun, 23 Jun 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DtSMziIr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C22D02E;
	Sun, 23 Jun 2024 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719125372; cv=none; b=el1FrevtqEGEWykARGecgIFIBr2QsRpAXusnjkbAJA1N/ZMi/PpwJVq9yuiM7dcNs5Z2U7iOzeyQAMxnaNw0fK/J9netKw4u+K4396hVhTbRIvXrdyE36VZ8QWt9MVp1+Yw66lexQhf0Uv343m1AifZfDTV2gOQy08WMEyfm3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719125372; c=relaxed/simple;
	bh=JvRxzBYRDawIpvCcMBhrTvBSbD+AqEcFp7PwIVlmaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAPruKzWQ7qHp/PFl6MqSXJ3sm+aToW4zTptBwXh5q92/AQFVYkj12LqvEf8NRUJ+FPXRQYVhQ+Hqlp+sVb8YbgboIDv4aFjcCE4S5EFo5qfYgKsE3hi0utZgd33Hk8InvwoLIT/n60cgtB7Eu/TeSPXRhuRLlQv3NZatAtzk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DtSMziIr; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719125342; x=1719730142; i=markus.elfring@web.de;
	bh=JvRxzBYRDawIpvCcMBhrTvBSbD+AqEcFp7PwIVlmaTw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DtSMziIrcTieYDncqP28i16sF/5Cuy5/Nc0ShHV2cqDGwWo2Aqc72f7hOTP4fm6o
	 yh6BXgT+mxbBGeFnUxmFwcN6br31gcEyDScs6CY+ZouP6ZDcl+HTr4IexdRmsWXq+
	 YMXJlomocAlUvpry43Edujv6M8PB/fSjy2GmeFuXWQXvD+HMgajyPCgkSopmr9wJS
	 Md3wFd67D34WcEe22P7LRK1/ZdryCrzncdCvw+Bf1TVDI26Bo6iAnmnM1KtgvhNVY
	 SJdl7lZpW91ZL8LoKq40OqwQ+5ecSN6q/kB+QAhW5q6c9e8lXbFl01FXBSJkGxBHO
	 wDI0SdCSY8lL8ojr8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7am-1sfXEB3jjq-00d67X; Sun, 23
 Jun 2024 08:49:01 +0200
Message-ID: <6217cc19-9aa4-48e2-85ef-2bbe4c0d8189@web.de>
Date: Sun, 23 Jun 2024 08:48:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: octeontx2-af: Fix klockwork issues in AF driver
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
References: <20240622061725.3579906-1-sumang@marvell.com>
 <2cf888b6-f8ec-4632-befd-bf2678307a5b@web.de>
 <SJ0PR18MB521611653D45DEDFC42704D9DBCB2@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SJ0PR18MB521611653D45DEDFC42704D9DBCB2@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iQaZqO1KqcJ/xdoFEnWHyfHc0LVN4tj7RI66tg+Yf54a9AYOYFa
 so7wiwJM6TXdHmkNDWkqN/J2XKT8/l1DITdIvB2nJ40JXPREfb3FFImi3RWWKUxYkhIyFVA
 Ay3RfDlAenAgbQ3wsu6K57rsGlaNPf1xi/N87dKl5xbloSMRKDSQYobsniCxU6ijxKt4I/p
 8iFPmk471IPCYkteLfMRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bOTZs649C0A=;Njtk8EHk8XalUXD8LH36u1J1hPT
 MiTTXPwkQzhSIcVvFNSETeepTNW+fTD9y/pJT2jvNNCMIyL1e3QLN6oxujsrdwjktViQcYXd9
 RfRdT+ZFoNo+ikVOwO7057nkxIQymQBg6fS6ncL5d4R9j/40nuFd4146rTqX4o1m7+4Wxx4M+
 bqLdEgshkhom2hdj5Xfnpxf+XLGpQwHXV/48E6xJ88vjxt9bQmo48WEjfE11qreFafWwFfxec
 ZhQxMnow0EQz76GwKB/zBzTH5tm8mSJ60wqfESuaLLAp+gH1xUkCm7Vtq0rzuiWiPjvbv08Mr
 OjSrb0eXDVINqHMMn4TVFSkPi19SA8pWQWGTQ1lfAVC7pbPQHUl6cBEbUSEXyllxoxYZ32YF4
 aK9RR/JcN39N2xcMv3SOUH1J6Dy3KBDeQPHU0s1jiTCdOVip2I4LuFlEhsgsDCFosY9xyJzmH
 5OeiMsF4UwWx9khTLAylCJMfncaGFpMMcV+9CXK+OdjRPiulFVGiqdnW2Q2T3rMd5PBteovoF
 p0X2Sw5rMwKnr3bmUS5cH+SdSE36r5L7EN5g9ms0y/LQlDOrKSoe7SKPFya2jvdmbSIfURUbU
 SgiUNsWhDL16srX2MO8wwwv76MJjdg90u+4/zamAArjhTgGJA9FLgE8b89ab4SZ1GA2I6P5JT
 tPZFYOX+CJNJuBg0GEDe4c4g4oc5Fno1kKAfVUrN53br+BZh7FGVyBfUQ1VYudS5+LI1B7Jha
 zU/mJ1hQQHjgTKW4eHNRSG1zgq52j1EVPpgKZYyeaoTc5LZG0wsrOp1ZjNUp12SjBZTzrSnku
 L+XarbpaebtXNRwPM3VOYsLGLShU73KYWE2unEJ7nga1Q=

> I guess that there is a need to split different change possibilities
> into separate update steps.
=E2=80=A6
> This is the first time I have submitted for klockwork fixes.
>
> Since these are similar klockwork fixes based on variable declaration an=
d NULL checks.

Did this source code analysis tool present items according to different
development concerns (from selected categories)?


> I thought of combining the same.

Would you like to take the known advice =E2=80=9CSolve only one problem pe=
r patch=E2=80=9D
better into account?
Please take another look at further approaches for the presentation of
similar =E2=80=9Cchange combinations=E2=80=9D.


> Do you suggest 2 separate patch one for variable declaration and one for=
 NULL checks?

Probably, yes.


> Or do I need to submit patch per file?

Maybe.

You can dare to offer software updates for each concern category
as patch series.
You can adapt then also better for constraints according to the selection =
of tags
(like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D), can't you?

Regards,
Markus

