Return-Path: <netdev+bounces-263498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNc5MIl7p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:23:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE31F8DF2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAFDE309E798
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7B2E975E;
	Wed,  4 Mar 2026 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="RuU2UnF3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935F78F26;
	Wed,  4 Mar 2026 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583765; cv=none; b=FUUK+sA+WntlJXGGu6JRI1eaqPkf7U1p2wD88s2q6RYt/cjTUgBlKtGweq05UUyTZ9g6yuuXvZGavpcDAg28gbWRXBG8jJBKAFBLdUVROMAPtaEO+5tRsY/Z3Zgsio/zO+vPf1Q9Cq7fjyMMp8qm8N+UWuWjYH9QgKWRMOfNJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583765; c=relaxed/simple;
	bh=cyPyITjOIQ+w4nb/esWCTjk5FOjvH6Vv86+Ke+w9EVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7mUba4FhLFeQ3oy1JIN8X3eubKuAUDJh7Ckreh1CAGHhsN/AQdwbJLJGOTXCoA3UAUiSRQl8FsuGHe+54V4ugEvxGb2lRZ2PhzdNcYvyc5prl9y86mFc389BVxhtBlIX1R7u3e1EXpbpqgyFPoCrllOm4K6uLsHpFxuc7UnF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=RuU2UnF3; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623LwOgY326039;
	Wed, 4 Mar 2026 00:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ekWIM9E9kc1Ni3hR6sXZDyEJD1clb0GI6ud6vNH/Jhc=; b=RuU2
	UnF3Gu+bmx99MHMh3PiogvMCITimegHyaJ6DIPRuolL0iMSSWoH7rOHhHvkMJbUx
	7w3qxs3zXDunxkkUp2n/H3C+R/Gf9yPooAyPcaCr9wz6/W8IC6FG/qVIz2rN8KGO
	fyCmiQbVydEGZ2WQ+e72BBL+4h7UfZ4Rzxd83kqdp6mawC86UMvyorCS5JDS+nE/
	8YZ+BsfZ+wu7Ejvi3bKfe4fm39L38/di2Ece5mGWF1EthmMniw2/mBxp1ldn4XiB
	qmiUDYGzs8GJkxaUSqk1dYIVQ2Yvqy7K14/5XXry8SNa07YZl/lDyvtEyQ8VmOop
	5pyypC+0n57SSt/5mA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwm4ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 00:22:13 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Mar 2026 00:22:08 +0000
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
Date: Wed, 4 Mar 2026 11:22:05 +1100
Message-ID: <20260304002205.15728-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
References: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMSBTYWx0ZWRfX2jd19+qCnQNp
 Ij1b/gi2N69liqYrKiFWbbiPh3ohp48lqgOViCgnlpbgF0VfibDzIZ502D+c+4JstCj65obY0z/
 rRM9YnmfCnM1EqbRpel4qhm0eONZL09kmtWNTWJGxqroLxEiq3vauC5bbXTQOBOMCb9719cEuWV
 c3/fQQwJmrwM7s9stSshCFQfjokPViV7PRZjg0SfnM7WR5gGZdGltioTiw7jh0Uk/TCn4T9A4kz
 1r+vOv+h1haRgZV5yNYPUcJjOAfOlkJ8GLtjlKfppKvyZ0SSIcACv6Rq+X2RG+cexuwieXA1bE+
 CrBA2aEnjSVnqdma5oAN4L6SX1eSW8gnZwNLBktzc/4QKqcXE557A0A102MoHTKmoAp34ogSBm1
 so4jjHprwvmxFVu1xiEK6GopvRItGTlBs046LIMUiEoEnAsHgbGhmn9By1nl/H5hkwXnuNdcn4B
 K7pHK5WHjKBw+1EfQFg==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a77b35 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=Y2iwlWk4ATm4TtG2QrYA:9
