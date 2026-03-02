Return-Path: <netdev+bounces-262911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOnjHrgOpmmFJgAAu9opvQ
	(envelope-from <netdev+bounces-262911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:27:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 783CA1E5611
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B37183309D5A
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789239FCB2;
	Mon,  2 Mar 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b89AdYD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE439EF34
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485204; cv=pass; b=BfsPfXHa9FYRf3At5qPhaSLDMqK03mFOzPw3zuhIvJGz5evg/2QkaLXDfZNLBwuBS1QPMeW7CpsxOPNKIvI22gPPTtBmov6qPp9U0USm2nRVcRzm+FL7TXuPSO+fANDwg1625sGukuI3JPqPdPyMIKQnPyMy/NDGliYzxVpB1Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485204; c=relaxed/simple;
	bh=KjgbAzL1E1IdcmiEt5GtmmF34JBS0gwFcSJFm9y6PXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9PrxK/4/9kLKbv2e0PO0JfgTAC6CwSwKQcGk/O/0/3Nh1WHZTwTZ1UA6ERXiSTkpFC5kVuY6dk+P9ZBUxxCxKOAuUm9CR1cYtB+vld4Ov4BeCQ4TFM6NwYfhndLviZ0YiGdoGsJ38v4bJSuQIaMwjoLTGaRSbe0P1/eMbWo154=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b89AdYD+; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4612383eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 13:00:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772485202; cv=none;
        d=google.com; s=arc-20240605;
        b=S6ckOHsbjBA1+EkOOOUWs1xltBJiz/EyGlBW6Ndtmwi42dkLBNJ2sE8L2c7SCuzLmN
         5lILAQCASVJO+vMV2YYi9GW0LqmZeHy+H+/7uwNfYTd7e7srrsBon77j7mt7yGaJB7Ua
         M4RzMXONdVtpc4HfRmYir6QcCrwm3s0BVtjACUjWQrYaxXso7zmubSMcm6xDlZOnixRA
         pUbH75fgnNoqntb/aUcdWYR7TPsiTR/SMzLX2fUlbwSb/qISjb8bUH7Evh3A4IQQ80zo
         M3bbmshiedJdVoLbNvEx1bhpzFwdyBwevQmwJHq4lsm44wL9Tt0bYE+81imvbBU+Ui6I
         fPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        fh=KT0hOXxTuwe5vy3al4DAhksd1LyDVYQD5jf3b/TMVws=;
        b=AErtOzxaHXLVTUfTOHhz2uPlaqHXjWLjU7XAV4vDGimd0GzLvLTpDkRiJLa5XRYjaG
         nbWA3sZHiWYx0MsuXQTDWB80KroqXrvZ8sb70cWsVzKkmo9f0l8egHzvF33JSYGvZ1Kk
         dsO3ocBhy+1miM9QSBB8kxTpKSaWqPa3S3LoR+AU2ALRFQb2RY8TxTNGPK5crJ4QpKJw
         TCltwiXTBzNqHEuYhiicXsU/0JXqDYPx9wzsJCY0cQGm476ClwJxWmkW0MTlu4GIplWJ
         SJjEVcSH5q4VkAmyVAO2MVMkNH5IxtHK7dIgk04NMNW6F8ILFod0jUj+yZfefT4wiJ6p
         L4vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772485202; x=1773090002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        b=b89AdYD+VhDkxxWNjWXPUvruqjHpT9mAICFNkE2SU5wfIyERnLN/cMLYA45Vj3FtnU
         WfUnEcw8mS8wSDvSj4jm/nvcdCCfiE4WLy+VvNomgkxw1vIEXt6OlNRSqEOLel0v5we+
         8JU4O2zO3c8rghNL/V05MbR9HMArzrCMt82cCn0KA4CKu/McD1u1rVuYgjGM+JIPVO/h
         Lm18wjuJX/CvwCKV/sh1o4FsnSuCCF0z7JJYxFsvENSHlC/yyk9PcwlBYUWs3chDrhk5
         cX64aYFPCMSq2URvn8kmh0ksSely8MdXek9YxNjxj1d2surlkyVZUo3kp5IfGTdSs32r
         VxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485202; x=1773090002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        b=WQGto6xh+zjb2sHX5YyNYTPu/DmT1Z8m1sDJkmsi1BVUfn8x4wHdTKBf4G9sKPwR7F
         9dJzPWbVgBgxaTw1tspLjyfcZRLLk//VBiGFr3nBt6/ALyXXyWD8a6U0IwIlxoGJpdvf
         Bac8grjndPCgHC1CJyPylY38BAn7ZZQPmR/iZ7Pi+32bU+QkvUaQzFbOyChpopglaCCu
         kqnF9ALdUJ/NdPbu20Y8C4Ud/pFa4Bm2L8IncnN4Q20+738K+pYWsSZezpTr0UjFSvx5
         YX34kidWA5MYxjZm4gziB93gf9zWWPZRYhYOT2R5CV0DT5cY/BWq4cM7T06mjtRD+vjk
         T1mA==
X-Gm-Message-State: AOJu0YywC7Lie/70lbS7dub2//zfhnRuThil/rpuH8eZzYKrF7vgjZGo
	/ytT6jcm0xIOt6rll0b19YPdpQiDU5Du3iEqSv6XQPBYIzb22cIJ1K66ggn4Z0pd882+POsGaE5
	dIq/F7yOKgtu27kFXbLXnkzRnKSBXRJI=
X-Gm-Gg: ATEYQzxgZYcqxFKFjzJSRi9l1bB2MBbM2RgbHfbFqsohBixxSyXSWlQs9p2PsMiQ2y2
	ujcaAqCajMfTddX4qPh7OjKBvwqWQVPeg/nR+5Ml3JZE80R+j9R/1GNDKcfn681xTlZq2EK565p
	te2P/agh8LYWeqeVVVlQKr8A7knHknRNj6zcKQ0C8A8v/foy534H9uk5AP/ps7wD/6+o1XJh3XD
	gzMSvSXUlGXVUJq3TnDRudeRfNZhQ9e3uc3/jQMWzNpIeC0ccSbJPAERtpBrmf+c1GYzXUHxKY9
	q612n1zPgj4ZXNr8j+Yx8UVw5GyYWGO5SV/jTr569A==
X-Received: by 2002:a05:693c:409a:b0:2be:8da:321c with SMTP id
 5a478bee46e88-2be08da3393mr1740887eec.2.1772485202409; Mon, 02 Mar 2026
 13:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302203600.13561-1-ebiggers@kernel.org>
In-Reply-To: <20260302203600.13561-1-ebiggers@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 2 Mar 2026 20:59:50 +0000
X-Gm-Features: AaiRm52sgjZJdZRrfWpXsEb9jJIE1M7aZEwhGDOdaP19FXauiP7ZogndER0-Nag
Message-ID: <CAJwJo6Yt9v8pscqFB7mfuHGhwNSOE2no4Y5fu8o67atn=EtnUA@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp-ao: Fix MAC comparison to be constant-time
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 783CA1E5611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262911-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,arista.com:email]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 20:36, Eric Biggers <ebiggers@kernel.org> wrote:
>
> To prevent timing attacks, MACs need to be compared in constant
> time.  Use the appropriate helper function for this.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Thanks, Eric, LGTM.

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Could you also send a similar patch for TCP-MD5?
tcp_inbound_md5_hash(), tcp_v{4,6}_send_reset() would need the same change.

