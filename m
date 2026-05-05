Return-Path: <netdev+bounces-284566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GQnxM4ZA+mlCLQMAu9opvQ
	(envelope-from <netdev+bounces-284566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:09:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC304D3099
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21A423014775
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7A4BCAD4;
	Tue,  5 May 2026 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvxXfJ6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C154BCAA5
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008195; cv=pass; b=kRrCM2YymJLz6EIeUt9cZOMSe4sv6TfLfjlHdT5aZcPXABxfVoeVB8SyZ719QdIdzNlHRiMM16FGja1e6XvUCugS7Y51AvH63bnLww19IZzgWC3FwztmCbOcumml3Nr3Ubzgsn6C0BYIVNwiFP1aVyrSgRkEvD25rh8JO95lnF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008195; c=relaxed/simple;
	bh=Bx9gkPPFEl1fePOmnwnlCcaRXiZsz2HzPTFaFk9GHic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzZAnjzpAa6y+05NgUCEW6yBsQptBGqupZF9wSbBRRzu4GnTyDUxYZHQow/Np+ZIwrcwjfymi1+jsR14nv02bBUkPPsw4ECzVpAfA52QsJYPXEou5y5M2Rfxzk2KaUGFXAyo8bWYVBtmpGl4jkDhBNeJhGzswVJUSZG0ZnsS8BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvxXfJ6D; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so6123744e87.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778008192; cv=none;
        d=google.com; s=arc-20240605;
        b=RV2Xx1BCMUP62gutgSE+qvXeSdOnGCBKAjJEOcEDR8PQxu3wQSjMts5MYEvpYiXjVW
         kDoEEtTX/TqzYnHpYgI3+zKQr/cb4K7Ucq7cArxy3cUJzuQ3KS5WZ1Y4N0w4JqOZ6nnU
         pCowvz9BdSmEEW5OzskLO+Qoh/6wtbLaEyjao0OHZ/Twp1nNVTmXH9xYaMmJOatqwmPD
         TXUf0xrj6M2+sCgRhhzVb6u8gFXZ6DR9NKINUH/lyO1s3edqbJMFqs+qCnx+CLV/ZHDG
         6UsX6cqk6SBuKYPl+Mqn5wrJOxjXsqnD1cUbGDchIdwzXRdj7LUG6zKX05V/NBDbhnoH
         KxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        fh=Ucjy596EmGKE3YE3DWYWFMZEpcO3Ct6d66ju37iglis=;
        b=iPObHy6easLvBpWViydtNJpcDBv0+ORUFZKiu9tgUn43ya/NIaUHv8aNLw+6rpQeVz
         tY6lkgfT7/WCMPjtWL6tTI/CucppzkmBOBJHrvzFBFszE3WO9Ca+aT0JfP4g6a3MBs/k
         0p1ZAhyReAcvwrvKwWv2gbwjEf/CvGXAoMjoAOVDj0v1N6HNcdBBhGEvfAh86lX+3PyJ
         vBiDK6u8s5apwCzJ201rnzL6fFzENeruhfKRU2g9gPgrdDGv8Eu8DxOJDpeF0eBjRWbt
         NUFSqouN5ap3UEKTBkQy/vdt+UX8ynnXRu2K3AF9a1PwUhJLxEGNZX6sCPoiQn+dYRUS
         hFlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778008192; x=1778612992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        b=mvxXfJ6DPIdMtmEF4GCWwcPWSizeDTCL+EskQTmsJYfhXnKkXfJDT2yRsi6woiS346
         QtDu4fh90x5QD4111MTzP3WyjUNknLdGnxvMq4ERR6gRUXsyHLBTjm6c3LrhEEcRP4Fx
         bjUu8+n6UpxDz6U4Kh6M246QqWr71of4Egd5T1UTFGK58vo8MoIuyh0nU/0vDmhJ/PnK
         7lHvuXJLgEJE2/MLyMMhZbP/33tmn2mESRvU0kRHHs8ugjwfs0nB5SJBsNvv0e0ehAcs
         0QHBNnGEvrg+zB+strNjR/GXZzsEBY5fNsyP4GC6ObuMqeLEIMzCfYUa+wLL+a4MDC0s
         aicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778008192; x=1778612992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        b=F9vZlP3rDTDwDQ+vO4ZlSA/fUJRch308YMZ72PSRbvnjKYqqSCrUucprUOjFR39qDp
         tm78h8tDb80pSeZP2rOccVkGGeGNeZXOv3k7fjgbM0McHliPcqPHtphYUhbIoahecrjj
         vwqcpegT2hjs5QnhUBK5zzkhhHe8Zrq6xHuT3a3ppiAUJmUSzMe1VXLoRYCCuF8+JqvS
         4j+DxS0zrMf4XoTVUr1ih/lOWAJx28rw8vx67j31Ya3cQFaF52BA1O1q2bB2X39sflpd
         7Dj+o68i0wP+HQYA/pGCLXOaX/4/piWPY1t4xGwvCde5ui4Ge1tGvFMy7ZM/odEhpADi
         stsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QUXsmHGHOS2eJhl4RXNrqXI0wvmMW22xiFx73aemoCFWHg9EfI3oS/dHBIsBGVz6PIS71rQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw710l4sWOcW5fdXhDk2CQsEk+09uxoaRgLf2VqpbgGF1hLUpj
	OjFnVVmwJ8FEgyZPEDw0rkqvKZ9msvaIip+WtQA/ATD+E7ks5I4vArT5YduX/Nfn9XvnF84mWUK
	Z4GhjfxrvIaZQysQFTm+arioTFyLX0+M=
X-Gm-Gg: AeBDievq8ukk42QrcwKcqc+DGIaJM97f6TKnujMQXCrK6jnUTMCgeUYkhPe7zUfPm+R
	b+4W3b6jTUGZsNEp+6zAcEgCEmPR9kjlrm3NTey9o5fcwvAUA8xno1sMXGk25bLh28z0TORglB/
	hmVS5JSNE3wAFGT8KAdrcxW1m7CqhiK8ubx31FZ8k/yuhY+U0ZTbwvjToP05HjAKbKT5bk4EGVh
	p5RszAA5iwIDj1yyQRF2Zy8/u4kcNzjIdxo/i93xL4zfijU3ZZoDmXCfIOVQrSxQ9PwbUPBF3ec
	Cchh+PFkCohUZ/zi//UmTv+31MuNDI2DW2SZabAFtq39zJFM
X-Received: by 2002:a05:6512:3c81:b0:5a7:4783:a13a with SMTP id
 2adb3069b0e04-5a887adfe0cmr13645e87.6.1778008192233; Tue, 05 May 2026
 12:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-1-kerneljasonxing@gmail.com> <7418a37b-1aff-4b48-80b9-012830e5f9aa@intel.com>
In-Reply-To: <7418a37b-1aff-4b48-80b9-012830e5f9aa@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:09:07 +0300
X-Gm-Features: AVHnY4Kmshfoum5z54jJolebXkA9r9-UGluPM9tCJdED7bWrAykrbXBKxnxoXaY
Message-ID: <CAL+tcoBQiEtYaeCECCPkOnWdHD1vGPYbtUEe+RVUPn1j6SEuHw@mail.gmail.com>
Subject: Re: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3BC304D3099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284566-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue, May 5, 2026 at 6:45=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Sat,  2 May 2026 23:07:14 +0300
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > There are rare issues around xsk_build_skb(). Some of them
> > were founded by Sashiko[1][2].
>
> For the series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> Just don't forget to look at Sashiko's replies, I haven't looked deep
> into them, so can't say whether anything there makes sense.

Thanks for the review. I'm currently away from the keyboard because of
the long vacation. Now I'll handle them one by one in the following
two days. Hopefully, I can manage it today :P

Thanks,
Jason

>
> >
> > [1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing=
@gmail.com/
> > [2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > v5
> > Link: https://lore.kernel.org/all/20260424053816.27965-1-kerneljasonxin=
g@gmail.com/
> > 1. reword patch 3
> > 2. adjust the order of patch 6 that is now moved up to be patch 2)
> > 3. use helper in patch (Stan)
> >
> > v4
> > Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxin=
g@gmail.com/
> > 1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
> > 2. add acked-by tags (Stan)
> >
> > v3
> > Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxin=
g@gmail.com/
> > 1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
> > 2. move init skb after it's allocated successfully, so patch 4,5,6 have
> >    been adjusted accordingly (Stan)
> > 3. do not support 32-bit arch (Stan)
> > 4. add acked-by tags (Stan)
> >
> > v2
> > Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxin=
g@gmail.com/#t
> > 1. add four patches spotted by sashiko to fix buggy pre-existing
> > behavior
> > 2. adjust the order of 8 patches.
> >
> >
> >
> > Jason Xing (8):
> >   xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> >   xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
> >   xsk: handle NULL dereference of the skb without frags issue
> >   xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
> >   xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb(=
)
> >   xsk: avoid skb leak in XDP_TX_METADATA case
> >   xsk: fix xsk_addrs slab leak on multi-buffer error path
> >   xsk: fix u64 descriptor address truncation on 32-bit architectures
> >
> >  net/xdp/xsk.c           | 115 ++++++++++++++++++++++++++--------------
> >  net/xdp/xsk_buff_pool.c |   3 ++
> >  2 files changed, 77 insertions(+), 41 deletions(-)
>
> Thanks,
> Olek

