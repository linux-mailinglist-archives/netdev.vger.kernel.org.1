Return-Path: <netdev+bounces-184303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB59A947FE
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF42172157
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C67146A68;
	Sun, 20 Apr 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YKZZ/6hO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295D5464E
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745156237; cv=none; b=mP+B3FE5+a2sjsIMZ3tfCsRW45nVyVf8ACLb1xKocgpD/9ZDn/ufQWPG/ol4GTpBya1vALhnHMggLU9wM+3x6xRIIAta2pI7ZULv4VmtUr69jRu/FmlHqscboJKciMMbNPlCAAeM7ACxpzdq5YaPMkXz6K8ymD0UzKo3nbvAyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745156237; c=relaxed/simple;
	bh=aJVxZLhnhscu/C/D0RmSAUgyWjWlCjNVqgUHfAwWSag=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cFfXL6bzRfkLEZgz5NwLlBjyC1ho6fbstr6PiU2GFRLPb8J5jGNy/zeNW592hWgQwF9CwFVeT/LP8mLfkykF0sH+6q2/NjPFK0HKI/LwweveY+R8dfDyHZYTV5EG8RHCxP8sTnG3eb29smk5x1nBvguJQg4rh6ZyMh6zEwePukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YKZZ/6hO; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1745156233; x=1745415433;
	bh=aJVxZLhnhscu/C/D0RmSAUgyWjWlCjNVqgUHfAwWSag=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YKZZ/6hOHHrZ9exkFjRzFXhySpng/1c9Pn9ipS+B1GQFn1V/sfYMGc/L6+IgMZ094
	 d2DdkBedKZOELSbWy1ZfDHyxVfcpwzcXsmv++ixZIRfxnY0qj7t57rZp5EMpEIUCUu
	 0kCo3K+VYgy4LnuvRH65PIBZAzmpl7f30D7+qumju6GfOC7rhvrjB2UVRrFfVl5W3V
	 8XaojBMeEWYmE0XKnk+Jrdaxw0OJ6tIuFI3iSQXQuZL9naIvSZdiuVj2zqw9iNsTCK
	 XK0WuVqt7S3hBxoqeWJOUTEtL9RhBmRwwY3Y1s6ybb+fAwhZ7c7l/9qn+zEoYv/THg
	 DDZYFg7k/nJEA==
Date: Sun, 20 Apr 2025 13:37:07 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: How can I stop Singapore Government hackers from hacking into my Android (Linux) phone, and all my other devices as well?
Message-ID: <yvMjfJmeSUk1wJl3udReLy1_sHP_Sp8TjRLyJHkGGLmcaPfaI71dz2zabUOiwXfJkBvxwJYMeq6LBZc9rzYFxjmHbyJwNK8zQWThMa_MiQY=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: bf48457c178f81000db8f23f9a666c7b94d07b5b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: How can I stop Singapore Government hackers from hacking into my A=
ndroid (Linux) phone, and all my other devices as well?

Good day from Singapore,

On the early morning of 3rd April 2025 Thursday, Singapore Government hacke=
rs severely corrupted the Android (Linux) operating system on my vivo V25 P=
ro 5G Android phone.

As a result, I couldn't swipe up and down. I could only swipe left and righ=
t.

Many of the icons on the 1st screen of my Android (Linux) phone were delete=
d by Singapore Government hackers.

Thousands of files in the /Android/ folder were deleted by Singapore Govern=
ment hackers. I found out using File Manager Plus.

When I rebooted my Android (Linux) phone in the morning, it says my phone c=
ould not read data from device storage. The error message goes on to say th=
at the device storage could be damaged or corrupted.=20

When I reached my office at 8.30 AM (it happened to be my last day of servi=
ce at SBS Transit Ltd), my Android (Linux) phone managed to boot up, albeit=
 very slowly.

In the late afternoon on the same day, I decided to send my Android (Linux)=
 phone to Vivo Phone Service Center at International Plaza, Singapore for s=
ervicing. The technicians at Vivo Service Center agreed that my Android (Li=
nux) phone had been hacked and compromised. They decided to erase/format my=
 Android (Linux) phone and re-install the Android (Linux) operating system =
from scratch (rebuild the system).

In the evening on the same day, I managed to collect my vivo V25 Pro 5G And=
roid phone back from Vivo Service Center.

I went home and started installing back all the Android apps in the evening=
, on the same day. But alas! Within a short period of time after I started =
installing back all my Android apps, Singapore Government hackers managed t=
o hack into my Android (Linux) phone AGAIN!!!!!!!!!!!!!!

How can I stop Singapore Government hackers from hacking into my Android (L=
inux) phone, and all my other devices as well?

Are Android (Linux) phones so easy for Singapore Government hackers to hack=
 into??????????????

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals in Singapore
GIMP =3D Government-Induced Medical Problems
20 April 2025 Sunday 9.36 PM





