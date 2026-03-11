Return-Path: <netdev+bounces-266644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IZkN5hpsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:09:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E52642B8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9193030DA6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568102E4257;
	Wed, 11 Mar 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ddBrJh5K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2528507E;
	Wed, 11 Mar 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234487; cv=none; b=pirMBszawCXNK3gXZpU7/5Fsbwjhd6ADFJDS1wdk9KWFTCsSVFqgqKfzqwpkIXtxq8aH37AtG43paMRQD6mvpYFVWSWYqbtSwA9ETzuOYVefLNXtyNORRuRmkd1x2d0nIOgGBrRFQxEHWJqaH1bXKh1zZPvLpZAYBBgvYrkMQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234487; c=relaxed/simple;
	bh=8E+RklUDOEWGr3ASBSUDYmUqwJJzbYjGPEsS2dVw21c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOH2CapqnthCMvKe2byU5EarQI0cxHwWnu3JX0/VBKp6L84oyAGR/cBYGXz/YaR9Gm6lOfbDW8URtocf3AZCJHDZ/WIZjZukh+7/1F63WQXVH4xSNev83xp9cSRNjZTfkUU3LtcOV3q2M8kK+pXRTJ+wJFHkdt4gAKpNeoUetBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ddBrJh5K; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9TbZK983285;
	Wed, 11 Mar 2026 13:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=SrAeFWtveCtEjyE93SCzkC8c47nJq1JLGeA5lKkS2Y8=; b=ddBr
	Jh5KHnMGBWqk+k3l/jEWGCFQC2jacrZpcM/i4rdK1IoC9xUVz8RrlbC2azQq4Om7
	G/kHIsd2LhFgg7dv61Pbfo0LMHJDihuM1l5SmtUxVQMZFHX2szlZWZH6F0PdhPkk
	vPoRaMl71fxdSvTWoliuIIiDveOwrrUpQZOm5iFisHn9TIMKi0KyTD3iCz7lDa1t
	fSzdl2zVsrju3kzIOp3zbCy+GTCWU4krZ6+e+ZAyxxgGg42HJ+e2BGEdKmdaxPlX
	EL681UyCPZkyEyprR4lkAr7YpYrlZtrOuH8Znrzdp7fbjawQ15KLJV+s8vHP+snf
	X8eC+MRg932SktvdWA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cu5tf8nrq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:07:20 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Mar 2026 13:07:14 +0000
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
Date: Thu, 12 Mar 2026 00:07:11 +1100
Message-ID: <20260311130711.33966-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
References: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH013.crowdstrike.sys (10.100.11.83) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: CcdMPNc4NXEkZivWkmHMQ8qkEE15fTCU
X-Authority-Analysis: v=2.4 cv=ANV8z2x0 c=1 sm=1 tr=0 ts=69b16908 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pvr0aSInfWstAloVo1wA:9
X-Proofpoint-GUID: CcdMPNc4NXEkZivWkmHMQ8qkEE15fTCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfX/V+SIEDRrIH3
 h0B1M2lbaQBFT+v3Dg0wWy2BTGQXEZTuW7b4NDCsxWl9xb08kla2l2yZc+jVYgqzk9NpbOTtib0
 Z1cjWH3uaYHv6a8rH3HZENZfN6p7zb+gImb3xZTTwNGauYqJXGScdMmvYDY3ooMrVVV+bxpsdkD
 kAkJAtlyAd52JuIVeXHz72Gomb1C/fCy9lPL3I3Apl5clT2gPEdW6B60+oW4Wi/Pi5aR6in/Vaa
 roqtfC4f9FWbPvrGZR1HgdZT3sXt7SMBgERzyZ3cFbyhM4FYne/gL/24Xia+LtXt/qNI5QiYRIV
 nGHi4BAkHj6lP3dHxNxTnaFKYTGYqmsyN2qIxZdRQmuDBNstGVAEvOa2Un5BIXxpL/oNARiX7FI
 etg8So2gFqC4pRFdY0ahNWUS4kXKU4QxzCLmcgh1XGk7VOqPrEvh7ahMfYK1XB2gRH9HuJfYJQD
 oiMog9E2xIj+9qEZHpg==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11726
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110
X-Rspamd-Queue-Id: A17E52642B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,crowdstrike.com:dkim,crowdstrike.com:mid]
X-Rspamd-Action: no action

