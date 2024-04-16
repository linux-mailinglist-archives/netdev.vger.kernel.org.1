Return-Path: <netdev+bounces-88465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEB8A757A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FD0B21D3A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09BB139D10;
	Tue, 16 Apr 2024 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6cTamxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C602AE91;
	Tue, 16 Apr 2024 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298982; cv=none; b=hBjE0wX7Eg0pWKmhBuUWmrzhYXZ3FQIKHDVOrUaji6tpv6lhiMxgno1cmg5c8x31FKAgbw0fXTRX++GEcLNFN88Ii7Nvhb7AVqIVAKek8wF/IdMay1sSvbqjQ1CGrZLXv2BHi2/kJkiVUU2KusuYHEL8uNqYQBwFC1W7Ierg5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298982; c=relaxed/simple;
	bh=P8lF68ySs95YEFtG1UXAcD86630c/ZMTacV5Xy+yOjA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=snmRCN0xvBrAF1UJHJNd5iwmKO+n+d82gmqFUNB+E5GW1SlxGwGh4yFZzBhu7u71wQ0t2epJzG4byJJ8Qj581V/jED4hI7+T6wpMRMHEG20L6sICxZTivOeQQ20UQoe5FrvYyUG8pAEacICQhbxTWKzdnymjgxiMbUbfsUMOVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6cTamxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05958C113CE;
	Tue, 16 Apr 2024 20:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713298982;
	bh=P8lF68ySs95YEFtG1UXAcD86630c/ZMTacV5Xy+yOjA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r6cTamxEhtPFTsHpoWSGRGg9oVyCzpubmHcZ050GCKFvWFQ7reQ5wPeb74rhDWP1Z
	 RUjpPlxmmoBSPxdyJs9OhyrWyigB7xPSj3WFhkY97EcGEj1oImQGYUkluiSYMHMFpt
	 AQ/PK4i8miQpb3FduG8E0CqzLGx0CW6cO49BAA8Arg9ZWMSXxHPvtDg41SDPno8HSW
	 f3iaJITQsvQeCmHPDrdjVszYwyneKkSZpYPfyhr1KLi2fKoDa8tdY8h9pjROqxiMVx
	 K0abnuU9nAn5Bcqd4RZrRUbAojp8h7wSl8B/nzNXJ3ARTkB10GAknACS2gcXUcKbC7
	 +z+UCGYalf7cg==
Date: Tue, 16 Apr 2024 22:22:55 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, dsahern@kernel.org,
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Message-ID: <c64c8a6c-2e24-43ca-8ee7-7e15547ed2d1@kernel.org>
In-Reply-To: <CAL+tcoDVFtvg6+Kio9frU5W=2e2n7qrCJkitXUxNjsouAG+iGg@mail.gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com> <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com> <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com> <CAL+tcoDVFtvg6+Kio9frU5W=2e2n7qrCJkitXUxNjsouAG+iGg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive
 reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c64c8a6c-2e24-43ca-8ee7-7e15547ed2d1@kernel.org>

Hi Jason,

16 Apr 2024 14:25:13 Jason Xing <kerneljasonxing@gmail.com>:

> On Tue, Apr 16, 2024 at 3:45=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
>>
>> On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
>>>
>>> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
>>>>
>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>
>>>> Reuse the dropreason logic to show the exact reason of tcp reset,
>>>> so we don't need to implement those duplicated reset reasons.
>>>> This patch replaces all the prior NOT_SPECIFIED reasons.
>>>>
>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>>> ---
>>>> net/ipv4/tcp_ipv4.c | 8 ++++----
>>>> net/ipv6/tcp_ipv6.c | 8 ++++----
>>>> 2 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>>> index 441134aebc51..863397c2a47b 100644
>>>> --- a/net/ipv4/tcp_ipv4.c
>>>> +++ b/net/ipv4/tcp_ipv4.c
>>>> @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buf=
f *skb)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>
>>>> reset:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_v4_send_reset(rsk, skb, SK_R=
ST_REASON_NOT_SPECIFIED);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_v4_send_reset(rsk, skb, (u32=
)reason);
>>>> discard:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_skb_reason(skb, reaso=
n);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Be careful here. If this=
 function gets more complicated and
>>>> @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drop_=
reason =3D tcp_child_process(sk, nsk, skb);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (d=
rop_reason) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_v4_send_reset(nsk, skb, SK_RST_REA=
SON_NOT_SPECIFIED);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_v4_send_reset(nsk, skb, (u32)drop_=
reason);
>>>
>>> Are all these casts really needed ?
>>
>> Not really. If without, the compiler wouldn't complain about it.
>
> The truth is mptcp CI treats it as an error (see link[1]) when I
> submitted the V5 patchset but my machine works well. I wonder whether
> I should not remove all the casts or ignore the warnings?

Please do not ignore the warnings, they are not specific to the
MPTCP CI, they are also visible on the Netdev CI, and avoidable:

https://patchwork.kernel.org/project/netdevbpf/patch/20240416114003.62110-5=
-kerneljasonxing@gmail.com/

Cheers,
Matt

