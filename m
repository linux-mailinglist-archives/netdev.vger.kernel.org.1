Return-Path: <netdev+bounces-260208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IerFYnFnGnJKAQAu9opvQ
	(envelope-from <netdev+bounces-260208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:24:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225A17D8D7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E43E83008696
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98DC378829;
	Mon, 23 Feb 2026 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="qsPQtzzh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE43783D5;
	Mon, 23 Feb 2026 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881859; cv=none; b=EoCpUgjziJOMAmQ+qr9j7f05GDwJoLKSwUP6SX8VFwavK2ra5easCI+vuJzB/8+pNMVhJoMAB5a3Uh9OrkJeSlO5+jWC8bErsPC5pkDKZR7XU4d5bN53BObI67MfEOqp6qTwiRg0XsCHbbJyUBXGZeJCH4RyrCbq4ig66e2i0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881859; c=relaxed/simple;
	bh=WFrj/lZtqs44cNRXO4qgohbFideJk5QTDWmHS37c4M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBy6Gz7huGqGU0W0IqODo4e8/RiYlHnowKks3WnU8ruHzPqLfI6cO5Xq2ERKwiscrkRT5E9A+W+atj5KGTt1Ee+7MJu2hQM8ta4/qZavypcrcHj+B1v0wou4j4inka3m/g98Xz0RGGFQI2HT3CksXYGEAhmzfDIcWNuRk7uoMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=qsPQtzzh; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NK1R0Y2383293;
	Mon, 23 Feb 2026 21:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0RS5kT8l4nIEQijTO7RqJlylIQ0xrDRUlNZg5uAdP50=; b=qsPQ
	tzzheHgzelGIOpxGx39JE25DulziVfrSNTU5lo+Y6nCRCZaxqKz29DjllGUmQ90l
	eU7guzfqn4AysKwSu+juRsPwbMLTIwqVbyXhQg3LfuovXRNfPaVYzDhdnMq7y7hi
	g+/z0Uv3HZbuup1k89l+Llyt93EHdRXddfl9WqaWLOCsfb5PiytpuP5/AS4S69/S
	cT9PQ+niLmdLahfQxnjLzaqviJkJIvvAM7RmI2i1LZLLwexEp7Ljlh7ESETtT3zi
	11OeeKWk77kUTCLsMTyYLKFUkejakZOUYHd8mvI0kZinipNS3USyvSL8tp6nz4Jg
	vfCqwzUbAD3WKvsPbg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfry9psp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 21:23:43 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 21:23:36 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bot+bpf-ci@kernel.org>,
        <bpf@vger.kernel.org>, <clm@meta.com>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <eddyz87@gmail.com>, <edumazet@google.com>,
        <haoluo@google.com>, <horms@kernel.org>, <ihor.solodrai@linux.dev>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        <martin.lau@kernel.org>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: Re: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer params via SCALAR_VALUE for trampolines
Date: Tue, 24 Feb 2026 08:23:33 +1100
Message-ID: <20260223212333.11438-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAADnVQ+okfKHvKzCy9vLQkpevhvHMFXhincqmFOQX9zN_vtQyA@mail.gmail.com>
References: <CAADnVQ+okfKHvKzCy9vLQkpevhvHMFXhincqmFOQX9zN_vtQyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: CHbpyHajqq48QOwRSKalp0lbR_lxV-ko
X-Proofpoint-ORIG-GUID: CHbpyHajqq48QOwRSKalp0lbR_lxV-ko
X-Authority-Analysis: v=2.4 cv=b7u/I9Gx c=1 sm=1 tr=0 ts=699cc55f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=FujS-YLXLLbCOATfuAEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE4NSBTYWx0ZWRfX+5ixqzCHahBd
 YeWsrRYx9+ILBYLGHaTsEq0AfogXXHmkIiTiwGvmnlBn1ENVH5QrP+EdL0q/OpRSr6DAWkNhztT
 ZWwjZr9YyJd91xCXPL75S5FgJmY/Utnup+ht7MDXsh4aWKBLDBnmxcZ05dUlVjXD88JS9TdwHjY
 uMuzJPjcS0+mgm5S+xq2a7B1Kfz2Mc0adrm3jXJrNphUdE/0UaK5WWLExjfRmERMy5Z3RK6FC8R
 Qx+md0EBTPljlMIKdXTdHSgSjZO6ETwxr7YiTwnuj2llN6+TOBVcw5u5hjLt8LQV0OBUXkWwFrt
 P3d93K1sdLZZPcUsQf/hmP/Nf9QxUYGg0L7rvYFbfvraZXHqgTdxfmdoZuMXjd+xqExfdohFepy
 H6f9aMKs5K/rODcjn/K/Bdgbb7pOtEWqNK7urVF9bu+YSFmiL52T2nhaXHciCmHjFFx+KNsc5mD
 GMzZuKorcOy5xjThgHA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230185
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,crowdstrike.com,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260208-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7225A17D8D7
X-Rspamd-Action: no action

Alexei Starovoitov <ast@kernel.org> wrote:
> On Mon, Feb 23, 2026 at 2:48=E2=80=AFAM Slava Imameev
> <slava.imameev@crowdstrike.com> wrote:
> >
> > I think support for broader types can be provided in a compatible way
> > with future annotated support, as I explained in my reply to the v2
> > review:
> >
> > "
> >   > so I suggest treating 'void **' as a scalar as Eduard suggested.
> >   > This particular sb_eat_lsm_opts() hook
> >   > doesn't have a useful type behind it anyway.
> >   > I'm less certain about 'char **'. If we make it scalar too
> >   > it will be harder to make it a pointer to nul terminated string later=
> .
> >
> >   > So I would do 'void **' -> scalar for now only.
> >
> >   I changed to scalar in v3, keeping broader scope for pointer types.
> >
> >   We encountered double pointers of various types that required
> >   workarounds, such as:
> >
> >   int __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)
> >
> >   Adding support for void** alone doesn't address the broader issue
> >   with other double pointer types.
> >
> >   When annotated array support (including char**) is added in the
> >   future, it should remain compatible with the scalar approach for
> >   legacy (unannotated) parameters. Unannotated parameters will
> >   continue using scalar handling.
> > "
> 
> but then there is no need to relax it for double pointers only.
> 
> -       if (is_void_or_int_ptr(btf, t))
> +       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))
> 
> would make 'scalar' a fallback for anything unrecognized,
> and we can argue that making it smarter in the future
> maybe hopefully won't break progs.

I can increase coverage to anything that's not a pointer to structure.

I added support only for multi-level pointers of any type because
we needed workarounds for them in our development. This was the real
case we encountered in practice.

Multi-level pointers support appears to be a safe extension since any
future support for arrays and output values would require annotation
(similar to Microsoft SAL), which differentiates between current
unannotated scalar cases and new annotated cases.