X-Proofpoint-GUID: r2rJt9ZL2zPYwzcdcQf4uACFP5Naam_M
X-Proofpoint-ORIG-GUID: r2rJt9ZL2zPYwzcdcQf4uACFP5Naam_M
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11718
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040001
X-Rspamd-Queue-Id: 3ECE31F8DF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263498-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 14:43:01, Eduard Zingerman wrote:
> On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> > On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
> >
> > > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > >               }
> > > >       }
> > > >
> > > > -     /*
> > > > -      * If it's a pointer to void, it's the same as scalar from the verifier
> > > > -      * safety POV. Either way, no futher pointer walking is allowed.
> > > > -      */
> > > > -     if (is_void_or_int_ptr(btf, t))
> > > > +     if (is_ptr_treated_as_scalar(btf, t))
> > > >               return true;
> > >
> > > I'm probably missing a point here, but what's wrong with Alexei's
> > > suggestion to do this instead:
> > >
> > >         if (is_ptr_treated_as_scalar(btf, t))
> > >                  return true;
> > > ?
> 
> Uh-oh, I copy-pasted the wrong snippet, sorry.
> The correct snippet is:
> 
>          if (btf_type_is_struct_ptr(btf, t))
>                   return true;
> 
> With it the selftests pass (except for `float` tests noted earlier).
> And regardless of selftests, the code below this point will
> error out if `t` is not a pointer to struct.

I think you tested with

	if (!btf_type_is_struct_ptr(btf, t))
		return true;

I decided on a narrower condition, as

- if (!btf_type_is_struct_ptr(btf, t)) -

changes the existing selection condition from "treat only these types
as scalar" to "treat as scalar any type that is not a pointer to
structure". Technically both approaches cover the problem I'm trying
to solve - multilevel pointer support for structures, but the latter is
open-ended and changes the current approach, which checks for pointers
to int and void. So I'm extending this to int, void, enum 32/64,
function, and corresponding multilevel pointers to these types and
multilevel pointers to structures.

It seems - if (!btf_type_is_struct_ptr(btf, t)) - works, but it's
challenging to strictly prove it's sufficiently future-proof.

> > This reflects my belief in a cautious approach: adding support
> > only for selected types with tests added for each new type. That said,
> > I can add the suggested broader condition and make it pass the tests,
> but I cannot be sure it will be future-proof against conflicts.
> >
> > I think the broader check like
> >
> >       /* skip modifiers */
> >       tt = t;
> >       while (btf_type_is_modifier(tt))
> >               tt = btf_type_by_id(btf, tt->type);
> >       if (!btf_type_is_struct(tt))
> >               return true;
> 
> btf_type_is_struct_ptr() is almost identical to the snippet above.
> 
> > might have some incompatibility with future changes, compared to
> > explicit type checks for selected types. This condition is
> > open-ended, including anything instead of selecting specific types.
> 
> What potential incompatibility do you expect?
> Two things change:
> - types other then `struct foo *` or `int` can be read:
>   - do you expect we would want to deny reading some ctx
>     fields in the future?
> - the value read is marked as scalar:
>   - not much can be done with a scalar, except for leaking it to
>     e.g. some map or ring buffer. Do you expect this to problematic?
> 
> Note that the above are selected based on type, not on the
> function/parameter combination, which is already not a very effective
> filter if some parameters need to be hidden.

I do not think any of these represent a real problem. As I said,
my approach is based mostly on narrowing the supported types to
reduce potential conflicts.

I do not have a good example of such conflicts.
The added tests for pointer to float, which failed with -
if (!btf_type_is_struct_ptr(btf, t)) - might be an example when adding
a new type might silently pass this check because of missing tests.

I  was not able to convince myself a conflict will not  happen.

That said, changing

	if (is_ptr_treated_as_scalar(btf, t))
		return true;

	to

	if (!btf_type_is_struct_ptr(btf, t))
		return true;

just makes the scope of these changes wider. This was
my initial approach to this problem, but I was worried
by its wide scope.


