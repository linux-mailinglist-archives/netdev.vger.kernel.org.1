Return-Path: <netdev+bounces-271270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IRHCfbtwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:03:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31E31C0C3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E023077D1B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB062D94BA;
	Tue, 24 Mar 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AmcOTFso"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E92D0635;
	Tue, 24 Mar 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382478; cv=none; b=rVggVaqFMxaGpL9Vm/GRhZ5QbqulXtYeEG9OfbPpnsGYcUWwMj5c1r/T6OkTV/cReDSZo2IRGOkJ/NGCVqtfP0Q2pCypcAWMP3KOwCiK9cStbNcph3wGnkJ5RLxeLR9qNK0E7lVhv5jKS63ROXDTOljLRcpHOl1donPuWRMVdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382478; c=relaxed/simple;
	bh=MPwNHSpoYjyM16ewI+BxbAdvmJMpRdZDXK7CwZ6QIDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JszMo7icXkoI528blbv37+KOdUPAFRqyG7/9IkaQuVv5x96MSOZMa3gSOnh5qN7mD+2H29wOwcKu/CLBJn3Cl7Czl95kHz5cQGH2wqnmj3AOv0AcLSQ5V0uJvZNjwWVlHxS+/KDpoZbRfWOfO8UU3S5FQwz76E7as0nng1au57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AmcOTFso; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8045540E0222;
	Tue, 24 Mar 2026 20:01:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vXkONk_xMsOw; Tue, 24 Mar 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774382463; bh=rrltVfsKaUOz3jKzbq8S1z1BNCaZvfoi0wgXPux+LGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmcOTFsokQCadYhgaodHohkOM+Z+rHYntVaJXympYseSn0bmHzpYLQwX3qjT7BO6V
	 Z6n/zj11uUN3AJXlC8IC9gNJoR2Ukj6qmiI+ysggCuy4t+MrUfJytvpXCwzJSb5PtW
	 ov8I1VmsRIj/fKyefGm7/GkvSzS/mRAPFAoo0VQJK68LX1SO+otT0BX8MQMCCVO3Of
	 7IlSJtnEtuG9RAOWrviSHwm5ciQsS4o8S5CFGpZrQmqcav3px84M7InZF3+mph25nG
	 HPnPlbwaBfj3RNcPuPzBQo/SSzB6C47ArYDzCckZsrU4lY83D3G7bNv8W1RKuMOZsq
	 Hpfhsv+RV+9+jc90O22I+5ltALhblGl4gEfBNUxBzBVtzh6Dei40gfEBxOgkTcyJix
	 NyVAb1KE50NWOBJdXfEiMghOacFkk4/fOrQfHaXTCwHHl5zSuh9mDFU+m50dLyvxjt
	 jngde1ZkfG6vChR3De2mnBZgrFz/3LUgc3HR0i9LLo2dOtrjSkA+/lX4xQRaZ/a7eq
	 XTcPYn8vIK/HvYwYGfYjzmPk8iTNjc39InYjK7AJ/luScpkVfEy4XsAFaKIbn6MNRv
	 1quh2qbNUCh+aawylKNXtU6eqxyluGDqHcdRgnjnyCGWD8TbH38IIbOyo1bwWtgAw+
	 asPjanKnk6HRhk9DezGoMurk=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5730B40E0031;
	Tue, 24 Mar 2026 20:00:27 +0000 (UTC)
Date: Tue, 24 Mar 2026 21:00:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260324200026.GCacLtWmhGVOmz832E@fat_crate.local>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
 <20260320062206.bdrnmnvho6lhmejw@desk>
 <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
 <20260320113134.GAab0wFqe-hewZc175@fat_crate.local>
 <20260320182308.ahynqzuswlv34wf6@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320182308.ahynqzuswlv34wf6@desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271270-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,suse.com,zytor.com,amd.com,google.com,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Queue-Id: 7D31E31C0C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:23:08AM -0700, Pawan Gupta wrote:
> I am curious, what problems do you anticipate? There are nearly 50

What's easier when you need to change the underlying implementation: unexport
the static key and touch a bunch of places in the process or simply change the
accessor's body and all the callers don't notice a thing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

