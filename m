Return-Path: <netdev+bounces-293293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UATCIC0/GmrQ2QgAu9opvQ
	(envelope-from <netdev+bounces-293293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 03:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4FC60ACB9
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A25130305E6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074A2E266C;
	Sat, 30 May 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjluBJg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CB239E60
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104990; cv=pass; b=FzmvolNPzw0vquB1HIdwvJB/Q6TQ6117/bNY2qKVfckgixha2crpUM8xVFMyvPsKMU0IMI1CyMyOvU4N0jF6du04kh3cRdiJ8vpTniHYXb4eHu8Y1TzRMIpil7U9KSff26HYRhJkm45CNXemzW+DPDUWt9PMhUYL+OhMOfy4owk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104990; c=relaxed/simple;
	bh=r/R1G+fHN5VMQcgjBHd6EVs04fcrss/12vcflfTDVD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpSr2FXPJdPr7k0ElM6YdeeFijpnTiQVuf2HYN5hdO9pb2i9noQSTXr97pxn6ror6w33OYdzSXuDf1YLk7FfJddwi9a8K4fz7XEwLmu/er+/+HhYhajOQfoLuOttccEO2RgnkoDbWT4GXhPTwjmc5aykZ8++/kk4wM1Ng9DCTfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjluBJg+; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8891febd2so18991294e87.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780104986; cv=none;
        d=google.com; s=arc-20240605;
        b=IczGBisc6aA0o+bqRNHtQCVKUhpte9TRwEexZKmi3VXkLRdq34QtYa3zx26WHYSj/h
         Op7BxEWndZ5diYdEoCzrlEuCahqR7zoB9j8aTzyAOqKkTSJQZzjXuP6kwDhxen7HQ3dX
         qWCuvRvq8m8pybSg6gwge+EncudNmVR3f2wkMZJeGz3YlB+lEHMRxfelIOnR/po9pvzO
         TR2ze2nUBfoyBEKN1osmA8n7jv6rrruZlsi29YNsdckERMkSySMqDk+77HEGRAfAjLQl
         yNokNd1u/vuIJCmHBnI/rQoShSSYukh3t3/msbj1GjZhx2OMt3/6DEcHPRe8yZ/K0o9W
         /5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        fh=RPTtkmzn1LBBlQT83ACTeD8pStXqi9ANNhOtKUF39WM=;
        b=ibuInv/nl4fZ8gAJ7qVRBJFO3v8DK1iRkeXFinz/lfa8ucxG8rpidzRpNmeno8L968
         OI/+Sp2sxnXkmOzF4pnf7UM8ZytfOrsKLnQAK1b+3TA6ahVpBV295LGaZjiJbObEtSJJ
         uFBNqmIbN11hABQSXt5vP/NCnlHYDD/lfRsQoYLj2Ujk/Dv4FVgcLvIikR7+NjiyjKG8
         uOc4QLkEJdHhl6bnThuY3aTtElss38PMK7lJqwR0pB2Nvq3MUR9Bep9O6ihC81qNMXdr
         MK3ItmWsl/X+xRUYG5psBJJ5gxJ7Weayr/fzh8X1HbhhEfg5h0B88YHpEyJfyQqnTu5v
         UD+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780104986; x=1780709786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        b=fjluBJg+m03Emjr4esnI2XxvwRkcpP2ZETyYzaCLKb1vRJdMiCmPZ2pBZ54dzHH4UT
         9O/K7bYauX3+GYzo886oIBIRu/A8bfsT9DSCOruoAN6gbgMD0KhEaF4UmjI00N8XknsR
         VObX893ixbub5mwDnGmB/oBxZmLRYp5bF6y8ExEGFi2Z/sB6L2SU6wP070C0Yn/TxzC5
         1Z2xX7qqOt8Dc+t0mSimjewl08WoN7qdFSs2PG2eRnJxahqwlkMy9lUO4ek4tyePi9AU
         eeZit9AiOKZsmyzvHvPWG4j4UuquT0UvfU4hUavi8xgoSLV9eZw0/WO6B5a6IG5jzHJ5
         Yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104986; x=1780709786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        b=nevaOgHmgnocFCF4ghZr0/gyyym17QMIn+mCnQ2+S1BOXDwIvUP7nX4WKxlntd6utF
         8IryINfljnRs4y2ka3Qtou3d+p27ql/LXB2QPf5H5n6EenzLzNpgmXoGGJDITqwWEGDG
         QFxZHnFJopxa7DdxIdo5Fz7wth85SylFwooyx0kRY5YARsWHpln0Wil999KNTAp8VE8W
         +BL+IdLbmdqVEuj4WkzakVPLIhg7m44IYmzQHSHUXub4GINFkXpqycsRLzqCPbrrbP6y
         i2GL5Gpu8Hp9biKkwRrj0HmMSN5fA+VhWmp/HingU28lkJcE6e8xbKxyJJQ5U6FsOxR8
         f/0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/AJxMwTdM+IqkLvrETIWnwsr9WTpoQzQlQrw1ecHOYa1H0nBiQv/tEMdkzwVEw0uABChwPHR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySE2K3HCotrhZC6n5V/4ca2MOMhdEk/LTIgRuOK0yFl6LbYztH
	/yc6Bh1vVbNZ+wK+E7xWiw5eDgfO0pvLBRFnZw7uYquTPuySAkblr1ZMI1R5bXUWbwth25jnnVg
	E+sJ5xW5wS+kR8OUGkoZ2wl+NF5ubtk3SGOJz7ViAXu+g
X-Gm-Gg: Acq92OHZMHF97/h23W51XOFJGn4/TcDdW99+CPqjxq2eAtf80ScE9xLZsy9LCnmTFJ/
	Cq4KSp/wWySJ6TV/bgDrR7EeznqvqhLGJlxlrUTOlI7CXlhksYtKXsK7R41fjkT2tmLuRT0Z3p+
	I8qVSKtLzQulUEs+4fbvPopg/zf4H6xrF6xX5RzM7j5RnK8hafO6rYLiQ0zBr4XlZYTWw/P+5ki
	mr87q8hYPpdIyzPW9zCmURBpsTNx21pNzQfJaNBO1tpE5Eu30qIeJGjPIOzri6pKY11bK8U0uuM
	tjVJ5TWNjh0yLL14GwxhXrwQxfIs5A6vzDxSXAznrxunVnUazw==
X-Received: by 2002:a05:6512:acc:b0:5a3:ffed:8443 with SMTP id
 2adb3069b0e04-5aa608f7df8mr646683e87.23.1780104985295; Fri, 29 May 2026
 18:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529203909.1222164-1-martin.lau@linux.dev>
In-Reply-To: <20260529203909.1222164-1-martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 May 2026 09:35:47 +0800
X-Gm-Features: AVHnY4Jac9PeH7AVgS8XGDe3QDii5Y6RCWB-lmAVnMkSOyKNEZIpJmtMNuxDkQQ
Message-ID: <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293293-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid,iogearbox.net:email]
X-Rspamd-Queue-Id: 1D4FC60ACB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 4:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> I am making a life change and will take a long break
> from my current work, so I will step down from the "M:" responsibility.

