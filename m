Return-Path: <netdev+bounces-245377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2415CCC8B5
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D202300B5D4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05F33C1B7;
	Thu, 18 Dec 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LaGesljX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145734AAED
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072553; cv=none; b=VebnqvXPSTp6kUeI/7udNgTS34bvdPPQ4Dkl5sEx/Klwu+rUlcxXP4hMA8ijYWalnV6sFcH7y/9U00cgyL5IOIAaKPdI2iPlJLCSS4/E6MBew5Gv0SVQbcP5NsIa0RpWoGG7ROU9IORxUXiLg+Be5OWq7+Zs3OLsTB6ERwn4Heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072553; c=relaxed/simple;
	bh=zC9z0cD9OibBblxjNau7s10jF8PSz7VscIF61AO89fY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLgEmacoKMRSIc8d8mGDoeI+oIoO6e/j3O/6UncOYpv34RWJGq2OiT45155U4qt/MAQzcNwADYMBy3tP88LwtclQxYsXnwsa+wgY8E5kE91/FaUTESjN5v4C6MqyLvJTBoe4AQ7BAr5hBGtyHKWkNECzYp4jApbp8QzCEQ79cBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LaGesljX; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1766072542; x=1766331742;
	bh=oI0qx4CA9KSaGaZir3d409X5sIdFKjHc6CSkDmQWvNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LaGesljXn/t3sQYvGD+7m3rNrbW/5yCF4zYhrYh3kVWb//mZZSlD7vOg2uLKV4Vru
	 v4Tlkswy2x0w3rJ18moYtIEVf3sSwgiXmCLDbz7bJ/bTMXUHhzBv4Hjz7u5887gdnt
	 vXJJ6PUEKf5k86phj7kOEsAUVMIXM2DIfdE7yFq6HiZBknQUR2nLagDCmFEIXD5QMC
	 00xG/y4+ReayLRuX5o1Jd70+j+1zZxVD505adMRxX4AMw4CKR5J6sBBX+AFJXO8/K4
	 JLH6uEAxzMmR4VVXhJJoul95+mwV0rmAYHtL11oBYkD2dIXkr1+PLz+hVwqvmJDgCZ
	 Tgp/fIowEV6aA==
Date: Thu, 18 Dec 2025 15:42:19 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Re: Advanced Persistent Threat (APT) hackers had hacked into my Virtualmin Linux Virtual Private Server (VPS) on 15 Dec 2025 Monday around noon time
Message-ID: <9sNM6oMuL9IWuCYpGUXyRI6hQRHS_k8vbQxZyCT1bADW4vLQnc62qA0weSH-NlAMmkcln9rhCMPmKepeQUOKAU69ihyfEIr-MxuEySzHTWg=@protonmail.com>
In-Reply-To: <p6q1ZcmyQr1jf50qb0CTkQWCLEYt3BTyG_sNxtXAqj-Y40eMBWBjRueCvSmnXt3w6FSBYOBC4f5ck2-KinfmHiLsE_lklsrGZWlAJhPrHhI=@protonmail.com>
References: <p6q1ZcmyQr1jf50qb0CTkQWCLEYt3BTyG_sNxtXAqj-Y40eMBWBjRueCvSmnXt3w6FSBYOBC4f5ck2-KinfmHiLsE_lklsrGZWlAJhPrHhI=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: a61024e63f72c4c1ffd5dd24a0a9b52c03066ab5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi guys,

It appears that my /etc/postfix/virtual configuration file was modified. I =
have no idea whether it was Advanced Persistent Threat (APT) hackers who mo=
dified it or something else on my Linux server modified it. But if it were =
Advanced Persistent Threat (APT) hackers, I am nowhere as smart and intelli=
gent as them, for they are extremely good in hiding their tracks. I am clea=
rly no match at all for Advanced Persistent Threat (APT) hackers. Apparentl=
y my /etc/postfix/virtual was modified to a breaking point after I had crea=
ted a new email account "alerts@teo-en-ming-corp.com" on 15 Dec 2025 Monday=
 at around 12.29 PM Singapore Time. I was helping my client to configure em=
ail alerts in their Lenovo ThinkSystem SR530 server XClarity Controller whe=
n Gmail and their corporate email don't work.

Now, here is what I have done on my Virtualmin Linux VPS to solve the probl=
em (as advised by the community and generative AI).

Edit /etc/postfix/main.cf

I have removed the domains teo-en-ming.com and teo-en-ming-corp.com from th=
e mydestination directive.

Now my FINAL mydestination looks like:

mydestination =3D $myhostname, localhost.$mydomain, localhost, ns1.turritop=
sis-dohrnii-teo-en-ming.com

Save the changes to /etc/postfix/main.cf

Since my present /etc/postfix/virtual is not working, I have renamed it.

# cd /etc/postfix

# mv virtual virtual.notworking

I have decided to restore virtual.rpmsave which has a timestamp of 14 Dec 2=
022 (3 years ago).

# cp virtual.rpmsave virtual

# postmap /etc/postfix/virtual

# systemctl restart postfix

Now I have managed to solve the problem with the help and assistance of the=
 folks at Virtualmin community and elsewhere. Their help and assistance is =
deeply appreciated. Many thanks.
Now all of my email accounts hosted in Virtualmin Linux VPS are able to rec=
eive emails.

