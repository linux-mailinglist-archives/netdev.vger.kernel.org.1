Return-Path: <netdev+bounces-262964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA4uFnYvpmkrLwAAu9opvQ
	(envelope-from <netdev+bounces-262964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:46:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC91E75A6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB44312F0B0
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205E1A4F2F;
	Tue,  3 Mar 2026 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4v/bEa1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13E12CDA5;
	Tue,  3 Mar 2026 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498337; cv=none; b=uz60GRFPQshBdwfhXW92b4m/48YIR+rqqCbUYhzOFSUYChCEg1S3CWNrsGajImluSeAqKUbOLsRLazuW5fnU2dwsjeGQhPbMhn356D6M7DRv8Tm8Llic+L53g26hIj1BmmaMxZRhYsoVVfhln2rARU1JE7kS5rJfegQq+zRGMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498337; c=relaxed/simple;
	bh=ZJHabJONOLZQQhdXft+4aN6LhCa9A7dKtACrRqLZDD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNdQOU3Ae12cwUFiPlplCD9r9AYRN1PJlfPSHTJAJ0mHjbxnSDLBRaPlqUNPr27HCzDcGDMzg30QbaPmMl0V84x23qa0lTUbWdTjDnN1pJAmkwtAivy6VkX8JpI6h5pX4DELgIfuS8dlvq515s4yz6z+YDvudvmdBxyw9oZpj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4v/bEa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB9C19423;
	Tue,  3 Mar 2026 00:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498337;
	bh=ZJHabJONOLZQQhdXft+4aN6LhCa9A7dKtACrRqLZDD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4v/bEa10bWCrY8m5G2CaC/gR4eUKBr8K0fu/OtiChgTFjQdV5BSlqGqSXQdL/ZJg
	 5zjmq8NXg4cLW4KfbwIQ+514GjfGVGlKK45pHDDwxhpD6z+PRiCH5aCpXPc2uoD8Ke
	 1WA1nOadVSI4Ena8GCoPABg9kalFnSQ7iRoPsCERi0jvQeqCYZ5xzqXSUVkZgEEqU5
	 VvAODJi74KNHgrACM7iBVqHM8Ze9KdFFLpP+16lm0aWcvpHLztrEvPn6q2fBh4tP7b
	 9boM0VD4nMWWuuhVqe8LrGKYcNIIS5iVwwwZe8jrx3ponyqBnt1IDd6lSklegaKMD1
	 4PjZDAxI+4AjA==
Date: Mon, 2 Mar 2026 16:38:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com, "John Fastabend"
 <john.fastabend@gmail.com>, "Sabrina Dubroca" <sd@queasysnail.net>, "David
 S.  Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo  Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Vakul Garg" <vakul.garg@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] tls: fix hung task in tx_work_handler by using
 non-blocking sends
Message-ID: <20260302163855.28d12a65@kernel.org>
In-Reply-To: <f85c8e268a8384fe14ba5b0033b9f9b931afc122@linux.dev>
References: <20260227063231.168520-1-jiayuan.chen@linux.dev>
	<20260228091545.412a9a2d@kernel.org>
	<f85c8e268a8384fe14ba5b0033b9f9b931afc122@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EDDC91E75A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ca1345cca66556f3d79b];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 01 Mar 2026 06:52:00 +0000 Jiayuan Chen wrote:
> > On Fri, 27 Feb 2026 14:32:31 +0800 Jiayuan Chen wrote:
> > > tx_work_handler calls tls_tx_records with flags=3D-1, which preserves
> > >  each record's original tx_flags but results in tcp_sendmsg_locked
> > >  using an infinite send timeout. When the peer is unresponsive and the
> > >  send buffer is full, tcp_sendmsg_locked blocks indefinitely in
> > >  sk_stream_wait_memory. This causes tls_sk_proto_close to hang in
> > >  cancel_delayed_work_sync waiting for tx_work_handler to finish,
> > >  leading to a hung task:
> > > =20
> > >  INFO: task ...: blocked for more than ... seconds.
> > >  Call Trace:
> > >  cancel_delayed_work_sync
> > >  tls_sw_cancel_work_tx
> > >  tls_sk_proto_close
> > > =20
> > >  A workqueue handler should never block indefinitely. Fix this by
> > >  introducing __tls_tx_records() with an extra_flags parameter that
> > >  gets OR'd into each record's tx_flags. tx_work_handler uses this to
> > >  pass MSG_DONTWAIT so tcp_sendmsg_locked returns -EAGAIN immediately
> > >  when the send buffer is full, without overwriting the original
> > >  per-record flags (MSG_MORE, MSG_NOSIGNAL, etc.). On -EAGAIN, the
> > >  existing reschedule mechanism retries after a short delay.
> > > =20
> > >  Also consolidate the two identical reschedule paths (lock contention
> > >  and -EAGAIN) into one.
> > >  =20
> > It's not that simple. The default semantics for TCP sockets is that
> > queuing data and then calling close() is a legitimate thing to do
> > and the data should be sent cleanly, followed by a normal FIN in such
> > case.
> >=20
> > Maybe we should explore trying to make sure we have enough wmem before
> > we start creating records. Get rid of the entire workqueue mess? =20
>=20
> Regarding wmem pre-check: the async crypto path is not triggered by
> wmem shortage =E2=80=94 it's triggered when the crypto operation itself is
> asynchronous (e.g. cryptd fallback when SIMD is unavailable). At the
> time tls_do_encryption() returns -EINPROGRESS, wmem may be perfectly
> fine. The problem occurs later when tls_encrypt_done() fires and
> tx_work_handler tries to push the completed records =E2=80=94 by that poi=
nt
> the send buffer may have filled up. Since these are two different
> points in time, pre-checking wmem at record creation wouldn't help.

My recollection is that the work scheduling in the async encrypt path
is just a duct-tape fix for some old race. The sendmsg() paths should
normally wait for the async crypto to finish before returning to user
space.

> > Regarding your patch I think all callers passing -1 as flags are on=20
> > the close path, you could have just added | DONTWAIT if the flags=20
> > are -1. =20
>=20
> Regarding adding MSG_DONTWAIT unconditionally when flags =3D=3D -1:
> tls_sw_release_resources_tx() also calls tls_tx_records(sk, -1).
> That's in the close path where we actually want to block and flush
> remaining records to honour the "close() should send data cleanly"
> semantics you mentioned. Making that non-blocking would cause data
> loss. So we do need to distinguish between the two callers, which
> is why I introduced __tls_tx_records() with the extra_flags parameter.

Possible, I didn't look very closely.

The extra_flags argument you're adding is extremely inelegant.

