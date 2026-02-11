Return-Path: <netdev+bounces-258185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Qy7WLMgCjGnIegAAu9opvQ
	(envelope-from <netdev+bounces-258185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63D121235
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6095301A414
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE02E6CC2;
	Wed, 11 Feb 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9ImWDGQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831C2AE78
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783428; cv=none; b=qpAmTZSCrMmvEB0JWt2r1OG8UEz3q8h8kxuAAuDgFzk4xFjhCVoGcBpSrfSqj1c5OBoKlFxXff+3iRuZfRWPZuqXmZPcYpf/3zUxkKi4/0Q/8SewQ2lAtDzgPq9gmGopeQl5YUfyjAmnGJavoKWGxDapRZ6bqN66L1M89/Ci+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783428; c=relaxed/simple;
	bh=YdUKVACJn+Pa9SftQyMWc6LGFjqh6ByBvo1qfO5D6EA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZ5uQW+zqD71qKJtIXCqIWpaLgtOHh1GlFtgGemHxtNtPT/SzexFU6N+0ote4RQXQuMo/T6j68Gle4nC7+5Vr7/2NNpuIN2c0Hydet0KTHhedARZljzEUsWeudIU7Hv/gX/NtGLsEBiBt7RbGcLTxKWUdiMst92py2jMlVWkm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9ImWDGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D65C4CEF7;
	Wed, 11 Feb 2026 04:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783428;
	bh=YdUKVACJn+Pa9SftQyMWc6LGFjqh6ByBvo1qfO5D6EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9ImWDGQfbRj7/pNGRdaneUONkDvf80zrpW+XMAcSG0TPNkvc28UwcS6cfte4lrZl
	 qhtYu/85roTiR9/EOYPkc53ToXrN8Jvor2C24IU2uPh/rH+tACdG5sgg67h36Y+k1z
	 GRaofV8C/ZokD0rjuPUW3IE2drs3cgwc33HmKs3Nyab+G2lswg9Y4yWBpNlvcEaxW8
	 JDuAk/VxHpqk3sQmzzyXL9gfso9+hQPVneHQU/BJbWpingDckJ/AD84qEFfZhbklC8
	 nxuf7a5m1LTJVJIwY8MvwDY5GpkPWHMRMP0DZcuXpDAFBh08VgO3WZhrjhHlxxwR51
	 d/KYzhBluOy2g==
Date: Tue, 10 Feb 2026 20:17:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <20260210201706.1da13881@kernel.org>
In-Reply-To: <CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
	<20260206052930.1882740-5-michael.chan@broadcom.com>
	<aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
	<CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
	<20260210174627.2360a03c@kernel.org>
	<CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258185-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A63D121235
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 09:28:22 +0530 Pavan Chebbi wrote:
> On Wed, Feb 11, 2026 at 7:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > I checked and tried using the cmd() and it indeed eliminates a lot of
> > > lines here. But the test itself becomes a little unreliable.
> > > I often see TimeoutError: [Errno Wait for file contents failed]
> > > /sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked me to
> > > use wait_file) =20
> >
> > Does the link take more than the default 5 sec to come up?
> > wait_file() has a deadline param that should let us wait longer =20
>=20
> I did try with increased deadline. But I don't think it's helping.

If you check the carrier manually in a second terminal while it's
running -- do you see it go to 1? The helper keeps the file open
and rewinds to the start, I think that may not work with sysfs :S
Maybe we need:

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/se=
lftests/net/lib/py/utils.py
index 85884f3e827b..24e74475315d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -294,11 +294,10 @@ GLOBAL_DEFER_ARMED =3D False
     """
     end =3D time.monotonic() + deadline
=20
-    with open(fname, "r", encoding=3Dencoding) as fp:
-        while True:
+    while True:
+        with open(fname, "r", encoding=3Dencoding) as fp:
             if test_fn(fp.read()):
                 break
-            fp.seek(0)
             if time.monotonic() > end:
                 raise TimeoutError("Wait for file contents failed", fname)
             time.sleep(sleep)



> > > Also, even when the test succeeds, after the suite exits, I cannot
> > > ping the remote host for a long time. In contrast, my manual loop
> > > worked 100pc of the times I tested.
> > > I am using the command like below:
> > >
> > >    for _ in range(10):
> > >         if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=3DFalse, timeout=
=3D2).ret =3D=3D 0:
> > >             break
> > >         time.sleep(1)
> > >     else:
> > >         raise KsftSkipEx("Cannot reach remote host after interface up=
")
> > >
> > > I am not a py expert so is there something I am missing? =20
> >
> > I don't think there's anything Python related here :( =20
>=20
> What I wanted to check was that if the cmd() invokes some shell and
> has some kind overhead that could affect timing..
>=20
> > Is it possible that NIC reports carrier before it can actually send
> > packets? Maybe the wait_file() gives ping has a higher chance of failing
> > with carrier up which makes the neighbor resolution failure more sticky=
? =20
>=20
> I am not sure. I am willing to send the manual ping loop version as I
> have high confidence on that.
> If you or Bobby insist I must use cmd() then I can spend more time on tha=
t..

cmd() doesn't do any magic, it basically does:

	proc =3D subprocess.Popen(comm, shell=3Dshell,
				stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.PIPE,
				pass_fds=3Dpass_fds, env=3Denv)
	proc.communicate(timeout)

So pretty much the same code as your subprocess.run().

It has support for communicating with extra fds to=20

