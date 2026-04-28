Return-Path: <netdev+bounces-282090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HBDJsYo8WmteAEAu9opvQ
	(envelope-from <netdev+bounces-282090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:38:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281648C5B7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC69304B34B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DA3C6606;
	Tue, 28 Apr 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BKpyABXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23853B8D4A;
	Tue, 28 Apr 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412284; cv=none; b=RlSR1lG4oWMoP5AIDU9O27xXke7c+vYVGrqXwslZF6YRl0zYoW3qAIvg5HEzU+QVU4wnfNYkC1ZqwoEsY9YrSMpjK2CyZ7M+gfiRPGFCqR89jRs7i3JAPVR+aZw0TcPYGMttY8xWAR3xj794rchSNuONmbIQufV32NXwXafl51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412284; c=relaxed/simple;
	bh=3DHxrurPMXhWs/+VFuk5zRg5OApGCHvlQgCxsQ6X7vM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=aIjr5uI1rhGCOJmtyaxNULWLg2bdjl3c3hyktUD8bSQMJeE/0v0jTbasvz4uv44ZmHLba9x6jjfoPFQLG4R4oheCIpm5fIh9J+m+bQ554xXKE3pIknP8Ih0jPiScB23uSG4Hk8kOGCr+mrP6dxzqHW84lp84YcbkMSZeh9eW8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BKpyABXY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4CDAD4E42B64;
	Tue, 28 Apr 2026 21:37:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E94DD601D0;
	Tue, 28 Apr 2026 21:37:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 049BC1072939F;
	Tue, 28 Apr 2026 23:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777412276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m2SIkG8G4dme99QjBJF700FHzCmI2Nw1YXi++Sm72C8=;
	b=BKpyABXYUA3W1yBGbOawA4h4lg+xP/ujDg9fnM/GDmfVvQtFe4V86zv2jRnYLbIW85egeu
	gzsW7by84jCsCEyDe38rcP0G9Lu0O5PyhiJVlX1VH0lqEiLpLLVqCPQ6zb2WFjm+11Eb5Y
	n8RhoTuzI6NlP3mUu2V0iIjtY0wmrD64vrUUDjJFf8c9e/GfSIul/+IfTbDMPsSiDwMCw7
	iSMV2XUHFoLSDmaAwdjiKsMThFnyCYBB9t0d5djhof0yNcYWt/373RotXiqc8RA8Tj6M7F
	lFivzfSQqW2W19Ln1HG5awMplQ6C4gwNMrAWCyzv+PL9twiFGEXnUYVU/us/rQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 23:37:43 +0200
Message-Id: <DI5429HR7UGP.IJHX75ZB16AZ@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing
 program stack
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-2-1a5831230821@bootlin.com>
 <7dd64547-25a4-46de-a896-98fcec04468e@linux.dev>
In-Reply-To: <7dd64547-25a4-46de-a896-98fcec04468e@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5281648C5B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282090-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linux.dev,bootlin.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url]

On Sat Apr 25, 2026 at 1:18 AM CEST, Ihor Solodrai wrote:
> On 4/13/26 11:28 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> In order to prepare to emit KASAN checks in JITed programs, JIT
>> compilers need to be aware about whether some load/store instructions
>> are targeting the bpf program stack, as those should not be monitored
>> (we already have guard pages for that, and it is difficult anyway to
>> correctly monitor any kind of data passed on stack).
>>=20
>> To support this need, make the BPF verifier mark the instructions that
>> access program stack:
>> - add a setter that allows the verifier to mark instructions accessing
>>   the program stack
>> - add a getter that allows JIT compilers to check whether instructions
>>   being JITed are accessing the stack
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>>  include/linux/bpf.h          |  2 ++
>>  include/linux/bpf_verifier.h |  2 ++
>>  kernel/bpf/core.c            | 10 ++++++++++
>>  kernel/bpf/verifier.c        |  7 +++++++
>>  4 files changed, 21 insertions(+)
>>=20
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index b4b703c90ca9..774a0395c498 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1543,6 +1543,8 @@ void bpf_jit_uncharge_modmem(u32 size);
>>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
>>  bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, co=
nst struct bpf_prog *prog,
>>  				 int insn_idx);
>> +bool bpf_insn_accesses_stack(const struct bpf_verifier_env *env,
>> +			     const struct bpf_prog *prog, int insn_idx);
>>  #else
>>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>>  					   struct bpf_trampoline *tr,
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index b148f816f25b..ab99ed4c4227 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -660,6 +660,8 @@ struct bpf_insn_aux_data {
>>  	u16 const_reg_map_mask;
>>  	u16 const_reg_subprog_mask;
>>  	u32 const_reg_vals[10];
>> +	/* instruction accesses stack */
>> +	bool accesses_stack;
>>  };
>> =20
>>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF pro=
gram */
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 8b018ff48875..340abfdadbed 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1582,6 +1582,16 @@ bool bpf_insn_is_indirect_target(const struct bpf=
_verifier_env *env, const struc
>>  	insn_idx +=3D prog->aux->subprog_start;
>>  	return env->insn_aux_data[insn_idx].indirect_target;
>>  }
>> +
>> +bool bpf_insn_accesses_stack(const struct bpf_verifier_env *env,
>> +			     const struct bpf_prog *prog, int insn_idx)
>> +{
>> +	if (!env)
>> +		return false;
>> +	insn_idx +=3D prog->aux->subprog_start;
>> +	return env->insn_aux_data[insn_idx].accesses_stack;
>> +}
>> +
>>  #endif /* CONFIG_BPF_JIT */
>> =20
>>  /* Base function for offset calculation. Needs to go into .text section=
,
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1e36b9e91277..7bce4fb4e540 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3502,6 +3502,11 @@ static void mark_indirect_target(struct bpf_verif=
ier_env *env, int idx)
>>  	env->insn_aux_data[idx].indirect_target =3D true;
>>  }
>> =20
>> +static void mark_insn_accesses_stack(struct bpf_verifier_env *env, int =
idx)
>> +{
>> +	env->insn_aux_data[idx].accesses_stack =3D true;
>> +}
>> +
>>  #define LR_FRAMENO_BITS	3
>>  #define LR_SPI_BITS	6
>>  #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
>> @@ -6490,6 +6495,8 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>>  		else
>>  			err =3D check_stack_write(env, regno, off, size,
>>  						value_regno, insn_idx);
>> +
>> +		mark_insn_accesses_stack(env, insn_idx);
>
> I am not sure this can be done unconditionally here.
>
> It may be possible in different states to have different pointer
> types for the affected reg (PTR_TO_STACK in one execution path and say
> PTR_TO_MAP_VALUE in another). And if set uncoditionally,
> instrumentation may be skipped for legitimate targets.
>
> Maybe reset by default in check_mem_access()?

Hmm, ok, thanks, I missed this subtlety. I still need to dig in there to
make sure to really understand how the verifier handles those states,
but if I understand correctly your point, I guess that just resetting
the "accesses stack" flag at the entry of check_mem_access is not
enough: it would make the final result depend on the order of the states
being checked, eg:
- first state being checked result in PTR_TO_MAP_VALUE, no flag set
- second (and final) state being checked result in PTR_TO_STACK, flag is
  now set
- if no other state: insn ends up being (wrongly) marked to be ignored=20

So unless I am misunderstanding things here, the question rather becomes
"for this specific insn, is there any state in which the accessed memory
is anything else other than PTR_TO_STACK". The flag could just be
inverted (ie set to true by default), and reset by any state resulting
in something other than PTR_TO_STACK.

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


