Return-Path: <netdev+bounces-292306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OELDOrv1FmoozAcAu9opvQ
	(envelope-from <netdev+bounces-292306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CB5E54A7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DC0430A7152
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAF421890;
	Wed, 27 May 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4UFROZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F324405874
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889230; cv=pass; b=DKXoE/3xguh/nFniJOb4vZTgynIMO7HYM4EmYCz8fWGUX0WMPU+RegTSB1FqwwIAG/Tbk6WpGaEsMmDM90c4FWRJ68KUhtY1rZFkyvo35rxYM61NaeyEh8Ue3m6zA+fAQUjDKSIWa9hP/qTXh/muXZYZHtbAvR5mt05kx2hFpZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889230; c=relaxed/simple;
	bh=aoA2qDJcqGjCx8Ga40VunvHDKF++GAAxrGGVMNyvMDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pla80gfVCiX7Y8nIIHzZBDnGX46sLybTwx6+hKm0N3KBPzRZcTbBa4nkHQwqtRF/ZjRxvViAq605eedGd/aYeW8UXeSqa7PtU4KBMtuzmM5H/gQp33dmtU4X8fMkgMvsA4kAKQcY7g+jEN6rVwRoz6bwtBYlYJY+eGSPl9LUgGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4UFROZH; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d15ed2bcso53676071cf.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889222; cv=none;
        d=google.com; s=arc-20240605;
        b=WUL0NLaMwGSKPQmkNQJaTS2eE2xqtbUBjWj4xv7Z2NQpXA5qptj2npEdyh6wVY0KEh
         Xeb+d9zTBxG2CGSewGE5fTUL4Ho6hrHUTW69e1glF3AIl1APsJULQYsgPcoQK2RoeLaQ
         kUP35ma3c2EaCwziLpUD8smAwxunbxJdRHsyTeZ9j8e557vslJx1LzRT+WpwyU7h8FMO
         wubKLtVFX9uIS7EI2vHihVdJHa3FeoMOeQSqsXxRvb3ShgUokQm3qwbhFPj/hJEK7oSD
         HEx4+ETNB1Oem9nb6WeftqwF4PZusJVzas4La9gCzl2gCbUrlnAqYjf6KqAGHdxr5wFx
         8rzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNLTV1v0wjtslhReHN99E6vUICBsO5AaK3DbLfhODW0=;
        fh=VtpTx4LLsjYN6YljHOoeF0gOU+sDewGpuphshbwFp0c=;
        b=WWh9TCB9lD4PXqLh/U1IIIRNnm1es7b/GMhfiiiSzhtZ0RLZRHWG4uG0LuykNsNQ3z
         /bFrK+evq4e3DkyIdbDh6utV75OYbPukcvUef//UH1QoxTJYw8+an5BDow0ZhoEDm9Z4
         sd/hrlBHask/SPijAmhLhdUwHszYF9kEFHyHvqSXUJ2xnGRb4BLHhCaBWP10CiUTmPHm
         XPkyAgmTsf3fG8Q3WaXqyYVv/itCU+XG7bT8Glr2LVasx5onAEO0NYHH24neKkCM/dus
         ZQEcDf1WSXE/R2VQcJ29GcyvqcJP49Fd4fQj0TCUQm+Nc+7nKJEum7aEUTwZbwxwZdhu
         vN1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779889222; x=1780494022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNLTV1v0wjtslhReHN99E6vUICBsO5AaK3DbLfhODW0=;
        b=Z4UFROZHek7Ru96X0mgZJb8ZEgwFalJTM0k30PwbfBR0YhwLxdNhmGXOyNk1PYeBcu
         S44J9ihewDXcQrvhIiyf5uBhPOeInEYDV4I7Zrw2J2Z9y2CVMi1c5u73kHFWnpn+rXb5
         Flp/If9Cfq7U7Qyzj/ZM/952GeULyIkSxHt4fGBNf9jSn+H5BWuK2VENurEMith4PBkF
         Vn0PoHoeb+5TlPJNGEkEIMZ5C7qtuIA8ltG2r5LhMl6pk1pgNKGbk+eJTN7Rr3BNEmd2
         b1osl1WnSnYnbQKM24MSSQGocnjroVhOSgwvNvAtyGY4JqIyJgus6fd4uRuJmen3bW/S
         3ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889222; x=1780494022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNLTV1v0wjtslhReHN99E6vUICBsO5AaK3DbLfhODW0=;
        b=c+xY/+Hy55BGwWmCvp9Vdz5sNVTBEGeCjAJyY+fI9MNT2BkM4qBpnY7NuHKqf7wYcI
         xbZV7vcLg0XlXuQy3oP1Vfyw1AbwSap0vdb21Jpmgd07VSGNYXS84TzzyLs0/Q2s5iCk
         YspW+QV1auRjf8HnXJdast2RocimnvHQ3I2D8PpmYYQFnh1q2DGDjVH8Az6ywoXexvgh
         +9YUNZoZljIIQvwz2LTgojSdAMR1/jaFAbzNX+mXDMR+V5s+5c3iYSi7jFuZvZczrly2
         nujREQmMhWAqTyZ3fqE3ZQzt8d+sr4e+WCwWz96bQKYpcyVjRUcyIvyw1r43Y0VsxLd2
         xbOA==
X-Forwarded-Encrypted: i=1; AFNElJ8WXl1xGa1L0KWPazkGEzg+gbLdKq9fvkzhzqktr50MN7ueN6l0PXIfxY6AvzH5i7tBoLe6piM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywirq/Z82abp962IVbjnhKQWIjBn66oH9XZsQgDXr6g1pZIQrnw
	8VU1dSkBEa9K7z6YHk7KdDN2wjtOwnBCGSBDHx9eG4EJGSeLkyNqiPg5jnxHpRw/4k3Z1C+h93w
	CHpplNHccqgIIyLaPbYI94LVkEG9FKGv1cRCs0T5iGKn3VZ5AS3xcLq51Nlw=
X-Gm-Gg: Acq92OEuxRKPbQZJfXv1GyuXhmeU+gxZVsSWja6i7noLn28M5DbSuZnWP3mB2Nj7fEJ
	yXStvEsB1CIuiBQE9WFlUau06DBY7iEJNcn/FxkZIGf+xqi1p5A91XU1Xf/TwI5/rFnf3X51MaM
	2k8+Ecci9zACHumtHYe3DFY+XA1OtPYgMW/tG9K29jQ/fxvrh9rqcwCILMvwItMMJGO0q/O9RMj
	wf4Xee3+CnuXmsQaPdKrPdk3VuPxyibJ4ZZq8lppro41/2yuypXkc5URyEEd/LeMEouD5MR6Hnt
	AMx8Iv7wUVliwNjpthuIJsxv21mPZnxTgwaCPL5+RP5JHNd+4iZFbqhJ0xFjFwMwzeCvA5Cmg3i
	cwEt2QBjQWjDYbx8fenST9FvukVU=
X-Received: by 2002:a05:622a:d17:b0:517:1470:6f41 with SMTP id
 d75a77b69052e-51714707e5cmr17774071cf.26.1779889221899; Wed, 27 May 2026
 06:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EDFF6E75FB9C46D0+ac77bc6c-2057-dfc5-4541-05679f6a6bce@shinnytech.com>
In-Reply-To: <EDFF6E75FB9C46D0+ac77bc6c-2057-dfc5-4541-05679f6a6bce@shinnytech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 May 2026 06:40:10 -0700
X-Gm-Features: AVHnY4KzPjUxQw_MvTGLxLS5PVYc2qpPTtuXMgSUNPHLRHjHSo16FnxpmA1fmEQ
Message-ID: <CANn89iK_MvaXcVufptM_k+4Jq8zUEGBXPG0frR62m1+J6QqY=A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix spurious connection aborts due to
 TCP_USER_TIMEOUT and zero window
To: Zhi Cheng <chengzhi@shinnytech.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,shinnytech.com:email]
X-Rspamd-Queue-Id: 5A2CB5E54A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:16=E2=80=AFAM Zhi Cheng <chengzhi@shinnytech.com>=
 wrote:
