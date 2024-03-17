Return-Path: <netdev+bounces-80234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7C87DC11
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 01:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B052A1C20F8F
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063A366;
	Sun, 17 Mar 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="UKSQ9x6H"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2325364
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710634452; cv=none; b=qWkdjlkkr7Cri+Z2g1uaSkLMKWJ5naVzSCl3X6WXJ7jlICG4rbeVSniMf74hFPV0hNYre8HwORbzu8L3Sn1SwfyFP/NHrAJshifeUPd6dtQQrDQpJboLAC5L4yaEUDBt46rY/Eny6QV2FxU9LwmdCPcR8jzwoykdn+SFAG7822k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710634452; c=relaxed/simple;
	bh=ViC/3kfg6pScVcRrgg5dLdqHLTWAX4Weobg9lLqow60=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aluFkTSliWLxRd1v7zqZw9BpquFFySBI7tIqH4ogaonWekI9GnLoqnDIdFh5DE9e30/8tFFsQWADuJNOVKtYe5FPrFt05k7CAWKic/N7u5V59f1Iy5TkTfmAsRs/AQa2D0ETW4x1OxF4JYwp/8hQA80Hu7tU59Ypt3f0QSdfoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=UKSQ9x6H; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from [IPv6:::1] (2a02-8440-3216-19e2-908a-95a7-e955-f7e2.rev.sfr.net [IPv6:2a02:8440:3216:19e2:908a:95a7:e955:f7e2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 18932601BF;
	Sun, 17 Mar 2024 01:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710634446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZx6gacg3ew6//7NN731PROIppd59aJH20lkNiUmGlo=;
	b=UKSQ9x6HSLBMKCqP80u9c7AWip1/vI0t9b8dyXdVc67ZHmo39dPAoSx/8dIIn2Obr4cpnG
	zHizLtPWu/kKIRiH8DaXw+sX+mvQRtSQlHBCl1yvpSy8ONs7fkxqplVq3QRktvGqdOQHW/
	cYEpirHPB2Bd5yhBkFRY7OWWdAEhzWyi6bP/O/IlAQqEFHbpx8UA+WqrzrkxPIS3rOxBHL
	xdtJuYLzbkEAwiGUxSKZXHa7UJqjeck2RMtK+7q+5eISzRyCjxQFyVHhLOxNno25CjFGW2
	xUYoTjpC4qJQ1lA/Cp/4ijurTt9ntdKac/vUKMGuBwNV2vqtaP5DJUEYELJUkw==
Date: Sun, 17 Mar 2024 01:14:03 +0100
From: Max Gautier <mg@max.gautier.name>
To: Jay Vosburgh <jay.vosburgh@canonical.com>,
 Stephen Hemminger <stephen@networkplumber.org>
CC: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] arpd: create /var/lib/arpd on first use
User-Agent: K-9 Mail for Android
In-Reply-To: <3016.1710618997@famine>
References: <20240313093856.17fc459e@hermes.local> <20240316091026.11164-1-mg@max.gautier.name> <20240316080702.4cb0ed9a@hermes.local> <3016.1710618997@famine>
Message-ID: <04AF6DE2-606E-4CC5-AAC3-CC95CF4896E5@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 16 mars 2024 20:56:37 GMT+01:00, Jay Vosburgh <jay=2Evosburgh@canonical=
=2Ecom> a =C3=A9crit=C2=A0:
>Stephen Hemminger <stephen@networkplumber=2Eorg> wrote:
>
>>On Sat, 16 Mar 2024 10:06:44 +0100
>>Max Gautier <mg@max=2Egautier=2Ename> wrote:
>>
>>> The motivation is to build distributions packages without /var to go
>>> towards stateless systems, see link below (TL;DR: provisionning anythi=
ng
>>> outside of /usr on boot)=2E
>>>=20
>>> We only try do create the database directory when it's in the default
>>> location, and assume its parent (/var/lib in the usual case) exists=2E
>>>=20
>>> Links: https://0pointer=2Enet/blog/projects/stateless=2Ehtml
>>> ---
>>> Instead of modifying the default location, I opted to create it at
>>> runtime, but only for the default location and assuming that /var/lib
>>> exists=2E My thinking is that not changing defaults is somewhat better=
,
>>> plus using /var/tmp directly might cause security concerns (I don't kn=
ow
>>> that it does, but at least someone could create a db file which the ro=
ot
>>> user would then open by default=2E Not sure what that could cause, so =
I'd
>>> rather avoid it)=2E
>>>=20
>>>  Makefile    |  2 +-
>>>  misc/arpd=2Ec | 12 +++++++++++-
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/Makefile b/Makefile
>>> index 8024d45e=2E=2E2b2c3dec 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -42,6 +42,7 @@ DEFINES+=3D-DCONF_USR_DIR=3D\"$(CONF_USR_DIR)\" \
>>>           -DCONF_ETC_DIR=3D\"$(CONF_ETC_DIR)\" \
>>>           -DNETNS_RUN_DIR=3D\"$(NETNS_RUN_DIR)\" \
>>>           -DNETNS_ETC_DIR=3D\"$(NETNS_ETC_DIR)\" \
>>> +         -DARPDDIR=3D\"$(ARPDDIR)\" \
>>>           -DCONF_COLOR=3D$(CONF_COLOR)
>>> =20
>>>  #options for AX=2E25
>>> @@ -104,7 +105,6 @@ config=2Emk:
>>>  install: all
>>>  	install -m 0755 -d $(DESTDIR)$(SBINDIR)
>>>  	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
>>> -	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
>>>  	install -m 0755 -d $(DESTDIR)$(HDRDIR)
>>>  	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
>>>  	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DES=
TDIR)$(CONF_USR_DIR)
>>> diff --git a/misc/arpd=2Ec b/misc/arpd=2Ec
>>> index 1ef837c6=2E=2Ea133226c 100644
>>> --- a/misc/arpd=2Ec
>>> +++ b/misc/arpd=2Ec
>>> @@ -19,6 +19,7 @@
>>>  #include <fcntl=2Eh>
>>>  #include <sys/uio=2Eh>
>>>  #include <sys/socket=2Eh>
>>> +#include <sys/stat=2Eh>
>>>  #include <sys/time=2Eh>
>>>  #include <time=2Eh>
>>>  #include <signal=2Eh>
>>> @@ -35,7 +36,8 @@
>>>  #include "rt_names=2Eh"
>>> =20
>>>  DB	*dbase;
>>> -char	*dbname =3D "/var/lib/arpd/arpd=2Edb";
>>> +char const * const	default_dbname =3D ARPDDIR "/arpd=2Edb";
>>
>>Make this an array=2E
>>const char *default_dbname[] =3D ARPDDIR "/arpd=2Edb";
>
>	I suspect this should be
>
>const char default_dbname[] =3D ARPDDIR "/arpd=2Edb";
>
>	i=2Ee=2E, no "*" before "default_dbname", to match the type of
>dbname (below)=2E

