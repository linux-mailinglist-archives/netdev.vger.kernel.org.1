Return-Path: <netdev+bounces-80269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCE87DF07
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6251E281D32
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700E1CD35;
	Sun, 17 Mar 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="othqXSCS"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4A33DF
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710696199; cv=none; b=IZzQV0S8yJ9BVo5bEEThqVcKhA4cdZFYMsOY3n2n2mMmpc8zK60UPQKLzF20MFN0kiVfDw+OxUyKwXIGdUuBupuESmMSTDfZdMjXMfAmqe+TCF4FNHes5MsjXewwAY8aoipsYSDZoir09aRo5Krt6rTXQYRGJs+5fnu5JDzUSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710696199; c=relaxed/simple;
	bh=Gw75jg9JN2zILKZOn5z61Q9NlOwLMeMRr88uLGjdwYU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=C4FdlJoDLV7MUyUF+QLlRmIES4eqKYDWTSTbab/eQXiScF1UnESDoeB2053DpqctADs67yaqERa7/Bm+QmWJN9pAOnO2EQfM2v9XMOEmv6hH2r3vSq8qAgtu0Waz3FISwfmqFuKL48vRU3n7uqGKgIwaHDntnR3HJtOFbCynPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=othqXSCS; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from [IPv6:::1] (2a02-8440-3217-5496-24a0-8569-abe9-6b8d.rev.sfr.net [IPv6:2a02:8440:3217:5496:24a0:8569:abe9:6b8d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 2BD06601D2;
	Sun, 17 Mar 2024 18:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710696188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0P90YQNl1asHh9GXhRQRqI/oL/OZvOl0eiDlWqnM76Q=;
	b=othqXSCSVsC2SyTOnT5jY+wRZFEA6FenwtMjTsLkWB9trmxvt2x48ODwtjTDOPDdt5IwJC
	2FKfe3JdARlWU6eGkZDoAa5SdANvt9Nhz/g1ppxurFPWsoC++sbqElQXFzJUY5ne3b8R+i
	H0oj/93mnhyFO6Xl3zk+vB1g9NSZUqV7RP69P/jQ6CppEffGAjkWie059/M/pWQ0ztuh/l
	9DFRfFvEXsd5hByWFGmk9QYrYQbZ/yBKijenwssWfhopyDXRPmbPPbqUGu5W/uSHrnTpfH
	N6EAFkeKQl9pU97C6+2v/zke6aQpRoyL0GveoZUwPQzVWAy3eh8GxsCBcOFI5g==
Date: Sun, 17 Mar 2024 18:23:05 +0100
From: Max Gautier <mg@max.gautier.name>
To: Meiyong Yu <meiyong.yu@126.com>
CC: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] arpd: create /var/lib/arpd on first use
User-Agent: K-9 Mail for Android
In-Reply-To: <09BB339D-A57C-4F67-BE67-2859F0262C86@126.com>
References: <20240317090134.4219-1-mg@max.gautier.name> <09BB339D-A57C-4F67-BE67-2859F0262C86@126.com>
Message-ID: <0EE20B22-A0C2-4ECC-A1C0-CD52C5A478A6@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 17 mars 2024 17:03:32 GMT+01:00, Meiyong Yu <meiyong=2Eyu@126=2Ecom> a =
=C3=A9crit=C2=A0:
>
>
>> On Mar 17, 2024, at 17:04, Max Gautier <mg@max=2Egautier=2Ename> wrote:
>>=20
>> =EF=BB=BFThe motivation is to build distributions packages without /var=
 to go
>> towards stateless systems, see link below (TL;DR: provisionning anythin=
g
>> outside of /usr on boot)=2E
>>=20
>> We only try do create the database directory when it's in the default
>> location, and assume its parent (/var/lib in the usual case) exists=2E
>>=20
>> Links: https://0pointer=2Enet/blog/projects/stateless=2Ehtml
>> Signed-off-by: Max Gautier <mg@max=2Egautier=2Ename>
>> ---
>> Makefile    |  2 +-
>> misc/arpd=2Ec | 12 +++++++++++-
>> 2 files changed, 12 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 8024d45e=2E=2E2b2c3dec 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -42,6 +42,7 @@ DEFINES+=3D-DCONF_USR_DIR=3D\"$(CONF_USR_DIR)\" \
>>          -DCONF_ETC_DIR=3D\"$(CONF_ETC_DIR)\" \
>>          -DNETNS_RUN_DIR=3D\"$(NETNS_RUN_DIR)\" \
>>          -DNETNS_ETC_DIR=3D\"$(NETNS_ETC_DIR)\" \
>> +         -DARPDDIR=3D\"$(ARPDDIR)\" \
>>          -DCONF_COLOR=3D$(CONF_COLOR)
>>=20
>> #options for AX=2E25
>> @@ -104,7 +105,6 @@ config=2Emk:
>> install: all
>>    install -m 0755 -d $(DESTDIR)$(SBINDIR)
>>    install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
>> -    install -m 0755 -d $(DESTDIR)$(ARPDDIR)
>>    install -m 0755 -d $(DESTDIR)$(HDRDIR)
>>    @for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
>>    install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DES=
TDIR)$(CONF_USR_DIR)
>> diff --git a/misc/arpd=2Ec b/misc/arpd=2Ec
>> index 1ef837c6=2E=2Ea64888aa 100644
>> --- a/misc/arpd=2Ec
>> +++ b/misc/arpd=2Ec
>> @@ -19,6 +19,7 @@
>> #include <fcntl=2Eh>
>> #include <sys/uio=2Eh>
>> #include <sys/socket=2Eh>
>> +#include <sys/stat=2Eh>
>> #include <sys/time=2Eh>
>> #include <time=2Eh>
>> #include <signal=2Eh>
>> @@ -35,7 +36,8 @@
>> #include "rt_names=2Eh"
>>=20
>> DB    *dbase;
>> -char    *dbname =3D "/var/lib/arpd/arpd=2Edb";
>> +char const    default_dbname[] =3D ARPDDIR "/arpd=2Edb";
>> +char const    *dbname =3D default_dbname;
>>=20
>> int    ifnum;
>> int    *ifvec;
>> @@ -668,6 +670,14 @@ int main(int argc, char **argv)
>>        }
>>    }
>>=20
>> +    if (strcmp(default_dbname, dbname) =3D=3D 0
>> +            && mkdir(ARPDDIR, 0755) !=3D 0
>> +            && errno !=3D EEXIST
>> +            ) {
>> +        perror("create_db_dir");
>> +        exit(-1);
>> +    }
>> +
>>    dbase =3D dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
>>    if (dbase =3D=3D NULL) {
>>        perror("db_open");
>> --
>> 2=2E44=2E0
>>=20
>
>if (strcmp(default_dbname, dbname) =3D=3D 0
>
>Do you consider when the input dbname is relative path, for example: =2E=
=2E/=2E=2E/var/lib/arpd/arpd=2Edb, anther example: //var//lib//arpd//arpd=
=2Edb

I don't=2E IMO this is a corner case which isn't worth doing path normaliz=
ation=2E
Symlinks are not considered either=2E

