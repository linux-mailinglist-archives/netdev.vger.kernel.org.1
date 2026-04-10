Return-Path: <netdev+bounces-277429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNyAIO792GkVkwgAu9opvQ
	(envelope-from <netdev+bounces-277429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 176973D8376
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C86830372C7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A393C73C2;
	Fri, 10 Apr 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXkk7MjG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AD3C5544
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828410; cv=pass; b=aColTnl8mkvqp1lF78OVtP/vtLFcH4Pz+aEjqNDvfpRkPVXcVadRWu0uqR+76LaN+Ks6oUqV9MprUn3cTxlOjtDA/k7hXvwH9DPAoJw9HdXC9qongCgRYRkgfoI4z01j+t0BCPe9SVG7mSIUjQo+WQiBKRFggvIJ3m7rVBhABII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828410; c=relaxed/simple;
	bh=LSR04DrYd2CNPoGkLuzcgQfT1tMVn5ZfdEM6iihG19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqZy/a4QJwX0jVFfYOv+4T829tR5fWVxIZ2I+CtAPBiG1ekabAsRRGA2pMcL97lx5RLwGR+X0sje1228no3aHCQNzd1naq9JG2YaHryk7Fi0BPSQqzSDb40sR7cgtTmj3lTjbEwl0P9eZh22HOCMoWM8+79a3TuW0rpiroHJd/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXkk7MjG; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so3035208c88.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828407; cv=none;
        d=google.com; s=arc-20240605;
        b=c4kZMRGnSnNUXGReVIKU4e3aFOlwWuYIueuPwoOyFTDyT/MhiTqLhkfgr0gLlh8bx+
         Rm1NdOLGnbmw3HM2JoUVVM8ZMStFZ+R2XKuuCrTaKxwSVyaGaxdKVKlpf+xpdd5Arnby
         UBtkn/7MrzBmR/4rTllzj4sM3YR7zSoELta2zQnuZZ0NYmtNpUyOu++lOuvUlEsVP6iJ
         VXCY7wC5FNF2N5+GQWj3wvWfZSEGjiSPqZw18nQwAt5IQHkYVTLVl7DJ1mCocEqhyk+2
         kdkydrvPf/C1OSQ426fm7YR09et+D49V6gvTptiQi4GmoAQR2pXwxDrN74JmFr8hvxum
         ASxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=c41KbdBgNqMu1Af3g2NRATh4F+qIRMIeXCmHZ2a94JI=;
        b=F4Lzqa2hJ1gHjC/k4cgHvzHGIOslQ5OfkqJMYACHs4DGLdJUYoj44X2zq/EnSpyNsM
         jDf0EddsKQjUcSElH+j9Yw7vEvAmg5u4srZfdmitD5C3kmpEe+Rd2GffbXQy6fslizvu
         4CYnP+Mr4AEF4bhjQbhhzPBU4mZV8sK8Y77o51zJb+ejTOrytLJPwc8ofrC7JYSq0XXH
         LYy1Eq+F2fzWte3dEv2c6ewwyTW8f9EH+m6iE4G3tSl7i9NPXgHnOBpsy8bfkdVEcnr9
         ZKl2NTb/22IMA0PRz94XqO2g5BsaU6aLbz4502Dkwcs4AtDop174yeM94bubGcHHk7t2
         byMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828407; x=1776433207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=WXkk7MjGsWCUHEg1iU7liVQxxmn76Z2Blc65Af4B1zix0M2rF8QfzApVNMifY6ss0I
         o28bXJ2WoZKKs4P+RMYVL7Cyz5rTozkqN1LFEZKxQrY0UWy/+P4MTVZ7JlV/GmTfYw7g
         BHdpmSI3dFIhezek0dIMEojwsl7VI9CpBDtWrVKxWRCyxE8FKu9tCx05MK1Z19mpDbLY
         UAmVUcxpvcLdZE3bWKkeviuFv+z6weHemrn+Q1dbNj19BdhmlV3lYWFxMcZ5yjPYSXjG
         1ICMvCFl+bVV4g0F5SiLzhG+oRaoJBenKb2hyA5tkvyV436rK7zq2Le6HAfSbviCkDzM
         W8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828407; x=1776433207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=MFNICBDSGK5EBDiAFdXs493fh60HjuTadJrI2rmTF1FmqQNY9HMYmTql3QLgQe9nhh
         gtwIEYhcLMG9MS4B2X7On6iRfqOYLpkwOO4gFQurFx5/vHa6k+oiFuqZqazJ8TCg5qRq
         t04uCbhdyT8DwXYB9BPATT33g35hF9hrFPDTVnHSmbb/IbPayxB9r0LcWFrpcK8afC9/
         kox7rSxGYg2ArcEXQ6RIJ8W9+c2v6F9s7k3TYpznO5RwBGIgXvh3F1tupF5OrWXib+Fz
         RSGRhbcJdr158MCkgZgd23rCtYtzIwITV0ntp2etxVOsBDanvn+NVaCRcGbwtJ5xS8qM
         CbFA==
X-Forwarded-Encrypted: i=1; AJvYcCVJG1hfOZvcXFMnhriJtKt3HLScL/1M2Sf7iXuefyRta5ydx3NHNwpqUVfyIk6JvnqI2w7OAAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtvwtra21As/oxlofzNu/6ou2kCLkNok5LC7kEBqeDghnYU+M
	t3CL03QEIRJF5uCt2wcUcNYPFGoHTAb1ChQQb3ISO5cN0X9fVKaWk33fJUVCOvBjommnEvTjCrM
	M0xhnLoVuKSVd0kpqjTWoCg8WEgdcUFjcDFw0fxyU
X-Gm-Gg: AeBDiesA4U0i+6+nzt8y0hVvgohr58O1ZvQ+KeLchxxTw95QHLqWJtVvxfs4o6Co5VR
	OWR+/vx8j6jWVdTOEqT8F+sNBTgVZAnt3F4j4vRFbli4HSwmxP5KrV3bilwJCvKDNIjbepccKrO
	q9N3A+OPXDF4uyXI35J+v7hj6a6sj8z+ab7wy0Xp0rqlP8YL5bqQ46wcy2GeRrsBvW5+J6MFR2y
	kRkvVWHNKfx3BUN1WLpdva8CAyCyj3BA/JYqOZiLohKsQ4oTSV3tl7hRCLCp0OZj93fzSotkJgD
	dhQC706bt4VlEfGpQWjFDCL4pN9Hec45gEkWRK+fISCcQ9X2
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277429-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,googlegroups.com,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 176973D8376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>