Before solving the problem tonight / this evening, GMail used to send me De=
livery Staus Notification (Failure).

[QUOTE]
Message not delivered

Your message couldn't be delivered to ceo@teo-en-ming-corp.com because the =
remote server is misconfigured. See the technical details below for more in=
formation.

The response from the remote server was:
554 5.7.1 : Relay access denied
[/QUOTE]

Thank you for all the help and advise guys! The cause of the problem is wit=
h /etc/postfix/virtual and not /etc/postfix/main.cf. But I still have no id=
ea who or what modified /etc/postfix/virtual that caused my Linux mail serv=
er to go down. I am no forensic expert.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
18 Dec 2025 Thursday 11.02 pm Singapore Time






On Thursday, December 18th, 2025 at 12:51 PM, Turritopsis Dohrnii Teo En Mi=
ng <teo.en.ming@protonmail.com> wrote:

>=20
>=20
> Subject: Advanced Persistent Threat (APT) hackers had hacked into my Virt=
ualmin Linux Virtual Private Server (VPS) on 15 Dec 2025 Monday around noon=
 time
>=20
> Good day from Singapore,
>=20
> Today 17 Dec 2025 Wednesday around 12.30 PM, I was trying to use GMail (G=
oogle Mail) to send email to my email accounts hosted in Virtualmin Linux V=
irtual Private Server (VPS) (aka web hosting control panel). GMail reported=
 the error "554 5.7.1 Relay access denied". Which means all of my email acc=
ounts hosted in Virtualmin Linux VPS could no longer receive emails.
>=20
> Advanced Persistent Threat (APT) hackers must have hacked into my Virtual=
min Linux VPS and changed my server configuration.
>=20
> Webmin version: 2.520
> Virtualmin version: 7.50.0 GPL
> Operating system: AlmaLinux 9.6
> Usermin version: 2.420
> Authentic theme version: 25.20
> Linux Kernel and CPU: Linux 5.14.0-570.51.1.el9_6.x86_64 on x86_64
>=20
> When I logged in to Roundcube Webmail, I noticed that I had stopped recei=
ving emails with the email accounts hosted in Virtualmin Linux VPS since 15=
 Dec 2025 Monday around 12 noon Singapore Time.
>=20
> When I checked /var/log/maillog in Virtualmin Linux VPS, I observed that =
I had started getting "554 5.7.1 Relay access denied" errors since 15 Dec 2=
025 Monday around 12.28 PM (for my email accounts hosted in Virtualmin Linu=
x VPS).
>=20
> Advanced Persistent Threat (APT) hackers must have hacked into my Virtual=
min Linux VPS and changed my server configuration.
>=20
> When I checked /etc/postfix/main.cf on my Virtualmin Linux VPS, Advanced =
Persistent Threat (APT) hackers had changed the following line to:
>=20
> mydestination =3D $myhostname, localhost.$mydomain, localhost, ns1.turrit=
opsis-dohrnii-teo-en-ming.com
>=20
> I had to change the above line back to:
>=20
> mydestination =3D $myhostname, localhost.$mydomain, localhost, ns1.turrit=
opsis-dohrnii-teo-en-ming.com, teo-en-ming.com, teo-en-ming-corp.com
>=20
> And then restart Postfix daemon/service (systemctl restart postfix).
>=20
> For Virtual Server teo-en-ming-corp.com in Virtualmin Linux VPS:
>=20
> Advanced Persistent Threat (APT) hackers had changed my email account use=
r's Login access to Database, FTP and SSH. I had to change it back to Datab=
ase, Email, FTP and SSH.
>=20
> Advanced Persistent Threat (APT) hackers had also changed "Primary email =
address enabled" to No. I had to change it back to Yes.
>=20
> For Virtual Server teo-en-ming.com in Virtualmin Linux VPS:
>=20
> Advanced Persistent Threat (APT) hackers had changed my email account use=
r's Login access to FTP and SSH. I had to change it back to Email, FTP and =
SSH.
>=20
> Advanced Persistent Threat (APT) hackers had also changed "Primary email =
address enabled" to No. I had to change it back to Yes.
>=20
> After making all of the above changes, I am able to start receiving email=
s with my email accounts hosted in Virtualmin Linux VPS since 1.15 PM today=
 17 Dec 2025 Wednesday.
>=20
> When I checked OpenSSH server logins and Virtualmin logins, only public I=
Pv4 addresses belonging to me were present. There were no traces of Advance=
d Persistent Threat (APT) hackers gaining unauthorized entry into my Virtua=
lmin Linux VPS at all. Of course, if they are Advanced Persistent Threat (A=
PT) hackers, they must be very smart and intelligent (their intelligence qu=
otient IQ sure way above me) to remove all traces of their unauthorized int=
rusions into my Virtualmin Linux VPS.
>=20
> How can I make a request to Advanced Persistent Threat (APT) hackers so t=
hat they will stop playing pranks on my Android (Linux) phones, home deskto=
p computer, laptops, Virtualmin and Webmin Linux servers and other various =
numerous online accounts not secured with 2FA / MFA?
>=20
> Please advise.
>=20
> Thank you very much.
>=20
> Regards,
>=20
> Mr. Turritopsis Dohrnii Teo En Ming
> Extremely Democratic People's Republic of Singapore
> 17 Dec 2025 Wednesday 3.50 PM Singapore Time
>=20
> 

