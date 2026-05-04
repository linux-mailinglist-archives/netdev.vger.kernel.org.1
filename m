Return-Path: <netdev+bounces-283938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOQcNejE+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCF4C1336
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFB6230071E7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC23E0228;
	Mon,  4 May 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnrFLpYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6363A7F4D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911014; cv=pass; b=ZuHO0dyAUesshWHFWQeBRYyvGXZuWyIGOLmR19bzpwEY0xfxDMm+tjQjWk+pABPrWrr8jJUgHdbL/5frXXfLcViC1lw0D74v5N2x5sY32Aj9uRqCnp3dfMpWry/W7iS1DF1WMFBLx8vtZ+b0iuwYphdGfWJIfX2O5ApMvoVQdgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911014; c=relaxed/simple;
	bh=uoYIsiNnp8B5t698iHvOdLv2MxANuYFqYuG6O8DJCqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXhkPOX+hWzuc/Wtj3Bsv4MzpEcDydrKBiAgqQZI4FshzXuJTaB/DTGxPsz2eFNpf5Zfl+y1Hoty/LEFnaFF09Fqb+bWAy8tUqos605MjfylDD5F2jRQU+urGRqdbhtsYBuxDb1SziE3gL0OrEKvQDrGN3uG7jcay/Gl70PAJLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnrFLpYw; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d880e6fbbso49100381cf.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777911012; cv=none;
        d=google.com; s=arc-20240605;
        b=EKsI4CT1JTKbNVyMPB5H0UQX6Eu1rd/qhYT2oqxFYeltWrNbbEluQ56B+Y0DN+oTQh
         Ep96hWR8W+gRhzmmPJJLWR6ErimBrQevHjV4Odqemjvs6DdxgpcbnJ4VXWsuVFEoot9I
         0tAPVwjKJ7+VGeUSGGyvduNSbGjk2m4et2yZo2oTl4Qml4G98d1VbpihejlGyWMkZScM
         bcF40pjZ4+GFgcYUOYH6bwb0e8zFjw82qpJHfi3yvY0vAgRlL7WOt9fPiJcgBoUVKtTu
         7/BWZzm3z+OGsuEgCIs6ctgLz3keaa+8rtQAYynSq2IMExsd964ZwVtUBW/ebkF/lf4/
         nDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egOYHEAv0L6hvc3JzaR6OIc5zhvVouVIH8ZCrlOe4UU=;
        fh=n3J5RQqR088+ZSc2unEwgo5hgLw5she8ce2rrwXOClE=;
        b=OVTkXvmd17fawJYl946jn6V3g+WHTiFFTCUosAR6p7dz5tjgJw7n2vmFVATmT6IjRa
         sorU9+SHDk/tDeQij5pr1qBU9mljDhcJaEkIskrBC0EO68NhH3df/jpoLGa2LE4Z06bd
         G/LU5LxWGmyqRvF/HYV8hx/T0ylJsPXGZ2GQa+5P86pKdtCFeNmXAs7cAxpsONqKBkLt
         5FuxdrLC211qzpVkWWWghtAlS2vRdgSUGtutnH+upkQryYHXLWbn6QofrUGrE8AJ1uSN
         H07buXABGSJYpEWtqcvlutoHNRWghZ4hlxr5LA0m8sG7mTvogveB6trRuK40LxF6l+/z
         xwrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777911012; x=1778515812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egOYHEAv0L6hvc3JzaR6OIc5zhvVouVIH8ZCrlOe4UU=;
        b=fnrFLpYw4VgfYZoAstW0Fe+MKYpwiFAUaLQc8rRWZAPU/KzvCi58XhaOG9fxDovtjJ
         X+V3Ao8ZM5awiXivSwC94TcuJMGhee+cwQdsZu45rfXCbcB5AARCLtjOds8l1rGzRNQo
         J/g9m/yRLRQ2qIbVTDYIBboV9pa5Qg0O3JOGC4f1bBwjYUmdzRpZFYDwhDOs0jNQD17n
         QkkkVgADh7c9ZB+cz7eXfGkh5c6eHbGmyvTpVr9fl+lofV5PMXiGra64SHK6/bHFGgB+
         3M1sXDC32ExZOEC4Vqw/I713PzW9EiV/WTqysHVpDBmFC38Ds0LJkfKZhgUSHvOftnaX
         RxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911012; x=1778515812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egOYHEAv0L6hvc3JzaR6OIc5zhvVouVIH8ZCrlOe4UU=;
        b=q9FHl8Vtt67Bept6++n2+9X9oXjmAtSJ+lEHHu6MYuVOjjL1Y/Fd9jvrGCpD3rxEyw
         ES7dmXEqpea4UhQQHW8q8xm5CdMaa0Il4w7bHa1HAU39HedFNmBmUUtppah30CFbC0kw
         Qm4JDa+tS+HbXVMuOSO3a2CZNUrrb2jWU+xM5XpKy8eE0xsne5euA3HXM65G+f/H2h6z
         8r4o0uYl0o93uZlI3KM6vuBeWGHtAedCbr+Xw36hpPJrc7ymUCCFwnu2hKn8PQt0IoEG
         sMhJI5MnACxIC9nhELFq8nw94UVMacMmwvwhRBDH4VWMzADiYO9hgx8pr0GQJPwPsHjI
         F88Q==
