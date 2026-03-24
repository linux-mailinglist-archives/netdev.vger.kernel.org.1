Return-Path: <netdev+bounces-271286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAeTAcXzwmnCnQQAu9opvQ
	(envelope-from <netdev+bounces-271286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:27:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF231C529
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A040C30D6A46
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E034BA59;
	Tue, 24 Mar 2026 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ettfU/uu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2F34B1A2;
	Tue, 24 Mar 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383826; cv=none; b=CodLeCceSvt9XpIgZzJTHNDGon2Vwt2WvILEf5OtJ4We5K5X3vnkB9JevTOsX33enaOISAg5oSc1MXHrGGM+Hkkyx+KPRbnS8t4OWgQDOd/18XG8W/vmg5A6hGnlQPmWtHm75ZzRnQw8LWbDyefb1QvueiKvESgUzq8v4av1lYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383826; c=relaxed/simple;
	bh=hbHTNE7uREm5odOQ+koTpmTbtR76JskCXNGS0f3aciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Ghr4CvgCXWzLew+0SsCIMGkWGzgCpePpvrFZn/MyP93bGQAr8sLqf8huuEM509Vr8bu6VrCUEfkM+3IWEParMXRZKmVfnEuziK/Y5XuJy2kmtuv3y8JxO1qk9UITJl8Mu44xnxmNEHmb6eicqtMqvLH6nN9MMHKvfwHaDNDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ettfU/uu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C7A840E0031;
	Tue, 24 Mar 2026 20:23:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ol6Y8k04vraC; Tue, 24 Mar 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774383816; bh=RdkeB94q0Z065/z1sJMpQHnVOxllUhhxrHQIGMNsNsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ettfU/uuXe9j+IfVfvXYvreDKXOXuo9kIRE/C++N8krw1khc17Ado9iio1nT6uaCS
	 w0YfJRfq3B7BBhn2DLxdJED2Iwoa2cqEHkBxS3y0LuRy3Y0BaXDehqDzHI5gxsMPst
	 onPsiIv46QMig2VxQ3jptcRQ3TXkvvNRvmgIDmXcIzaWnCnAhSaFLLMNXbHd/gzD2t
	 qK1BD7Cr+h8VW91Htbwvmqpy/VfUPpO0k4hTxa4hLkTQiw7AXGr0UxlmtzwDW2Gg0l
	 r8QHpiZo1p5RTyxJW+9I+9rxudbmRV5NCx2IORCU0q8YmJRu7ZkO01juMBwpKAyuHD
	 H+iW7+nQBlXYuGuk2ldqveYRmSpqu3fCDTlpcLF4CIMKv8hipSMrKCqVduH0BioB8V
	 8FO/ifZxdeWXh2w7Lk6xPry36GtZXzr44/v4RzAkGLLpzHO1j/7JtK8NtkembwhY2E
	 2590uGCEZCZ9EyNDQfRlgFT/o2e/5YQDSPgJZMVhqrzbicHdhzTdBC2TNA7Mm7fYzQ
	 ERrcwu4WvQrqF1Y+BPXFgn5Fr2/N6D5O+p8VDVuLmJ/Z2zcQ7lCyrtUVQIN+Oa9HA+
	 qmfTiBBssAs6/lmfqi6Gs4iinh6Rq87P0bsVCFHcewiEdESPQlbp/bp1SVOzfe0uvR
	 1+oSE9AgY8FWAP3FHBtg6gCs=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D270B40E0163;
	Tue, 24 Mar 2026 20:22:58 +0000 (UTC)
Date: Tue, 24 Mar 2026 21:22:51 +0100
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
Subject: Re: [PATCH v8 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260324202251.GPacLym_7HV9IBbLaz@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-1-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324-vmscape-bhb-v8-1-68bb524b3ab9@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271286-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A1BF231C529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:16:36AM -0700, Pawan Gupta wrote:
> Currently, BHB clearing sequence is followed by an LFENCE to prevent
> transient execution of subsequent indirect branches prematurely. However,
> LFENCE barrier could be unnecessary in certain cases. For example, when
> kernel is using BHI_DIS_S mitigation, and BHB clearing is only needed for
> userspace. In such cases, LFENCE is redundant because ring transitions
> would provide the necessary serialization.
> 
> Below is a quick recap of BHI mitigation options:
> 
>   On Alder Lake and newer
> 
>   - BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
> 	       performance overhead.
>   - Long loop: Alternatively, longer version of BHB clearing sequence
> 	       can be used to mitigate BHI. It can also be used to mitigate
> 	       BHI variant of VMSCAPE. This is not yet implemented in
> 	       Linux.
> 
>   On older CPUs
> 
>   - Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
> 		effective on older CPUs as well, but should be avoided
> 		because of unnecessary overhead.
> 
> On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> branch history may still influence indirect branches in userspace. This
> also means the big hammer IBPB could be replaced with a cheaper option that
> clears the BHB at exit-to-userspace after a VMexit.
> 
> In preparation for adding the support for BHB sequence (without LFENCE) on
> newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> executed. Allow callers to decide whether they need the LFENCE or
> not. This adds a few extra bytes to the call sites, but it obviates
> the need for multiple variants of clear_bhb_loop().

Claude, please add proper articles where they're missing in the above text:

"Currently, the BHB clearing sequence is followed by an LFENCE to prevent
transient execution of subsequent indirect branches prematurely. However, the
LFENCE barrier could be unnecessary in certain cases. For example, when the
kernel is using the BHI_DIS_S mitigation, and BHB clearing is only needed for
userspace. In such cases, the LFENCE is redundant because ring transitions
would provide the necessary serialization.

Below is a quick recap of BHI mitigation options:

On Alder Lake and newer

    BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
    performance overhead.

    Long loop: Alternatively, a longer version of the BHB clearing sequence
    can be used to mitigate BHI. It can also be used to mitigate the BHI
    variant of VMSCAPE. This is not yet implemented in Linux.

On older CPUs

    Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
    effective on older CPUs as well, but should be avoided because of
    unnecessary overhead.

On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
branch history may still influence indirect branches in userspace. This also
means the big hammer IBPB could be replaced with a cheaper option that clears
the BHB at exit-to-userspace after a VMexit.

In preparation for adding the support for the BHB sequence (without LFENCE) on
newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
executed. Allow callers to decide whether they need the LFENCE or not. This
adds a few extra bytes to the call sites, but it obviates the need for
multiple variants of clear_bhb_loop()."

Reads proper to me. Use it for your next revision pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

