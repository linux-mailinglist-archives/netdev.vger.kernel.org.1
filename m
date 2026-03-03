Return-Path: <netdev+bounces-263213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONb0C27mpmnjZAAAu9opvQ
	(envelope-from <netdev+bounces-263213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:47:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D691F0A57
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9B7A30A5096
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2E27AC31;
	Tue,  3 Mar 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LDBZPmK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBEyQk8P"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDD324B27;
	Tue,  3 Mar 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545108; cv=none; b=LJryFkBiDds2FZmxlxmQdGrtqgnGtgELYojvY6oxYjR45i2Vr3KmyuGoL8NH4UP77cAfRqNT8OqIipXPdavND0DH4ohMBkI+o+SYzJrPI+62m1iJ0tcmjPrfOUxi8tJ7mAD4uA/0tCGUELLekZPgzhnUSYegzqaobvlSY7cf2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545108; c=relaxed/simple;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvFCb59EcWXiWl9jKlEfweULruI7+y6awR0P6ph2VZRRpp9yMoLmlZai74v7fQ7L3rN7+nX1sVpOIV+wVq/sJMsPTktX8U4BsWPjAWJWa2rnDAI2jdJqPFK5aIxjh7UGeoHr0g7BkvN+R3UCG75CGG18ExbsSYwb/w2rBwT73Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LDBZPmK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBEyQk8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772545093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	b=4LDBZPmKYMrMkaPbCVywO2f3s+eYFA984rvFUndjVB18nt16AhKieNdKRpe8qkXfvl+ssE
	O8Dn79K94qr9J7P19d6iRQkBh2L9olhXM/vYKyFxqaTMiCXvaOKZybh7XE9pFRV751mS3H
	n9/gpb1zPzMQOMyUZ+m3YMZQqJkMK2JPiZ7Am3w2H73NhMyI7jesIoekiyfzvmeDo7tptE
	y0YNPrD+DaxThz0U5m8F//GOoOyNdBkY9eD0TBifQxYojVgBomqi08plios9MrESUFkwzX
	EnrqatylNbhsUO8s6RwrmQMVP+nvK6vJ06pZQZDqgicL1Bl26/PR4gjXrn6tEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772545093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	b=lBEyQk8PaGlnn48Bha/m0Iv1tc+mdAuXfNtqRyogmn0XZmB1fSdSfLl1MphKBw/Zxpsoxg
	i7nXcoi5WxknxtCg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
In-Reply-To: <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
 <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
Date: Tue, 03 Mar 2026 14:38:11 +0100
Message-ID: <87qzq1rq2k.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: A5D691F0A57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-263213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim]
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Mar 03 2026, Paul Menzel wrote:
> Dear Kurt,
>
>
> Thank you for the patch.
>
> Am 03.03.26 um 12:48 schrieb Kurt Kanzenbach:
>> Retrieve Tx timestamp from system BH instead of regular system workqueue.
>>=20
>> The current implementation uses schedule_work() which is executed by the
>> system work queue and kworkers to retrieve Tx timestamps. This increases
>> latency and can lead to timeouts in case of heavy system load. i210 is
>> often used in industrial systems, where timestamp timeouts can be fatal.
>>=20
>> Therefore, switch to the system BH workqueues which are executed directly
>> at the end of the IRQ handler.
>
> Thank you for implementing this.
>
>> Tested on Intel i210 and i350 with ptp4l.
>
> It would be great, if you shared the numbers. Did Miroslav already test=20
> this?

Great question. I did test with ptp4l and synchronization looks fine <
below 10ns back to back as expected. I did not test with ntpperf,
because I was never able to reproduce the NTP regression to the same
extent as Miroslav reported. Therefore, Miroslav is on Cc in case he
wants to test it. Let's see.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmm5EMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvQWEACMXEkyWc4oiQvvfpz+VFyPGHKQWZR3
nTb4r2KTU42t75o5ukOCAq0+hpgtgd7H5VD96qwiNHvacfd4IvKsP4/DI32LWSqw
yRqH6M49S2/LSZr7fYtkdfLjY5VOGzF41b/abAgVoXJfn0yn6/NAzGc9kgGfQKXR
uSidNO7GJzcwzvzxRChYtcmIMq5NrhXZsG46r329VjFEsLplOCynX8+wjsDT5Jhh
iVmXfxNmY96zbrueIgCAWyCXQT5xHWe8pnSPgBna14q60ygXF0STN1UhrQNi4WK0
oCjWSzivIF0jmm/zXwOcDlmhbOwOeHEwPf/4G5YG8METMjdURwmZ6JbxYWrMr0SM
soGF4idZ3Eeh8prt50kqdE5/N8M018gR8AvKKQecwCqhYx5imXikIcteFoIVsXPs
y8hOJU0/1yN0xGpn0WVZ4umyujoDiL1Im/eZK1bHDvaJyD+5g+YwaUPw05q2XcRQ
+SJl0fNYSKkg/itB3pkygIffLpIFQO5ip23gEDAS8o6wIAZz8gZnh7CbgwigB5+E
m9Pk9EquSCM0xdJidOoK9Od9uqlBloZolCXFEPAmnEIJtc9WYBjLiTcfshCNnfBW
IIFaov3rdq5td5Ul7TD0AwwN7a+bc3NBo48ijFFjq3jwpWj+4vGvWiXGqPM3286b
Tf7yhlSENlmJJw==
=TRL7
-----END PGP SIGNATURE-----
--=-=-=--

