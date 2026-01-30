Return-Path: <netdev+bounces-255093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKUWF9aIfGmbNgIAu9opvQ
	(envelope-from <netdev+bounces-255093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB7B963F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA24300DDDC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B070369202;
	Fri, 30 Jan 2026 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYdmt+1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D935E54F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769168; cv=pass; b=kD6dCFL2zPfiFrfMpWYLuEOETNnY3Uy4J5vFF+Mtgl0A1PafcNAojstVzdvZ16f+emHiuhokfgDR8YptLcca5gQCDLWvJqX+U+bz5LchSPwab4XRP4YIqKFH7S23xh/yeSkDJ10rDFyZebMU6sSyLzOuGovdnRjNeN8yX9bHnRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769168; c=relaxed/simple;
	bh=PM+crK4N6TQe9RH0AMdaTWLLQaP/RG3fAKprYEzGy9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKLe+C2djMrjfIgrX7WBtJ8Aex4nWNEM7/d1Fp9QZJM7Q/QxESHZHstnEGH/z6k93weUkrts7vN5wDwDsdWAtBjkfOoFf5YUC3KNEaMXTFlh31yIWUJeJak2G50F5PhqvD/WANvww6BAhf6xE68p2qpLU+7THoQqAmG5H6ST+Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYdmt+1B; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a407dabaso14088751cf.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:32:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769769166; cv=none;
        d=google.com; s=arc-20240605;
        b=dONIyPllpcDqBBboc77Tr0e8OfskKqJ2I8o4OHdWEL3vGAWK4G99l3N84IYpU2wY+Z
         OeQlIqU2YRu/ieOefFUpWy1xwkJjPWKVR9VJmJJBPBESI2Cch27KTDCUPqDeOxhC+PBC
         /twyruAWX4Yd/9VCbFTtNrXqcIANAktWNdQ+tLO05awXS/bX/vbiLF6S8Os/MgkqeLD/
         8ApnYEA6o87Gz94F+6ZcnuB8Tib+1ujp0cC7j0KbsOT0unablIumtySeX2Hwd+Phdtn0
         VaslknVWDRHlUMgzmXU7880fudYvFo1jzmMZqSFnFrv/iBwh+kVeMAtMRMhERyth+8ql
         WtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKmx4RJI0M3ErZSi66Ul/ZO3J0tfze4ljxzxFgky70c=;
        fh=19RKIccJS8uFoeLeVmsZJmd3+sOf0IcIZufZSkVX5D4=;
        b=b1WOcWi8kl+g+x9jTd+U+iW/P15nfnhhHJZ7hpltTTmz6hwcX9HdhPjZNyiKXrNeBq
         2hnTU/LRAwJ8tLEx/4klMmVCIz+hu8L0b/tDaE5na2KJXhdA5PgDzBibjvsjNzEUn0t4
         fUIgCLTymoB9gQowEc9D5s06k8GcK3ByJbypy3UKC/RtFKL6h/I8AiOD/wNJeOara9DO
         pcrgeHFMFczP7wbY7IXrk08G1xCVvNNjjpgtF2O7JwYdiefJhBabSSHAswrkboxts9il
         FVf39xbbmXpsg5ieyyZcom1bgxB90xJRBJdvrDdyE403gS4ZglI6rJDftKgV9jYQiUFy
         /SHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769769166; x=1770373966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKmx4RJI0M3ErZSi66Ul/ZO3J0tfze4ljxzxFgky70c=;
        b=tYdmt+1BAKbQ882qp+R5RKM2QNVDviROFiBrxn6hDT65BKSOav9Bvsiz0aaQZvXIkZ
         87bjpITBLgHZc9BJ/NZLwkSMEQ9iOHh3PJRmqcsZn9cVu9XJ9pamuru0rwZtWtxjC/Yk
         Obg201FuUyhf7tZ98cAQ+ARdME8MhtwqzC9gt+rC93R2ViFeOlt6H0JNh0aLq1S925nb
         AWFXvY3T5Oc5BNnFx/WwnCXXPCzTsegwKea6a0fAGgrprlnCJhMh9PEJs4oNvl/l2xhc
         r5XHGShUCssEZ5Y13dH5GTCP8oJa21CKVdD/8CbQCfGjhMuihcoibf6hJSgpnm469Pab
         Xq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769769166; x=1770373966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKmx4RJI0M3ErZSi66Ul/ZO3J0tfze4ljxzxFgky70c=;
        b=q8Ahvxf7DgQazVJw6VwEPTxMdyx1nCL9wFWLtvgtNwIlitIqIktdIGOIWQjcb2W+CV
         ZyMSnyPIblqy4EodrQ+F8dSAzkwkJJBP10tE3EPgdG1ZtCry9soMZpMw+HOefMeVhb7L
         5b2t5D/GjcHnZF31QZtvJKnBjY9KuH7+PdF94qKhG/fsksFmNrI3GiWkr0VjMZQfAvUt
         O0ATZ1d5wew6XNAXZLOjARNluCUy9hxlw/+fQYB5/kGJXfNUn1qfTvqVA1uU6ORBPOCu
         MUet/+EzsgLZCeCiCMEutpNR5jZODvBXwPVI1s+A1uMVQB5jS/d1nlGWotBzovLCerqr
         MpNw==
X-Forwarded-Encrypted: i=1; AJvYcCUXvErajsj9iSXCPG1damzefpiTJj70dntq17ogyuYkevijoz7mL4PXvCgExl3m6g7XVFiWe+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJJqBcHgDmmTGTWnyt7uCcwLsCskDlCzp11VuIRrlg2xP2Lqf
	MvC9pxywBOFDqu1NV1Yb4ZTHzGHjkOcVMohVklIFZwu5H70DuTKs9a2jZWEQcuNZ316kkwL2K86
	dymm+aIIcsSGJGFqI7lmOJay6JNHQrT0/oEGMjMQAhnvxlVz8LqPUnl13odo=
X-Gm-Gg: AZuq6aKQxKg+3TXC78KY03ax49WvaDveiBYqKVsxnOPzb/aYMskAX/cUeDBVPHzKnwp
	KH9/rxrRSzxMSIyOprJXkP9t9kM6rLFCDDKO8bXXzWa/m5OE+xc6dS7u6zvYwnn4F9Edh/powMF
	2bpsGicOcc7WrVsd73pSzsgyV9EBhhfBCP3j4LuQBFIlpkQL1Llnco7zLEqUlEA30MHbiMGDRAU
	K+cGF7aQvl8xdVfo+9iouaZp8DXsJTQnl7lGpIZ1rc6DIQJFQwA6gXd4rfXcnACMaxKhqI=
X-Received: by 2002:a05:6214:c4c:b0:894:6f51:b4b5 with SMTP id
 6a1803df08f44-894e9fb0dafmr31281676d6.30.1769769165826; Fri, 30 Jan 2026
 02:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130044348.3095-1-lirongqing@baidu.com>
In-Reply-To: <20260130044348.3095-1-lirongqing@baidu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 11:32:33 +0100
X-Gm-Features: AZwV_QguFHUo17T64TFpbIe9PBPhtFTxGSaH6-PWsbeemZcAQsG-P6tB82iuhLo
Message-ID: <CANn89iLetxqpxpSBpQztPcg=av38nGNr2VpOo7HARrbqubREyg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: remove __read_mostly from nf_conntrack_generation
To: lirongqing <lirongqing@baidu.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255093-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C0FB7B963F
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 6:02=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The nf_conntrack_generation sequence counter is updated whenever
> conntrack table generations are bumped (e.g., during netns exit or
> heavy garbage collection). Under certain workloads, these updates
> can be frequent enough that the variable no longer fits the
> "read-mostly" criteria.
>
> Applying __read_mostly to a variable that is updated regularly can
> lead to cache line bouncing and performance degradation for other
> variables residing in the same section. Remove the annotation to
> let the variable reside in the standard data section.
>


> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/netfilter/nf_conntrack_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntra=
ck_core.c
> index d1f8eb7..233a281 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);
>
>  unsigned int nf_conntrack_max __read_mostly;
>  EXPORT_SYMBOL_GPL(nf_conntrack_max);
> -seqcount_spinlock_t nf_conntrack_generation __read_mostly;
> +seqcount_spinlock_t nf_conntrack_generation;
>  static siphash_aligned_key_t nf_conntrack_hash_rnd;
>

