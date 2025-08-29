Return-Path: <netdev+bounces-218093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18196B3B13B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 04:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58E894E2689
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF83220686;
	Fri, 29 Aug 2025 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="gl4GdYbT"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB11A58D
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436110; cv=none; b=Mqaxju2XKKv5D/ogNg81tMyS2nPw339RgOu3bIGa9uwZ5aZB2alOtCGkwXyd+3SQny4LUx7jVVJfiuyPbRwk7nzVcPT3n3/8KJxGIcz8mMuuRtJnHeCD26CgZh0kuvIQvNVU010phkkpYzrTwhLorHal+NdH0/gt740q1epTxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436110; c=relaxed/simple;
	bh=KHo1Dw+h8GbN/vM+aEHw0JUGCyBxM2rPTdnmWj0a3U0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nprBfoXWuHnz/HG2rgBQDfj8aVIK6Udhaf/PO+VzaOB6zOfdLOd140mElurktRXjCSHfo5TrGAo5mclWHLFd87UCG6ez06e9hTqUqju3mqhf3fGgb2VrAlwJcJWsS4OS4Ye7wvVxYpQSXb159Ad4Q8Qm66WHPnOxhU+39trmRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=gl4GdYbT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756436101; x=1757040901; i=efault@gmx.de;
	bh=BHUCzaE0aQgTujvzwPblOceCBDKB+7rU1lyL+14kSCE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gl4GdYbTHbqy9kOs+nYNpv9dd4ZC8P5c04MeWV/ivGPfZJ+gI0oTLUNoOasKs72o
	 bkli6TeQtMOtf1O1Clc9Ne5cL6pemLrE+xf61qPVL4ASk//WIGo2SCu6kcaQPp0Tg
	 xg1Cz9DVLiqbm3+vF3OIClEgXoF0BylsCMWl9wp/Op3cF/1y7kGOaD+Oibzzg4AWU
	 99WCMQY70PKoqBr1RjxwVWRAk0CG6yQ44hXT1K+kgkbvnO2lo+8BL4SaevmEIQF7j
	 4HuvvkrwAGX8WyVqoyygoP8Y4oWlbHILpWnccBn5QyNI9g7cqmcBw3IF6HhBii7zr
	 GssSDtNy4xWvCTLxHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1uIlUr12xs-00cZfg; Fri, 29
 Aug 2025 04:55:01 +0200
Message-ID: <dac654faa61de1d1a181a7d23659e420742418a5.camel@gmx.de>
Subject: Re: netpoll: raspberrypi [4 5] driver locking woes
From: Mike Galbraith <efault@gmx.de>
To: Sean Anderson <sean.anderson@linux.dev>, Robert Hancock
	 <robert.hancock@calian.com>
Cc: Breno Leitao <leitao@debian.org>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Fri, 29 Aug 2025 04:55:00 +0200
In-Reply-To: <8e60d336-9cab-4003-8972-bda0b041d8cf@linux.dev>
References: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
	 <e32a52852025d522f44d9d6ccc88c716ff432f8f.camel@gmx.de>
	 <f4fa3fcc637ffb6531982a90dbd9c27114e93036.camel@gmx.de>
	 <cbc6389e-069e-4f59-8544-fa59678e401b@linux.dev>
	 <39f14032374d5d60c62b283637267a96ce535861.camel@gmx.de>
	 <8e60d336-9cab-4003-8972-bda0b041d8cf@linux.dev>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:iVJHWRnuWjMhfYNfctQYEnX+RDHmgXMnK3LiKbpGK9ITZefVdJC
 Y2oqI3GMrnAq0N713zGPm74OMuZSAlDhyPeUIdjH+iycQu1pwc5ydps6BLxe9Tp4cjy/n4Y
 ZsSdQezqzzLGoYNgkmgozLoENqAxPS4EL39Xj1MzHCOLGx+1QBy3RW/GdJBClt/r7jN2A6f
 Djyrtpfd7TESYc4TqG8Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hUFRNorlpuQ=;9NBKGNTgkUs2hT6W3T4isntC62k
 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
 fM3IFfA=

On Thu, 2025-08-28 at 14:56 -0400, Sean Anderson wrote:
>=20
> Looks like the tx completion path can also be called from netpoll. Can
> you try the attached patch?

Done, zero netpoll or lockdep complaints.

	-Mike

