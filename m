Return-Path: <netdev+bounces-278216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBKgFYps3WlNeAkAu9opvQ
	(envelope-from <netdev+bounces-278216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59FB3F3C6D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CBD3037E43
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220C39B494;
	Mon, 13 Apr 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7iVQ4YE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AE394780
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118843; cv=pass; b=diluKWYXfLB4+1hPS4sQRp3xvOfCuCtb9WWbL0r3fD3wR6cLRjtf7julzM4Pj8knIAQiI0zKMano6l8bLowXwKBA2dHIltytX9lRotAp0SrqfX/7iaY4ooHjq3oxWRQz2708SPkdrer3FEj+sXAQkqNj4UDTLzNEVT//h078d2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118843; c=relaxed/simple;
	bh=L5sRhn39Gq/EuNejgwrQZjyUO/2vF2bKM1TN0xPKjqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Biw1kOG1IrbM16OXxz991xgrAzXJLkY1SfMaaEKZ+cZLdRrBfKw6V8WCXD6FEIB7b/aLDOf//9UmAHB6aMv9hjIcQH9FLLLdBBiCYgxmH5kBTTG8ggAYEpGvk37OEXm3/nwKACUFVuv7WDRjsjE9ugnCGL7gX6gcmKcbghs2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7iVQ4YE; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so54109385e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118840; cv=none;
        d=google.com; s=arc-20240605;
        b=JTTvXyo7Xq4oWVWpA0fVK1Bd0E2u3vYepGsO8jZWMjxPlrnEXlE85CYztzGekKlbaD
         T1LZi5U1f+3TGjMZBOdWEdvbU6kHascbVz9qKa1QFYvC6h1OUpMoAdLLkIeVljWpaipV
         rBf0xRRKPLOsqg1G5Vy/bKmFrE2HGUObYooZAvCAcSGdna2QEf/FX0/ym8SgJJPGK/cp
         XpdJU/olBNoY7Qgqn4r3SDcDuC6JFUzFUZhguG0BXKWs1WTI2Ff5j4sg/WbLEFpnywaA
         s5ewbLRalV/PDRYw/FKnu03LUuxSNzurgd5a/vPu4B/xyDuvpR+GLZI12A3AQJjC/zSJ
         7oGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        fh=ccNpvIXyEodmEyEYw8G7v8sTNbkLrx9w0uwOeOZG3r4=;
        b=VFYBk/2IXUSSOXJ+ZUkC89Z8AYxF13PWcjdAvRpUoK6jE5uflL2QAFnmLXcfxuNv7x
         eriXXw5x6FpuCxUZmlvVEw+6AU9ZyBvbEQ+skwYzamEQlBcyy/5PakFEPCah0JKMCRkN
         1QRcINoo0vOCHSvBXMsHbs5buvcd/nVFdSr5McVnS2yOen7W5uO1HFCFjKbLHqEtPPN6
         d7sC99S6nrp6Y9Sp1v40Y/t5AZMP6+2mGuduvnBDwDmNDP9dfnL4qjIIg7c2S2CxPhXu
         MxGHCZqml4o77RwcVc2Bml598RnJClRcrfDM5A/kifAQ3BYLFnDarSCzhDi4JnjMr4n+
         aBiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118840; x=1776723640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        b=U7iVQ4YEtR4ke+7DcubhsKKyixj5Dkr6VDXTe5lTATEJoAXxx4byxgT6fNj0UvfEDS
         QJtQJa5vN5GbWSh2wvFn1loSdTUrEONym6KQY6MihFnJO/JBwmIEpQHitpp3kesQ0+H6
         9gWWPkYn05gKKg6G9Qn0/0VlOMlDBIzxGaMz2t+GljMiQrJjRyOIgoHhFMDeuwhv8m0e
         1+k+Iu3o9jojTYDiBIMoeyEaUekiUMm2iBiqmPWavCKKl6OliSajZIIumF2kCRmaWY3U
         arnohCXvwaUrcvOJZTt5PiKPLP7XZQ4NILRf6MIT2hFl6XyNHwC1OEBuBqU8BY268JCO
         wd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118840; x=1776723640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        b=CzoUNIUf6CkJNjW9zS5kXZJHjJW12giAH7Jmgman+iBtMx30o4YDfbXPgnjJC0fmzk
         yxyT9ES17Ouhrn4vEaQJZ65HfzcvT20qOsY1y0m0RuPC2Su0Q7ybEc/sDdZ4Zmb855i/
         k9X0ls+8xevGC00IDJFG22n3c+tSTBNQ0GUGgrlAp9i77NqijJlzBnKwYmsrzr0aFmS6
         oT8F+BHA7Rwc+HalAMxdBrt4si4VT1HczLKK3A9Os+cNDvFc0IlutUzZuKkmdMLpyZQt
         AnFn3a9txd4cnvrtuG5DnWXveNXpimFzz4gi0YciucxI8WlCflb1aBf7AbHDM4iq+hKa
         KjvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4vSX0rcZytGkB744Z0Afq8GGdXxEgcRjqtQwnTfNyIGnnoPPEcQkZDGl/GRWuyFgVnha2DmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HwjxRHCuqFTKur61Xmrekuv7RrnnF8pAw0OOb67q8io605i2
	37Qwl3lPScjOm+vXBjl5oxaJMY7+M1hdkKlDTZkelYl+vwPS677Rq40A80PoreLtOD0pnkkoZNx
	c1DlX5uksR/lDdAy1HowSfSY9bdxGVqA=
X-Gm-Gg: AeBDietWaizhkDp+pybtWAGYCdQtJXdDmBHKtJCym5Y5TkrdHRtOi3pI5fSFhRyh1sN
	ni6FPaFzB1ZW9f1YEId+1JdvJVGqp4ohzfi6IWAk4W1zIIjNmpr2L24Mb67bmaGaE3jHEEoq6NX
	msfICjdBsHKsbg3g/BBiVWxyTJlarzF2w9ov6kY8hJAGRiFMdB5Wbw3P/n55Nx9cymJh23RWkra
	uV3vmNB/VOdsQDy8oIQhmXM7y3ukWRi7ESza3+FVbMW9TlSUZ1ScveQUltXJGkj31GpM7yVhRus
	crCwp1W2MB009x2zFIroEc8Eqlqn1N67gxl5l7Lb
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id
 ffacd0b85a97d-43d642b6e75mr20785387f8f.26.1776118839833; Mon, 13 Apr 2026
 15:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-8-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-8-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:20:28 +0200
X-Gm-Features: AQROBzC46tJ1Vulp-Ruy1LR_qNHLJczc_Mec_FX1XvbzAbvB4RmfM9pOdtpD_VM
Message-ID: <CA+fCnZekgcEgsZnRrOB=+HoG=neRg=oLTt2jStyrPJ6mYf2ctQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreyknvl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,topts.sz:url]
X-Rspamd-Queue-Id: E59FB3F3C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report.
>
> This version implements two faulty programs triggering either a
> user-after-free, or an out-of-bounds memory usage. The bugs are
> triggered thanks to some dedicated kfuncs in bpf_testmod.c, but two
> different techniques are used, as some cases can be quite hard to
> trigger in a pure "black box" approach:
> - for reads, we can make the used kfuncs return some faulty pointers
>   that ebpf programs will manipulate, they will generate legitimate
>   kasan reports as a consequence
> - applying the same trick for faulty writes is harder, as ebpf programs
>   can't write kernel data freely. So ebpf programs can call another
>   specific testing kfunc that will alter the shadow memory matching the
>   passed memory (eg: a map). When the program will try to write to the
>   corresponding memory, it will trigger a report as well.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> The way of bringing kasan_poison into bpf_testmod is definitely not
> ideal.  But I would like to validate the testing approach (triggering
> real faulty accesses, which is hard on some cases, VS manually poisoning
> BPF-manipulated memory) before eventually making clean bridges between
> KASAN APIs and bpf_testmod.c, if the latter approach is the valid one.

