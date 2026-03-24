Return-Path: <netdev+bounces-270900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP8BHOU9wmmCagQAu9opvQ
	(envelope-from <netdev+bounces-270900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B66303FF6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD1173182258
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF33CCFCD;
	Tue, 24 Mar 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvM/fOVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C23CBE77
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336748; cv=pass; b=JduW06XbJwgv6wjbR/pacbqClQvnXXWwNUkUmE9yblqBWmPOZYIpx/U7yxNP1LG2g7PGgSmPhIVVSmE98spRgA+JK60wl5lzvaG9Ih6aDKYpMP5zgrVLYqJdjSgZJUnZFlNDXWGEn4l097d9fBi3k/NxCVGzQ1MxtblNTcobkQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336748; c=relaxed/simple;
	bh=GioMay0z3RvGrI+bvOMxrRrL2BGI3lbKrkimRkrS1VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNYtTbu6Pgj7RLukwb6/No6vEw1SoiaPcgYgvwJU/Lutv/mh88/7bu9f+UAimE5qLItcgqlH4SKy7R/9YZ0Cox64m2Sasjsq+e25T3zkh60CTBJqFq+DH3XEK74QvLJir0LeLlo9XxRaJE5QfnztemwZXCwmiKJut9fquDfM46A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvM/fOVX; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89c4468686dso51883856d6.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774336736; cv=none;
        d=google.com; s=arc-20240605;
        b=Bs1oKkPaZJ2PJZ94y3g9X6mSHzQnTCIgmiNTXtBuogC6vTpOD4iDkYFbS5mK2cEnhL
         J6Cvgf1DLA1x7PJYNJZUcl3vD17AFFbtyvbHWxNvFLqEfj4Vx59JLNcB5EUd9ldFonCi
         lVCj266wCN0K2q4xcalX0W06ggdG7aQtX02B6obsiB09DA0h4OoSI8qQxXfL7+OlKmt4
         Dta3iNxVYqk0q2NVeSAZ7OyNTDtWIJO/YS9HqFDsvwt9q6gxobHbtgOaUvAlL477/d5P
         OCkgWaqMTutOmsUrE4ibRgUNINpncBZRPtSLANTqVlmXexeOThiA1Fo6oabbUqCjDIpP
         YGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GjKVYMKloW8tN0wIDskwyEALoOphOGhC8hi08Q33Ro4=;
        fh=cYV2rQ0Vvj4eAFaZRBrc4+BEkBYFr/o5DbC5ELc+ANI=;
        b=f+SB19KbEm3CPByeBvJ7zARbSccK/LvvKCPXH5q4XrCiJgGVHeqhR/uWIxSfb8oKos
         eS+ObiLmgPhMzyLePXeiRsDk11LxMRrmwCW/4/zA+WPLyolbCrcDIH2m4Hdnn0XpD4ta
         KLGnxRczdL3201UCmNc1H25GurWYndUhFBpTTFzNDG0GaOolJ7/EXh0bwAqGepmXtxAb
         XxdogUrGcc9dBYvUr/oix8YloY5g+zfr25hs5XrwI8h3A9tS8NfccwhO/fJpdlpmrqVa
         IBM2n7bnBqVhVzqXbU3pbzQje9nUuuNb3XGSpaJUgVjCHSCdxjqfDt4V2vXJoVfFtqV3
         ZvCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774336736; x=1774941536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjKVYMKloW8tN0wIDskwyEALoOphOGhC8hi08Q33Ro4=;
        b=IvM/fOVXU9bHWYMI2i3KLpf7CgqflDPFXvbsTBxM5OUsjehGJ5sChkQ5tmvkx09f8R
         Nh/zm1lJxAP40rdsFU2lPcsLpRuwpTt6V665hMIsA121jKa7bsigBKgdoS5p9mKzCZEu
         GsBk0gU0HoowmJp6k+2B93l72qAuPNwgvNEF2tWqREJU5nNe4T3nR7S8YZtYpTaMtdbT
         fEXWKk+mqPAHpYV4GiQjdSIU9oNdBWAn9HJvcWprM9bGHAxe/aowUa45w2wZnlXibgwz
         VnFmhv7Z6WPTbcd4rLJz7470iZwH6dhjSEQGJiMNDovFlJM3mhupFNuFmDq6WfK+tIaI
         LtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336736; x=1774941536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjKVYMKloW8tN0wIDskwyEALoOphOGhC8hi08Q33Ro4=;
        b=rLVQMfhSxa8scG7ldZqFtvWEX6qgXGtYRnPib5KqlYOwdbySKgLVgVSVapMDAYKJdm
         RRrvQU76R3xUxCuQ4nTuq+qi0Yqem3YruK3cx988cEn68FFG8rfl2opNqxJoMB3MDBWn
         Ibl8Hk5H+LMXuZEq+lpX94l8qzRr9240+VLhnw3EgySAhE3Wtl6FHkRTOUGx0/vWJlIB
         zIqjteQ2K5tbxyZT9KoCPNBwdpQ21qqA+kPXhShbRpHtNuCauv5HA1MXiiTLbj8R0J8B
         rewgOTz4hUYY7AbBRR3dJsYQQ9wsk0Bu0rIRdbFsVZRkPGuuqVDyjM29Nj4xSwqiFpsR
         z0JA==
X-Gm-Message-State: AOJu0YzbyKwAqstc+Ygk9O7zIvBl8+GW+8JvKbEia/HGIPN6t9XZuIvg
	MBnrupUigQ4New6f5sfULTiciaOC8Ks6+7u9ufGfTPSCJC7vORFQmN2BTLmEUkXorkBQ0445yRU
	LAxkdMGi9cnHHHqx7Ui/KFrFF/S6DOMBcnkXiO69L
X-Gm-Gg: ATEYQzxlKXehZW+TnxPgrf3I/rJiumJzk7Guq2vKkJKndaTfyn7rltnFBR15ZuuK9OM
	H2W9badDj/OLrrGCuYDkzoNqwmedxqQx2FEG/Uwevd1dUNLRvHVELOgqlpIDIthCRZWTmmaUvZ2
	YAO3WnGYysucRX6vssbkePsWDDhYz08iwpI11K+c+YXxO9Gk0NMs82Yivr8F/bptjk0gekvOVt6
	UMLhYu5HTvQfVG+vbv8RQS1Q2qyySzV/MzeLeZC6D/MVpKx9o2THryYGA7omRkEdu4vI0AldGYy
	3/QEGA==
X-Received: by 2002:a05:6214:4e81:b0:89c:44f9:e87c with SMTP id
 6a1803df08f44-89c85a8cdffmr245118496d6.48.1774336735971; Tue, 24 Mar 2026
 00:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324060410.1137199-1-atwellwea@gmail.com> <20260324060410.1137199-3-atwellwea@gmail.com>
In-Reply-To: <20260324060410.1137199-3-atwellwea@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Mar 2026 00:18:45 -0700
X-Gm-Features: AaiRm53LVuqc3tgPkdjQ5OCud-oJjiexn1bWMClLsMt295YllL2swqwujHey-r0
Message-ID: <CANn89iLFT_JF_h+EXFBUBrtqKRRsS5nRySYbX5sLisDV4LKKVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] tcp: keep scaled no-shrink window representable
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, ncardwell@google.com, 
	kuniyu@google.com, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, gmbnomis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5B66303FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:04=E2=80=AFPM Wesley Atwell <atwellwea@gmail.com=
