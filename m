Return-Path: <netdev+bounces-258272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFf5IVpxjGn6oAAAu9opvQ
	(envelope-from <netdev+bounces-258272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:08:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9778124173
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD0C30226A0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB232E6A2;
	Wed, 11 Feb 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pL8ZfjDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atjWLwPM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF992737E3;
	Wed, 11 Feb 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811735; cv=none; b=kpWTk4Ll7amAnklvtW//uuAt9qGjl4C8hE+OA2Fg7Nux5QsueLCzI7BGf1UXtLWksFC84XNC6GwSW8HcJJyLhPr+rTa313DgO2U0+/2umGyd1rxyzCvorFgIDQd+sz4uTJsJH/Mr30LtHyKh2E3GC6pQqD2Asu8N6G4ZdlEfjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811735; c=relaxed/simple;
	bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OGDs3aQoVQmGVkLBwe5Ui8R7U69YTuRhzks2f5+SyDU+YLp4l/AbYfWzvsHkYrUWTiYxuKjFT6FREjhIdMLyxE0WR3OOguPID2cUJfUcfKzJ34stFJ2/fX8uHk/iSirPwa8idVWpLjCFkrpBd+c+CX/is2hp/3RGInSTWk9KCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pL8ZfjDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atjWLwPM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770811733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
	b=pL8ZfjDUF5ZD0/8j11okajAj6FSQhpdfoQD4uW44etpx8XP5QWbaRup1awTOtVIIbNsW7y
	07HcUy1uTgvmXBfarJhbeOpunX6Y6aJAaulyLsm/XZlFoOqlayV9i0O8q3D51llNqAn73J
	+YP+ZmTZFhVI0rVgkIDLcFuEhnjzfmPI9NogfMJ0lkq8Qri6/IELmN0vfd5BSXJlfCJPMQ
	WSebTq7GPY7cjT/9jNcdYJGXXJOweEhBRND1gE1I0uX/qFfNnY/xsI7Hs3UkHZ8+lGcvFC
	+4H74BS9DlhXrUTZgTJHjYuGF9IkBXJuKFglDunoIOv2RRx/oqQW/B9eHPfwmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770811733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
	b=atjWLwPMWpgm0wC3MfQan/BN02jSIISsUhcGZdRuJevEphi9wrjdm0kUwK/UYSgWxNJvDd
	RxQgAZ0dPAhtI5DA==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn
 <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
In-Reply-To: <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
Date: Wed, 11 Feb 2026 13:08:51 +0100
Message-ID: <87qzqr5vos.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258272-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,jax.kurt.home:mid]
X-Rspamd-Queue-Id: E9778124173
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain

On Tue Feb 10 2026, Willem de Bruijn wrote:
> The core issue seems to be that the ptp_tx_work is not scheduled
> quickly enough. I wonder if that is the issue to be fixed. When/why
> is this too slow?

The igb driver uses schedule_work() for the Tx timestamp retrieval. That
means the ptp_tx_work item is queued to the kernel-global workqueue. In
case there is load on the system, the kworker which handles ptp_tx_work
might be delayed too much, which results in ptp4l timeouts.

Easy solution would be to tune the priority/affinity of the
kworker. However, we have to figure which kworker it is. Furthermore,
this kworker might handle other things as well, which are not related to
igb timestamping at all. Therefore, tuning the priority of the kworker
is not practical.

Moving the timestamping in IRQ looked like a good solution, because the
device already signals that the Tx timestamp is available now. No need
to schedule any worker/work at all. So, it'd be very nice if
skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
igc call this function in IRQ context as well.

Alternative solution for igb is to move from schedule_work() to PTP AUX
worker. That is a dedicated PTP worker thread called ptpX, which could
handle the timestamping. This can be easily tuned with taskset and
chrt. However, there's one difference to the kworker approach: The
kworker always runs on the same CPU, where the IRQ triggered, the AUX
worker not necessarily. This means, Miroslav needs to be aware of this
and tune the AUX worker for his NTP use cases.

I hope, that makes the motivation for this patch and discussion clear.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmMcVMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkf5EACZwVUUvNc7py0uF6SrA9X07oBlVklo
StF+ThGyjZhpKPq2u+1MNjt/r4p+dibkjycrrom9LIiFHDWPA3poxdo7STQO8Vgr
zk62M3uaJDdWVKF4BPb4jiSyFbx89iTTJaY0WvHrwke5hHAy5hCk7Hygqn4BO+YD
507pyajHpayo3Bl4E07XUFY+A3VN0LtCpRXsl3FNqD08u0RiJ9pXUxixH16potRN
Nm8Jcvygsjj43FlCy5rPncp2Hurvj0WKvAnaYM7YmwLP8hYhxSd0UkC8w9uEkPYW
mW7btcjNhyh2fa4oNW4KIkAX9NWVXzoYj9Hc0p8defQEcQm348fjBpnQZZLk/DGs
LCFqfUgBetWV5OtQxp2RnkuvZ6HYYuTHzaN3c4aZiYG97znyEMijMN/RgR/gTqu4
e3blXZhLqQOB1QyxIviVKcuNlvUFVTxeuhMxzlUcDlCOi/hRZI/WESBYvHu3OQJ9
rqT2QwhDAht1OndQakb66Yan60iiMs8UdyFTRCQQLSn/FZEI8OEHzxbMC+vNLqZ4
Ut+W8xT7FQgPFRqVc9mFH+17JWQsoL5KdTqLPP4jk9mxzQMHZkzQsnERrFGonqf4
7UhLueNDycMMDU3LXCy1+4Fo+J8i9lXxmg4IXSR0X2Kws/Y9mtpR0u4a/ofe09WD
eH4n7GXcxYEO6w==
=yPTv
-----END PGP SIGNATURE-----
--=-=-=--

