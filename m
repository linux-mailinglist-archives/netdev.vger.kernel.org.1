Return-Path: <netdev+bounces-301631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRv+GzrKO2q9dAgAu9opvQ
	(envelope-from <netdev+bounces-301631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:14:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD416BE075
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=YBmQz9P7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301631-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301631-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BEC30747AA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A032D0C62;
	Wed, 24 Jun 2026 12:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD026B2CE
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:12:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303157; cv=none; b=VTuubFUjm8fdfDxR5B/5K8cui2+hYoOh9k3dg8gFAwsBbP6Pj2lG5Fi7HW3DN5rcxasSi1cOkCmm9HnAW9+57oSKSlYioCsGaPgFJPgHErfb2sFi12bbEsIQ2PcELSuRZBDz8mEGteqR8lvdqXKlSkymX7DoQ5ZWt0K81h6Ebjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303157; c=relaxed/simple;
	bh=AzJxR17LeggvP5p8IUNi+OFv3fxzePdsrz0neVEdzNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hshZ1owo7zrvAF9btkLjWRRIokqltmqASWog9DyYzVX1WIaVISnIGClXKkjCIcJkzs7/EtcNuNbF5vpjT1hZycFxu+k/QrKBLqqijubjl0dYspFn5PyaroPv2su9jLCW1INFavaBTM5Go+OGmfpq4b8pY9g4Uwq5sQDA0Vg9/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YBmQz9P7; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso6478595e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782303154; x=1782907954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=myNo/DEuhpzwm5mdaD3SVg2ivdFiLyKElhtRgaxmzTc=;
        b=YBmQz9P7MESAmznHuEEsfTbHvQU3ktRHb2nh5qU4wapAvDODAG6yJnBxK7Oj+bG2qd
         ATtBtLnXC9DcgIvRsEwKQi2rxZRZgY+3j/yFlWmX+gWMtwhemagu6xukQL8cFtwqb+RX
         KCjB1tQ1pJxB5SXlWCwhHMHLer0uwdurErVe3TjeSyUTA7aIRmgLt5sy1woTw1UVlqXo
         y2l7Cu0APM4LBLWgk8oamz3VpODl6vt9zAgLGa5EfXiGU2iNvTS69Lmcy+weSqmw90yH
         B+BPM1aC6YAqgY3vcZqno5/II3RIvVCKeNwx9bTnfjun/asDcWz5jiYmcZjSIdcMRJey
         2qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303154; x=1782907954;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myNo/DEuhpzwm5mdaD3SVg2ivdFiLyKElhtRgaxmzTc=;
        b=ojAZtRN6KylM8dlPRx3YaEbC+E7luNi+hwE76/J341Xdkntbmf6EdltXy5n/YYroRP
         V6VDz4qg82Q70ei0WoWgkHDjhwhSy87/DpVLlxuPZ0f1a1KNmN/SQJu+PUwXH+V4JyJo
         iB0zlbJCimKF5XUrfbG8o6Ce+eUV8gwKEij/nIPONW4pPoMBWBVitGzbAi6b6xMwABcZ
         22/tF88IULJQfwLkMPzzqjkKEIfGPqtOUu2/1CYfHKvJZSGNni5P3PJIsVzidnMllT9w
         zZHvHy5AzsTVWKSXiNEfuBp/Nji4SeExxuPRJlODvdz/oqjG7KOnAUKkXFPnGh3FBZaS
         NU2g==
X-Forwarded-Encrypted: i=1; AFNElJ/RJLe5PAeWnjrb1VjwfBcLT4oItPjiWRoqaykFiF3CfVz+mPnoT7V8J6ZFaW74CE1mo+S9FGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ySR8d0n2xUcI3+xzWJQ2WXrYIuALfUJ9lRZCxjtJF29mhRIF
	VwfsZKSzX1nnNmR+ByDLrdGUi2HsBzdgaCnFOA/K6W1lwbybuZxBsKRk+zTD6kkcsVA=
X-Gm-Gg: AfdE7cnPxW4a57RvAFELAI5Jk6witdUAPhU1TtRtfhD17QwrzqRbTgaVaj8oT9sEe2v
	+sl6JJ92ofBT/P+oGje1Xgo/ionJ78FwfooW6H7RBJzSZ3uSJWawC0qJ01LBzGrQe4mwM0WMGWz
	X9WUdG3qCRjI0JTL20NKjtUmzhhL8CsFvOXhJGRz0FaZICkcOh+HqdhryO7nPivqJ4PjCtMQxC/
	oGRuXJ6903ULpnev76FebDRUDS1wk5d51f2gjVniMPGEpSD1s6UM8hfmWBUNXIVkwmlxHnKCoCu
	TdgldvYIHjPmLfMQZX3yd9nydqH+lWQTM0y2PYfP+fxMRpKmh/6QTPT9Ux/rMwYeY1JWRVVPK6F
	3xKBoTsSRV+AAw4x09n1unKB33pihRqrvtKp2XAZuPVJv4rW6CV1FfIXmlgvVGZdHUKSsfWbk0Y
	CiL4kCv2yHmQihCs9GlnJLptXbym2L/LTkTs6id3t0uoduGIwi
X-Received: by 2002:a05:600c:4899:b0:490:cb90:3e00 with SMTP id 5b1f17b1804b1-4926084b98emr28115875e9.14.1782303153562;
        Wed, 24 Jun 2026 05:12:33 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.67.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fbbdsm408926155e9.12.2026.06.24.05.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:12:32 -0700 (PDT)
Message-ID: <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>
Date: Wed, 24 Jun 2026 15:12:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 Jon Kohler <jon@nutanix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 David Laight <david.laight.linux@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,nutanix.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:pawan.kumar.gupta@linux.intel.com,m:x86@kernel.org,m:jon@nutanix.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend
 @gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nik.borisov@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nik.borisov@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBD416BE075



On 23.06.26 г. 20:33 ч., Pawan Gupta wrote:
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> in the kernel.
> 
> Now with VMSCAPE (BHI variant) it is also required to isolate branch
> history between guests and userspace. Since BHI_DIS_S only protects the
> kernel, the newer CPUs also use IBPB.
> 
> A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> But it currently does not clear enough BHB entries to be effective on newer
> CPUs with larger BHB. At boot, dynamically set the loop count of
> clear_bhb_loop() such that it is effective on newer CPUs too.
> 
> Introduce global loop counts, initializing them with appropriate value
> based on the hardware feature X86_FEATURE_BHI_CTRL.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Although AI brings up a valid argument about whether guests should be 
pessimized and fallback to the longer sequence ?