Yeah, does not compile otherwise, that was my guess as well=2E

>
>>> +char const	*dbname =3D default_dbname;
>>> =20
>>>  int	ifnum;
>>>  int	*ifvec;
>>> @@ -668,6 +670,14 @@ int main(int argc, char **argv)
>>>  		}
>>>  	}
>>> =20
>>> +	if (default_dbname =3D=3D dbname
>>> +			&& mkdir(ARPDDIR, 0755) !=3D 0
>>> +			&& errno !=3D EEXIST
>>> +			) {
>>> +		perror("create_db_dir");
>>> +		exit(-1);
>>> +	}
>>> +
>
>	Should this be a string comparison?  I don't think the pointer
>comparison "default_dbname =3D=3D dbname" will do what you expect if a us=
er
>specifies "-b" with the default value of ARPDIR "/arpd=2Edb" as its
>argument (i=2Ee=2E, the pointers won't match, but the actual text is the
>same)=2E
>
>	-J

I did consider that, the reasoning was mostly something like "if you speci=
fy a custom location, you're on your own"=2E
But a string compare is probably best, it preserve the observable behavior=
 of arpd and is overall less surprising=2E=20

I'll send a v2 shortly=2E

>
>>>  	dbase =3D dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
>>>  	if (dbase =3D=3D NULL) {
>>>  		perror("db_open");
>>
>>Missing signed-off-by
>>
>
>---
>	-Jay Vosburgh, jay=2Evosburgh@canonical=2Ecom


