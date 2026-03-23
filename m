Return-Path: <netdev+bounces-270732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG1aG8SjwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:34:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B02FD539
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBD0D309C4AC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59736AB53;
	Mon, 23 Mar 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxlkyVWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AB36BCE7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297782; cv=pass; b=vARtlrQoT5XtTtlM3JpDrQIqbNdHC4Onkm+nl6yhc1hqbdiz1uw0zn1WZjtnwcRAauQ78O9pbBonDjNPURK00o/RBXzAc1Cve6zGWjbDu+4xYmJrl90uUgD1+Ot3bYfOOlXG9PNvuZyKmEs7eDPDZLFyf7QkPJPe18iaDUwXfwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297782; c=relaxed/simple;
	bh=qwRaz43M17oW3hUHGIqNbrVCV6bItsFYHKmnhM6Wqrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXna5f5TjNLf5prNc+3+rOlgi6euyZIyYyM2+scIAxcWPIsPnm/WcjcIJHXsoHkLxkROYZijmPEyEyknVrgbpyWrNCxgaO5bjLQ55381I6LW+NWvm8q954cuMOJyoAUQJQUkCIfvqvIwhfQU4DdKesF4R9hDPERw3tfOC4IfxH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxlkyVWy; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so1144506c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297780; cv=none;
        d=google.com; s=arc-20240605;
        b=MLeCO3r86J+4giF0seYohzeQJd0UhEXSsE2Tia4xMfbttH8q/uhizIyjtb3wMU94LU
         5seZ1dWwSZC0sMDFKdfGa8q4CF4u5LOdFQ9hf4IgbO2xNyTBm+W0ngLXueWgTbJwGJEn
         IIK/lYBgoknKt4DUD2rSthkvP4WKuQXRBswAVffxl8sdd3rY/lkXnievxM8uHfxrcH5W
         YrooTI/aNgoFuyNfpj8DNqx3TDENsGUkJBM9XWX9z1fJA7v/WL7EXt+qJ/2vl+P6tLTv
         oyysVbRF79cTSM7MXHhzMYgrt1IHbOBdtKYrKQ9paUlMSBqmrpTmHHCYcEQLbKPr4KkH
         qwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p7TdcMddJwgSx9MlRhEv9s76cx2Ih7onGO6klp/vSwY=;
        fh=UwhI+9d1If6u4fHTbBwWQ216jMKuqAxKTLA8aFZPqHs=;
        b=ir9O5lqSn5M3QzCwZum4nzfGodAP9gfBhFXPCsNAqteSo3NPVhFUTDMiWCj5nOvJG2
         S97dnmtq8WuA78Em6Aoco08fgPaHG4D2ecG4fQqguZ2eKP3x45b93VZpb5Tkcshap4qu
         AWZCS3/0Bko9p+i3Fj+o2GKUMsoIddG7rs87HoDjptzJAcy67FpFmw82JVXOQ2NotIAe
         qW0k7grts5y+0H+I4/O0J5WPu5GHFMd9TepeTOx3RuVA7UHSyein1hJjEgCVajASeq5Q
         HOWKDd3ldF+8+ui2WDAc9lsVZVTh6yyIUxjv+3F+4JW/TG57T+S729GU8WSK9EyKqRpu
         PKZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297780; x=1774902580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7TdcMddJwgSx9MlRhEv9s76cx2Ih7onGO6klp/vSwY=;
        b=RxlkyVWypji92MnxDJiS4IAToEIynLsKED1U8gSp6Bbb/CchkpPaNpsDQX8BYn4KJF
         N4WkXMmg9ZL8akuqvrg92xBgj6gFr9PV+1Gs226uJIsOMtoZUVUzMkIIRN4e5K0zlOPT
         KAxVlM82MpezQVZtfbUt6IwjuANwF1Y7pOu6XxEbuZlhLzzl4rR7IQoBLhwgxhmDH/E7
         cgA3/+jcXK4GlgGyQfizfxG3b/rdgDkRJX4RSjFhMsgy6N+hQzRMUO+nR84fbxgWxfQF
         UtmIqL0/SoDvQQzLlsE3zYsoUyQr7RzH7gox6diS1oX6HH/uoYkryFXw9Zihocm6qaqx
         14UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297780; x=1774902580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7TdcMddJwgSx9MlRhEv9s76cx2Ih7onGO6klp/vSwY=;
        b=ara2fCPglJZIYOE9USmER1tqH7RS2jknMrk9PFt3Hnnf/iBs/YZpE6InU7rGh1aYhT
         Eluh+W7CKOjG88Yk1vCABv/eaqwggpTJCM9IOI/eCMrEjIxArmqvNmeVKKPyUc+3ZKYZ
         cw6ip7/lz4o3lhgY0dgQKSKV2wIqt5W8w8H5VrqImB28sNqYooY9NpgcsP4GZnS+jQRr
         2NHrRebgbFHxJ0u8X/yuZ+ZliF2TKxeXZ5CruRuq2D2yZR71nJK+FVfHlHBYJYrypyYm
         Ctne5q4kbHigPYnYm/209PP3hihGm7CcLndCT2oH95+Qo+esY9s2j/oL4rYu0a1CUVmO
         FmAw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSBw+bFL9tp4bvxQo8/DxqbE+kNcHytSIvqE2xmkJij/pZ90FSjgw0uYHU2ITMnlWceM6JFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2cib2+ghiGd4RgJMyUAAgSWE9fX58m0gnhTQg2aHmx2ruXuD
	9qQwPGdlaSYkwncmn4gbjzhJaL5HX2Cq0GNz1jP0KuMa5I0IpQkTZHttyFtP8Zf2BispGSbvhh8
	I8vqZvtJmwofQrnJd/oB3oI7jpHHj+2/2BdJ2SE/U
