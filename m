Return-Path: <netdev+bounces-270848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yImgFwz0wWmPYQQAu9opvQ
	(envelope-from <netdev+bounces-270848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:16:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EA3010B7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE16304DC96
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F8386427;
	Tue, 24 Mar 2026 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPM8x6NB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56F37F729
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318580; cv=pass; b=X+OlTSKqSrFTtpaxqFKA1/9jpYc1Z3/BzxYR9z1/4G3YnIo9D/qCRmR4ideGpWFDG6XJpOylmqoKWx7LylAJCy6wUYwZurIg6IJKzoRMUeBFsixlhZyTpbYBBK1EoFlmJjG9rCZ4PWqbmwGCHrlWkM0psK83nNDccUdgHuIMGSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318580; c=relaxed/simple;
	bh=wWbHGOahe1TmIl8FAwScQTkdwY/rQIonaOmU2HriuZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0D9GZYXuQnKFiotmiASfU8NlX5cGQgXSKL24qaWPBn0osuxHTmPCnvym/WlzGxvrE68pFu32+RImArEFFNWD2DZVxAFV2APH49wVJ4jHaHcqTV+TrItt26BBCXd73XatalYb8j3eReIrJuvDb9t6QvHSOw2B74xEfjV6AV6Jzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPM8x6NB; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ea5b45673so4767964d50.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774318577; cv=none;
        d=google.com; s=arc-20240605;
        b=SRo7VhgzbLezjaCpnYWZyV+zzhMpJ51EJ6UUEaRy2/p/spULYzvGN1ii7oafURDGJ3
         TKY6OAthbgNRAQHJdVtMGADSqT3W1EwKnu4pW4pPxadwDd9x5Tl5zWSCwJ1sb0WMGqnm
         om2MOVWl55gM2FqxEVEjQME2ZFRg3GAGcjLLsr53xfnblAlJxnC7Yns355WN24o9+dMu
         Ro7/d4sMk13zN58N6zUZIOPB0vphvuOT+bxYauB3qUQgoSLYfIurKFje8Jen67/v3h9i
         TNbGKdQnuaqV9TnhTMAnCic82LN+1Lw35Dh6fqFw42DU1X9fqq+9xsgjN3XmG4l/qPT5
         dI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        fh=0A+hpDQL6Cx400JSHlZeUf8ayr4SLWxAkCXhkB2W7EY=;
        b=O5G+60HNe/OwIozVSsj6JS05/7GE9+8PqUClG4yMRLosCi8RMRCGoMlTWchXHJwfb5
         Iys6jFot3MDvR+c6UBGf7yfdpaq/C86QPBKHkK7uDeSiy254cZXXudtc1qkD5wHZvc+Q
         uFdTk2+tVdVbYv5XJh4QlgKqSXEbv96y50Imh3lB/EqrlEILq4zDZAF9RTs3YR0blTrq
         hVEtLIMkQ8G2406TG3JuKIZ9ktaDFpgdeh2naoGec6tB7nDV1/uo5ZLyV1dyPkLkRDzB
         hW9X5JdxID+s/MN3JXYpDx8oNw8ou7J5HL3xJSfGe0g5Jh4n0wvTfrlC8Eq2Yta4NaPK
         1huQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774318577; x=1774923377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        b=bPM8x6NBxGknS1C2c8f5PJLmbGuw4/Wl/fhqFpQnIVBUwuD92BqPmNv/1I6Gr8z4zk
         2jbeo+Obgzn6SukTfCrZf6PDiVHWIpYxATpr1l2PSGklhd2TvoZYk2X3pxCPnmSUWo5i
         4qPvobQ9vKjEPeOV4qEgFE1x1SZ2NO7sIzaPqNmLHOZvUpAEFQveW60+95nwKc+ClKxf
         9jv+19lZBNMOzj5TTI2MpsVb7yIjdJkjc+a/eIkN7dRNKdFy83mNqaLDswZ7FQWLhkGl
         ogm1HYcH6ZtE60g9zNrs71+YkIDF4lOTParLswYnZz7KcOwjaiFA3qW1i2FeUkyQX8NK
         a6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774318577; x=1774923377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXYWZ3Af8+UWCG+9zf8xt8wJvtMCh01uE4kwpvainlo=;
        b=pQSvkIulJeAayjQA+LCYYroyfkuFb+57kURW/nD/TbH9Ge4ghxQXYP0xl4jtV9BsFJ
         NdYJpaKd4i8fy/Rz3T2RYMGI5+0nIGQ6SrKLyaJTMwmooreqSZ6rF8EQ3DBM0fHnh5fh
         WEsHTaQJDvNvGszBIJ2xlhyqz4uv3dq0JgdC+3Bvk1fOgPY5sSCNxeXST6X4sRhBtaXx
         +EUhW1KXdTq75/+lToq4yNL+rMWNt83E2/AaE8iSOtEWZBTGF4uid/87TXGKFH+g7nTP
         C87QuCHOjcHopBGd5ztR16yKwYnTnMcL6gaJEWKCnzOwoVywbgJ5wVZWfMq0yhgcH4al
         /87g==
X-Forwarded-Encrypted: i=1; AJvYcCXT71rQxJe9j33Kqrk0WT8P3Du4qpEbjs+yhClr2uaF5dRr7FegshgnEw7lVWgmNT5RCSBqmiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Pw8nz/d8MIzHRmL0BYi6fCNtQDsxuoJcwh79xuCCastM0WOf
	DRI2yy3EbFr4FUEFjuIKaJjCGOQVCilo7gyILG7rbJKlb2TFBS4hCJx4PTlnw22th8xwk2vZGK3
	qKw4JdKuvOzX6g1XQgqOgnRlwJnIOp0k=
X-Gm-Gg: ATEYQzyWQiCSHCCBUSZWZxYCAVyh27CXO+7Dg9B5PwEly0FSri3/83VuaG4iBqKJ1pe
	ZxC4oVe6Srj6qAgwmVfJAV83krZ6IvXvHYodCqJ732CipFMO/cEJ7gwmq3yvMOWLHnEaMcpYCj5
	ZKcU+raZTt0lqeS+sYG9Rw9KbPuW7lhDbeKx8wIeofiQ0RcEQzghwW44OXjfXYnzho6GpFlr6Gt
	bsFtjKEiCT+6FAH0pFPCdCJxQ2o3XHf/O+LWk0JA72Zcge8t72S4DIklhpk8cAPUwkvhDPohP8J
	VNgvS9BSELPtpCDHYlaaTz/r02CTLzdL3o7WQ4Rus7y/VKbHQgSoEKXiE5A=
X-Received: by 2002:a05:690e:4383:b0:64c:a41a:3a65 with SMTP id
 956f58d0204a3-64ed78937efmr1191837d50.13.1774318577568; Mon, 23 Mar 2026
 19:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323225250.1623542-1-martin.lau@linux.dev>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Mar 2026 10:16:07 +0800
X-Gm-Features: AQROBzDmBOwVNM8Iuq0GXGbuwKqfn5aRlGcf3rHTrRU9EEzZvW22fo-B-XQzorA
Message-ID: <CABFUUZGdgV9RgsFLnayOisXOAzyvT0szFTuV9miR0MnTxbaiJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,suse.de:email]
X-Rspamd-Queue-Id: A28EA3010B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
>
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=3Dm support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
>
> This change depends on that series [1]. Without it, CONFIG_IPV6=3Dm is
> still possible, and net->ipv6.ip6_null_entry remains NULL until
> the IPv6 module is loaded.
>
> [1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de=
/
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  net/bpf/test_run.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 56bc8dc1e281..fb25184ed03b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1157,15 +1157,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
>         }
>
>         if (prog->type =3D=3D BPF_PROG_TYPE_LWT_XMIT) {
> -               if (!ipv6_bpf_stub) {
> -                       pr_warn_once("Please test this program with the I=
Pv6 module loaded\n");
> +               if (!ipv6_mod_enabled()) {
> +                       pr_warn_once("Please test this program with IPv6 =
enabled kernel\n");
>                         ret =3D -EOPNOTSUPP;
>                         goto out;
>                 }
>  #if IS_ENABLED(CONFIG_IPV6)
> -               /* For CONFIG_IPV6=3Dn, ipv6_bpf_stub is NULL which is
> -                * handled by the above if statement.
> -                */
>                 dst_hold(&net->ipv6.ip6_null_entry->dst);
>                 skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
>  #endif
> --
> 2.52.0
>
>
 Since the CONFIG_IPV6=3Dm removal series also removes the stubs, switching
 the check to ipv6_mod_enabled() makes sense.

Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>

