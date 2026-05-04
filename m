Return-Path: <netdev+bounces-283947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPZ2Gm/G+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:16:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 611344C1417
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9AF3016510
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985A3E1CE4;
	Mon,  4 May 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QX6J9u2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662352253EC
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911214; cv=pass; b=cVFzwVocY3PKkgM2616Etzku65+VGuVLAbx5RAcMziwV9mIhqdVgEjgev+zWqEAkxyEPMXZW32+BEgLEOYhoUsnLWaYQwlvf4N+GlYkSR3gLpQEdTodQpi9tZBBdKXTmj1NcUb6/8THD9Sae5paTadcnYDBKOYJmN6rrSbSst6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911214; c=relaxed/simple;
	bh=rngbnG7BDe/PSEAJIR/WpQ8dp7dzBhHmNpQRxrMNeJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOfGSGQUk0xfOfmfaiHYiCR4CUlWe/9ayvFpuz1MMwvw/NZO2Ap6o9VzmfdN0VZqclfFIv1tuu3UX7oG+8XJjmAFcwWBSJzLInOZZeub0UDVzhQNzPUo9ksX7GFG3JxR0IsxuhrAQpecTJ0XFNwaJmI3EisyuzKtDa90Ewig/ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QX6J9u2C; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b9bca48so62144451cf.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777911212; cv=none;
        d=google.com; s=arc-20240605;
        b=i9IUXVNNruJ7wTT8EcojA5cYRBRSewcFev5S7r2D2uI6IMkdZl1qawTqZX0I/UL3iW
         ZcwXY5kZC8Ux1puuxBzqHTPceokImBVxmJUr82QigIiaEnLiQNKDGFt/K41aleoQ9cvE
         isB9pKTob4MPQkVptqM44QcXvYJDwumYIz8OePLamvWpP5EILZeC7WFxqC4Asa9ITea8
         lPDyK0D+OQIJXEkeU9AWKgScm4+K1NzgvhF1ktZrm9yge1Ds+TDbekxYZFc2eS4Fjg23
         G5aGsmm3IgZgcHGjmhYtwpc23YmeTYwRRTdz+dl2Tr3n7MI9CNpTlwgr6Q4e2Bub/UKT
         kwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMU0ondNGF96N8XD6/S6//2leT0MS7Eli3gTF88yqes=;
        fh=gsFLK9jaBF7uoqE8DpMnrwbJtKdQZXHE/Lpgt9jsgrI=;
        b=V5f43KbraQTQjgRFHEYmv4s9ODQW9CPWUZwxtPVuZpuRinSe2j2O/uubSB4lFX4vsY
         gzWTG0hbKVIhHcrmJmpJaAVrgLtyrNmD7uqq0xlAC1rdpl6NseVTemVfJlTAQTkX9p8s
         g0SOHjqA4+XjpN5R1wy2eGQFJhRI7XFNgadEiFuRW5wQ7CrssWRjPNijUjYqlwgeexur
         kj7vQau+H9XVqLT1vbN4KDbvwRYdetLI/7DDVq2dmA8Vex7b0wEPhu0uvPpG3NdEf/dp
         imu/HJPDoHxo1RvytrP20HmzducRpG4woJlwPw9nfNkaxRCG+R+w349n8TddX4LfCwSC
         rlow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777911212; x=1778516012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMU0ondNGF96N8XD6/S6//2leT0MS7Eli3gTF88yqes=;
        b=QX6J9u2Cve5qbl7gNyo9WOckdxstoreY59sjI9gPaRF76EPSMfx1vZxA+mSXZ8AJFP
         OXKwp+H5mPfgu5Bu/el1QTl7BbFybz/0zgpdzjBBLD4UPRcJ+/48QVYKvd2XoFMXTpXp
         87xiyQVmINHt8By2ASCKABtd1Cd237AiuTZgx9d2ouL8A+wRZi3AUzsHYiYCvgoFVvaQ
         MyTzLz3WHjqmp94renfzk5uPCGjhITT2YuoaJ3bGww7gTZspFTRlY+fEIH2DfqH4m2RB
         ld7QgRLCM1cKnxcjLDNrGYCAmmxBM5z5au6NLP7SNIfHiR3daB26QDKv5GX6xGI8o2GC
         +rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911212; x=1778516012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMU0ondNGF96N8XD6/S6//2leT0MS7Eli3gTF88yqes=;
        b=ISfgimEA5MEXbELCMDjG+js3DWwc8MNJtLItzOGVzzrydT7lr42DHTNi5C9awesXN2
         vnGftcZYGL1SCdC0ScCO9BEsgiQ46LkFYQaUunBnr/gtR8Vk73xbQTstsTCL/2NdNowx
         vkPffUxD4fhKyXwlfo4HmPUwM1Iehjj7rhuCKcHLXq/OGdjxcj6aWcXcVABYLqOiHQuR
         IaiP5kp9kNLBi+Itq69zBXnZr5A+c1sQdrzaRAVFDtybYLK4VSsiaH1KlWObsfjrEYwB
         maMIbWHUj806VtNG39vTgL8m4qZD+zq4UbBeNjYxDL84BHziDkMbHRN2ww/63QIqyl1R
         JnIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KOoL86sZFqK9ZApNf4IEa6Z6oLb0JdN8NNWoAEQhwXSLnEeNAKCtGBz3umoPTCJBolLL/YMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNfMMz6ZX3I2KER5JmJVAmUUFOrZW1oZg8sh3qxkbTzfOrNKR
	v/6POpcRMcSHl0R3IzG23iK2k9o+Y6qdkvdYZ1ZAdhU/c/v2ZhEI+/4VA/rxzNvlj/0rxIML830
	qcAU15nDV4iutFAS52r+4n7QrMU6w+SRtbHHOC2V0
