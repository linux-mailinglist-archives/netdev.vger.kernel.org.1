Return-Path: <netdev+bounces-266232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MrAIStFsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A79254A5B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90BC13343A12
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924E3B6C19;
	Tue, 10 Mar 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHama83q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69B3B775C;
	Tue, 10 Mar 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157906; cv=none; b=dGupVZOZV/QRZxbcy5/6AkIJVhh3x1emQUfo0MvDqg3sHHhvbFgQ0odTBJ4Sy/xGFcgqRd/9JY2CsewPtqfNLZ0dJqNq3F9KGDZE1wgR7jk8yBY0q6OEBnIzXv9t0pQH5TQwqwOuUsph+7D0wnozJAG6Lx+6O0hWn6MLw2iv3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157906; c=relaxed/simple;
	bh=hrMCPiD1kSuFSsYwv40IBpKagD47pviVhBH4RjPYoYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foOv6E78n4tv5Ek53WcRN/C79Cst6ab45yd/VHtfYcEYZ3DNtZ0A+IzEeD6ZfA04oyFCkXm9sYCNlB9sHFpZLL0D1h/mAOOne5sgUcKeoN6ouwX9n8cxsFuMkIWbfmb05f/NmpIoFtWFsBd5hPvLB7FzjWdGFCLj8wBnBoqMxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHama83q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47990C19423;
	Tue, 10 Mar 2026 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773157905;
	bh=hrMCPiD1kSuFSsYwv40IBpKagD47pviVhBH4RjPYoYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XHama83qMsDpQzGN0ZbqxayU2oExcsKwBAM3hr9sLfso+2dxx0XcYdqezwNt2gQxJ
	 8a8rgTTnjX1ddbgxmNqi/QKwwCIyQ0NLtbqPr6Ut89IodjyBvvBINR9U543EAIt2oC
	 zSlyTSshyhTbMO+UFReA9wP+FwAMkKBQdEtKeu0dQtRvzXmFXxoP87VYtx6/taK7V1
	 fRqFQg0IhKfzVFxUuOzPNyGZ7Bt2QKFszfOaw0VzLJQB8tAsuLXlejsgmtck5k9MgC
	 3+mjn9WWhUFXg8FKtzI8RujpB7U1ofUuoIVNZZ27P3D2i0zDvQk1OMQgdjuT+ZLGaW
	 8ZwbIXKLHUUjQ==
Message-ID: <19d9b245-3307-4d6a-8e42-895fbd167887@kernel.org>
Date: Tue, 10 Mar 2026 16:51:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups, RCU
 stalls, timeout
Content-Language: fr
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, luto@kernel.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <MKoutny@suse.com>,
 Waiman Long <longman@redhat.com>, Marco Elver <elver@google.com>
References: <87v7f61cnl.ffs@tglx>
 <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org> <87pl5ds88r.ffs@tglx>
 <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org> <87eclsrtqg.ffs@tglx>
 <e846cb5f-65c4-4a9b-9f9b-593e4af526d8@kernel.org>
 <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org> <878qc0rofr.ffs@tglx>
 <874imorobw.ffs@tglx> <4cad1b9a-e157-427b-9896-cf54cf6fba36@kernel.org>
 <20260310115433.GV1282955@noisy.programming.kicks-ass.net>
 <87y0jzrhqn.ffs@tglx> <a5cabf68-df88-4a5e-8075-bb10debc44f7@kernel.org>
 <87v7f3re2w.ffs@tglx>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <87v7f3re2w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 31A79254A5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 10/03/2026 14:47, Thomas Gleixner wrote:
> On Tue, Mar 10 2026 at 14:40, Matthieu Baerts wrote:
>> On 10/03/2026 13:28, Thomas Gleixner wrote:
>>
>> (...)
>>
>>> I've updated the debug patch and removed the @users conditionals so it
>>> keeps searching. So it should find that magic 73.
>>
>> It looks like it does, thank you! I just tried this new debug patch, and
>> I managed to boot 100 times without issues, while before I was getting
>> it after max 20 attempts. I left the test running to boot up to 1000
>> times, just in case.
> 
> Now that I actually understood the problem, I was able to write a
> reproducer which triggers the issue 100% reliable.
> 
> The debug patch does cure it and it does the right thing. I have a
> better version of that in testing right now which avoid all that flaky
> accounting and especially in the vfork() case the full tasklist walk.
> I'll send out a complete patch series with changelogs etc. later.

Great, thank you!

Note that my 1000 boot iteration finished without errors.

> Thanks a lot for your patience and invaluable help. Very appreciated!

My pleasure! Thank you for your support, and for maintaining so many
important pieces in the Linux kernel!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


