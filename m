Return-Path: <netdev+bounces-288676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RkxNH28jCWpmKwQAu9opvQ
	(envelope-from <netdev+bounces-288676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:09:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B755EFED
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C176F300646D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B63101BC;
	Sun, 17 May 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8vKpF3q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEB23C8C7
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983785; cv=pass; b=BYCCE+oBYE+8mvwABMPMl2XDodkWphL3uzC/nDo9+qwiITJK5W4Jf/spd/iJA5wb8FfD1YddscttzVjfFY+HxIt0Ai6SNmaBj7dCLPKVIlwJll687reSHZl21DhUwyb+VS9E1J8a9lahHAcdULZUEA4wF8//NiUxsb2MX2NdGMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983785; c=relaxed/simple;
	bh=wCr4N8mYfYoIPWB9C8PT2ELm8Fckx0JWQsBfxrIsZoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNKy2S6hp1SWYNi8QCzBH4oT9T5vtgIVbUuBGPctevNr5ZEBM9FsZECX6NdOoPGxstgzM0/f7NypNT8XPwMu7TXzAmXRpBBp0OVQV+VrV6jzR1VFswpX4mH6fgQ5ASJemcmErW8dSeJqW8t2JlIpiYZ5zbP8KU9MIV9f52FFslg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8vKpF3q; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a877510541so1394024e87.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778983782; cv=none;
        d=google.com; s=arc-20240605;
        b=Dj3lgE5/qcxn8r/sroIKpmCheLE6ndPiMSTorSKxYhPDPR15e2HeNUhvCOb7SsRwkE
         GkeY/2jw9539eMYxVXCLwYmj8wH9r5oSSe6nuS1IczIg8SqqqsiF6LmulYRM0zqVZS/Z
         6HkDrstNOAnkDlNQchuujJF39/e1OD/LB9zuVbB7VyrnSr/GgpYpfcBcp5jhn6+Wu8Iz
         K5/CBELr5HIsw74zVksWzL/CZs2iNTZI0RfK1SCvFIdrPFW0WOfD6q7yTw/F1Ixwe/cE
         wXtL4dZdh39HgH9aI9+2rW35gU1V/EF6hf+oFp5Us91w52qf+9GwYoQ4qkG8QD5PBb+x
         AEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        fh=h1DMvjMTv62eitf7lTKSJFH8UTrrV8tCPNxrxYZqLUU=;
        b=hUi2ApXdlDRtNGd60Nv8SE1BWpGpzgFEYQcyriyd58vY0xmQHCeF+hmi1x++s8pVXh
         BSHRUp0XHfb2GSlhwrvinV+hbrCKy+O/XeJ3rQFfO949ShNIrSbqhFtM8mRXFCHPA0pX
         MTip/XpSy4hNd1RPn0pamlrQcW7aW88oFxG+1FuPnqNe9dRBbBgQ7fhLUgWUCZ58O752
         RTXYwc52NnNHA2W5wqNuFfE3rhfn8tDcg0IZ38BLQ3LZwR1XycyYjN6He5SdR07VM7pA
         3szovxUcbfTA8qpLx9RyXVp4u5LoNEtFkEcymzv4gCId35+X4v+GfxwmXYYhmj7YK4Z5
         GZpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778983782; x=1779588582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        b=P8vKpF3qvGMznU1qwNMFV/H6wcMlIyX9Fito7HiMvppEbz9rekeFtBLdoGIUQER8IM
         J9v0/LcpK8SFCtoFgE4wVZj7+w6z2ibEePI3Ihz72hmBUTFeVfTp9AgOdXRm3jZ5xJxA
         Kb9mc/4tkrH4CeUvy0tFU4K7E2ZpGYzHyOxCnPUtD8NM1z23CmxE91E1d2tNtIrqI59H
         Kp4YAkT/9UNBcjuEeyJE2cue6rRF+UjVKRrVropuaPHlm8l4qlyIM4p5nlxOEAQ/FWi/
         X/Si4hBtZn8sV1dGkaIg/G+aItKTV8Rbbtgw/MI6S67aPp8B3vHvtlPfwxhAKUz7VPxe
         A8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778983782; x=1779588582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nO3j0t9MiAa/cJqnzOkw+Q9w6M93B+L1CjXXR/zt8LU=;
        b=ZI3wUFnLN6uKuJhnlIdY6GWCep5THw2jJ7dC6dg5ZtSo6x1zDFop/JsEQRI8RYN11c
         3XWnMpk202pgtIdQbIbG3M8pHy5nX9BKwRHsyRwXro3b3LwoTsNkJU6+A24WluJvYobq
         ivC/1Me1+mDoOBsk6rxDbgv8H40zwtkBuP/HfcmxZOWSCwa4+2MvHg6Y7GrryFSijC9g
         2365DQz9NYQQ4xLnLiO8vfUhZPjCzXanr9rxf7Mv38coDfx49L8c2+JHRqd1woExa/S/
         R+aZtXWhsjiTrzqU9V9fIRJmdbQI9uzpKfbokgP514W1LtsftKX0Ts9LqSNMw8VbPHUk
         0qeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xg6/7+RcM6oFjzQUmvwdfxirjnmi6XioUyx/xiW5jffBja17dv3gBTzcsDyUFrfXE3vtYnT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dvNhukYCnQDAIw+b0G+MTqII28FB9amH0GjZqxZgeZFQbMxJ
	ZuKkfeSQUBx7/E1g5kKRuGp4v2z0HGb6DYgi33Qr/AKrotU0+NFIEJkUvBleJWCcKrJA9CBGChM
	ENhwV71NX8jMYgUBek/f94z3Rf2pZWrc=
X-Gm-Gg: Acq92OF37CdUPXfmRWNDp2lHWufzYihnkqldDuSrxaFiLF7TM3109iNSN/Kk1LSumTR
	HVzliTduggtzmzDGbR5v+witdYljeavgd3PxBSmL5m++QVN9f7Dt8ToFR0+GZCAKj38JsOOQwB2
	lZ/5hN2eomFE4/oy7vgpyDvO74SQ1GWj94deZb5VLZsfc6W9HGj2KRcee4MMLGL/7qHbFZ+KGWM
	RW7tmCEUaOL2xTWPAfhvj4tHkVhn63eJNQJ9+cpFQIZRZXaJolTtrId+5c7hG+vb1EAaBcMzKZC
	vfzG0kj++OPEq9yGlMZdwJEbuvyGCIfrntdZbijbbggSw92zTA==
X-Received: by 2002:a05:6512:128a:b0:5a8:6c7b:f9d7 with SMTP id
 2adb3069b0e04-5aa0e769eecmr2807294e87.41.1778983781501; Sat, 16 May 2026
 19:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-1-kerneljasonxing@gmail.com> <agdRCYgpmVKkrQFB@boxer>
In-Reply-To: <agdRCYgpmVKkrQFB@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 10:09:04 +0800
X-Gm-Features: AVHnY4L8iEfTvBrUVUtHlcv0-8kRC6326SHOWRCABLdtZk3dSp_FwiYWdc9NopI
Message-ID: <CAL+tcoBqr2Hb_Lkprp5brxLeVnr0fQDY=sUKEVdD-CcowZ7BRQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 133B755EFED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288676-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 1:00=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, May 15, 2026 at 08:30:13PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series is the product of previous review from sashiko[1].
> >
> > 1) META
> > patch 1: address TOCTOU around metadata.
> >
> > 2) PUBLISH of CQ
> > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> >          overflow occurs.
> > patch 3: keep cleaning up the continuation descs (more than 17) and
> >          publish its address when overflow occurs.
> > patch 4: like patch 3, but only handles the invalid descs cases.
> >
> > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxin=
g@gmail.com/
> > 1. adjust selftests (Jakub)
> > 2. add READ_ONCE in patch 1 (Stan)
> >
> >
> > Jason Xing (5):
> >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> >   xsk: drain continuation descs after overflow in xsk_build_skb()
> >   xsk: drain continuation descs on invalid descriptor in
> >     __xsk_generic_xmit()
> >   selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
> >
> >  include/net/xdp_sock.h                        |  1 +
> >  net/xdp/xsk.c                                 | 48 +++++++++++++++----
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 45 +++++++++--------
> >  3 files changed, 64 insertions(+), 30 deletions(-)
>
> this adds regression to xskxceiver runs on real hw (ice on my side):
>
> PREREQUISITES: [ PASS ]
> 1..108
> ok 1 PASS: SKB SEND_RECEIVE
> ok 2 PASS: SKB SEND_RECEIVE_2K_FRAME
> ok 3 PASS: SKB SEND_RECEIVE_SINGLE_PKT
> ok 4 PASS: SKB POLL_RX
> ok 5 PASS: SKB POLL_TX
> ok 6 PASS: SKB POLL_RXQ_FULL
> ok 7 PASS: SKB POLL_TXQ_FULL
> ok 8 PASS: SKB ALIGNED_INV_DESC
> ok 9 PASS: SKB ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 10 PASS: SKB UMEM_HEADROOM
> ok 11 PASS: SKB BIDIRECTIONAL
> ok 12 PASS: SKB STAT_RX_DROPPED
> ok 13 PASS: SKB STAT_TX_INVALID
> ok 14 PASS: SKB STAT_RX_FULL
> ok 15 PASS: SKB STAT_FILL_EMPTY
> ok 16 PASS: SKB XDP_PROG_CLEANUP
> ok 17 PASS: SKB XDP_DROP_HALF
> ok 18 PASS: SKB XDP_SHARED_UMEM
> ok 19 PASS: SKB XDP_METADATA_COPY
> ok 20 PASS: SKB XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> ok 22 PASS: SKB TOO_MANY_FRAGS
> ok 23 PASS: SKB XDP_ADJUST_TAIL_SHRINK
> ok 24 PASS: SKB TX_QUEUE_CONSUMER
> ok 25 PASS: SKB XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 26 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW
> ok 27 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 28 PASS: SKB SEND_RECEIVE_9K_PACKETS
> ok 29 PASS: SKB SEND_RECEIVE_UNALIGNED
> ok 30 PASS: SKB UNALIGNED_INV_DESC
> ok 31 PASS: SKB UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 32 PASS: SKB SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> ok 34 PASS: SKB HW_SW_MIN_RING_SIZE
> ok 35 PASS: SKB HW_SW_MAX_RING_SIZE
> ok 36 PASS: SKB TEARDOWN
> ok 37 PASS: DRV SEND_RECEIVE
> ok 38 PASS: DRV SEND_RECEIVE_2K_FRAME
> ok 39 PASS: DRV SEND_RECEIVE_SINGLE_PKT
> ok 40 PASS: DRV POLL_RX
> ok 41 PASS: DRV POLL_TX
> ok 42 PASS: DRV POLL_RXQ_FULL
> ok 43 PASS: DRV POLL_TXQ_FULL
> ok 44 PASS: DRV ALIGNED_INV_DESC
> ok 45 PASS: DRV ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 46 PASS: DRV UMEM_HEADROOM
> ok 47 PASS: DRV BIDIRECTIONAL
> ok 48 PASS: DRV STAT_RX_DROPPED
> ok 49 PASS: DRV STAT_TX_INVALID
> ok 50 PASS: DRV STAT_RX_FULL
> ok 51 PASS: DRV STAT_FILL_EMPTY
> ok 52 PASS: DRV XDP_PROG_CLEANUP
> ok 53 PASS: DRV XDP_DROP_HALF
> ok 54 PASS: DRV XDP_SHARED_UMEM
> ok 55 PASS: DRV XDP_METADATA_COPY
> ok 56 PASS: DRV XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> ok 58 PASS: DRV TOO_MANY_FRAGS
> ok 59 PASS: DRV XDP_ADJUST_TAIL_SHRINK
> ok 60 PASS: DRV TX_QUEUE_CONSUMER
> ok 61 PASS: DRV XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 62 PASS: DRV XDP_ADJUST_TAIL_GROW
> ok 63 PASS: DRV XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 64 PASS: DRV SEND_RECEIVE_9K_PACKETS
> ok 65 PASS: DRV SEND_RECEIVE_UNALIGNED
> ok 66 PASS: DRV UNALIGNED_INV_DESC
> ok 67 PASS: DRV UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 68 PASS: DRV SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> ok 70 PASS: DRV HW_SW_MIN_RING_SIZE
> ok 71 PASS: DRV HW_SW_MAX_RING_SIZE
> ok 72 PASS: DRV TEARDOWN
> ok 73 PASS: ZC SEND_RECEIVE
> ok 74 PASS: ZC SEND_RECEIVE_2K_FRAME
> ok 75 PASS: ZC SEND_RECEIVE_SINGLE_PKT
> ok 76 PASS: ZC POLL_RX
> ok 77 PASS: ZC POLL_TX
> ok 78 PASS: ZC POLL_RXQ_FULL
> ok 79 PASS: ZC POLL_TXQ_FULL
> ok 80 PASS: ZC ALIGNED_INV_DESC
> ok 81 PASS: ZC ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 82 PASS: ZC UMEM_HEADROOM
> ok 83 PASS: ZC BIDIRECTIONAL
> # Can not run RX_DROPPED test for ZC mode
> ok 84 # SKIP SKIP: ZC STAT_RX_DROPPED
> ok 85 PASS: ZC STAT_TX_INVALID
> ok 86 PASS: ZC STAT_RX_FULL
> ok 87 PASS: ZC STAT_FILL_EMPTY
> ok 88 PASS: ZC XDP_PROG_CLEANUP
> ok 89 PASS: ZC XDP_DROP_HALF
> ok 90 PASS: ZC XDP_SHARED_UMEM
> ok 91 PASS: ZC XDP_METADATA_COPY
> ok 92 PASS: ZC XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> not ok 94 FAIL: ZC TOO_MANY_FRAGS
> ok 95 PASS: ZC XDP_ADJUST_TAIL_SHRINK
> # Can not run TX_QUEUE_CONSUMER test for ZC mode
> ok 96 # SKIP SKIP: ZC TX_QUEUE_CONSUMER
> ok 97 PASS: ZC XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 98 PASS: ZC XDP_ADJUST_TAIL_GROW
> ok 99 PASS: ZC XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 100 PASS: ZC SEND_RECEIVE_9K_PACKETS
> ok 101 PASS: ZC SEND_RECEIVE_UNALIGNED
> ok 102 PASS: ZC UNALIGNED_INV_DESC
> ok 103 PASS: ZC UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 104 PASS: ZC SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
> ok 106 PASS: ZC HW_SW_MIN_RING_SIZE
> ok 107 PASS: ZC HW_SW_MAX_RING_SIZE
> ok 108 PASS: ZC TEARDOWN
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
> 1..108
> ok 1 PASS: SKB BUSY-POLL SEND_RECEIVE
> ok 2 PASS: SKB BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 3 PASS: SKB BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 4 PASS: SKB BUSY-POLL POLL_RX
> ok 5 PASS: SKB BUSY-POLL POLL_TX
> ok 6 PASS: SKB BUSY-POLL POLL_RXQ_FULL
> ok 7 PASS: SKB BUSY-POLL POLL_TXQ_FULL
> ok 8 PASS: SKB BUSY-POLL ALIGNED_INV_DESC
> ok 9 PASS: SKB BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 10 PASS: SKB BUSY-POLL UMEM_HEADROOM
> ok 11 PASS: SKB BUSY-POLL BIDIRECTIONAL
> ok 12 PASS: SKB BUSY-POLL STAT_RX_DROPPED
> ok 13 PASS: SKB BUSY-POLL STAT_TX_INVALID
> ok 14 PASS: SKB BUSY-POLL STAT_RX_FULL
> ok 15 PASS: SKB BUSY-POLL STAT_FILL_EMPTY
> ok 16 PASS: SKB BUSY-POLL XDP_PROG_CLEANUP
> ok 17 PASS: SKB BUSY-POLL XDP_DROP_HALF
> ok 18 PASS: SKB BUSY-POLL XDP_SHARED_UMEM
> ok 19 PASS: SKB BUSY-POLL XDP_METADATA_COPY
> ok 20 PASS: SKB BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> ok 22 PASS: SKB BUSY-POLL TOO_MANY_FRAGS
> ok 23 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> ok 24 PASS: SKB BUSY-POLL TX_QUEUE_CONSUMER
> ok 25 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 26 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 27 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 28 PASS: SKB BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 29 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 30 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC
> ok 31 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 32 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 34 PASS: SKB BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 35 PASS: SKB BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 36 PASS: SKB BUSY-POLL TEARDOWN
> ok 37 PASS: DRV BUSY-POLL SEND_RECEIVE
> ok 38 PASS: DRV BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 39 PASS: DRV BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 40 PASS: DRV BUSY-POLL POLL_RX
> ok 41 PASS: DRV BUSY-POLL POLL_TX
> ok 42 PASS: DRV BUSY-POLL POLL_RXQ_FULL
> ok 43 PASS: DRV BUSY-POLL POLL_TXQ_FULL
> ok 44 PASS: DRV BUSY-POLL ALIGNED_INV_DESC
> ok 45 PASS: DRV BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 46 PASS: DRV BUSY-POLL UMEM_HEADROOM
> ok 47 PASS: DRV BUSY-POLL BIDIRECTIONAL
> ok 48 PASS: DRV BUSY-POLL STAT_RX_DROPPED
> ok 49 PASS: DRV BUSY-POLL STAT_TX_INVALID
> ok 50 PASS: DRV BUSY-POLL STAT_RX_FULL
> ok 51 PASS: DRV BUSY-POLL STAT_FILL_EMPTY
> ok 52 PASS: DRV BUSY-POLL XDP_PROG_CLEANUP
> ok 53 PASS: DRV BUSY-POLL XDP_DROP_HALF
> ok 54 PASS: DRV BUSY-POLL XDP_SHARED_UMEM
> ok 55 PASS: DRV BUSY-POLL XDP_METADATA_COPY
> ok 56 PASS: DRV BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> ok 58 PASS: DRV BUSY-POLL TOO_MANY_FRAGS
> ok 59 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> ok 60 PASS: DRV BUSY-POLL TX_QUEUE_CONSUMER
> ok 61 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 62 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 63 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 64 PASS: DRV BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 65 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 66 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC
> ok 67 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 68 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 70 PASS: DRV BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 71 PASS: DRV BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 72 PASS: DRV BUSY-POLL TEARDOWN
> ok 73 PASS: ZC BUSY-POLL SEND_RECEIVE
> ok 74 PASS: ZC BUSY-POLL SEND_RECEIVE_2K_FRAME
> ok 75 PASS: ZC BUSY-POLL SEND_RECEIVE_SINGLE_PKT
> ok 76 PASS: ZC BUSY-POLL POLL_RX
> ok 77 PASS: ZC BUSY-POLL POLL_TX
> ok 78 PASS: ZC BUSY-POLL POLL_RXQ_FULL
> ok 79 PASS: ZC BUSY-POLL POLL_TXQ_FULL
> ok 80 PASS: ZC BUSY-POLL ALIGNED_INV_DESC
> ok 81 PASS: ZC BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
> ok 82 PASS: ZC BUSY-POLL UMEM_HEADROOM
> ok 83 PASS: ZC BUSY-POLL BIDIRECTIONAL
> # Can not run RX_DROPPED test for ZC mode
> ok 84 # SKIP SKIP: ZC BUSY-POLL STAT_RX_DROPPED
> ok 85 PASS: ZC BUSY-POLL STAT_TX_INVALID
> ok 86 PASS: ZC BUSY-POLL STAT_RX_FULL
> ok 87 PASS: ZC BUSY-POLL STAT_FILL_EMPTY
> ok 88 PASS: ZC BUSY-POLL XDP_PROG_CLEANUP
> ok 89 PASS: ZC BUSY-POLL XDP_DROP_HALF
> ok 90 PASS: ZC BUSY-POLL XDP_SHARED_UMEM
> ok 91 PASS: ZC BUSY-POLL XDP_METADATA_COPY
> ok 92 PASS: ZC BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> not ok 94 FAIL: ZC BUSY-POLL TOO_MANY_FRAGS
> ok 95 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK
> # Can not run TX_QUEUE_CONSUMER test for ZC mode
> ok 96 # SKIP SKIP: ZC BUSY-POLL TX_QUEUE_CONSUMER
> ok 97 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
> ok 98 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW
> ok 99 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> ok 100 PASS: ZC BUSY-POLL SEND_RECEIVE_9K_PACKETS
> ok 101 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED
> ok 102 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC
> ok 103 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
> ok 104 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> ok 106 PASS: ZC BUSY-POLL HW_SW_MIN_RING_SIZE
> ok 107 PASS: ZC BUSY-POLL HW_SW_MAX_RING_SIZE
> ok 108 PASS: ZC BUSY-POLL TEARDOWN
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]
>
> Summary:
> XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
> XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]

Thanks for the test. I spent some time finally configuring the env in
my machine with ixgbe driver.

Some of the failures are probably caused because of lack of patch 5 in
your setup? The rest is caused/breaked by patch 3 which was stated by
Stan. I fixed that in the next version.

Thanks,
Jason

