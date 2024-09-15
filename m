Return-Path: <netdev+bounces-128451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB5979915
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 23:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0AC1F23577
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1A3CF74;
	Sun, 15 Sep 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Zx/vHaF5"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E625760
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434173; cv=none; b=tTMhFm3bzCvRRBFp0Az+I8pg/tYIk5nbSDkDMS1ZUEkEG14KUTEsm5oKu3OvM5ta81GWsHtbz5nK1PWDG9RKKxRR/3DRMO/VHOnhXSZD4QhjbRy4xqvWvaTt7YZqz5GWPkhP3EudPL6ACHAMijDERO8Rn8m4WZWSBCQhINhZsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434173; c=relaxed/simple;
	bh=f/7Q0TO4Qoiz7sfaTz0dhyEHRK6cfBds655o4Z6mnGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOHCJdfKAlGtMZIM5pzIuVO4KMcVqg+KS4jR9HvPrU0bk5JHlidx89YeOlbNc731dElgadK61u7+XiN9mmLIbYjXHuww5adtKVJzK8fKbGi2E1JUQ6tSXWjBQ3ywl7pbgA4cEc2TwlF5/mZ3l5k6tuW4nOdBnhWMFa7ydx/W+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Zx/vHaF5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726434151; x=1727038951; i=hfdevel@gmx.net;
	bh=f/7Q0TO4Qoiz7sfaTz0dhyEHRK6cfBds655o4Z6mnGs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zx/vHaF5dKUE50MIOkpA7Rou4KTLkIWwYChVnIfZqkuYNlOJw9j5Og6sWaO76MjS
	 iofQGeu+dQv2lOIx1OzSdtuQOhjY/fhjF1GLIi+hKIufo6HArZ72a37J4QckGEv6I
	 lActOTK5rGRm+GMWPvG/06QduDoQBgQ3Oo9Ksh9gMYBjLyJyl2I8+NKGGfrai8/Lb
	 gW/9rS0kwO4XCKQWt1SubRcFqZh4sbfhBdeNfsrqPd2hVqe7nlwFynYyIA4kSMHfz
	 p1O/J05bxNdQ4/dqUms4+fDNTT+YCRZ/G9HHyHtWHOZ3nMr9ue3RpXth06Vj7Hnzi
	 YX8981mXsk76K/LkiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1sByrd0Poo-00dJaP; Sun, 15
 Sep 2024 23:02:31 +0200
Message-ID: <80d6ffff-fce0-4fa7-8042-249bfc368e65@gmx.net>
Date: Sun, 15 Sep 2024 23:02:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net: tn40xx: add support for AQR105 based
 cards
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07>
 <c3bd51cc-fc8f-46b5-bfc3-ccb0fa1386e9@lunn.ch>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <c3bd51cc-fc8f-46b5-bfc3-ccb0fa1386e9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PX88f8JYBT15UAHSOTwybhpt/kA7LklDWFg+5g/+wLKgOkg3t2F
 +XBKF3gMOlDME0gXL2zZEqKXNrOuHxWPUXn/VSVU2LPDpKtoO4PCRUpSu4CD7j7CQav47PR
 SGjzAvapE8HbfhRaxORuvb5OQHxNnNRojRA4rOAEwInmO0GloAu1V4u48iCfDkcrTEFeH2z
 gHqDn8xXmtkMy9BeWwJ6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/w0Hs+MSIIY=;FLHphWeM+Xo/U0HnATS+fAQzWGA
 O0rPzoy+cUl97r/33bUSKJDkMHFbbNzakHd5Q5Qz14d9ErWDRxwDRNBd70wPzQQdFFnguVeSO
 sNsITerO0vfrH4i/hGBMTcykFHFA2oeGaclDwUZVMxOw9RMQMK3wiuL++WAc1bww1QtGIZfY8
 yp3Lu8AUATtSa2mx0Lj2+Neev/cNjWG5sz2NoT6VJQ4fWUR8XZauuxinhC3IKKGb1BHjFxDHj
 ulafRTGRZUxanWCr+EfZUVeGP4ceMpI9DFWDkfXW4TvTf1Tc0JxAuH2jOe9kdvy/Mbyrv622b
 y66QZ/V9S4Z77NJMM2kjbVf26WIrWljLeQ06XQtg17AVS3g9ODQzKxmfFjIQTkMNMGwUpKD1B
 NFaDKeOu/wLabDvJ9OsG74OtLAN3IJ1vldbaz8Q80ap8oGVDUOKRCJ+jbnVhx7i+pQwK/VuXk
 XJo3egeFb4h9s8HuenCQZofLQMVc4fMBwIctCadAj9dD5kJInuXyu4e1EUijsa0uKUa/Ju5Fu
 YmAyuY4S9frPpo+ZQn/3C59qDZJWmjj0wGwMo7hoQvJkoBysXzJvMp69rbJ4gBKoaaI74lwXG
 3zSha00217tyKlofAAUe1s2u1eP26DNPipXBrKx09FRxTDLThjHT2S1gdpW9NHKOMXLNx3z87
 FJOLDnH2CDL/57/qP6AZi2GYOSFdJgqq5/ztip2KdgpfXRJbN4Z+q6ojvFsMGiW7T5lvkeU/m
 C5V6oCZucH/LVXL0wnDiwxLbNjpYaKRNYhm3aEYHcA67YpkURhH8VaEWOH/S+9IG9wQJEZbL8
 7x48nJfTdONw/PDuInqtyFHSUkkA2toUZ9OI4asIDWCy0=

On 15.09.2024 22.21, Andrew Lunn wrote:
> On Sun, Sep 15, 2024 at 09:48:17PM +0200, Hans-Frieder Vogt wrote:
>> This patch series adds support to the Tehuti tn40xx driver for TN9510 c=
ards
>> which combine a TN4010 MAC with an Aquantia AQR105.
>> It is an update of the patch series "net: tn40xx: add support for AQR10=
5 based cards",
>> https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94=
ffc2-1726082106356@3c-app-gmx-bs04/
>> addressing review comments and generally cleaning up the series.
> Hi Hans-Frieder
>
> A few process issues first, before i get to the patches themselves.
>
> We are currently in the merged window, so net-next is closed.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> You can send patches, but please mark them as RFC.
>
> You have one patch with the wrong subject, not net-next, but net-dev.
>
> Your emails are not threaded together.
>
> These last two point suggest you are not using the tools correctly.
> You should have all the code on one branch, then use
>
> git format-patch --cover-letter --subject-prefix=3D"RFC PATCH v2 net-nex=
t" HEAD~42
>
> and then use git send-email to actually send the patches. That will
> cause them to be threaded together.
>
> Alternatively look at b4 prep:
>
> https://b4.docs.kernel.org/en/latest/contributor/prep.html
>
> It handles a lot of the details for you.
>
Sorry for the noise on the list.
Yes, I am a git beginner and have done all the e-mail submission part
manually. Which has been quite an effort.
I will resend the patch series as RFC.
Thanks for your advice and your patience!

 =C2=A0=C2=A0=C2=A0 Hans-Frieder / Hans

