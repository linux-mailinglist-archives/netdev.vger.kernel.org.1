Return-Path: <netdev+bounces-260122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOw1KgiFnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E317A213
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698AE3142FDF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36331A072;
	Mon, 23 Feb 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfg0mLJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB782315793
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864745; cv=pass; b=q3To6k+am/Xj+/glIfw26R2I56FnzuoEMmZ92OT0nZxWElx9YbP7yh/jpsSat+9FDU65lTwULIulnjgovfpOzlAfLosuPheyphirKfXTm24R3PpUKuTcGXUlS9JcjTPZ8l4dQrCiMcrAAKCdLj6iD1BoLHBP8XfVDgwDFRvg2i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864745; c=relaxed/simple;
	bh=6BMG4Aw9cTxQ9+0M97149ECEu9MA2fic37H9nokz5/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6FPa4F4WvYG9p2blpktdI1W0wxsLG8SKy+vyx+47FE/a3GiUMJ02uGvPXfroYo9WGvDJk/RFbUYMc/4l0YhxLgtZGUnUf0XghVsdCq7/4hsAKJmYNjcI14zn+XCAGnZKrWATX9paZnvicdJBU2oxmskafi2UT/jmsh2yaoMlK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfg0mLJ1; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362197d174so2902466f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771864742; cv=none;
        d=google.com; s=arc-20240605;
        b=K7GHyj1oWgUxO21SRya3GkTmCElSHtmKRfsvmJDgU1rlKUCUJm/N312LXYVLRV+DzA
         mekMJVtfNjcSrqIpMcBafK4cFZtY0xSv+R587mHAdw+6h0hmXfM6Xvw0bKZsv/I/SiKN
         iyEnk4SnOz/tbBGETuh74r5/zYex0CWvS+RsvR6URbGs9SA38SfMZ/vosk2VqPQu3kbf
         3dVOOtxfmrpJxw8798hlcWsVwzUmK3UvL0i3SIiLDWommS2BrnStuIqpgZlB4a2jzzIj
         1mO8yoRN+Hg6ru2HDd5H/vYx7GioRCbWgzQ5MI0m8jGRoq0nB4ksUpfcfSCOIrj8XkS1
         +a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        fh=MlOs5H8/b8tZqFe7IcXdm07VOBBU44ZseVHdRgI+o50=;
        b=elF+aLeTihj6g97u//rXg0KCFt/Hc21Djvs7gb25voFbFSLcALXWiiaLIj1045RtwA
         6znqA2BUhuB360MB1vztSvaqBF3sZf+ogdBLKK8+sTXhzyACjUPBvb+JWj7nCrIAhm5f
         SXwkgBosUz0c0dc5sm1noII+iNLLkw6qqH4owrZOc2APNZoX7kDeCLz9U/J6WGftXBTC
         XQcJlP3K52EX+TEcf2KfJ/2Cdc3hyQgLIEHr2WTUv4WzFFOfQ5ae6Y4CrZh2JIAKVPfk
         wm7miW9u3q2YuMZtN+GTlncGuUsKsEguhs+TrioIUDdmnlOO9DQ6Eoes6UBrLPM6gfpK
         d3gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771864742; x=1772469542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        b=Vfg0mLJ1k/XPortGSlRwBsGhmmDAiuwD3PfBM/gyQK4jkvK7qAhkbn0aFg5g/JydBU
         fEnl9USlhTpgCtkEOIkWLq/i8pEr3+08T3bm/joRgz8nOFux+JjDEEk0dVqiw9PhFpsT
         gk4P1pX4xd52gvTjnBxOcSVqL3kxi0VRSLGTDhUotprfHaI39n8NG30j+SRcvp5MbEWS
         mZK5Y+3h6lfxoz8hLmavGmCoH7AHkUal10iR9a64YpPuK+iR/rQqM9I1kSLcNXzWQN+9
         FlPT8cQ2mzzU7c+3vjLOS3TFrsGyCPBlpbusvsGxeP9Xq/tHf+b60dtMUMJ7Iy3OWOyK
         WRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864742; x=1772469542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        b=bYl93BihfrFlLHCnZNtBikY+JVEdpsFLvIrFvXTZDe5PFTtlbXKb7Zd/V38MzDA279
         ldfCyCbGhwUnHiafv5ifxv8J9oqe5SutsDrVqxXxqX5KG/de1SoAhsJA6I5SLxwfGLWs
         ZohM964P1QHwf8ECWmk7mnKvqzicCwJ8vqbBLek8U5YR3Nt9F3zcaZu2EcU1Si1Yrk6c
         x6h7Za56mSjVpTRGY+nghb0umstawb56bR0sG6/5eGpQyxjUp/zghnXE5bl3M0/RjGDl
         0YJIJPQ27N+aD2Lr73/Orl5FlQk8FnLNjX+Y2cSt12erzXfWbIxGwlMd1qjKL49i488b
         ZqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWatcVFCF9i+fDSoE8wpFI+16NLFgkDroeUMetCBJI0usOmyWEwYpAY6mAEuxafX11nign/LeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcoeAY/OgNiQOXao1z3OAcRe8w7PexSwROZh4lad+oZbFzJ3L
	SHSJDmfOWGQg8OWr0+PgkRnrT7Twnl3NEe9sHkcdBOBr6A9e4c28pnokE+TJ1xooMX5US+ZBzm0
	qctStwW3G/FmYQa8sRg4G9xw0n7qNlYI=