What about nf_conntrack_hash_rnd ?

I _think_ this needs to be __read_mostly, regardless of its current
location (it might by accident share a mostly read cache line),
especially if your patch puts nf_conntrack_generation in the same
cache line than nf_conntrack_hash_rnd.

Same remark for nf_ct_expect_hashrnd

diff --git a/net/netfilter/nf_conntrack_core.c
b/net/netfilter/nf_conntrack_core.c
index d1f8eb725d4223e042b02ab86ba89b9b7caf75f5..0a705fab2bb73f7590647ff06d7=
066395e6eea66
100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -204,8 +204,8 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);

 unsigned int nf_conntrack_max __read_mostly;
 EXPORT_SYMBOL_GPL(nf_conntrack_max);
-seqcount_spinlock_t nf_conntrack_generation __read_mostly;
-static siphash_aligned_key_t nf_conntrack_hash_rnd;
+seqcount_spinlock_t nf_conntrack_generation;
+static siphash_aligned_key_t nf_conntrack_hash_rnd __read_mostly;

 static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
                              unsigned int zoneid,
diff --git a/net/netfilter/nf_conntrack_expect.c
b/net/netfilter/nf_conntrack_expect.c
index cfc2daa3fc7f340937898b4bef0769fd31f801b5..4dae405527febf913af43c49ddb=
2961a8f05e0e4
100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(nf_ct_expect_hash);
 unsigned int nf_ct_expect_max __read_mostly;

 static struct kmem_cache *nf_ct_expect_cachep __read_mostly;
-static siphash_aligned_key_t nf_ct_expect_hashrnd;
+static siphash_aligned_key_t nf_ct_expect_hashrnd __read_mostly;

 /* nf_conntrack_expect helper functions */
 void nf_ct_unlink_expect_report(struct nf_conntrack_expect *exp,

Thanks.