> ---
>  net/ipv4/Kconfig  | 1 +
>  net/ipv4/tcp_ao.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index b71c22475c515..3ab6247be5853 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -746,10 +746,11 @@ config TCP_SIGPOOL
>         tristate
>
>  config TCP_AO
>         bool "TCP: Authentication Option (RFC5925)"
>         select CRYPTO
> +       select CRYPTO_LIB_UTILS
>         select TCP_SIGPOOL
>         depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
>         help
>           TCP-AO specifies the use of stronger Message Authentication Codes (MACs),
>           protects against replays for long-lived TCP connections, and
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 4980caddb0fc4..a97cdf3e6af4c 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -8,10 +8,11 @@
>   *             Salam Noureddine <noureddine@arista.com>
>   */
>  #define pr_fmt(fmt) "TCP: " fmt
>
>  #include <crypto/hash.h>
> +#include <crypto/utils.h>
>  #include <linux/inetdevice.h>
>  #include <linux/tcp.h>
>
>  #include <net/tcp.h>
>  #include <net/ipv6.h>
> @@ -920,11 +921,11 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
>                 return SKB_DROP_REASON_NOT_SPECIFIED;
>
>         /* XXX: make it per-AF callback? */
>         tcp_ao_hash_skb(family, hash_buf, key, sk, skb, traffic_key,
>                         (phash - (u8 *)th), sne);
> -       if (memcmp(phash, hash_buf, maclen)) {
> +       if (crypto_memneq(phash, hash_buf, maclen)) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
>                 atomic64_inc(&info->counters.pkt_bad);
>                 atomic64_inc(&key->pkt_bad);
>                 trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
>                                       aoh->rnext_keyid, maclen);
>
> base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
> --
> 2.53.0
>