Thanks Martin for your great effort! I always appreciate your awesome
involvement in BPF timestamping!

>
> I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
> I am folding most of the parts into "BPF [GENERAL]".
>
> For "BPF [BTF]", it is long overdue as I am no longer involved.
> It is folded into the "BPF [GENERAL]".
>
> The "BPF [STORAGE & CGROUPS]" will also be covered by "BPF [GENERAL]".
>
> For struct_ops, its usage is no longer limited to networking,
> so this naturally should move back to "BPF [GENERAL]".

Maybe it's not an appropriate timing to ask this, but considering the
further development I really want to know if you'll continue with the
latest series around struct_ops? Or you will delegate someone to take
over your work?

Thanks,
Jason

>
> For the reuseport, it will continue to be maintained together
> by "BPF [GENERAL]" and the "NETWORKING [SOCKETS]".
>
> For other "BPF [NETWORKING]...", I am moving myself to "R:".
>
> Thanks!
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  MAINTAINERS | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfc621ff629d..d9caa2d980f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4766,13 +4766,6 @@ S:       Supported
>  F:     arch/x86/net/
>  X:     arch/x86/net/bpf_jit_comp32.c
>
> -BPF [BTF]
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -S:     Maintained
> -F:     include/linux/btf*
> -F:     kernel/bpf/btf.c
> -
>  BPF [CORE]
>  M:     Alexei Starovoitov <ast@kernel.org>
>  M:     Daniel Borkmann <daniel@iogearbox.net>
> @@ -4905,18 +4898,11 @@ F:      tools/testing/selftests/bpf/prog_tests/tc=
_netkit.c
>  F:     tools/testing/selftests/drivers/net/hw/nk_qlease.py
>  F:     tools/testing/selftests/net/nk_qlease.py
>
> -BPF [NETWORKING] (struct_ops, reuseport)
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -L:     netdev@vger.kernel.org
> -S:     Maintained
> -F:     kernel/bpf/bpf_struct*
> -
>  BPF [NETWORKING] (tcx & tc BPF, sock_addr)
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
>  M:     Daniel Borkmann <daniel@iogearbox.net>
>  R:     John Fastabend <john.fastabend@gmail.com>
>  R:     Stanislav Fomichev <sdf@fomichev.me>
> +R:     Martin KaFai Lau <martin.lau@linux.dev>
>  L:     bpf@vger.kernel.org
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> @@ -4951,14 +4937,6 @@ L:       bpf@vger.kernel.org
>  S:     Maintained
>  F:     tools/testing/selftests/bpf/
>
> -BPF [STORAGE & CGROUPS]
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -S:     Maintained
> -F:     kernel/bpf/*storage.c
> -F:     kernel/bpf/bpf_lru*
> -F:     kernel/bpf/cgroup.c
> -
>  BPF [TOOLING] (bpftool)
>  M:     Quentin Monnet <qmo@kernel.org>
>  L:     bpf@vger.kernel.org
> --
> 2.53.0-Meta
>
>

