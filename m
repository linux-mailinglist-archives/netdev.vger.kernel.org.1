Return-Path: <netdev+bounces-251684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJnINfErcGniWwAAu9opvQ
	(envelope-from <netdev+bounces-251684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:29:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 863294F17B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0DF0724C1D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D4305E1F;
	Wed, 21 Jan 2026 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkfhhh5M"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E802D2382
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958958; cv=none; b=nu1eJwKMYkCrDg1nn6kHBM3JC62HxTBn4CFvmJ/rKPUzcKvg+6c9ycoSv4QPPtovHBHE6+D/mrdwk5ZEYNahweeVeLM6CFRAcm2YVHD1o6L/nCJBugOND1ciL6ptrrTrDIp4Pe+aS8pwDPa88PGeZDIbG3XASRhBLUYxEKFu4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958958; c=relaxed/simple;
	bh=Yz74SklOzFUHbvFKVoxkVGq/W4W+oC0JAJszJhLM70M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhKCz15eXNg/82+cQ5i+uuvwT+N9JrJhvRdS7IjRZJTlvW8NMwao+qsaOLOJIqNJ3HjbA88UrGI3yl/Y25n3pKfcewnICSo4sJH3wkbg/8W7C8r8ZGVtKRN5NyRfP7k9ZwTpru4M6KIZtiZB7lrIpLDmqJZPTQ06tVNH/+yucno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkfhhh5M; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768958944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riHSXXsr4HU9SoADhAYRMOD4/ov9LwqJ/Epgtx0shhg=;
	b=kkfhhh5M3jjX95XEKB8TyaXR6acnQdVVLs3ji0ZioAPV1z/RT6BqWa2lpGfe+lAFio7vu9
	AT60hAuKcfcDbZWm4VYjB6+CV2SppRhSWveM/9KpLWRaNNCA5CMaR47SyZ2KTXQrY3uvPw
	stZf8l2yrDsPcFrwPTj+IwYXSoSGMoI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
Date: Wed, 21 Jan 2026 09:28:41 +0800
Message-ID: <5071056.31r3eYUQgx@7940hx>
In-Reply-To:
 <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
References:
 <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-3-dongml2@chinatelecom.cn>
 <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251684-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:dkim,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 863294F17B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/1/21 09:05 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > Add the testcase for the jited inline of bpf_get_current_task().
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v6:
> > * remove unnecessary 'ifdef' and __description
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
> >  .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inli=
ne.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index 38c5ba70100c..2ae7b096bd64 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -111,6 +111,7 @@
> >  #include "verifier_xdp_direct_packet_access.skel.h"
> >  #include "verifier_bits_iter.skel.h"
> >  #include "verifier_lsm.skel.h"
> > +#include "verifier_jit_inline.skel.h"
> >  #include "irq.skel.h"
> >
> >  #define MAX_ENTRIES 11
> > @@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_b=
its_iter); }
> >  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> >  void test_irq(void)                          { RUN(irq); }
> >  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
> > +void test_verifier_jit_inline(void)               { RUN(verifier_jit_i=
nline); }
> >
> >  static int init_test_val_map(struct bpf_object *obj, char *map_name)
> >  {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/=
tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> > new file mode 100644
> > index 000000000000..4ea254063646
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +__success __retval(0)
> > +__arch_x86_64
> > +__jited("      addq    %gs:{{.*}}, %rax")
> > +__arch_arm64
> > +__jited("      mrs     x7, SP_EL0")
>=20
> I was confused to see this, as your patch actually implements inlining
> only on x86-64. And then it turned out that on arm64 we inline this in

Yeah, the arm64 implemented it already. And I add the testing for it
BTW.

> JIT. But Eduard also noticed that we actually SKIP this test on arm64
> because of missing LLVM dependency, so that's not great.

Do you mean that the CI of arm64 doesn't use LLVM for the selftests?
I noted that. I found that there are other similar "__jited" testings for
arm64, is there anything we can do?

PS: I tested the arm64 locally, and it works fine.

>=20
> So we should do something about silently skipped tests at least...

Like a warning?

Thanks!
Menglong Dong

>=20
> > +int inline_bpf_get_current_task(void)
> > +{
> > +       bpf_get_current_task();
> > +
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.52.0
> >
>=20