Tue, 10 Mar 2026 11:52:10 -0700, Eduard Zingerman wrote:
> [...]
> 
> > I verified whether PTR->FUNC, PTR->DATASEC, PTR->VAR can be passed to
> > btf_ctx_access() in the current mainline.
> > 
> > I added helpers that inject PTR->FUNC, PTR->DATASEC, PTR->VAR as pre or
> > post calls to btf_check_meta(). In all cases, the BPF program load
> > failed with errors "arg0 type FUNC / DATASEC / VAR is not a struct",
> > which indicates that btf_check_meta() can indeed be called with
> > PTR->FUNC, PTR->DATASEC, PTR->VAR.
> > 
> > If the condition for pointer check is changed to
> > `if (!btf_type_is_struct_ptr(btf, t))`, these BPF programs will load
> > successfully with arguments set to scalar().
> > 
> > Do we accept this change in behavior?
> 
> Kernel validates BTF before loading, see kernel/bpf/btf.c:btf_resolve().
> Validation is applied to kernel, module and program-level BTF.
> Does BTF containing PTR->DATASEC and PTR->VAR pass validation?
> If it does, validation should be updated to reject such cases.
> For PTR->FUNC, which one is legit PTR->FUNC or PTR->FUNC_PROTO?
> The legit one should be allowed and invalid should be rejected
> at validation phase.
> 
> You can craft invalid BTF as in the following selftest:
> tools/testing/selftests/bpf/prog_tests/btf.c.
> 
> [...]

Invalid BTF pointer types PTR->DATASEC, PTR->FUNC, PTR->VAR are
rejected by btf_ptr_resolve(), which is called through the sequence
btf_check_all_types()->btf_resolve()->btf_ptr_resolve().

PTR->FUNC_PROTO is a valid type.

vmlinux BTF is processed by btf_parse_vmlinux, which calls
btf_parse_base. Since btf_parse_base doesn't call btf_check_all_types,
it becomes possible to invoke btf_ctx_access with PTR->DATASEC,
PTR->FUNC, PTR->VAR in case of vmlinux BTF.

Modules and programs BTF are processed by btf_parse, which calls
btf_check_all_types and detects invalid pointer types, so
btf_ctx_access cannot see PTR->DATASEC, PTR->FUNC, PTR->VAR in
these cases.

If btf_check_all_types is added to btf_parse_base, invalid pointer
types get detected inside btf_parse_vmlinux, resulting in failure
to process vmlinux BTF and effectively disabling BPF. libbpf
returns this error:
libbpf: Error in bpf_object__probe_loading(): -EINVAL. Couldn't load
trivial BPF program. Make sure your kernel supports BPF
(CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big
enough value.

If vmlinux BTF is trusted not to contain invalid types like
PTR->DATASEC, PTR->FUNC, PTR->VAR, which seems reasonable, we can
conclude that btf_ctx_access will never observe these types.

Adopting the view that vmlinux BTF is consistent, we can replace
btf_ctx_access's condition for inferring scalar() for pointers
from "if (is_void_or_int_ptr(btf, t))" to
"if (!btf_type_is_struct_ptr(btf, t))".

Otherwise, we need to either check types for vmlinux BTF,
incurring additional cost, or use explicit checks for pointer types
that can be inferred as scalar by btf_ctx_access to exclude invalid
types. This would let invalid pointer types be rejected with an
error like "func 'bpf_fentry_test_invalid_ptr_func' arg0 type FUNC
is not a struct".