Would it make sense to put these tests into KASAN KUnit tests in
mm/kasan/kasan_test_c.c? I assume there is a kernel API to JIT BPF
programs from the kernel itself?

There, you can just call kasan_poison(), some tests already do this.
And you can also extend the KASAN KUnit test framework to find out
whether the bad access is a read or write, if you want to check this.



> ---
>  tools/testing/selftests/bpf/prog_tests/kasan.c     | 165 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/kasan.c          | 146 +++++++++++++++=
+++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  79 ++++++++++
>  3 files changed, 390 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 000000000000..fd628aaa8005
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#include <bpf/bpf.h>
> +#include <fcntl.h>
> +#include <linux/if_ether.h>
> +#include <sys/klog.h>
> +#include <test_progs.h>
> +#include <unpriv_helpers.h>
> +#include "kasan.skel.h"
> +
> +#define SUBTEST_NAME_MAX_LEN   64
> +#define SYSLOG_ACTION_READ_ALL 3
> +#define SYSLOG_ACTION_CLEAR    5
> +
> +#define MAX_LOG_SIZE           (8*1024)
> +#define READ_CHUNK_SIZE                128
> +
> +#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free in bpf_p=
rog_"
> +#define KASAN_PATTERN_GLOBAL_OOB "BUG: KASAN: global-out-of-bounds in bp=
f_prog_"
> +
> +static char klog_buffer[MAX_LOG_SIZE];
> +
> +static int read_kernel_logs(char *buf, size_t max_len)
> +{
> +       return klogctl(SYSLOG_ACTION_READ_ALL, buf, max_len);
> +}
> +
> +static int clear_kernel_logs(void)
> +{
> +       return klogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
> +}
> +
> +static int kernel_logs_have_matching_kasan_report(char *buf, char *patte=
rn,
> +                                                 bool is_write, int size=
)
> +{
> +       char *access_desc_start, *access_desc_end, *tmp;
> +       char access_log[READ_CHUNK_SIZE];
> +       char *kasan_report_start;
> +       int hsize, nsize;
> +       /* Searched kasan report is valid if
> +        * - it contains the expected kasan pattern
> +        * - the next line is the description of the faulty access
> +        * - faulty access properties match the tested type and size
> +        */
> +       kasan_report_start =3D strstr(buf, pattern);
> +
> +       if (!kasan_report_start)
> +               return 1;
> +
> +       /* Find next line */
> +       access_desc_start =3D strchr(kasan_report_start, '\n');
> +       if (!access_desc_start)
> +               return 1;
> +       access_desc_start++;
> +
> +       access_desc_end =3D strchr(access_desc_start, '\n');
> +       if (!access_desc_end)
> +               return 1;
> +
> +       nsize =3D snprintf(access_log, READ_CHUNK_SIZE, "%s of size %d at=
 addr",
> +                is_write ? "Write" : "Read", size);
> +
> +       hsize =3D access_desc_end - access_desc_start;
> +       tmp =3D memmem(access_desc_start, hsize, access_log, nsize);
> +
> +       if (!tmp)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +struct test_spec {
> +       char *prog_name;
> +       char *expected_report_pattern;
> +};
> +
> +static struct test_spec tests[] =3D {
> +       {
> +               .prog_name =3D "bpf_kasan_uaf",
> +               .expected_report_pattern =3D KASAN_PATTERN_SLAB_UAF
> +       },
> +       {
> +               .prog_name =3D "bpf_kasan_oob",
> +               .expected_report_pattern =3D KASAN_PATTERN_GLOBAL_OOB
> +       }
> +};
> +
> +static void run_test_with_type_and_size(struct kasan *skel,
> +                                       struct test_spec *test, bool is_w=
rite,
> +                                       int access_size)
> +{
> +       char subtest_name[SUBTEST_NAME_MAX_LEN];
> +       struct bpf_program *prog;
> +       uint8_t buf[ETH_HLEN];
> +       int ret;
> +
> +       prog =3D bpf_object__find_program_by_name(skel->obj, test->prog_n=
ame);
> +       if (!ASSERT_OK_PTR(prog, "find test prog"))
> +               return;
> +
> +       snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%s_%d",
> +                test->prog_name, is_write ? "write" : "read", access_siz=
e);
> +
> +       if (!test__start_subtest(subtest_name))
> +               return;
> +
> +       ret =3D clear_kernel_logs();
> +       if (!ASSERT_OK(ret, "reset log buffer"))
> +               return;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       topts.sz =3D sizeof(struct bpf_test_run_opts);
> +       topts.data_size_in =3D ETH_HLEN;
> +       topts.data_in =3D buf;
> +       skel->bss->is_write =3D is_write;
> +       skel->bss->access_size =3D access_size;
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
> +       if (!ASSERT_OK(ret, "run prog"))
> +               return;
> +
> +       ret =3D read_kernel_logs(klog_buffer, MAX_LOG_SIZE);
> +       if (ASSERT_GE(ret, 0, "read kernel logs"))
> +               ASSERT_OK(kernel_logs_have_matching_kasan_report(
> +                                 klog_buffer, test->expected_report_patt=
ern,
> +                                 is_write, access_size),
> +                         test->prog_name);
> +}
> +
> +static void run_test_with_type(struct kasan *skel, struct test_spec *tes=
t,
> +                              bool is_write)
> +{
> +       run_test_with_type_and_size(skel, test, is_write, 1);
> +       run_test_with_type_and_size(skel, test, is_write, 2);
> +       run_test_with_type_and_size(skel, test, is_write, 4);
> +       run_test_with_type_and_size(skel, test, is_write, 8);
> +}
> +
> +static void run_test(struct kasan *skel, struct test_spec *test)
> +{
> +       run_test_with_type(skel, test, false);
> +       run_test_with_type(skel, test, true);
> +}
> +
> +void test_kasan(void)
> +{
> +       struct test_spec *test;
> +       struct kasan *skel;
> +       int i;
> +
> +       if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
> +               test__skip();
> +               return;
> +       }
> +
> +       skel =3D kasan__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open and load prog"))
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +               test =3D &tests[i];
> +
> +               run_test(skel, test);
> +       }
> +
> +       kasan__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/se=
lftests/bpf/progs/kasan.c
> new file mode 100644
> index 000000000000..f713c9b7c9ce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define KASAN_SLAB_FREE 0xFB
> +#define KASAN_GLOBAL_REDZONE 0xF9
> +
> +extern __u8 *bpf_kfunc_kasan_uaf_1(void) __ksym;
> +extern __u16 *bpf_kfunc_kasan_uaf_2(void) __ksym;
> +extern __u32 *bpf_kfunc_kasan_uaf_4(void) __ksym;
> +extern __u64 *bpf_kfunc_kasan_uaf_8(void) __ksym;
> +extern __u8 *bpf_kfunc_kasan_oob_1(void) __ksym;
> +extern __u16 *bpf_kfunc_kasan_oob_2(void) __ksym;
> +extern __u32 *bpf_kfunc_kasan_oob_4(void) __ksym;
> +extern __u64 *bpf_kfunc_kasan_oob_8(void) __ksym;
> +extern void bpf_kfunc_kasan_poison(void *mem, __u32 mem__sz, __u8 byte) =
__ksym;
> +
> +int access_size;
> +int is_write;
> +
> +struct kasan_write_val {
> +       __u8 data_1;
> +       __u16 data_2;
> +       __u32 data_4;
> +       __u64 data_8;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, struct kasan_write_val);
> +} test_map SEC(".maps");
> +
> +static void bpf_kasan_faulty_write(int size, __u8 poison_byte)
> +{
> +       struct kasan_write_val *val;
> +       __u32 key =3D 0;
> +
> +       val =3D bpf_map_lookup_elem(&test_map, &key);
> +       if (!val)
> +               return;
> +
> +       bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val),
> +                              poison_byte);
> +       switch (size) {
> +       case 1:
> +               val->data_1 =3D 0xAA;
> +               break;
> +       case 2:
> +               val->data_2 =3D 0xAA;
> +               break;
> +       case 4:
> +               val->data_4 =3D 0xAA;
> +               break;
> +       case 8:
> +               val->data_8 =3D 0xAA;
> +               break;
> +       }
> +       bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val), 0x00)=
;
> +}
> +
> +
> +static int bpf_kasan_uaf_read(int size)
> +{
> +       __u8 *result_1;
> +       __u16 *result_2;
> +       __u32 *result_4;
> +       __u64 *result_8;
> +       int ret =3D 0;
> +
> +       switch (size) {
> +       case 1:
> +               result_1 =3D bpf_kfunc_kasan_uaf_1();
> +               ret =3D result_1[0] ? 1 : 0;
> +               break;
> +       case 2:
> +               result_2 =3D bpf_kfunc_kasan_uaf_2();
> +               ret =3D result_2[0] ? 1 : 0;
> +               break;
> +       case 4:
> +               result_4 =3D bpf_kfunc_kasan_uaf_4();
> +               ret =3D result_4[0] ? 1 : 0;
> +               break;
> +       case 8:
> +               result_8 =3D bpf_kfunc_kasan_uaf_8();
> +               ret =3D result_8[0] ? 1 : 0;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +SEC("tcx/ingress")
> +int bpf_kasan_uaf(struct __sk_buff *skb)
> +{
> +       if (is_write) {
> +               bpf_kasan_faulty_write(access_size, KASAN_SLAB_FREE);
> +               return 0;
> +       }
> +
> +       return bpf_kasan_uaf_read(access_size);
> +}
> +
> +static int bpf_kasan_oob_read(int size)
> +{
> +       __u8 *result_1;
> +       __u16 *result_2;
> +       __u32 *result_4;
> +       __u64 *result_8;
> +       int ret =3D 0;
> +
> +       switch (size) {
> +       case 1:
> +               result_1 =3D bpf_kfunc_kasan_oob_1();
> +               ret =3D result_1[0] ? 1 : 0;
> +               break;
> +       case 2:
> +               result_2 =3D bpf_kfunc_kasan_oob_2();
> +               ret =3D result_2[0] ? 1 : 0;
> +               break;
> +       case 4:
> +               result_4 =3D bpf_kfunc_kasan_oob_4();
> +               ret =3D result_4[0] ? 1 : 0;
> +               break;
> +       case 8:
> +               result_8 =3D bpf_kfunc_kasan_oob_8();
> +               ret =3D result_8[0] ? 1 : 0;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +SEC("tcx/ingress")
> +int bpf_kasan_oob(struct __sk_buff *skb)
> +{
> +       if (is_write) {
> +               bpf_kasan_faulty_write(access_size, KASAN_GLOBAL_REDZONE)=
;
> +               return 0;
> +       }
> +
> +       return bpf_kasan_oob_read(access_size);
> +}
> +
> +char LICENSE[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d876314a4d67..01554bcbbbb0 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -271,6 +271,76 @@ __bpf_kfunc void bpf_kfunc_put_default_trusted_ptr_t=
est(struct prog_test_member
>          */
>  }
>
> +static void *kasan_uaf(void)
> +{
> +       void *p =3D kmalloc(64, GFP_ATOMIC);
> +
> +       if (!p)
> +               return NULL;
> +       memset(p, 0xAA, 64);
> +       kfree(p);
> +
> +       return p;
> +}
> +
> +#ifdef CONFIG_KASAN_GENERIC
> +extern void kasan_poison(const void *addr, size_t size, u8 value, bool i=
nit);
> +
> +__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte)
> +{
> +       kasan_poison(mem, mem__sz, byte, false);
> +}
> +#else
> +__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte)=
 { }
> +#endif
> +
> +__bpf_kfunc u8 *bpf_kfunc_kasan_uaf_1(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u16 *bpf_kfunc_kasan_uaf_2(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u32 *bpf_kfunc_kasan_uaf_4(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u64 *bpf_kfunc_kasan_uaf_8(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +static u8 test_oob_buffer[64];
> +
> +static void *bpf_kfunc_kasan_oob(void)
> +{
> +       return test_oob_buffer+64;
> +}
> +
> +__bpf_kfunc u8 *bpf_kfunc_kasan_oob_1(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u16 *bpf_kfunc_kasan_oob_2(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u32 *bpf_kfunc_kasan_oob_4(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u64 *bpf_kfunc_kasan_oob_8(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
>  __bpf_kfunc struct bpf_testmod_ctx *
>  bpf_testmod_ctx_create(int *err)
>  {
> @@ -740,6 +810,15 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
>  BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
>  BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
>  BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_1)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_2)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_4)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_8)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_1)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_2)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_4)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_8)
>  BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
>
>  BTF_ID_LIST(bpf_testmod_dtor_ids)
>
> --
> 2.53.0
>

