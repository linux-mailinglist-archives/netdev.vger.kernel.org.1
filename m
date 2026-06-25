Return-Path: <netdev+bounces-301977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b8nVOc45PWoKzggAu9opvQ
	(envelope-from <netdev+bounces-301977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D76C6964
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cdKspgzo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301977-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0140300E3B2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099234B66F;
	Thu, 25 Jun 2026 14:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDC347529
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:16:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397017; cv=pass; b=j/JZwLFgTDLVM/uJy008SglVWqN1IRRT5Clt7YWKhGr4wO/LPnPMcax12DEX+uxfrhajJ3IPxaefIacxg3nga8tW0h4S0ScnyhaWhum77HVwQ9h7EYvuSGM5MKKCDrP4QRzR/bWJoL3mXNS9dDn9iJYIH+24m+WhUpZhrM4FxZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397017; c=relaxed/simple;
	bh=W0vyq7YcmuC8WwkEvuR1qfqmZYoRCHyHLzHmSmSPVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG6GHckLAidd5dB6kB7Iwjg/R2indFoxhE9jdXxUcbWy2UlyqmLWEanA5DKi90rMQd333RCIv42KzBpvJzOpPWkVZjG9FZYwdRmGeeS1P3w8qSa3rtuWcoCSZrU2RuwAKb3AdAvsbqWXqNO27NPxLZo5rpMnjpUENZkN047iv7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdKspgzo; arc=pass smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1079010e87.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397014; cv=none;
        d=google.com; s=arc-20260327;
        b=gntKT0MGHvYlibkgVs3NBnwPgXZOyA0h6E0sYFVx0gLCmiW66ObtjMJSYjyEQIQTBy
         kvteAb01MmMubIpsFup2L7iLPU9Darsary/6wYzRRHTtchPdb77P8aius6atgqlLu02h
         0AObzNf1BlG1iD2HEJDsJraemHygGxHVNPGDZ8p8ND7fHyVSkSH2YzTKXdqe37L2TLcN
         889luWugFTgOOwSwyFz8dtOmGZh/d0FTS1uS9rXXvJru6Kf4VTQvDho0kUhwetJMODsr
         magAlJGXEQ1mzcrTICGMTrz/JrJV5X4zbg4/XfnLSgVzSkPtJaqwXlkHSuiBVAW0Re6h
         gv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        fh=JI3h9u+zcTfgqfsrvii+M2LwYW6m91hHHyR7PjAVQZI=;
        b=VkNzKlQ5fguwqlXu8q/KH5zXD/30+c22eor33Z5qxexSnicZpUgsHaFkN8bH/VzrXg
         h0WjY/IuUnhWbtbPhlrBp0ynLDiY3Izk/pHB2MGTdO4dzJo8XjyS9ijt4fI0PV6BsToD
         3H6EAH3zselTNtnqQVTdacaeCE4qSSS8r9dwaMphU7aoM0x5OZCGN27yDx41VtF7968L
         bAUu4XLms4I8eBaS9740UietUstZHkbfCUixa+0pQMV5pCHbLcZOwYl/LysSUVE9aeVG
         Ssoz4d8QxWiIaA7ICiIdpFlwOwDrJnL/n7SKKww2BmakMEynV+82+BZVvX04vId8X5qK
         8sOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782397014; x=1783001814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        b=cdKspgzo0+lxk5lvyCmvDveIeIjbHy69toCrTbln4p4VIRTFPSVn+/yWGjkIk1JjCf
         HthWRH0Yzu9+mkO84Rrcc4R/B51nozmhsvqJ0NexuZR7uhfphCnUDGqxWxY4pbgYXVRd
         oO9IvkzhMs03ZaixYZV8iThA4gcI61LZVh7GIYOUwNlPgKA15MwjWtsKAPFIjIM04jpj
         2YW+kkN5qCmNulKd92DnjmxJeowjLAV+0Gv+AF9ZqNixWkfOv50V3SeMAd4x2307aC2j
         JNdS8tGvIPtoOpaIUoal1exSi9uiyr5/GDTh8Vw0IAfwmWK2NY5oWBockujGPoJB6vZb
         uVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397014; x=1783001814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        b=f5s1Ifu3HoY+buVquQsn6ApRX7czRw/Hfw3yXIGms2xF+afTx4EyVqVrvOUkeGZ4O9
         t1NyVZo6vOqXRNUhEqThzTmgth7Ef9QemBHLNOdKCfK2DH51RMttUOi10ZTbemhmegDe
         ZmHYxPomGCECejb3JG0CWhBnkpuIMVnffFmGBwCHJ2KiJUGaQd6Nz20vq/E4DUQASsgU
         voHNgbF3C0hA7HMtgSw6H4+w9d/RRx7bY6+xiknjCzIngoKZGjOy/2shJwink/TpXDRm
         iqj8kXlKSqMg8F9n+UJno4iZ9GFrnz/pclG+8/cC2qtX5On+WBen2OGq2Wc5cC7LSiWQ
         wd5g==
X-Gm-Message-State: AOJu0YwnhvsHQ+mBzzDeM5rLg6TRC/OnYGr9A0/5wPdAULyrJxh5GYRl
	xIerl7VAN0Hpwo84Vat4j0+rwTzEWeJhFkA4wCJCdsxaacpwnCiEN/hJkEUWaO5ME29x2FpblXe
	5/J8MSLKXITSWCJi1h6+seYObJQT0ZKU=
X-Gm-Gg: AfdE7clOFBKmocVrYzUNgdNRsOyxysvV7f8XSoTqEgpHoiT65EPtMu6tAcyxPk8f79M
	Rwwwa1i8pXauiVzab6moQHXDapd/NKkUe+l3lZCnetpzIHJeuchf7HyyNfPTxx7OVUlokttgorn
	S5m0bJnphgKlM9HVMA/dLKss1CtZdiHH1cd6oc2/RrFUcftj+9c8LNwMQPotOhOxs9gKjjyPKCh
	QFuoRsrYjCtwOZ6postRBE6baA4gFY1K7NZXtmczCd2042CqXAcFddfuFKnijEo6pnZ82yHHiKF
	zAUZfkSaGC2nGKHpvi28vty2wjiyKUhZM+SgKnz2v0gL+tjZQLxrEgRHRNQiYbQcZgbN4y9NRa8
	SS4wBsxggCO3+5HPb69kf
X-Received: by 2002:a05:6512:839b:b0:5ae:9c19:165c with SMTP id
 2adb3069b0e04-5aea1f28dbdmr659555e87.7.1782397013921; Thu, 25 Jun 2026
 07:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com> <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 22:16:16 +0800
X-Gm-Features: AVVi8Cd_eNsml4y9VUFBX08VAzVlAbKnlPEBr2spRpxaaelvJdAWps3GMzCudr4
Message-ID: <CAL+tcoBapOxuWXyCJMNJ5ECeJ7XHFZ4K_Y1nvQ6LRZCEJUL7yw@mail.gmail.com>
Subject: Re: [PATCH net 4/7] xsk: reclaim offending invalid desc in generic
 multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301977-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 487D76C6964

On Tue, Jun 23, 2026 at 9:33=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> After an invalid descriptor is found in __xsk_generic_xmit(),
> xskq_cons_peek_desc() returns false and the loop body is not entered.
> Jason's drain fixes reclaim descriptors already attached to xs->skb and
> later continuation descriptors handled through drain_cont, but the
> offending descriptor that made peek fail is only released from the Tx
> ring.
>
> This loses one completion for each invalid multi-buffer packet in the
> generic path. Userspace then waits forever for a descriptor that has
> already been consumed by the kernel.
>
> If the failed descriptor belongs to an already-started or already-drainin=
g
> multi-buffer packet, publish its address to the completion ring before
> releasing it. Standalone invalid descriptors keep the existing behavior.
>
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path=
")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c489fadc3608..43791647cf18 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1125,8 +1125,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>         }
>
>         if (xskq_has_descs(xs->tx)) {
> +               bool reclaim_desc =3D xs->skb || xs->drain_cont;
> +
> +               if (reclaim_desc) {
> +                       err =3D xsk_cq_reserve_locked(xs->pool);
> +                       if (err) {
> +                               err =3D -EAGAIN;

xs->tx->invalid_descs--;

If the same descriptor is peeked N times due to repeated CQ reserve
failures, invalid_descs will be over-counted by N-1.

Thanks,
Jason

> +                               goto out;
> +                       }
> +               }
> +
>                 if (xs->skb)
>                         xsk_drop_skb(xs->skb);
> +
> +               if (reclaim_desc)
> +                       xsk_cq_submit_addr_single_locked(xs->pool, &desc)=
;
> +
>                 xskq_cons_release(xs->tx);
>                 xs->drain_cont =3D xp_mb_desc(&desc);
>         }
> --
> 2.43.0
>

