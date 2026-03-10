Return-Path: <netdev+bounces-265921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIsfO8PUr2kfcgIAu9opvQ
	(envelope-from <netdev+bounces-265921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:22:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0CD2473BC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C1643018588
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEA3EBF0C;
	Tue, 10 Mar 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXGx1vAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36272359A79;
	Tue, 10 Mar 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130843; cv=none; b=AzUNV84CujVAdcrDzYEWy0CIL71qeVhyTEkKrCjNalFvKiqKQLPMedc9DaOuiD3PXYPa0oNuo0/EWeBYY+S6MLlkpjWJQoxlQv7Bu9hkgyyqzynH8O4A7bsfeGRHobQsdPH5hWHo7BGFvFOhOOeNU/L9a8Z8SuBehDuXHY7eGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130843; c=relaxed/simple;
	bh=Y8GYnKbz4eYcvSaBBRoLhh4UlJAVNjD6eWg7sPSC554=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q0m/2Y5bQgAFGPqUewDkW84e8GZNwMb9gvQ/Y2IwSS673adXTkHljs8qhmJZAmhKPOq9EKPuOp1mHj1ecVWkJCJWWSGKIfOHmQ2W8Aj/x2y8IcDeQGGeFl0avIbUeoV7ZGwfFSdT+m35B10dMrZBX6Dtd+5wcutyV6vUihuNXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXGx1vAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF84C2BC86;
	Tue, 10 Mar 2026 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773130842;
	bh=Y8GYnKbz4eYcvSaBBRoLhh4UlJAVNjD6eWg7sPSC554=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dXGx1vAgQ6gpWEmqvlaJ+M+7ZoQBt6dkfVHgq9hij2SlyuY065+i4AIN4EUc5hNUW
	 C8JtQ6OXCi4oVCOWh0sWtepHWhs5NJTyVc7R/vHaij87yYOozkDneKVBvU7orQbBPE
	 uFiB7pV+OopprIgbRG2ZLpKBI6Z8/eYD9Exi5/Cyg44CKjRylPZnbVr7aZsjORprd6
	 fIc4c/IRBnro1IKca3Vp7tpdxScTwFQs/LffEBkIJbDhCWpQem6jpFVaOfBzLizQxs
	 Wd5n0geRYGjVIZ366C4ZUFN/88wrgIugEpqkdQ7tuETwT4pVa8xnfofrvWbWpa7t77
	 a9XT5QjiwjJgg==
From: Thomas Gleixner <tglx@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Slaby
 <jirislaby@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, luto@kernel.org, Michal
 =?utf-8?Q?Koutn=C3=BD?= <MKoutny@suse.com>, Waiman Long
 <longman@redhat.com>, Marco Elver
 <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <87eclsrtqg.ffs@tglx>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
 <87ldg42eu7.ffs@tglx> <87h5qr2rzi.ffs@tglx> <87eclu3coa.ffs@tglx>
 <87v7f61cnl.ffs@tglx> <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org>
 <87pl5ds88r.ffs@tglx> <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org>
 <87eclsrtqg.ffs@tglx>
Date: Tue, 10 Mar 2026 09:20:38 +0100
Message-ID: <87bjgwrt7t.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6A0CD2473BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265921-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10 2026 at 09:09, Thomas Gleixner wrote:
> On Mon, Mar 09 2026 at 13:23, Matthieu Baerts wrote:
> So the only circumstances where mm_cid_do_fixup_tasks_to_cpus() fails to
> do that are:
>
>    1) task->mm != mm.
>
> or
>
>    2) task is not longer in the task list w/o going through do_exit()

  or

     3) task->mm_cid.active == 0 again w/o going through do_exit()

> How the heck is either one of them possible?
>
> Just for the record. The picture Jiri decoded from the VM crash dump is
> exactly the same. One task is not listed.
>
> Confused
>
>         tglx

