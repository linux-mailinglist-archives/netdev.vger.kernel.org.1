Return-Path: <netdev+bounces-275580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCz8FU2g02lajwcAu9opvQ
	(envelope-from <netdev+bounces-275580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7963A32CB
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6063F30125DD
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A530C63A;
	Mon,  6 Apr 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj83SUlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D673264F7
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476810; cv=pass; b=T6rgE0h/xbmthRbmovzk6tV3uATg8CXXm1bp5X+4ZV/Vz3DiXAv/H1bsBo1i/iMDsdNcyAFPreisMQ5U1xiOyTJhuNTaTGEf/HL2Z0FgbwWckcjzzHpYsz0Uxrkqs5BNTolDnpnw+KKKpKFN+7qS//Xwl9Zn8D6rY2C5ORd39Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476810; c=relaxed/simple;
	bh=fcEIZMZ8hJHb+M5FGnQOEit1qBuFU3wayQRg42scuo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBc8exSTF7O45Sj6HH2K4E4jiGabjmIqJbUfcfULirKxhP1008UiclE3pnnTz3ExYmQk5te4KlBAYOIUvDOTCsaU9kvs1k9OiDLBrgfDjpZ0kZWfQfMfQl4AwtXfy0tFpyDvoseojixtkp+u/AKs04JIzei9wfisSvhFP9W/a7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj83SUlP; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so5168700e87.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 05:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775476807; cv=none;
        d=google.com; s=arc-20240605;
        b=L+dbv+tJOj0Gsu6oToPRs0xAYzMxAy3S9FMm99lI/rt1FewgBoWg+jrYTDAtl64HFR
         rlF+G/9PTYkskQa99B4mgV1UdF1U7pLuMeqB7SwIc6k6TUyGUUm48QNLd/YXtUQZdydQ
         ou/IUSe54swAcBZVOP5iFk+/LmifuSoyCCHzxg1blFFqE9lu0oaeUeaf7+zBu6HnyP42
         6eRFQYJ/Ec/81VEq4CmDC99PfzB2Wi0ZhBJYlVnndp94dEB6VtY6HPcmNlP8byCvd1aa
         sT56zU86HZUGAWqmci08IpmlgP1NLdYBn5B+MDPlVT0r7lUVb7/5aO/1gEvXu0ZxzjfE
         pLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        fh=dnvcqhzGmKeATDu5BfnLdkPBPPYmy0h2403UDnqti+g=;
        b=Uggj63T6l0UI8PQo5D/Dr1T8dtQe+GMVuQFBctBwKivHIQUNg/XbN418heMsnXpOc+
         RIEkp9NvoIHG4x/H9wLOFypmsy2accCKNR8PjtxjEfsMk6dzHLfCFCPVzLZeuZgxsGfm
         U/E0DZz1exY/4K3bw2v1A5C9sESPxhDcpaScTSNQGVXw1SGwu0Wmp5bSn/VxF4XkoqsV
         W0I8JuhCs2TDCXihoJCaP0yIlB7kxNpjauX4Wosjq0hSsqmrytkpWyqY44mRjq6S6Fn1
         UehtpPuDvrsseeoRoxNtdtIKLZFFtwoyic2lwYP5SBUXTUCV3IlEEGa5PuUIkZQUN8eF
         l47Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775476807; x=1776081607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        b=Wj83SUlPex1uBTfA1nOtyIo5Yw/mz51AV3+XO61r1exCSO2Z3GjqrYXvDJpyJBrRPZ
         3sY505RBGWK8bWGQUKAnyVK40Z3irKenrRTJuW5dhFbPam/UjTMN0lVRc2Wd39AcpJ+u
         R69G+3rUhui/SXYmP95ZCbJgrwPc/QvlfMM4xTSWLmVonE5xICAC67NvFbnuoGqgS04N
         vGFHxgrkJc1pxaRgoYbJqwBjIcyb7EGjPV0vVRI4xNNNcjFeSryOgiK7x5ByPVl9chfx
         XVtA7FxU3UF7rLSLXQ6o3+zQMiQdIS74Tz3lQ2xX0Am3z1xwcV0wGO2P88asYhvreOec
         ickw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775476807; x=1776081607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        b=Z8dAoLOCktMZGW3knuHKtz8nPcmYhp7Oiv3utgLH8CpgfWBsmfMuCCs7FRQhOSRYLN
         gz7AlCcxlaNBRPmMshJxVsJW37DH2CgGwQUkbnFG9FRBsvttFdzvIl+me6MZcR5bpwgZ
         N+1AGPHA5G0K8s8gX0ZSQLMlGTABxqCBdqF95A2+jyCa2/TUxtadAlhnVOQ8JAYHLplQ
         BeVgwRCY57rraL/CSuVVHh03G7m+b98qRfIG45MuEC8q8zVW7We69mpL3lPfa9vFw7J6
         tMGqDqElZmnPLbOnHPqgyfha7qqeWuVqcj+6uX34izINiUEm9zYEU89s7kSaoFWZvymb
         Bkog==
X-Forwarded-Encrypted: i=1; AJvYcCX4ao+eOz39M72Zp+bEVMPtmAvjrGwXkguz8CsUN3xnSOuyasFwuXix0ASjGkDgZgLRiN9P1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdbxDlAY4SNyr5A33OmEoDBzXs5nN8BdZwrbh+qy887AwgBjR
	L6ZfDeBUcBm3U6S6mozaikqqgFr3gJYqbzUnxzR2UdLjdkzAby7aK5vDq4RhBvWW9q4coY2NS0F
	hh92r+tc1LRYyeg5RfiVvpci9SaciTiY=
X-Gm-Gg: AeBDiet6ZMVvUG+V+j+0rRLLBQTO9YIN4rMDscl9YZ+4EdVXUOQyU5q3ERWML6oUAfX
	aCF4MJgS6eDOEYpGwbFTuQL1azLSBxLkMin6OF6kx0EVwHoJQvY5QBgX/Pnf8bwz3CjMWv6yOkR
	R1KDTv7L7Uva3qyR4XV3Ja/z5CDJmMtxSGC+g4uUWDTOE6cfj8K97/qMs6T+siJZt4TtCHxcfu3
	KbYUxxHT099TbKgBLR9hc6n9i+pDcW2NSezpPJJ+CO2epPgNqVYl6IwfrwM+5uO+xBeF+OnVrmg
	Z9QYyuc=
X-Received: by 2002:a05:6512:3d92:b0:5a2:bb45:7f21 with SMTP id
 2adb3069b0e04-5a33757c21fmr4613352e87.28.1775476806506; Mon, 06 Apr 2026
 05:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Apr 2026 19:59:28 +0800
X-Gm-Features: AQROBzB3sC5UT6ZJcIRcqKr0kaJV4c5b4kQZPMFgIGiWrxzPe3N-tzGEy0vqdu4
Message-ID: <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275580-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE7963A32CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The patch is the 1/2 part of push-level granularity feature.
> >
> > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > though it might not carry the last byte of the sendmsg.
> >
> > Prior to the patch, BPF timestamping cannot cover this case:
> > The following steps reproduce this:
> > 1) skb A is the current last skb before entering wait_for_space process
> > 2) tcp_push() pushes A without any tag
> > 3) A is transmitted from TCP to driver without putting any skb carrying
> >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > 4) sk_stream_wait_memory() sleeps for a while and then returns with an
> >    error code. Note that the socket lock is released.
> > 5) skb A finally gets acked and removed from the rtx queue.
> > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto=
)
> >    'do_error' label and then 'out' label.
> > 7) at this moment, skb A turns out to be the last one in this send
> >    syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
> >    before the final tcp_push()
> > 8) BPF script fails to see any timestamps this time
> >
> > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index c603b90057f6..7d030a11d004 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >  wait_for_space:
> >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> >               tcp_remove_empty_skb(sk);
> > -             if (copied)
> > +             if (copied) {
> > +                     tcp_bpf_tx_timestamp(sk);
> >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> >                                TCP_NAGLE_PUSH, size_goal);
>
> Now the number of skbs that will be tracked will be unpredictable,
> varying based on memory pressure.

Right, I put some effort into writing a selftests to check how many
push functions get called at one time and failed to do so.

>
> That sounds hard to use to me. Especially if these extra pushes
> cannot be identified as such.
>
> Perhaps if all skbs from the same sendmsg call can be identified,
> that would help explain pattern in data resulting from these
> uncommon extra data points.

You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
close to packet basis without considering fragmentation of skb :)

Thanks,
Jason

