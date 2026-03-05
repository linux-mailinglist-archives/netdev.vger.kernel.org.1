Return-Path: <netdev+bounces-264179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CTAA6MJqWlc0gAAu9opvQ
	(envelope-from <netdev+bounces-264179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:42:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F820ADFC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B46AF3026AA4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3D28726D;
	Thu,  5 Mar 2026 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKvyCFtN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB52773CA
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685728; cv=pass; b=kQ8+zJWq9EV5RbCkhI9evhv2CXW50jRgYwf8eANRYxiYDPyJlRdBJLFHOzz1yTCHsTJN6AWM0syMAcpTysJQr1UQ3GOqZHHzsOkLowpq0qMQW+uPRbazFU2h0MziYRR2+O19KU+uw/calmOhYVkCUDKPBh0uW5bEUtiyc10LnTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685728; c=relaxed/simple;
	bh=b3Xkd4EKnRyb7vdnRVFaQz5szPGJij4qxH5oDzMhz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYJQxnh3GkZLmXCUakX2xCbIrFwfMOKEU4wRT2Jip8R3k5pkRt39q/FiucbdTDc/6h1+DSJWREWhGw3adKo9jst9u5gYObb/U7QmKZWiQGdwsHn8asD/F3C74Q1crmU5cvTVBVcTAH2ya07Tvw9mXcwNvbeZBWLUX/PlCyQUnN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKvyCFtN; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8fd976e90cso959798766b.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 20:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685724; cv=none;
        d=google.com; s=arc-20240605;
        b=SoWVhPD0Y4Zn11lpN3InJHcKk8om10Dk9EdPSyTBuDWjL5BUN6slSrr9BeNYwKphpQ
         Kv5k10RYPxSXXBoTIFyLMsT9ruTN22JmpBoA4Ylde8zIwenl3Aojp7DpK3SuNtoS5n0D
         30Az/OdW1ggaMZSy1jHzOLsvyDi1Y1wu7rL8WNMcdWiez1XwnI1iDytLi9oGzUfiAklV
         /WpaYhHA9Nahcj5gjbqFfg4UrmamTyI8OcxPD1i6QjG7zgd6O62VcGpDDsl6jLHINimr
         8H/JGWUMgQ1Fwp9SedrOnZ20IqjPElWB/iFTfAzq+piDfUapU9DyHccZYH+GPq9imaWo
         if0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        fh=zUk3AqAwbD8DawzUwSAtCNhQcObNGBzVrxAzTtv1ztk=;
        b=gjJWORiwJm+ZzOPr7b7VQdTBi6EXVBQezWMHv9zd/8cpsUT08lj1Kk4QcZxlLLDazJ
         hBAF6r8nPnUQh8lrW7/LMk82lvvIXgDttfJZXnNH4dEuCw9lvVKnHyORgwo5V9lTXQmO
         BKWPoW44jRwaBBbTMwHUwgxYCAbkvjVWwnBZJ/B2u10H8KxU0ZwWp940ayGYjIzq115M
         Xd1tSR3soN5dHWbxRFC0yjrhnZvEjuFO1d0zVH0eEuAMbjysEAUh4hWxtS4Im/9TIk6G
         ZQMLVj4vmkGIWY1XBjbiK5DIalVsXTr0fypt0PfIszTe0P2RPXFpZkYLtlFCqSMjgjjk
         rKRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685724; x=1773290524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=wKvyCFtNp2FYAD5iUZuRTr8+gCaU0TlVOD/+y4ibaYEbajzz6KZC/aZK07ApJJmvG9
         3NDenGzH0jboVMlOpkp+TrXpcon4cA5pZTzS+rSPvrzUfcPQ3gACjChyxIzkj/5Plgda
         WZj3CzxuvFn6RBzC3OFw4a95WmUaxeZvDQ0I02E89/qbiECMRK4IJWvUZ6GbqllrOc9g
         Qa2B+eRShjeRG5nWBgHJKTdofQYAN3tDEokTTDff/eBtEQuTU1DWFBrVslFQIQ3fWApA
         FZtp6GAwVWgdo6sZbJlyRkLzdKvPR008HeYFgQncFZk5S37SQfd6hwgQOPn2/WqwJzm0
         pMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685724; x=1773290524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=ntS5tx+w68EbOdBdMpwL13DKQLMWrGp7MElpVDzUhf5iI4YuAbTkaPoONgBUyc1Pj0
         o5cOuVnEtt1sSoct4QQAr+J7AQnad/Q98k/D6SrGUWTnfLq8cBf+IF0+QOFZSi5JDhPt
         iIrLzYdBQ1+3b4zS61T3gk/hYA+xfk4bniWIjGanPghnZ6XyKPp8Mvidns4wRyc4aHQ6
         lNvw2FxUkXDDlLhpf3c0tnfSBEouvIJFplRrrvcnDcUzknPwNZDSDXO/9rW8Ph+epbAp
         gsuIPPpsRM6+AtYGzQ8b1Y+uYiDbHQTaGbvhyCoSEjMKaUNy6KPQxiyyeN4qsdJnGYLr
         +x/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlHVDQF+1h2ia8+Ef00x2LKR2olmeZjmPe/wjCCyFC4dQ3A8xjSBTIt0y+I7aCGU4233Z4cWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtCe414six4j3k89XJs8X3YtvNdDShJLN49eB4CjN1qq3jxvo
	nf82z2rxOXIa+3McLZMaNx0v0YRvz2mSycAGm3Su+6IKc5Pq660VIvmanqWFlZ9svhqN5lVL2ox
	FwAptmDJ9/PXA2HqoYd6fllRuHPvkn1/DGlkTNt8n
X-Gm-Gg: ATEYQzyWVwLMoz/LzylGdkRe1xdO5OFVGV2RC5c48P1W0WVPNVh7SavJprpAFEm3K8c
	NIZIPEGwW7CF7y31vVCm/0tPnXJg/XfO4x1UUAqtp2YpzJ5WuRPvNro3O10ddMW+p290gvoS22T
	7KHV3kjGh413koiBNl6YzwBiAwooim1jENfD7k38Tst9CeJ72ExQePkf9qCslKDxOe5cCq5MeIQ
	5RS4dorAqxxlm60wPV2OYco2f5MeS7bsA84gUZlt4DdNWX/U8mUPyZ6kZ26CS/PO0mP6MVJJC/s
	YZjo7yDD8r+Oldy20B1VZWQJbG2oL5m4wxBcafcEZJIxMlnO9OfFJlTtWigoXsBsjLbj09Ke
X-Received: by 2002:a17:906:6a1a:b0:b8f:bb98:b8f6 with SMTP id
 a640c23a62f3a-b93f11c5ad3mr265537366b.19.1772685723621; Wed, 04 Mar 2026
 20:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com>
In-Reply-To: <20260304111517.2088694-1-kmta1236@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 20:41:50 -0800
X-Gm-Features: AaiRm51le4VIOnY5bCLbPnwrxhsRbSgcv1k1w5UJIrgYGqVkL7f7CO9wRGze_zY
Message-ID: <CAAVpQUD0gfpzZaMDBNuK2RQ1U5=3=5u-gb-jpLMxFvYPYQ+-Ow@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A50F820ADFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264179-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 3:15=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