X-Gm-Gg: ATEYQzyrRyyL7p57DVs6hp3fAVyaBGEQoq9/GEDtsJSE3suLnW55kL7ACnTixgVgRkw
	boETy9bUa/OlBjzRoF5HTuZGcnfDcHU+lYAo9JOmzksVgRAs2ZOrTCV7DZmxCGvo1F0TEcfoD+R
	VlGkkF/G56vrlNgQC/xhcOlNQpn8/TxtHI806DoYllYsoMf3ELQmldFKdY+Pa7Q2haD7z+U9Osb
	Hf20E14VNx1XmUuhTvwtszzHkOtuFHLAJPL0SlVz+aPJUg1lh8wqpWX58hhvLZuYQrD9KAMDI9p
	1kTrEK04kMsthmu9/KEeNIqfjG3ZwSsRAFNLXNyDSGU+q1gbKKoICzolCQ8kOh7OMurqHhfJYQk
	f5xE=
X-Received: by 2002:a05:7022:520:b0:12a:6902:ddc6 with SMTP id
 a92af1059eb24-12a725961b3mr6823786c88.0.1774297779717; Mon, 23 Mar 2026
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn> <20260322052417.1216-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260322052417.1216-1-kexinsun@smail.nju.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Mar 2026 13:29:28 -0700
X-Gm-Features: AaiRm51dnjiSjWv2pF71jLaqB3QPBcnsU7eifHG7WCYU-oz4sc_T35e_BJV2QYk
Message-ID: <CAAVpQUAvZvahsUNVU4BHogj8dtRCDM=dK=VnJBSjJeNwV1fC7g@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: update outdated comment for removed _decode_session6()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@inria.fr, 
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270732-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nju.edu.cn:email]
X-Rspamd-Queue-Id: DE4B02FD539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 10:24=E2=80=AFPM Kexin Sun <kexinsun@smail.nju.edu.=
cn> wrote:
>
> The comment in tcp_v6_fill_cb() states that the memmove of
> IP6CB into TCP_SKB_CB must be done after xfrm6_policy_check()
> because _decode_session6() uses IP6CB().
>
> This ordering constraint was introduced by commit 2dc49d1680b5
> ("tcp6: don't move IP6CB before xfrm6_policy_check()") and was
> valid at the time.  However, commit 7a0207094f1b ("xfrm: policy:
> replace session decode with flow dissector") replaced the
> per-family decode_session callbacks with the flow dissector,
> which parses packet headers directly without accessing IP6CB().
>
> Since xfrm6_policy_check() no longer reads IP6CB() anywhere in
> its call chain, the ordering constraint no longer applies.
> Simplify the comment to describe only what the memmove and
> barrier() actually do.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  net/ipv6/tcp_ipv6.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d10487b4e5bf..619b35669361 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1688,10 +1688,9 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>  static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hd=
r,
>                            const struct tcphdr *th)
>  {
> -       /* This is tricky: we move IP6CB at its correct location into
> -        * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), beca=
use
> -        * _decode_session6() uses IP6CB().
> -        * barrier() makes sure compiler won't play aliasing games.

nit: unnecessary change.

Also, please check this guidline for next submission.

> The new version of patches should be posted as a separate thread, not as =
a reply to the previous posting.
https://docs.kernel.org/process/maintainer-netdev.html#resending-after-revi=
ew


> +       /* Move IP6CB to its saved location in TCP_SKB_CB().
> +        * barrier() makes sure compiler won't play aliasing
> +        * games.
>          */
>         memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
>                 sizeof(struct inet6_skb_parm));
> --
> 2.25.1
>

