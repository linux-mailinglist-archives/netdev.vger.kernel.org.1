Return-Path: <netdev+bounces-256053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DyQNAdHgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2ED3284
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978FE3012BC3
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE0212549;
	Tue,  3 Feb 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfu9oW7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672118D658;
	Tue,  3 Feb 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080002; cv=none; b=JavJn6cZLZQ1zMeRATd/FJE4QOEUBLnVHwX6uVAxAsUQ/ZawLkSvfDsD2ccfx+idtDyyvIS6xaXfLP6ijERIvjUqeKwNfgF3tCWCAvOgS7lYtefgHIlZi+3DKlh+LThA7Iy7lIS5WxfeJdRDN+lTG7Nl/Z+9yayvMrOAMn9QYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080002; c=relaxed/simple;
	bh=Q66e2wNbr5G2bksRqR3gi6DKYZY+KKyX8+N7Iy7sfLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDiot3qKmNc6a4CGnbwFiP/nl+G2qn/Nl7gj1baQP5GokHwzl8Eph9mnu10nk2eGWODpf582Ax8waSjIHygKAC5HGvhFn+bc60EifQbIC3cVIU6bM8yAJW2l9C3F4vGK7DhKmKPgivlLB5d9/skiNHMU0CwN2pveKPUVUkuy65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfu9oW7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8CEC116C6;
	Tue,  3 Feb 2026 00:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770080002;
	bh=Q66e2wNbr5G2bksRqR3gi6DKYZY+KKyX8+N7Iy7sfLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kfu9oW7D0U5Z0Lh1/jEUmfcTeXIh2rcrocV0nw7JSieq9p+Y0+87Cs7/FSqinlZ5l
	 dVe5NUFSAB5n05qJhS1ThCwWAfCIrQxraJNSoVc5+xQ7c/VB5mDhibhh3V/pZrtmEA
	 65nExa3CWVP/j1C95632syua3lzqJ83fPgaqtDyi1UtxRyk9aqhaeyRiQLlic7ty+f
	 qPsFdHSc6JacQN4hGfOtTr6+E+di06zvlqRUSdera3pCpZjsnK/TFjuclq0LvR9vp1
	 EyxvLseT8RI/uUCRPgLBzeDtaUDADlx4J3IFMT0o2XTuFrlCR6tl4dGA6YL0rSNdHx
	 +GEE4og8G+REg==
Date: Mon, 2 Feb 2026 16:53:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Eric Dumazet" <edumazet@google.com>, "Neal
 Cardwell" <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, "David Ahern"
 <dsahern@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Borislav
 Petkov" <bp@alien8.de>, "Randy Dunlap" <rdunlap@infradead.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, "Petr Mladek"
 <pmladek@suse.com>, "Feng Tang" <feng.tang@linux.alibaba.com>, "Kees Cook"
 <kees@kernel.org>, "Li RongQing" <lirongqing@baidu.com>, "Arnd Bergmann"
 <arnd@arndb.de>, "Askar Safin" <safinaskar@gmail.com>, "Frank van der
 Linden" <fvdl@google.com>, "linux-doc" <linux-doc@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>, "netdev"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec
 restore window
Message-ID: <20260202165320.7ddb25f8@kernel.org>
In-Reply-To: <19c16df6e07.5d6555571430461.7492468111934043630@linux.beauty>
References: <20260130145122.368748-1-me@linux.beauty>
	<20260130145122.368748-4-me@linux.beauty>
	<20260130170533.257db5fb@kernel.org>
	<19c16df6e07.5d6555571430461.7492468111934043630@linux.beauty>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,soleen.com,kernel.org,google.com,davemloft.net,redhat.com,linux-foundation.org,alien8.de,infradead.org,linux.intel.com,suse.com,linux.alibaba.com,baidu.com,arndb.de,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256053-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EC2ED3284
X-Rspamd-Action: no action

On Sun, 01 Feb 2026 09:44:27 +0800 Li Chen wrote:
>  > On Fri, 30 Jan 2026 22:51:19 +0800 Li Chen wrote:  
>  > > During a kexec-based live update, userspace may restore established TCP
>  > > connections after the new kernel has booted (e.g. via CRIU). Any packet
>  > > arriving for a not-yet-restored socket will hit the no-socket path and
>  > > trigger a TCP RST, causing the peer to immediately drop the connection.  
>  > 
>  > Can you not add a filter to simply drop those packets until workload is
>  > running again? It'd actually be less racy than this hac^w patch ...
>  >   
> 
> Thanks for the suggestion.
> 
> When you say "add a filter", do you mean installing a temporary drop rule
> (nftables/iptables/tc) in the network domain which does not get rebooted by
> kexec (e.g. LB/ToR/host firewall), so packets never reach the new kernel
> until the workload is restored and ready?
> 
> If you meant a filter inside the kexec'ed kernel, I'm worried it won't cover
> the critical window: kexec resets the ruleset, so we'd have to install the
> drop rule extremely early (initramfs) before any packets hit the no-socket
> path, which still seems inherently racy.

I'm not sure what your flow is exactly, but I assume you drive 
the workload restore from user space already?