X-Gm-Gg: AeBDieuGSvxTapobVH0gFJYmF7TGF+MCVb4OoiuzVu0qjaTTDDRJUQRPe/onaQLYag5
	G40xUrOIjQY3X1+omoZ2iM97fwMLL+e03few7xBZ36lDN01ZZc3bpIRxCv1M+NNfV8cPIK8phZY
	GHGsglLEEyoaQB2Mvr6cVNfPTXMLRku7/X4LawZAn5CzfvOHeJpLcdzWmwyPlXUBNM2lY9PuQ6W
	18KVfIr/d3dAGaBUO6alkzhXEfZ/3xqHSgLVy1ZC/nXcthqEh2yg0y0OZhr2xuETNc+55qFxiio
	i/hifb+7C8I4tLoH+vEAX+sTXtIW85SHPGutSmNkAK41cZ8hEivOdK1bHGcnAd0znO3MvmwbXAd
	TdZZ7sn/8v18676InqUCrxvTjPRy5A8DBx+2cRgf9FkPNiiVsREM=
X-Received: by 2002:a05:622a:230d:b0:50f:b1e6:a901 with SMTP id
 d75a77b69052e-5104be44f40mr166742351cf.24.1777911211673; Mon, 04 May 2026
 09:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144945.13477-1-ankit-aj.jain@broadcom.com> <20260504144945.13477-3-ankit-aj.jain@broadcom.com>
In-Reply-To: <20260504144945.13477-3-ankit-aj.jain@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 09:13:20 -0700
X-Gm-Features: AVHnY4JZd71Obq4KzZ0qMQOPE3ryaNl99b1q6wXFfL5A25b6TCCeASXJUoXIkWM
Message-ID: <CANn89iK_SrGx4UuN-_h8LY0DFBwf8+hStba7vdjFnEogvo=N7A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: add packetdrill test for locked
 SO_RCVBUF SWS
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
X-Rspamd-Queue-Id: 611344C1417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283947-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,mail.gmail.com:mid]

On Mon, May 4, 2026 at 7:53=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadcom.c=
om> wrote:
>
> Add a packetdrill test to verify that TCP does not aggressively penalize
> the `scaling_ratio` when an application explicitly locks the receive
> buffer via SO_RCVBUF.
>
> This test establishes a connection with a very small MSS, then injects
> small payloads. On buggy kernels, the payload-to-truesize memory penalty
> drops the `scaling_ratio` to 1, which shrinks the dynamically calculated
> window and causes Silly Window Syndrome (SWS).
>
> The test asserts that `tcpi_rcv_ssthresh` (the exposed window clamp)
> remains protected and stays at a healthy level.
>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> ---
>  .../net/packetdrill/tcp_locked_rcvbuf_sws.pkt | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_locked_rc=
vbuf_sws.pkt
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sw=
s.pkt b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
> new file mode 100644
> index 000000000000..96d3a0813548
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Test that TCP does not apply aggressive truesize penalties
> +// to the scaling_ratio when the application has explicitly locked
> +// the receive buffer, preventing Silly Window Syndrome.
> +
> +// 1. Create a socket and lock SO_RCVBUF to 32K
> +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> ++0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768], 4) =3D 0
> ++0 bind(3, ..., ...) =3D 0
> ++0 listen(3, 1) =3D 0
> +
> +// 2. Establish connection with a TINY MSS (48 bytes)
> +// This forces the kernel's rcv_mss expectation to initialize at rock bo=
ttom.
> ++0 < S 0:0(0) win 65535 <mss 48,nop,wscale 8>
> ++0 > S. 0:0(0) ack 1 <...>
> ++0 < . 1:1(0) ack 1 win 65535
> ++0 accept(3, ..., ...) =3D 4
> +
> +// 3. Inject 100 bytes.
> +// 100 is > 48, so this forces tcp_measure_rcv_mss() to recalculate the =
scaling ratio.
> +// Because the payload (100B) is small compared to the sk_buff truesize,
> +// kernels without the fix will incorrectly drop the scaling_ratio.
> ++0.1 < P. 1:101(100) ack 1 win 65535
> ++0 > . 1:1(0) ack 101 <...>
> +
> +// 4. Inject 110 bytes to bypass the length jitter optimization and forc=
e
> +// a second recalculation, driving the scaling_ratio to 1 and crushing t=
he clamp.
> ++0.1 < P. 101:211(110) ack 1 win 65535
> ++0 > . 1:1(0) ack 211 <...>
> +
> +// 5. Assert the window clamp (tcpi_rcv_ssthresh) is protected from the =
penalty.
> ++0.1 %{
> +assert tcpi_rcv_ssthresh > 15000, f"BUG DETECTED: scaling_ratio crushed!=
 rcv_ssthresh=3D{tcpi_rcv_ssthresh}"
> +}%


I do not see the SWS effect you want to avoid in the first place.

This test is an ad-hoc test about your change, but I still do not see
why recomputing tp->ratio every time the rcvmss is increased is an
issue on loopback interface.