X-Forwarded-Encrypted: i=1; AFNElJ9MnLu5QWmvVFGplAsa6Sz/yQZ35DHhvO2PeEbklNq/ciGjn8LRNM41epHi2Ffu0M2BzzQD7jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCNI9ZF0qxk5uumlBxFDVQeD0EqdUSCShbx/NPlE0bPlzRfHX
	uENsSw9HzpJEpYBAWQFBunohAGHKEsz7TTbYf27uBrQpgU3FG8QN/qNkYtHim9ABiUFpZsyzi2S
	dzSWfO63GaMSx85too9pBpVPu6f0ycmwePBZXhKE6C8Elpylsx7Rp1Rq/
X-Gm-Gg: AeBDietCEm1l/HI3KZpRB4s1uYByo7/CEZucXW/SokmSOa8zJI32AtbLgUkGzseEqY6
	9Of9ViFfgJgFVxH5KH+6YfYuiF5n96vWD/IjoXfPszkHm5YlxQEyoZgNFHXMYnYT3ufZNcuOXx+
	8UnrB0kSGZCeIC2z6p+j4sab9BeF05wwSP5wy5ODa/hCg3nKIkf1s6PFyw3IO3j2szRh2RL3qvw
	ykC/zkPGw7NhbqD+H3/Lgl98b2LMRhL1LnrjdYT6aVBuN8wRqrvUIh01TXmkxYT7lpZkkjFf+0+
	xD0jCkCWGegQHV+YgeHAXWN2pMvlwuJH9h48/kdDlMnjkkcdjSKeBPByI4L0fVFMra4MXQ1Mz5C
	0E2/rltxor/lohZVuZtW8sALD9FF/gepg0UYrNvHp3RgPG4PO5GY=
X-Received: by 2002:ac8:5acb:0:b0:50f:c133:2dc6 with SMTP id
 d75a77b69052e-513052ffc59mr2115781cf.19.1777911011283; Mon, 04 May 2026
 09:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144945.13477-1-ankit-aj.jain@broadcom.com> <20260504144945.13477-2-ankit-aj.jain@broadcom.com>
In-Reply-To: <20260504144945.13477-2-ankit-aj.jain@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 09:09:59 -0700
X-Gm-Features: AVHnY4JgipRNKWKY0LcrsoSXVmObV-WiVxAP8JM6YGvi_bhJWCk-t_akFQ6tU4c
Message-ID: <CANn89iKcaOK6rrY=m0SVfXdx3jTRXCE3T+jNQpw434UZ8oxtpw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: protect locked SO_RCVBUF from Silly
 Window Syndrome
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	shuah@kernel.org, quic_subashab@quicinc.com, quic_stranche@quicinc.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	karen.badiryan@broadcom.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com, 
	yin.ding@broadcom.com, tapas.kundu@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7ACCF4C1336
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283938-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, May 4, 2026 at 7:53=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadcom.c=
om> wrote:
>
> When an application locks SO_RCVBUF, it expects strict memory bounds and
> disables TCP window auto-tuning. However, recent TCP memory fragmentation
> optimizations still apply dynamic truesize penalties to the `scaling_rati=
o`
> of these locked sockets.
>
> For workloads processing small, fragmented packets (like Java's Tomcat),
> this penalty drops the scaling_ratio to 1. This shrinks the dynamically
> calculated advertised window, leading to Silly Window Syndrome (SWS)
> deadlocks and 504 Gateway Timeouts.
>
> This patch fixes the issue by bypassing the truesize penalty for sockets
> with `SOCK_RCVBUF_LOCK` set. To ensure the kernel still defends against
> memory exhaustion from large aggregate payloads (e.g., GRO), the penalty
> is still applied if `skb->len` exceeds the advertised MSS.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> ---
>  net/ipv4/tcp_input.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d5c9e65d9760..569299dafa88 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -240,8 +240,14 @@ static void tcp_measure_rcv_mss(struct sock *sk, con=
st struct sk_buff *skb)
>                 /* Note: divides are still a bit expensive.
>                  * For the moment, only adjust scaling_ratio
>                  * when we update icsk_ack.rcv_mss.
> +                *
> +                * Protect locked SO_RCVBUF from Silly Window Syndrome
> +                * due to truesize penalties on small packets. Allow
> +                * penalty if aggregate payload (e.g., GRO) exceeds MSS.
>                  */
> -               if (unlikely(len !=3D icsk->icsk_ack.rcv_mss)) {
> +               if (unlikely(len !=3D icsk->icsk_ack.rcv_mss &&
> +                            (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
> +                             skb->len > tcp_sk(sk)->advmss))) {

Testing tp->advmss is not doing what you want I think.

A remote peer can send GRO packets with tiny segments, regardless of tp->ad=
vmss

If GRO is what you are looking for, why not testing (skb->len > len) ?

>                         u64 val =3D (u64)skb->len << TCP_RMEM_TO_WIN_SCAL=
E;
>                         u8 old_ratio =3D tcp_sk(sk)->scaling_ratio;
>
> --
> 2.53.0
>

