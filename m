Return-Path: <netdev+bounces-258976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN9VGIIglGmKAAIAu9opvQ
	(envelope-from <netdev+bounces-258976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CD1497F5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBC13013010
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C32DAFB5;
	Tue, 17 Feb 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVKmaSZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FD2D59FA
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315327; cv=pass; b=XEETQ6tLtrMp2Xi4PymyMzWQXDfc63Y+N6urmnBaxZBwr+XbV3m3i8vbKanOd/SOfUwpYBO9wOFztrsHguEgm7plIY2Urg49PaT+Vu7Xn/9nNnMwUlzMEp9/8D1kqo/79WwMG5EuAQmLs6W71PeRKbhnOl4hDyS1qqxdB0KeJBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315327; c=relaxed/simple;
	bh=SzfH2b93bYsuPM/clxkEUSTTo3iUi6UgLV2aZH0LOVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQCxhn4bTju5JAMzOq0oJpSgHhZDHUujUKjd0SpgwtGsJgJWv9A3uujagkaNayMCaBfP8k49RFpdtIP8crM/3ydl8w3hptiUbmphBfIgnFmo9kGx4i+i5f++HJC0ymzAhCd6nwuEH8Ze3k/hQcCC8d5r9L497zF9yHG7HhiPopA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVKmaSZb; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506984b6d83so35893321cf.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771315325; cv=none;
        d=google.com; s=arc-20240605;
        b=Yt3PD6lSAs2Y6HnhcZNUudHaVhkuI9uQn6vzyU11mC6FNfBcb4zyTAvxsHMz0WRol+
         roTuixBgkeLOOiUjY1pjnZNbbMsn4WHkZx9vQYb7ngNZJm/YvKeGkNdsKuqin83a1bvU
         eTpph5ZHlGIfQZDFzD63B6A+OPaFdb/7qX6mhS8QxdwtlGG7+/bNvllVWmdAObTZkQDc
         c8dbNL8EHpxdv59ajUWuKvkT0zgqj6QLxm9awP8NiDIi+wrkRv8nR+dl6br7jNmyLh82
         aehdZKpsY7WbIQ9Qg8/ZeSbFBBoYY5EO5Yg64Xomcutuezk/cHqXedolHqhap7z7TBIg
         kLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=83koU7lNRreyFtUQZP4xEaqNWamv1Qzz6wGQ5C2Q1vw=;
        fh=5/s5aj8OQjTF615lDYz02VSYMhM/zx1lelErj3oi7D4=;
        b=bBNZJ1AtUiRqt4W9QVN0eD5v+gliiWgnJMxupnlnSCWUlYkX0BCC5jJ6ZGndMklkkI
         qSL1tGsIEVOakykrdiRGq+bixlGv5P8jDLXir64r76dQvVYKHFkUo1mK5p4zoxGZ+fen
         pnwwiYD4vjLYPbcfeXKrna37TrgTtd7q1fmfb5iFPsJQ/ulce1GRnSKUZikwE7ct50HT
         qPbaaeV1D9zemPO+3UgQVA718iEJoXZsmddI+3Sz2DyunWZ3uaH2wnOT4PM7NPb4er5P
         YR5xNg/uQ5YZdVjpviIFfRw3+u1VZAJP96xuW9PvzhvXM05FCdvSC5jPHbUrBBgC/y/g
         UBaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771315325; x=1771920125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83koU7lNRreyFtUQZP4xEaqNWamv1Qzz6wGQ5C2Q1vw=;
        b=tVKmaSZbCLf34TAU14ocXyCgIq/hdsGPY9JEgjKNFUj2HOzf7hqcuRPuvIJDFaJ+p0
         Ylf0Lb8AQxAq3EOhFtGhayCOOlnM8VUwvfNYLlIvIjlMHwOJmRVRxOwfC9q+gWhMTOcb
         auo3N6ipjle+7cAb8gKCBzcc487eoI8aQ/n8FpGcOxgkAGpsEYK8vDbz0gByOf1Y4ZHP
         n3Uq0Nhkx6dQe5vm5M3tqnFvttYJQTKKC7L/oFI4gO+UUxxZ2HPRUd/4r4mylAvDVKXa
         txjsjUudCCWbbFTBqg3Pa3MkBj2aJ1pqn8ufe87UI0gs9ilmmvUFAFykUfpePEFg2rHi
         vE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315325; x=1771920125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83koU7lNRreyFtUQZP4xEaqNWamv1Qzz6wGQ5C2Q1vw=;
        b=CJitJi+BfdxBoklihnjhJ65ujP9Q73o752FaTdoXESQHR9NHYKYMMfDqbxVk9UwVBu
         3C9r2sM5knFZEUqaNM1SBrE2k8hHxAIvZ1mkvAbYE76X5SB/ymTasuYS3JuRcwpqc4mN
         JaXw2pBPMm7JYMWrr8J2MoCOb5HIliqbVGZvuazcpVFaHpj1EJ649yXC4vcHWBDC+2dy
         R0rwUGOjH9w5Kk1wWXCOfrh1aGI7ZgnNQcNvUDdSKtvaurkIdndVqdPKzP1DAHPoU1Cl
         Qkd3OfoTzkodBGf2mtZ8Mt6ceLlqW0+SoK6euVMg+qlIXHjWu+3iQaq6IVbLIlV3TWvl
         zW8g==
X-Gm-Message-State: AOJu0YxzNHB4xXX6mt/s8kWY7HV95C8OPRQeEKXFeMxJxcXlY1zbHBxA
	PVc1+6KHNizPPrAAL5ai87zsgTm8sb4qJHWNg5VdSKp+MhXCe1baScSAs2FXfzayDkMu/+R4oJ7
	HLNHld6+cyJUkCMHn4JxB9V/vTVibFKwv9+cE0IKI
X-Gm-Gg: AZuq6aKqYTiqVwAwk4eOWR/0ZWeu+AOpqez2i8Q6a+mmwfNoEHi97IS9CuGtwBfQK43
	iKhxSCiOKSn42l+ceMKyEOfwXj/MVIKcNljxeyUMiYbkjPP/uTR3e6gVUMpSeYuDUL+m6mOEmfx
	QyTJpqtMHo+FG0/melBBbl6gY/QwRZsb2JINdfWNeyPTaJPs/LOVlgLNKVxC/ykUhO6T5fFAN7A
	/q220Qe8erZ/fEzcr9SXXK7H41KPki10l46jVUm3S+Kuy4lGuObBTdChwZEs3/umLQCWKvT4F/h
	x6UOYyE=
X-Received: by 2002:a05:622a:8a:b0:501:48e9:69e with SMTP id
 d75a77b69052e-506a836fd39mr169951331cf.68.1771315324355; Tue, 17 Feb 2026
 00:02:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214232456.A37oV4KQ@linutronix.de>
In-Reply-To: <20260214232456.A37oV4KQ@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Feb 2026 09:01:53 +0100
X-Gm-Features: AaiRm51aim8D1hOOzQTEyVA6Bi3qGLoDP-eaBXrmzBG55rJ9SR0DdKOfPcW6ae0
Message-ID: <CANn89iJLXKeadC1NAHEZdTszO9t3XwNJJTSWywBtxNf3dM=rgA@mail.gmail.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258976-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: E68CD1497F5
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 12:25=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
>
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed and the IRQ and
> softirq handler qualify as a RCU-read section.
>
> Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/skbuff.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 61746c2b95f63..a174010e334a1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk=
_buff *skb,
>
>  static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
>  {
> -       bool ret;
> +       struct socket *sock;
> +       struct file *file;
>
>         if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_a=
llow_data)))
>                 return true;
>
> -       read_lock_bh(&sk->sk_callback_lock);
> -       ret =3D sk->sk_socket && sk->sk_socket->file &&
> -             file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET=
_RAW);
> -       read_unlock_bh(&sk->sk_callback_lock);
> -       return ret;
> +       /* The sk pointer remains valid as long as the skb is. The sk_soc=
ket and
> +        * file pointer may become NULL if the socket is closed. Both str=
uctures
> +        * (including file->cred) are RCU freed which means they can be a=
ccessed
> +        * within a RCU read section.
> +        */
> +       lockdep_assert_in_rcu_reader();
> +       sock =3D READ_ONCE(sk->sk_socket);
> +       if (!sock)
> +               return false;
> +       file =3D READ_ONCE(sock->file);
> +       if (!file)
> +               return false;
> +       return file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
>  }

I think this should work, but can you also add this in your next version:

Thanks !

diff --git a/include/net/sock.h b/include/net/sock.h
index 66b56288c1d3850439b2a0bed00be801d5770efa..6c9a83016e9551ed2e2a0d7edf3=
2300b8a4327e7
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2098,7 +2098,7 @@ static inline int sk_rx_queue_get(const struct sock *=
sk)

 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-       sk->sk_socket =3D sock;
+       WRITE_ONCE(sk->sk_socket, sock);
        if (sock) {
                WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
                WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
diff --git a/net/socket.c b/net/socket.c
index 136b98c54fb375e2065df861dd670bdb014e3da4..05952188127f5bce41494e99e86=
418249e9022f2
100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -674,7 +674,7 @@ static void __sock_release(struct socket *sock,
struct inode *inode)
                iput(SOCK_INODE(sock));
                return;
        }
-       sock->file =3D NULL;
+       WRITE_ONCE(sock->file, NULL);
 }

 /**

