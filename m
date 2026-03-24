Return-Path: <netdev+bounces-271096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI1jJBihwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:35:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CC30A3CC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2DD330B00FA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422B3FF892;
	Tue, 24 Mar 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZonTuQeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1803845C1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362501; cv=pass; b=HM2zecjibxQe4tsa/hgYfm0NRDW7QYSFrHgzoSCdLBc4hMpoTuzEcHlXWnue/Xp9drBe7kXXZziKEp8lX30NfVgSYRmjjgkkS6g/sLA67T3rGLvTPdB35pNyyXmKJpx88ZVUk+ie8MCDOpRMKZyXVfOS/6q+YELemFdrzZezjRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362501; c=relaxed/simple;
	bh=L3CuNiDuwieUnOiyL7wgyvC6rJNK4h8dNhkwpoI15G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAhjwe+Gl77eyf81KVcRW0Yx1OmixtndhTD/uHp98KI9l9QK7QqiCHTNYye1E49RbMxjbClDC7A2IyrzfW414fcP8FTGepEhS8Q1uFdozF+U9U12Qe6fP0w3XYcPz3ny4OCeny2+SjiuC8522dz7R3sprhdBvYrqwaLlqB4j1F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZonTuQeh; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-509061dab77so11734241cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774362498; cv=none;
        d=google.com; s=arc-20240605;
        b=LzlaaL+pR6WS3YLA6e5TUc3A6e+ojfuU/OvT1LH5Fly0Oo2g7KUdacwlJ4lEk/RMoI
         awweb/4BBWEhYR6WrD0Uaz3fmGx0fyTrJ1fZoXqbPBewRYiOt8WczrEoHnJ/1mYCVPTR
         DQ3ARBIpoXjR3x7tpJA4RO19fY2XzUipabOJYMRzZ5x/onc8VpJUGHh/cgFypvaPaIwb
         GGInVUL0O+AZaOmd4eGAkIVJ1N7q56bxd2nMexIaP7cGMC+uCq0wnex1bp0WSZmKPLAG
         B4FchMIDDiff5WHfiGnbPX0KN1qHBfRxgewoQ4BIifXsR+r8z9dNSv8v7Q5v1fpAe1CH
         Myaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULO39KvKl0c7cILigXpdtzqRgBfcJj+jT9Utpz3M4js=;
        fh=cYV2rQ0Vvj4eAFaZRBrc4+BEkBYFr/o5DbC5ELc+ANI=;
        b=h7NycXU4PcIdvvj4MKGPnyjTiLp9wgv9HIgeG3p84oTY//25V8B58wDmDsHZOKBqdP
         ffa0ypG3dVGP4iP2J4XM5mDzBrV4f3DPutWk/0McVRuXZBF6z/JnwmZiOIGb613/CLcX
         wbm7YVBzNGKTGikLEQyHqZeuMBpe2NjNTvC2nOoZj4Ya/ZH468wtysZR4d5PamMnI3wJ
         xJyqb3fzhsMlpb10hTHeUmqhKorB5UPGQR1RGL8hPQvtDle6IZywAgZiJDVO5oZy2TwH
         P/tTgk9XfMfb8eg3ZcmiQpIoo7ID6f6OH1NHOHsarHrO1srl4yCmQKLSaTZL5bJzu6Wk
         QHCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774362498; x=1774967298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULO39KvKl0c7cILigXpdtzqRgBfcJj+jT9Utpz3M4js=;
        b=ZonTuQehrYqbCb1jdqTMl+RsCaS69eCImQi2BFqFAq55T4En/06d1+BSeG6zl//2ar
         /A3AB4LEo0Brb1zuZBG6fk5lGnXt/RBSDrFBqI250Ez3uK+zf13m/vUO0uj4rSRxt8Ss
         zh9b1+8UEUDaiQUA60pEZ00/RMU2qKA/RNVayB2u+lRlfpTNQetNoGrjzNWha9kCcYv4
         hxvGNF1urTllraA/XAfvmJCryfAMRcVU5Q1cBk79T3Z3o4zbmFLkTN9U3qNb+GVUfnVC
         wolPEoFhMGqSFQAGWtTZzbJE79AXnE+5wlrlE8akVfmgKtUIhpjLQzjX/eoi+b7QdDh1
         TFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362498; x=1774967298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULO39KvKl0c7cILigXpdtzqRgBfcJj+jT9Utpz3M4js=;
        b=JqcCewAtPvdgceieyNsvQmShPFqxVUOP0el5FbKJvF18PCSwm7WAYGVub0Xjh8I3xL
         jIyOLCQxPq3IhiTxSfrQGR7RipNq987df+QkAfvzUrVtDlpOabgicVtLL+UPYB05Ft+J
         UMYccGGyjBALjdJx/SO88pbDom9AeaglXbLeO6OI8YtAV+ztHMMmcFmoyoTfwdcOxzh9
         tFDmfDF+K+hcjvJ+wxmw2XV7b0ZR4T8g7ROKA8J+AF8t5wbFeuyPA5uJkmzB6fD2yHbc
         200uRPd5oPL1ZMpsVtnzBFVc61w6EbSG3YOPOBG1vjw8tnnnlT9C+bznMoQPyqth5Qrz
         IEqg==
