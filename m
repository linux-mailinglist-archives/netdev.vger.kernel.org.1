Return-Path: <netdev+bounces-245277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C35CCA454
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 05:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E372301099A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235224466D;
	Thu, 18 Dec 2025 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="guEYJvje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36315CD7E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766033488; cv=none; b=Ax40J8yaNkNH0gARRGFjRev/sQsApIk3NbEaTC00HaqYJseqAKdy/S2uzRGtxsqoVJXl1gKey6eld7YdUuDQkiBjix4BuMRzhjwt9dwvZDXKrcVxtD3DxbMeTqhnE7DWMwJgsmUMqvFse5kAVil/mX4PSY8lR/JZL+zgOhghFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766033488; c=relaxed/simple;
	bh=QvxlFRwO1KIHzUk2uGdbBVUqHnxfYVK2vrVz2h27E30=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=efZZXBq02ewvAgMVOQzm4T00n/QKkJEQtwxWmHs/QvQZjS398O+F1yekXLtw8ljII8oUY2x5gcOPR+eAOhr6ez8XlhB5EDjgoirpxJwTEu+6lwmpw9/8YPQ0FyWVAIvylGShxp+OgbGU9TnMIn7se0YhZHJXL/56sF8eFJlvSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=guEYJvje; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1766033475; x=1766292675;
	bh=QvxlFRwO1KIHzUk2uGdbBVUqHnxfYVK2vrVz2h27E30=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=guEYJvje+jnmVQcPrx25fS5x3Y3rHDHi1krZdp3Z6T5pprjo4S4D3fdLpUcMHs5Fs
	 YsnDCR3Kum16SSg/uAemSs06pPPg4k0QjLCT2H4Kn2KIjTt+4MqnaLBtmY45ctsRJD
	 ta8Sbz9GNC58Yl2W6gYBEuk+jliJdqrAY7OpXBPElHBDyBiLXYxIw+KexYtqVsdh7z
	 6zxCAxEkUPMjDR8v1C4USgn80g+ImsUh8bzq+Cocu9R4ofuCOY2C5yaorZvIkXin1x
	 UfWCAmTV1UoFyJwJRJgqZZ88C90Y+pd5MKEtMFcXHtqmY5ZzQv+5piir/kHwI2xFNh
	 XC0sbExKOvuZg==
Date: Thu, 18 Dec 2025 04:51:11 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Advanced Persistent Threat (APT) hackers had hacked into my Virtualmin Linux Virtual Private Server (VPS) on 15 Dec 2025 Monday around noon time
Message-ID: <p6q1ZcmyQr1jf50qb0CTkQWCLEYt3BTyG_sNxtXAqj-Y40eMBWBjRueCvSmnXt3w6FSBYOBC4f5ck2-KinfmHiLsE_lklsrGZWlAJhPrHhI=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: b20c0e316072974d925ef4a5fe1b497faf09a745
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Advanced Persistent Threat (APT) hackers had hacked into my Virtua=
lmin Linux Virtual Private Server (VPS) on 15 Dec 2025 Monday around noon t=
ime

Good day from Singapore,

Today 17 Dec 2025 Wednesday around 12.30 PM, I was trying to use GMail (Goo=
gle Mail) to send email to my email accounts hosted in Virtualmin Linux Vir=
tual Private Server (VPS) (aka web hosting control panel). GMail reported t=
he error "554 5.7.1 Relay access denied". Which means all of my email accou=
nts hosted in Virtualmin Linux VPS could no longer receive emails.

Advanced Persistent Threat (APT) hackers must have hacked into my Virtualmi=
n Linux VPS and changed my server configuration.

Webmin version: 2.520
Virtualmin version: 7.50.0 GPL
Operating system: AlmaLinux 9.6
Usermin version: 2.420
Authentic theme version: 25.20
Linux Kernel and CPU: Linux 5.14.0-570.51.1.el9_6.x86_64 on x86_64

When I logged in to Roundcube Webmail, I noticed that I had stopped receivi=
ng emails with the email accounts hosted in Virtualmin Linux VPS since 15 D=
ec 2025 Monday around 12 noon Singapore Time.

When I checked /var/log/maillog in Virtualmin Linux VPS, I observed that I =
had started getting "554 5.7.1 Relay access denied" errors since 15 Dec 202=
5 Monday around 12.28 PM (for my email accounts hosted in Virtualmin Linux =
VPS).

Advanced Persistent Threat (APT) hackers must have hacked into my Virtualmi=
n Linux VPS and changed my server configuration.

When I checked /etc/postfix/main.cf on my Virtualmin Linux VPS, Advanced Pe=
rsistent Threat (APT) hackers had changed the following line to:

mydestination =3D $myhostname, localhost.$mydomain, localhost, ns1.turritop=
sis-dohrnii-teo-en-ming.com

I had to change the above line back to:

mydestination =3D $myhostname, localhost.$mydomain, localhost, ns1.turritop=
sis-dohrnii-teo-en-ming.com, teo-en-ming.com, teo-en-ming-corp.com

And then restart Postfix daemon/service (systemctl restart postfix).

For Virtual Server teo-en-ming-corp.com in Virtualmin Linux VPS:

Advanced Persistent Threat (APT) hackers had changed my email account user'=
s Login access to Database, FTP and SSH. I had to change it back to Databas=
e, Email, FTP and SSH.

Advanced Persistent Threat (APT) hackers had also changed "Primary email ad=
dress enabled" to No. I had to change it back to Yes.

For Virtual Server teo-en-ming.com in Virtualmin Linux VPS:

Advanced Persistent Threat (APT) hackers had changed my email account user'=
s Login access to FTP and SSH. I had to change it back to Email, FTP and SS=
H.

Advanced Persistent Threat (APT) hackers had also changed "Primary email ad=
dress enabled" to No. I had to change it back to Yes.

After making all of the above changes, I am able to start receiving emails =
with my email accounts hosted in Virtualmin Linux VPS since 1.15 PM today 1=
7 Dec 2025 Wednesday.

When I checked OpenSSH server logins and Virtualmin logins, only public IPv=
4 addresses belonging to me were present. There were no traces of Advanced =
Persistent Threat (APT) hackers gaining unauthorized entry into my Virtualm=
in Linux VPS at all. Of course, if they are Advanced Persistent Threat (APT=
) hackers, they must be very smart and intelligent (their intelligence quot=
ient IQ sure way above me) to remove all traces of their unauthorized intru=
sions into my Virtualmin Linux VPS.

How can I make a request to Advanced Persistent Threat (APT) hackers so tha=
t they will stop playing pranks on my Android (Linux) phones, home desktop =
computer, laptops, Virtualmin and Webmin Linux servers and other various nu=
merous online accounts not secured with 2FA / MFA?

Please advise.

Thank you very much.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
17 Dec 2025 Wednesday 3.50 PM Singapore Time






