Return-Path: <netdev+bounces-254378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCAoOTZJemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A7A7015
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 595E8301F699
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9728682;
	Wed, 28 Jan 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU4Ecy9f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AC318BA5
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621077; cv=none; b=dQGbQwi/FVSneMbc2Fk0gHg9no3hY+iAQ1bZ/qQ5LRi1TBMxFDzp09hvmDh5bztiiksR4tRueMrqN42QiJX/LHHpT42bRt22SIsVkw9/6gfpCi+vL06q2as6/5DIRiPndNpFMkfYs/pWqEwgQf4svEj1n/Bip42Y5oAGnDDpwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621077; c=relaxed/simple;
	bh=/2CQfAF62PfgS+QwqoevAqF3YepWLaI2UKaHpfk7vWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrPC58WPwYnbBtMvephiVFVomJkPL1rk/QUo52PrTFtcc5/chEe2uri4qyOEb7B623XWhZlotnko2g/UuUfG1M8BcxLZVmoeK5uQrdYDtGC/ODXPFvlcYmmI3EGrr6ThRSaYOzAzbcKG9bhtWUqJEnj5bGUtqxB9cRVs/IVeGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU4Ecy9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF38C116C6;
	Wed, 28 Jan 2026 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769621077;
	bh=/2CQfAF62PfgS+QwqoevAqF3YepWLaI2UKaHpfk7vWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YU4Ecy9fOvN+ELLKMzwDrNvp1vRAf0m7yifJU34cqqEOSWl+4o1p3oOIas1PQJXzB
	 xvJWq6ZPo3ZLmhYCSv/kklsFmWCrkD9KH4qYmQs59aLzJMWKdMZtYAoDYxR3N7YlZj
	 9tRkXbdOnv8RkZ2ZVkR//yBjorhITvvaTJCg+tR436tATPzJa3hSXhJerjrP18fmkr
	 QdAFBKJnz2Tj5u8MtFXNABt4tdS2IhBwqQJsJ5cBIDf2dJ0ARthAt22XLkECXuRBtS
	 xOzevW6U3gRQSUHYCtaiqkemD6rOASzIABMv7qm2biE+6wi1TolQC1ppBrH76GFvXf
	 OpAkGF8mWtKNw==
Date: Wed, 28 Jan 2026 17:24:32 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net-next] ipv4: fib: Annotate access to struct
 fib_alias.fa_state.
Message-ID: <aXpGULHCDALVFA02@horms.kernel.org>
References: <20260127043528.514160-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127043528.514160-1-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-254378-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d24f940f770afda885cf];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 043A7A7015
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:35:24AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported that struct fib_alias.fa_state can be
> modified locklessly by RCU readers. [0]
> 
> Let's use READ_ONCE()/WRITE_ONCE() properly.

...

> value changed: 0x00 -> 0x01
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 4168 Comm: syz.4.206 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> 
> Reported-by: syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69783ead.050a0220.c9109.0013.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


