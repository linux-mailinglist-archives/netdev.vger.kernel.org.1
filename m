Return-Path: <netdev+bounces-275103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBMJK0Laz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:18:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52785395B3A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 622083026586
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031E3C7DEC;
	Fri,  3 Apr 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AnlOnrpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683913C5558;
	Fri,  3 Apr 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229448; cv=none; b=iWnARop8h27yzFodaj67e0IMqoQ2WyIgGeS4TNFxsF8EtF7n+S3n+dPvE4tTXmFn562Bl2Ppd4q8V2g/palw3XQT+KtC9Y2EjaTbkje5l5EqshWUT5cEtnvrLaCCXRR7RNIi/qHuERYpA2KSFBLrXb3H82OSUfp5/sQlXsBYYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229448; c=relaxed/simple;
	bh=PY7nGMW4RIW4Bu4YiMdEX/an4i96Nd3s66V2fnrC0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGPdSYkpYHCt22mKCzGcVxCpyNjRoKw7+jqnHliB0Yvmz7SwzZFrNVM8+7weEwCPJV9g7oPU4zoDBq1v/DMvkfqNAXKJVpi4pVLf2AiFxyYk0kBI1D9SL0MIQMUWRKpkCfH9x0tdgbYWeHQvXxgOJ3+TZ5xjnQL9FtUtNsYM1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AnlOnrpF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 834D240E0163;
	Fri,  3 Apr 2026 15:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NkAatF0RFOQT; Fri,  3 Apr 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775229434; bh=wOjHFdJN9rNDh8e+lhwhZd95tC06NXIG29ivgD6QrBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnlOnrpFkOIt8FaYgWSTatnbjiqLpr+Ac6B22mE0MUn0wjMaVrpX6nIkQTxgLesb4
	 oRiFhgDQ+LrC8w4o9J/gmDehARehtBpZhUpC22AOATDS4TWUknDw+qks0rKCT6YUlS
	 NrJorkLv+T1+dSmYLJ963TThl8FMWr/5efClgJRWtxYBtC6mZLVKo1s3mA+RIVVqTj
	 ZDGB9hjZW3tQN7CCY6ZzDSUjJcs8lU8spppPnRoRgkED6qB8JDTM1MIWFB23VjMTg0
	 7BgLuW4+P5UQE2pDoIzW2qCkHw67cXxWZKegY+n9edq3fI79/VOYbjh1v9zQuKKZmo
	 KAC0Ox5+xm2xb3xoetKOPmO/PvL65iA4n2VR9UckQaNSOa8X7eWu5LJxm1BKcM/f49
	 z21vULe8V2ZivWHxb1SiNvGTL8uzq/2vX9Yz60CA9mdMlraCcmB7EYGr68BayWmacr
	 SjzJvBPRQoqA1e/0um0OO67YwSf8ZWz6IQkn37M5OZjurU7yM/WfubRXugEeG51rcn
	 o3CYgwUfDcVOjCOArNQJwLhV1NmsHbf24gZxSpelAAqhQw2Ed1SOcvsT3HZl9PkLk3
	 v9NGDIk9Vj9mMQIbAQ5fkl1DK2ovLhKnNxgk/Yp0/j/ojacfXW7riPMv3oPupFGXfd
	 vEew8VUnMQIKPCzZWRkXqWOs=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6D94B40E00DE;
	Fri,  3 Apr 2026 15:16:37 +0000 (UTC)
Date: Fri, 3 Apr 2026 17:16:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v9 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260403151630.GWac_ZzhQZj5LUDlRf@fat_crate.local>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-1-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-vmscape-bhb-v9-1-94d16bc29774@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275103-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52785395B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 05:30:47PM -0700, Pawan Gupta wrote:
> Currently, the BHB clearing sequence is followed by an LFENCE to prevent
> transient execution of subsequent indirect branches prematurely. However,
> the LFENCE barrier could be unnecessary in certain cases. For example, when
> the kernel is using the BHI_DIS_S mitigation, and BHB clearing is only
> needed for userspace. In such cases, the LFENCE is redundant because ring
> transitions would provide the necessary serialization.
> 
> Below is a quick recap of BHI mitigation options:
> 
> On Alder Lake and newer
> 
>     BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
>     performance overhead.
> 
>     Long loop: Alternatively, a longer version of the BHB clearing sequence
>     can be used to mitigate BHI. It can also be used to mitigate the BHI
>     variant of VMSCAPE. This is not yet implemented in Linux.
> 
> On older CPUs
> 
>     Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
>     effective on older CPUs as well, but should be avoided because of
>     unnecessary overhead.
> 
> On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> branch history may still influence indirect branches in userspace. This
> also means the big hammer IBPB could be replaced with a cheaper option that
> clears the BHB at exit-to-userspace after a VMexit.
> 
> In preparation for adding the support for the BHB sequence (without LFENCE)
> on newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> executed. Allow callers to decide whether they need the LFENCE or not. This
> adds a few extra bytes to the call sites, but it obviates the need for
> multiple variants of clear_bhb_loop().
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Jon Kohler <jon@nutanix.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S            | 5 ++++-
>  arch/x86/include/asm/nospec-branch.h | 4 ++--
>  arch/x86/net/bpf_jit_comp.c          | 2 ++
>  3 files changed, 8 insertions(+), 3 deletions(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

