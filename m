Return-Path: <netdev+bounces-65773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFF83BA87
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B901C21C6E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953C125B7;
	Thu, 25 Jan 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EdcYdaxf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCN3eaO1"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2E11C8B
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167246; cv=none; b=tumitH998SUnYzqcPcbQbOWWFZQxAYyXWaGbmSvkaZzRJ4XTcikZTV41IkUIpC7W6bgBnLP3DeXdYfZt+PMvOuh3RlHXbsojfVGWg/aOBFANwRmgg8a1BNZ55lsE1H2Mo4Q0BUqeGgZrUIQgtKa6WblROk6ZM1fMMk/qKkPiqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167246; c=relaxed/simple;
	bh=YZoqU6qJkaPtk4pr03QIuu2n889+cnQrBShezFHL1A8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVFK1VmI2F42Ln8iYdKFoWLyK5TYhVzncr2tWHcwmtlKQ1TpLJC4yfmUrVf4w/wznpus5MAekH+QrSJlPvMjXGSv6IxOON5kI+SSSg9fp6X3GlXJxg2WGqdHH+sXpPlLUIgLkbYj4N1Z2WAdzBdq5uAR8CwQ6ltr+WJzn6XTnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EdcYdaxf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCN3eaO1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706167242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATPAmHDLsadjvT36/PPtXerzsjMNRvc7H82hsdaZ9sc=;
	b=EdcYdaxf6Vl2Zj0PlUVMjBlWhm8Ceut83uoaqzPteDXKKOnV7bhAokjuTtr1elba0QMTHC
	4zxRwxuylybsCJUB3BgfWulzjXi21himPh3YtUWepe2QkV5qfSa631CzegCfvFmw6fHAv5
	LmDAkzoUZgaeLqsJw1t7knW5GWatY6cgBR+nNaFeZKe4dmrzuR1FIa9amZ8AhrmuJPg50r
	Jbk1JTOg1tn7CxR3VWFeHcuLz/LAvGcFAw22D2sLX8YLWF2gygu2h3EbZDq5Iap3cgKQKu
	9Eo3+nQvUVFa3jxM6GJuRmxXJdn2arSiq9iV4eguuKIBZGXXdS/VpY0HBkVR+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706167242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATPAmHDLsadjvT36/PPtXerzsjMNRvc7H82hsdaZ9sc=;
	b=JCN3eaO1qJpLuz+03itdyNLS4+mnTDTYcrSkZTIOnZ0nOvdCtjAOZN0OXwPhJJQ1fgkobG
	bEkhKhNJgnSxkbCA==
To: Simon Horman <horms@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
In-Reply-To: <20240124210855.GC217708@kernel.org>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <20240124210855.GC217708@kernel.org>
Date: Thu, 25 Jan 2024 08:20:40 +0100
Message-ID: <87h6j1ev5j.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Wed Jan 24 2024, Simon Horman wrote:
> On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
>
> ...
>
>> +static int igc_led_hw_control_set(struct led_classdev *led_cdev,
>> +				  unsigned long flags)
>> +{
>> +	struct igc_led_classdev *ldev = lcdev_to_igc_ldev(led_cdev);
>> +	struct igc_adapter *adapter = netdev_priv(ldev->netdev);
>> +	bool blink = false;
>> +	u32 mode;
>> +
>> +	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
>> +		mode = IGC_LEDCTL_MODE_LINK_10;
>> +	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
>> +		mode = IGC_LEDCTL_MODE_LINK_100;
>> +	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
>> +		mode = IGC_LEDCTL_MODE_LINK_1000;
>> +	if (flags & BIT(TRIGGER_NETDEV_LINK_2500))
>> +		mode = IGC_LEDCTL_MODE_LINK_2500;
>> +	if ((flags & BIT(TRIGGER_NETDEV_TX)) ||
>> +	    (flags & BIT(TRIGGER_NETDEV_RX)))
>> +		mode = IGC_LEDCTL_MODE_ACTIVITY;
>
> Hi Kurt,
>
> I guess this can't happen in practice,
> but if none of the conditions above are met,
> then mode is used uninitialised below.

Yes, it shouldn't happen, because the supported modes are
checked. However, mode can be initialized to off to avoid the warning.

>
> Flagged by Smatch.

Out of curiosity how did you get the warning? I usually run `make W=1 C=1
M=...` before sending patches.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWyC8gTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgk9QD/42ei2vKmG2WcSWM0YabBvWMfSsjO27
0I19ycGRrecvSImrMzxAHRKVqwQ3eC1zKvIv/CtkM/7VXWsXPPWgGwp5+1i/RWxt
tG0dtC58clJanhFJhXQcL4KTs5mgpoNGujv1oCe/AB+EYgv1OZeqkRlV7M5ru+71
6Frn/VroNiZZhNhfJOCNiAN7v+MbjpLhkdEovuzegqd5NM7X6zupqx3JgkP+JxQZ
Z+LfZ9xDAYmvWDOhW3e4ce9128cmOzLF71WUcaK1wdOh5d9HoEcditmMIC4/17wV
A5Po7YJS9t6U1m9KSW3brmfWW+t2yq84QVyCllQVcCQAPu/iMl5PRt877eHrJ1qw
BovNY6vLb4TEHnvbGT80sEdorpncq15HlFMgakHwqkTOjrKXqHyCW1wrDn64NlxN
rJqnPCHh5d2VzQhcC1fOQcsLJ5yCgEd/mtIjt1NL29mNH+tYDGPXXCBnjJeXUEsX
DhFK9fBD4rqTLixB7NPwuFw4ee7bSJ/d1vqGznJRHqNEQ/jP0OjSujIm+U9Gj6HQ
bpaPqBBYqsr6lJ/xjGBL0R6ko50iFwcRIFe82woBlOeB46yPPTBESlTeYCXcbRNO
JryjpG4BcfkYT4pptG6Cs78rljNgqS44/6JNAs2uamOGwSGXV+gGu5yRxHoJzt3j
SsdRNUsK2/gxOw==
=ju9m
-----END PGP SIGNATURE-----
--=-=-=--