X-Gm-Message-State: AOJu0Yx6EXUFkpR2lMbHi8ay+H99nU6IQcPx+hcJGGlSoKn8gUs6OFEj
	Q9cox3h4CoqSceMvBCk+e4q3G6IHpdGTT66ijkFr4lfjtSxuz2ktvmaD6h1npTU2Kc0k54Tgdoc
	fPXqVZ/gBJorVaHvx4O1xHWkbyCTuDfBjrX4tJTyN
X-Gm-Gg: ATEYQzyLhyKWHLz3F/+H7wePEf3tBcz/QPDpZlYFM2BtrTiIQtXBJAcFSzFOSY4Jtr5
	B7bYEnd/CKabeAmBZrLoFrKDd1zuTX7DwsIVU/6b2mvboKYzbvLoTypRKhkxJvN6+Px79qlT77w
	rVawQllfC/rsDdIE9+oxz5GFzkmTMFoLWEJrtS4TLH9DEfmqOHoq4+9EAQxNln7XQV8IjVlPQIg
	t2gd21Ckx5x25VlkoKasHaKsdqbvec0IlrE8UFociHMowBugeBRzdfg8FoQqxcj5dsYGsj3RkYD
	1QCKFQ==
X-Received: by 2002:a05:622a:34a:b0:509:34b8:a373 with SMTP id
 d75a77b69052e-50b3747c5dbmr246789041cf.32.1774362497318; Tue, 24 Mar 2026
 07:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324060410.1137199-1-atwellwea@gmail.com> <20260324060410.1137199-2-atwellwea@gmail.com>
In-Reply-To: <20260324060410.1137199-2-atwellwea@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Mar 2026 07:28:06 -0700
X-Gm-Features: AaiRm53b7oj3q18mF1VjTrV49jKDyaAl_yIR_9EKLfbAe9kjBY-d8l_Wq9ugm6w
Message-ID: <CANn89i+1mW0NRUoqB3W6JxO+7bywcuH=RP1=39EjZmu8xshC8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] selftests: packetdrill: stop pinning rwnd
 in tcp_ooo_rcv_mss
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271096-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EE7CC30A3CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:04=E2=80=AFPM Wesley Atwell <atwellwea@gmail.com=
> wrote:
>
> tcp_ooo_rcv_mss.pkt cares about the OOO SACK state and the resulting
> tcpi_rcv_mss update.
>
> Its exact advertised receive-window value is incidental to that test and
> can legitimately move when unrelated rwnd accounting changes adjust the
> ACK window.
>
> Drop the hard-coded win 81 checks and keep only the ACK/SACK shape and
> the tcpi_rcv_mss assertion.
>
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt =
b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
> index 7e6bc5fb0c8d..0b19de9f9307 100644
> --- a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
> +++ b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
> @@ -17,11 +17,13 @@ sysctl -q net.ipv4.tcp_rmem=3D"4096 131072 $((32*1024=
*1024))"`
>     +0 accept(3, ..., ...) =3D 4
>
>     +0 < . 2001:11001(9000) ack 1 win 257
> -   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:11001>
> +// This test cares about the OOO SACK state and the resulting tcpi_rcv_m=
ss.
> +// Keep the ACK/SACK shape exact, but do not pin the precise advertised
> +// receive window here because unrelated rwnd accounting changes can adj=
ust it.

I do not think we need a comment, the change is captured in the
changelog just fine.

Most packetdrill tests do not have 'win xxx' in their xmit packets, we
do not need
to explain this.

> +   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:11001>
>
>  // check that ooo packet properly updates tcpi_rcv_mss
>     +0 %{ assert tcpi_rcv_mss =3D=3D 1000, tcpi_rcv_mss }%
>
>     +0 < . 11001:21001(10000) ack 1 win 257
> -   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:21001>
> -
> +   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:21001>
> --
> 2.43.0