> wrote:
>
> In the scaled no-shrink path, __tcp_select_window() currently rounds the
> raw free-space value up to the receive-window scale quantum.
>
> When raw backed free_space sits just below the next quantum, that can
> expose fresh sender-visible credit beyond the currently backed receive
> space.
>
> Fix this by keeping tp->rcv_wnd representable in scaled units: round
> larger windows down to the scale quantum and preserve only the small
> non-zero case that would otherwise scale away to zero.
>
> This series intentionally leaves that smaller longstanding non-zero case
> unchanged. The proven bug and the new reproducer are both in the
> larger-window path where free_space is at least one scale quantum, so
> changing 0 < free_space < granularity into zero would be a separate
> behavior change.
>
> That representability matters across ACK transitions too, not only on
> the immediate raw-free_space-limited ACK. tcp_select_window() preserves
> the currently offered window when shrinking is disallowed, so if an
> earlier ACK stores a rounded-up value in tp->rcv_wnd, a later
> raw-free_space-limited ACK can keep inheriting that extra unit.
>
> Keeping tp->rcv_wnd representable throughout the scaled no-shrink path
> prevents that carry-forward and makes later no-shrink decisions reason
> from a right edge the peer could actually have seen on the wire.
>
> This removes the larger-window quantization slack while preserving the
> small non-zero case needed to avoid scaling away to zero.
>
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
> v2:
> - rename gran to granularity
> - clarify why representable tp->rcv_wnd state is required across later
>   no-shrink transitions
> - clarify that this series still intentionally leaves the smaller
>   longstanding non-zero case unchanged
>
>  net/ipv4/tcp_output.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 35c3b0ab5a0c..e5c4c09101be 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3375,13 +3375,19 @@ u32 __tcp_select_window(struct sock *sk)
>          * scaled window will not line up with the MSS boundary anyway.
>          */
>         if (tp->rx_opt.rcv_wscale) {
> -               window =3D free_space;
> +               u32 granularity =3D 1U << tp->rx_opt.rcv_wscale;
>
> -               /* Advertise enough space so that it won't get scaled awa=
y.
> -                * Import case: prevent zero window announcement if
> -                * 1<<rcv_wscale > mss.
> +               /* Keep tp->rcv_wnd representable in scaled units so late=
r
> +                * no-shrink decisions reason about the same right edge w=
e
> +                * can advertise on the wire. Preserve only a small non-z=
ero
> +                * offer that would otherwise get scaled away to zero.
>                  */
> -               window =3D ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +               if (free_space >=3D granularity)

@free_space is a signed integer, and @granularity is unsigned.
If @free_space is negative, this first condition will always be true,
because the comparison will promote @free_space to a very large
(unsigned) value.

> +                       window =3D round_down(free_space, granularity);
> +               else if (free_space > 0)
> +                       window =3D granularity;
> +               else
> +                       window =3D 0;
>         } else {
>                 window =3D tp->rcv_wnd;
>                 /* Get the largest window that is a nice multiple of mss.
> --
> 2.43.0

