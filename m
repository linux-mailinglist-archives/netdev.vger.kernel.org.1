Return-Path: <netdev+bounces-254828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPYgDfB4e2nWEwIAu9opvQ
	(envelope-from <netdev+bounces-254828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:12:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0944B154A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F4543004D06
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D45309EEC;
	Thu, 29 Jan 2026 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smkhMxP0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Moxgp5X7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A861BBBFC
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699565; cv=none; b=fBwVe5TYc/PjEqCQxIANnypW4Hj5H3jt7WWRKbF4FBqWzQ4m8iEqyS8Gy8j4CiNvJ0G9Mv7zZ6Pb0hvWwmmCrzT7D674tUNSwwEpyxqR8IZH0O4XDHHETBrPVfmi2mXvTWF4uRyloowYjhNAGDKQXCHJWSGz7u401WOWyeGMbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699565; c=relaxed/simple;
	bh=rAokad8wOJgi7AvHj0ezGpK0SIiAGCBZclrV0Uk3Ang=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1/+zXaKAuGhNvmZcxUd/slNgm/q9KsWR+i8LZB7RmAvG2n+XS1nbUdypa0CsNygxcR/A5gQObpYNxNaGkSYuSB6urp2OAs08jPpenSyLgPR2zCPg9FKDdYoPQdMAS4nkU2wXMAoW/I+HFi++UCxXBj2SxWspBssUmrLy74Qt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smkhMxP0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Moxgp5X7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 16:12:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769699562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TM1qmuiyXXR8uoeXIvOtTnMIaROHL5xYmQwryL4OhRw=;
	b=smkhMxP0xl47JXufSCD9YeEhNZ9APWdCkr80ZsBhYKT5Af+xFCiTguAFkcDh9WATP9Vk5P
	Z5Kw2Or3HDuUswK4Q2YLGH4uFj6Fik8P3HtCMHZkq/1WXNCMmx6U9F6n8S1gSGDq9Ivvyc
	fxuneDayQThAzCxs2XrmEJ5c3dLKS4FKgnHTgVUJK7LCRZ8qCWyzwrjtsSUQyJFgFGz1XL
	ICEC/y7jE5dUHiybmT1tsMaZITzjqHZXCj0PjEp8SsmmfvIEIdTw7XxzddC6zHiK5JdWse
	mF+tNifMzHa0aCdcmzQrXlMIkcQIc3ndRzUfAtKntO/EQYRXAT6FizqJHpgNeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769699562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TM1qmuiyXXR8uoeXIvOtTnMIaROHL5xYmQwryL4OhRw=;
	b=Moxgp5X7fjnk1tVoB0DVHHICpNw3XIvgGbhq1qpvKQJNdWCMCAYTlk+nU8FyfRvxTyjuT/
	uSUZtJaqJ9ehJDDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 8/9] hsr: Update PRP duplicate discard KUnit
 test for new algorithm
Message-ID: <20260129151241.44i6yt-r@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <e1e0065cd9ff84a970625d77300ba028392981c4.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e1e0065cd9ff84a970625d77300ba028392981c4.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0944B154A
X-Rspamd-Action: no action

On 2026-01-22 15:57:03 [+0100], Felix Maurer wrote:
> With the new duplicate discard algorithm from the earlier patches, the
> KUnit test for the algorithm needs to be updated. The updates are done in=
 a
> way to match the original intends pretty closely. Currently, there is much
> knowledge about the actual algorithm baked into the tests (especially the
> expectations) which may need some redesign in the future.

So the below isn't new but I wasn't aware we have this kunit thing
earlier. It triggers even before your series, just differently now. The
problem seems to be that node member isn't properly initialized. So
lockep complains:

| 1..1
|     KTAP version 1
|     # Subtest: prp_duplicate_discard
|     # module: prp_dup_discard_test
|     1..5
| INFO: trying to register non-static key.
| The code is fine but needs lockdep annotation, or maybe
| you didn't initialize this object before use?
| turning off the locking correctness validator.
=E2=80=A6
|  lock_acquire+0xc8/0x210
|  rt_spin_lock+0x2e/0x1e0
|  hsr_check_duplicate+0x40/0xb0
|  prp_dup_discard_forward+0x30/0x180 [prp_dup_discard_test]

It needs:

diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
index a7a5beb52d62f..2ab346d920bbd 100644
--- a/net/hsr/prp_dup_discard_test.c
+++ b/net/hsr/prp_dup_discard_test.c
@@ -27,6 +27,7 @@ static struct prp_test_data *build_prp_test_data(struct k=
unit *test)
 					     GFP_ATOMIC);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
 	xa_init(&data->node.seq_blocks);
+	spin_lock_init(&data->node.seq_out_lock);
=20
 	data->frame.node_src =3D &data->node;
 	data->frame.port_rcv =3D &data->port_rcv;

Sebastian