>
> Under certain conditions, a stale icsk_probes_tstamp can lead to an
> unexpected connection abort during a zero-window state.
>
> The exact sequence leading to the timeout is as follows:
> 1. A zero window occurs. icsk_probes_tstamp is set.
> 2. The window opens slightly. tcp_ack_probe() is called because there
>     are no in-flight packets. However, icsk_probes_tstamp is not cleared
>     because the window is not large enough to fit the tcp_send_head.
> 3. Packets been sent, and RTO is armed which overrides the probe timer.
> 4. Subsequent ACKs consistently acknowledge packets and the window
>     never fully closes. Because there are now in-flight packets,
>     tcp_ack_probe() is never called again.
> 5. As a result, icsk_probes_tstamp is never updated despite the
>     connection no longer in the zero-window state.
> 6. Much later, another zero window occurs. When probe timer triggers,
>     tcp_probe_timer() evaluates the extremely old icsk_probes_tstamp and
>     immediately aborts the connection due to TCP_USER_TIMEOUT.
>
> Fix this by explicitly clearing icsk_probes_tstamp in tcp_ack()
> whenever prior_packets is non-zero, ensuring that the probe
> timestamp is reset when exit zero-window state.
>
> Fixes: 9d9b1ee0b2d1 ("tcp: fix TCP_USER_TIMEOUT with zero window")
> Signed-off-by: Zhi Cheng <chengzhi@shinnytech.com>
> ---
>   net/ipv4/tcp_input.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index de9f68a9c0cf..02de64881b76 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4365,6 +4365,7 @@ static int tcp_ack(struct sock *sk, const struct
> sk_buff *skb, int flag)
>         tp->rcv_tstamp =3D tcp_jiffies32;
>         if (!prior_packets)
>                 goto no_queue;
> +       icsk->icsk_probes_tstamp =3D 0;
>
>         /* See if we can take anything off of the retransmit queue. */
>         flag |=3D tcp_clean_rtx_queue(sk, skb, prior_fack, prior_snd_una,

tcp_ack() is TCP fast path and  icsk_probes_tstamp was not yet touched
in TCP fast path....

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.r=
st
b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index cc2000f55c29879a12c0e4d238242b01cee18091..dfb2ecb4c1621f2eac2f3183ed6=
3057af90dba76
100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -45,7 +45,7 @@ struct icsk_mtup_int                search_low
      read_write
 struct icsk_mtup_u32:31             probe_size             read_write

tcp_mtup_init,tcp_connect_init,__tcp_transmit_skb
 struct icsk_mtup_u32:1              enabled                read_write

tcp_mtup_init,tcp_sync_mss,tcp_connect_init,tcp_mtu_probe,tcp_write_xmit
 struct icsk_mtup_u32                probe_timestamp        read_write

tcp_mtup_init,tcp_connect_init,tcp_mtu_check_reprobe,tcp_mtu_probe
-u32                                 icsk_probes_tstamp
+u32                                 icsk_probes_tstamp
         read_write          tcp_ack
 u32                                 icsk_user_timeout
 u64[104/sizeof(u64)]                icsk_ca_priv
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

An alternative would be to clear icsk_probes_tstamp in a less hot path.

Perhaps:

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba340b39abc79b5541adca369d63d7c..751a407f64c2ba90e7b72d48942=
506870a994a2e
100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1631,6 +1631,13 @@ static inline void tcp_reset_xmit_timer(struct sock =
*sk,
                                        unsigned long when,
                                        bool pace_delay)
 {
+       if (what !=3D ICSK_TIME_PROBE0) {
+               struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+               if (icsk->icsk_pending =3D=3D ICSK_TIME_PROBE0)
+                       icsk->icsk_probes_tstamp =3D 0;
+       }
+
        if (pace_delay)
                when +=3D tcp_pacing_delay(sk);
        inet_csk_reset_xmit_timer(sk, what, when,