X-Gm-Gg: ATEYQzyZBO28Z1P0S5TqbTrEXmoqH8ePhqQP7MaQeJhscsUxRKRN4UwD59jPjb0anqo
	Jsx9+X91pjHBwh3UINyVcBDGEYuXMtN0yG2TuETxPvRM0LZnsr0VI3BUSFfGAcFuKh1ja36Wqls
	oY3BkgY4S/t22fklt8cfxqx0H+hl9iFGc82THuRTLG4U/yAPtIM/pJR8Vxch/lLM2eXVu80hkaQ
	/LWJvVchpcLNJPcSvveu4CtxFntCVie0C9iPnhvGXQZ6R6kaC1JtnqqqZn3qoUXNMoMeBg4I6Fx
	oXCGw+oagS1YusJMyIH/uLCuClu/qQ3C5iJuzKtENCyKxx7xABoXsAsyM5p4iRLDTdRIZseqIwY
	faGNj2n2a
X-Received: by 2002:a05:6000:40ca:b0:437:73a2:2d4c with SMTP id
 ffacd0b85a97d-4396f15a735mr16101979f8f.13.1771864742055; Mon, 23 Feb 2026
 08:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223083120.23776-1-slava.imameev@crowdstrike.com> <20260223083120.23776-3-slava.imameev@crowdstrike.com>
In-Reply-To: <20260223083120.23776-3-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 08:38:51 -0800
X-Gm-Features: AaiRm51gzgi525_wFRB9fptLy63BCDSKPCaqKcQyhmb9W89_jXdbtCdsK1J7NFE
Message-ID: <CAADnVQ+50cMbAiTPEuPT_LZgPu3SuMDhemX9EpMLoqdCHvAXbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add trampolines
 multi-level pointer params test coverage
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260122-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0D4E317A213
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:32=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> Multi-level pointer params and return value test coverage for BPF
> trampolines:
> - fentry/fexit programs covering struct and void double/triple
>   pointer parameters and returned values
> - verifier context tests covering multi-level pointers as parameters
> - verifier context tests covering multi-level pointers as returned
>   values
> - verifier context tests for lsm to check trusted parameters handling
> - verifier context tests covering out-of-bound access after cast
> - verifier BPF helper tests to validate no change in verifier
>   behaviour
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---
>  net/bpf/test_run.c                            | 130 ++++++
>  .../prog_tests/fentry_fexit_multi_level_ptr.c | 206 +++++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../progs/fentry_fexit_pptr_nullable_test.c   |  56 +++
>  .../bpf/progs/fentry_fexit_pptr_test.c        |  67 +++
>  .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  38 ++
>  .../bpf/progs/fentry_fexit_void_pptr_test.c   |  71 +++
>  .../bpf/progs/verifier_ctx_multilevel_ptr.c   | 435 ++++++++++++++++++
>  8 files changed, 1005 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_m=
ulti_level_ptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_n=
ullable_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_t=
est.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_p=
pptr_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_p=
ptr_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_multil=
evel_ptr.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..9f6ee2eb01cd 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -24,6 +24,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/xdp.h>
>  #include <net/netfilter/nf_bpf_link.h>
> +#include <linux/set_memory.h>
> +#include <linux/string.h>
> +#include <asm/tlbflush.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/bpf_test_run.h>
> @@ -563,6 +566,42 @@ noinline int bpf_fentry_test10(const void *a)
>         return (long)a;
>  }
>
> +struct bpf_fentry_test_pptr_t {
> +       u32 value1;
> +       u32 value2;
> +};
> +
> +noinline int bpf_fentry_test11_pptr_nullable(struct bpf_fentry_test_pptr=
_t **pptr__nullable)
> +{
> +       if (!pptr__nullable)
> +               return -1;
> +
> +       return (*pptr__nullable)->value1;
> +}
> +
> +noinline u32 **bpf_fentry_test12_pptr(u32 id, u32 **pptr)
> +{
> +       /* prevent DCE */
> +       asm volatile("" : "+r"(id));
> +       asm volatile("" : "+r"(pptr));
> +       return pptr;
> +}
> +
> +noinline u8 bpf_fentry_test13_pptr(void **pptr)
> +{
> +       void *ptr;
> +
> +       return copy_from_kernel_nofault(&ptr, pptr, sizeof(pptr)) =3D=3D =
0;
> +}
> +
> +/* Test the verifier can handle multi-level pointer types with qualifier=
s. */
> +noinline void ***bpf_fentry_test14_ppptr(void **volatile *const ppptr)
> +{
> +       /* prevent DCE */
> +       asm volatile("" :: "r"(ppptr) : "memory");
> +       return (void ***)ppptr;
> +}
> +
>  noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
>  {
>  }
> @@ -670,20 +709,110 @@ static void *bpf_test_init(const union bpf_attr *k=
attr, u32 user_size,
>         return data;
>  }
>
> +static void *create_bad_kaddr(void)
> +{
> +       /*
> +        * Try to get an address that passes kernel range checks but caus=
es
> +        * a page fault handler invocation if accessed from a BPF program=
.
> +        */
> +#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)
> +       void *addr =3D vmalloc(PAGE_SIZE);
> +
> +       if (!addr)
> +               return NULL;
> +       /* Make it non-present - any access will fault */
> +       if (set_memory_np((unsigned long)addr, 1)) {
> +               vfree(addr);
> +               return NULL;
> +       }
> +       return addr;
> +#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> +       struct page *page =3D alloc_page(GFP_KERNEL);
> +
> +       if (!page)
> +               return NULL;
> +       /* Remove from direct map - any access will fault */
> +       if (set_direct_map_invalid_noflush(page)) {
> +               __free_page(page);
> +               return NULL;
> +       }
> +       flush_tlb_kernel_range((unsigned long)page_address(page),
> +                              (unsigned long)page_address(page) + PAGE_S=
IZE);
> +       return page_address(page);
> +#endif

This is serious overkill for a test.
See how bpf_testmod_return_ptr() does it.

pw-bot: cr

