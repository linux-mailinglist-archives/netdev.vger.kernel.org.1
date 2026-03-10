Return-Path: <netdev+bounces-266122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD9SCCgesGlBgAIAu9opvQ
	(envelope-from <netdev+bounces-266122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2F250736
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92EE347673C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0F3BC664;
	Tue, 10 Mar 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="vbwNsLxe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBF38D696;
	Tue, 10 Mar 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145058; cv=none; b=JiDwH9zWZzFXyuC3+2z7R3ir84ZzQI/IQNpCAOU1mgUmmFt5h8/Gb8cw7shhfbsrXLaa5PNXnWEKvhKfTEzrjfA/WuGy9RMWhutwxZYOP1ov7g2V8OLmTf3ljZXE7im4+1y9bgFNUgMsBSRcwIy6lhuQc2oOpk0nVm1NykHcDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145058; c=relaxed/simple;
	bh=MVAorFwASedMUQdlRsrssouaBR0ncU3LBy/pU1ACdEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoBGbbiTxHc6/ha/+cPa8bL84EbMhPBl2tj1ukceK/fT611UV57vg694Hk/qZK62HbVmPR7amlEKFn59yPlHJ0M6+XLtpxCacNqhcE+LV9MQzYSbWNlTz3jciiN+8pfKYSJt3EwoOglAx8e69KHz8kM9ENw7in3uVv8Ko9AwZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=vbwNsLxe; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8xuEP1367922;
	Tue, 10 Mar 2026 12:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yrMvraipRnMkORyFOvU3Oml7ZdrKvDGYUgiDs6XOkFs=; b=vbwN
	sLxeQCoYwp2+OIKQEb6fM8s74m428M3b6xQE/hdMH8DWNdF/0rujZdIzzYN7BNlZ
	DgM3HGyuwpPqdmXFo7jTctibYCfFKFZG8xfRvUM/Bj4rTGRvwViZpsyy4vQ8c7rC
	zG3BY1dBAupoUYtwQDqOJtFZ9pZkip0PipUomd6zFrUlAmPfnt4selycLA3xc0P5
	mmfa4BlX9msvS819il1sXqauwof9L3EiDd1Sn+22meSKI4kXxK3l5dnubg2h2ep0
	5GndgMluRofoWgsOrl3lrrzBHXkDMbrtWsW582RXClwPXV9+ULgrTMIz4qeWywju
	HEPqV5FlNGC5d1Vz0w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4crxykgynp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 12:17:07 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Mar 2026 12:17:01 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <eddyz87@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <haoluo@google.com>, <horms@kernel.org>, <john.fastabend@gmail.com>,
        <jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types via SCALAR_VALUE for trampolines
Date: Tue, 10 Mar 2026 23:16:59 +1100
Message-ID: <20260310121659.25801-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
References: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: muf0gwpN1ymRFua10pBAXBtTyZj5PPg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwNiBTYWx0ZWRfX9rflOR7IFCrl
 21yIma0F3kFVahtBclWfwzZlWpUjCPemhbo/tINRuUODJLKM+FFZdufvJxZmhCfLNOKz46+BCTP
 SjqGpRntpcuue3NTMs50t9Sb1MxWM/XKdZEsdiM3x9pSTVawLZjDlD6YBFTFsrQQn2zubbYGPmP
 ZeuSGKGWkNlItQfF/iCwEGTCZnly7pkNEmlV0hJYGwklx2BvewIyOotQZnI+UPFnpDHLTlGn/vU
 xP3vTU73KcLUcnmeAZ9jAILPjun090IzM2PmPUiI9eUnvDdAA6cwXxT4CE7PB17wQX9KkP9Qs0Q
 RNpLsNNsUV3+kYhILzU2r8VeapNUzcA4/Y9wik+aTGLlPwD4ztcZGnCxIs+BCB6Bge3zkxMpCGh
 qtk3cmtTeENZKA2Jo8Z3eq4qq4IJGAiOr9tx0y5toBQPzV0QXBpaTwB8vCliWD85mr/GCte3DvI
 rEvRpIT7V1YESrV51Jw==
X-Proofpoint-ORIG-GUID: muf0gwpN1ymRFua10pBAXBtTyZj5PPg1
X-Authority-Analysis: v=2.4 cv=M7FA6iws c=1 sm=1 tr=0 ts=69b00bc3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=NEAV23lmAAAA:8
 a=3kasHXYAN1gmPJuvoZgA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11724
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100106
X-Rspamd-Queue-Id: 96C2F250736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:dkim,crowdstrike.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 16:38:57 -0800, Eduard Zingerman wrote:
> On Wed, 2026-03-04 at 11:22 +1100, Slava Imameev wrote:
> > On Tue, 03 Mar 2026 14:43:01, Eduard Zingerman wrote:
> > > On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> > > > On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
> > > > 
> > > > > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > > > >               }
> > > > > >       }
> > > > > > 
> > > > > > -     /*
> > > > > > -      * If it's a pointer to void, it's the same as scalar from the verifier
> > > > > > -      * safety POV. Either way, no futher pointer walking is allowed.
> > > > > > -      */
> > > > > > -     if (is_void_or_int_ptr(btf, t))
> > > > > > +     if (is_ptr_treated_as_scalar(btf, t))
> > > > > >               return true;
> > > > > 
> > > > > I'm probably missing a point here, but what's wrong with Alexei's
> > > > > suggestion to do this instead:
> > > > > 
> > > > >         if (is_ptr_treated_as_scalar(btf, t))
> > > > >                  return true;
> > > > > ?
> > > 
> > > Uh-oh, I copy-pasted the wrong snippet, sorry.
> > > The correct snippet is:
> > > 
> > >          if (btf_type_is_struct_ptr(btf, t))
> > >                   return true;
> > > 
> > > With it the selftests pass (except for `float` tests noted earlier).
> > > And regardless of selftests, the code below this point will
> > > error out if `t` is not a pointer to struct.
> > 
> > I think you tested with
> > 
> > 	if (!btf_type_is_struct_ptr(btf, t))
> > 		return true;
> > 
> > I decided on a narrower condition, as
> > 
> > - if (!btf_type_is_struct_ptr(btf, t)) -
> 
> Yes, sorry again.
> 
> > changes the existing selection condition from "treat only these types
> > as scalar" to "treat as scalar any type that is not a pointer to
> > structure". Technically both approaches cover the problem I'm trying
> > to solve - multilevel pointer support for structures, but the latter is
> > open-ended and changes the current approach, which checks for pointers
> > to int and void. So I'm extending this to int, void, enum 32/64,
> > function, and corresponding multilevel pointers to these types and
> > multilevel pointers to structures.
> 
> BTF is defined for the following non-modifier types:
> - void        [allowed already]
> - int         [allowed already]
> - ptr         [multi-level pointers allowed by your patch]
> - array       [disallowed?]
> - struct      [single level pointers allowed already,
> - union		   multi-level allowed by your patch]
> - enum/enum64 [allowed by your patch]
> - func_proto  [allowed by your patch]
> - float       [disallowed]
> 
> And a few not reachable from function fields (I think BTF validation
> checks that these can't be met, but would be good to double-check.
> If it doesn't, it should):
> - func
> - var
> - datasec
> 
> So, effectively you disallow reading from tracing context fields of
> type: struct (non-pointer), array, float and a few types that can't be
> specified for struct fields.
> 
> Does not seem necessary, tbh.

I verified whether PTR->FUNC, PTR->DATASEC, PTR->VAR can be passed to
btf_ctx_access() in the current mainline.

I added helpers that inject PTR->FUNC, PTR->DATASEC, PTR->VAR as pre or
post calls to btf_check_meta(). In all cases, the BPF program load
failed with errors "arg0 type FUNC / DATASEC / VAR is not a struct",
which indicates that btf_check_meta() can indeed be called with
PTR->FUNC, PTR->DATASEC, PTR->VAR.

If the condition for pointer check is changed to
`if (!btf_type_is_struct_ptr(btf, t))`, these BPF programs will load
successfully with arguments set to scalar().

Do we accept this change in behavior?

Test case with invalid BTF types injection:
https://github.com/slava-at-cs/bpf/commit/c49af6500ace4e4aceee01c570e3b067aae7e48c

Branch:
https://github.com/slava-at-cs/bpf/commits/inject-invalid-btf/

To run test:
./vmtest.sh -- ./test_progs -t verifier_btf_ctx_access

The verifier log:
=============
0: R1=ctx() R10=fp0
; asm volatile ("					\ @ verifier_btf_ctx_access.c:85
0: (79) r2 = *(u64 *)(r1 +0)
func 'bpf_fentry_test_invalid_ptr_func' arg0 type FUNC is not a struct
invalid bpf_context access off=0 size=8
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
=============

=============
0: R1=ctx() R10=fp0
; asm volatile ("					\ @ verifier_btf_ctx_access.c:85
0: (79) r2 = *(u64 *)(r1 +0)
func 'bpf_fentry_test_invalid_ptr_func' arg0 type DATASEC is not a struct
invalid bpf_context access off=0 size=8
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
=============

=============
0: R1=ctx() R10=fp0
; asm volatile ("					\ @ verifier_btf_ctx_access.c:85
0: (79) r2 = *(u64 *)(r1 +0)
func 'bpf_fentry_test_invalid_ptr_func' arg0 type VAR is not a struct
invalid bpf_context access off=0 size=8
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
=============

