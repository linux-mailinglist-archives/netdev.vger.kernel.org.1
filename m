Return-Path: <netdev+bounces-259144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB30NnnSlGmfIAIAu9opvQ
	(envelope-from <netdev+bounces-259144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:41:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D63150127
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAA9E3006207
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AE2BD031;
	Tue, 17 Feb 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ECXyoR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19A6A8D2
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360883; cv=pass; b=gyfyLjRI+4umTqeRoTopQsijYOC19CpyxVCDIQyjnaTDupeluIDGihGEE++oxvBii2vePUL/RYIAP/5lu4oaw0FHKXxpl96HS0h1EbAoPYdebezDfHUWq2HvkpJt15v3qoPPwbZ/BK4zKQhpZs98ULpkjK+KByo190LCxPYFHRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360883; c=relaxed/simple;
	bh=4qoQhPmMkvUUkFFX4u6LpFNZcw5hPg+Wnu7idi+TIyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsUzxlEsH+okIcUsZTmKo8lzae0eM+QggwkjQIDwP3vLOiMsOs6zF83eoGhA5701igfphX8lFMoP/JDT5lMTWWxxiDm3129n/olQUGfD5QXtTAbqqCmc7ZWInGAovRWbNuuxLR/axWfn5cWTmYuJKf32/3PgfqJLUHMnz11JFCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ECXyoR5; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127380532eeso11509739c88.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771360881; cv=none;
        d=google.com; s=arc-20240605;
        b=e2c33aIdHmvb1kjRtjd7F1ymcFJjJjKyjHJcoaygIuFyZrmcrBbJPHUehichOBrI6r
         U2ugFAUY8lfnrFeL2KlIBSFjsw9eMAGyWneOg2ZG3kSJ5vrR7FkrrnOlIEV2TxLnQIsR
         6zGob4F0kkIUbXslNJuDTwXn23V4fzGSOtpHpkNpT1L8IBGdWlBXpAEZ5xLv8QzPVYj6
         XhPbDrI32DccipEEuPdwh/igCWWhlCc6VyXCPXHcJBqBHlAiWOTu+b2Y8OKcZ0k+ajWj
         iJR90qzAvY6udWknffg3Rfx9hummPb9gG7ByfP3bb4OklRu+J6xuf9gjVRpweUNNo5sI
         WBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoGwKRppEYEvPHalcm6SF9SK9nCf6oAU6PoymM21MZ0=;
        fh=XJm1ZgefMYAJ++OdvPtKYC9MLMvaGukH2P3MNQeF6cg=;
        b=goKg0Q7DcZJ5qGB/J7bmEOcUW0aSjB98OezBj05ysibwZGTtO59+LeZSK4PD0bRyhF
         oZFJ/SsL4P+Ziho/m2ovSW0KBLgcNvrjdzloKrrMlrUM6jtDTNK0BsLH8VKi6B8OLwlL
         2ugfTCuy6F0KQrLpAUVk9jYYQggwtLI5NAw1jt+0IbQpqGP6fHy2pVLDk/2UT/yh6wFy
         j+PcJ62oPMA73a1GLBGD6SVh4TuGLDXMsxmspjPkgXTmh7b0eAxb1i5gXlNrHTtb93TO
         ggVSm6tGrxnnNNP3hm12YxXwoN6cL8YbXQGW1XWo6zVJ0Xd7R77vYrvAeOhagD7H8ECq
         40Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771360881; x=1771965681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoGwKRppEYEvPHalcm6SF9SK9nCf6oAU6PoymM21MZ0=;
        b=0ECXyoR5e6EM+PgbkV32959ipY+G8vTE0foVXVObNceqj8nlTCpy8UR9lGKHkrtWzV
         PXygcfZjzgnxYkhlYDypveZ2hXZmsvURgz60j8DdZM24fY9gqtNbH70Uf9VTXQ8pZSGi
         SnfN69GerVEJk6u4TvOc5Szn0PIkHSbDuwY62vR45SNnvx4LYHdHSCw/+EjIc1LMb23C
         FxEVr5tPioDKaAXKHXp4BI+PkCbtU+4U9cYtFxvQd238ihD2uyNEej8zhhLwxrWcA5KB
         A4Hs/zBD22h+7wNr0okgrwe4mYlsnpbiSeJHhOFzf6wHa7orUxzF/YroJXViFtAHxiXV
         ul6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771360881; x=1771965681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoGwKRppEYEvPHalcm6SF9SK9nCf6oAU6PoymM21MZ0=;
        b=Z54izkebV9nzeymVz3MwWBxjEB/BYR07oAH5LQbglz3fFADdn3eFPOknjhdefaSnD6
         B+FvzYHu5wjiPuLhhtoRGBiKhXVLSsCWCcYBpgeWmj8VC/UuG1LYZreyd1RN6EwPmXVw
         wxFyIaIUVf38R0c4maqAXR0peKqM5KU6humNCecnS4RfLLroynVVshHtkuRze01jA94N
         D2KZnQwHDmZsXA/DO63pYyUAFgX4lqjZJViF9F8wqk8hJw8YsIkmZ4wLcNFrkDEEpO3j
         ohdrh/QkvO/UnfhoZ+wJatCPlq3ztjmA3VWBhc29mxnqM07Mv5NiI1pJA9ZNkOjf9ScQ
         uyQA==
X-Forwarded-Encrypted: i=1; AJvYcCUWqHucuR/P2BLQEMLdwmZytVaqOaFfX9k15EmEbnpzDC8odsu8z4XgxHn9P4hKCr1t6VCsTco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBqF3hVC7M8IEa5uPEENXapgPalJTn7vgVZtvvRKQwlEiBAWG
	Rm3AL2MKP25H1SkQxvk0blwiQXthDMWp2UO2gI8ORMIqs1aeydD0+u+I3i+yBvj9rRJXq5h3hEw
	1gsr8wkG5bOO3iAmKiNU5/6qREggtiCq+nyBUiRLs
X-Gm-Gg: AZuq6aJsSIC+4dsZWNN8RPnXtXh791U8Nmja7vVjh7vMREAFyPBsvJ4Fd3u6y4B+oSd
	6qySe6wREsee8+sLy6XUMXcwBy51xHA7lluuKHHydOctGBuFL8Gi+AM/NfqR7dJRE2ds3Yd5zjO
	OdKZNzY8Meir8kmony1GAq7K0oBu3v0StUvFPvQFAKWqStwD9j+r58ZuQfPncGcPDGbjv2tR8eh
	0b8dNZAvVBsDJEDpvwzQhTijqGw9fRTTuf+IgoTaLlslZfI6dnntGBUB/nhPnBaqMY+IA7OVGpy
	nGW/pg0RENe5yzbTksgcmsVjUKeS/tNL2k5f/72ykai6LgFe71cdeUdz/xF4XH9ZZ8LahvOqP79
	c/w2B
X-Received: by 2002:a05:7022:2397:b0:11b:9386:7ecf with SMTP id
 a92af1059eb24-1273aec0f6fmr4384321c88.44.1771360880648; Tue, 17 Feb 2026
 12:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217161205.2079883-1-edumazet@google.com>
In-Reply-To: <20260217161205.2079883-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 17 Feb 2026 12:41:08 -0800
X-Gm-Features: AaiRm52l9d6gnkU79cf6ISd6zx8LnlXMM9AmvbO4i3dhNXIz4yRtMoOT0ShVBNM
Message-ID: <CAAVpQUAnnKBZaa1cunyYSqbXKmi5FKuNgxvh+_kJN4Yhkg0v3Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix potential race in tcp_v6_syn_recv_sock()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259144-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,937b5bbb6a815b3e5d0b];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 13D63150127
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 8:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
> is done too late.
>
> After tcp_v4_syn_recv_sock(), the child socket is already visible
> from TCP ehash table and other cpus might use it.
>
> Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
> bad things can happen as syzbot found.
>
> Move the problematic code in tcp_v6_mapped_child_init()
> and call this new helper from tcp_v4_syn_recv_sock() before
> the ehash insertion.
>
> This allows the removal of one tcp_sync_mss(), since
> tcp_v4_syn_recv_sock() will call it with the correct
> context.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@=
google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Not sure why syzbot failed to decode the line number, but
for those who look for the racy place, INET_ECN_dontxmit()
called from tcp_assign_congestion_control() uses inet6_sk(sk)
of the parent listener.


> ---
>  include/net/inet_connection_sock.h |  4 +-
>  include/net/tcp.h                  |  4 +-
>  net/ipv4/syncookies.c              |  2 +-
>  net/ipv4/tcp_fastopen.c            |  2 +-
>  net/ipv4/tcp_ipv4.c                |  8 ++-
>  net/ipv4/tcp_minisocks.c           |  2 +-
>  net/ipv6/tcp_ipv6.c                | 98 +++++++++++++-----------------
>  net/mptcp/subflow.c                |  6 +-
>  net/smc/af_smc.c                   |  6 +-
>  9 files changed, 66 insertions(+), 66 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index ecb362025c4e5183ec78aef4b45c249da87c19ea..5cb3056d6ddc7cb9489131f50=
3b32f3dac211bec 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -42,7 +42,9 @@ struct inet_connection_sock_af_ops {
>                                       struct request_sock *req,
>                                       struct dst_entry *dst,
>                                       struct request_sock *req_unhash,
> -                                     bool *own_req);
> +                                     bool *own_req,
> +                                     void (*opt_child_init)(struct sock =
*newsk,
> +                                                            const struct=
 sock *sk));
>         u16         net_header_len;
>         int         (*setsockopt)(struct sock *sk, int level, int optname=
,
>                                   sockptr_t optval, unsigned int optlen);
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..eb8bf63fdafc3243469f293fd=
06aef0ce086c5a4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -544,7 +544,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *=
sk, struct sk_buff *skb,
>                                   struct request_sock *req,
>                                   struct dst_entry *dst,
>                                   struct request_sock *req_unhash,
> -                                 bool *own_req);
> +                                 bool *own_req,
> +                                 void (*opt_child_init)(struct sock *new=
sk,
> +                                                        const struct soc=
k *sk));
>  int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
>  int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int =
addr_len);
>  int tcp_connect(struct sock *sk);
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 569befcf021ba5598e57ee3256843c141aeb412b..061751aabc8e16c5d536a19f7=
b920d1bca2b0f4f 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -203,7 +203,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>         bool own_req;
>
>         child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> -                                                NULL, &own_req);
> +                                                NULL, &own_req, NULL);
>         if (child) {
>                 refcount_set(&req->rsk_refcnt, 1);
>                 sock_rps_save_rxhash(child, skb);
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index b30090cff3cf7d925dc46694860abd3ca5516d70..df803f088f454cf157e0efbba=
8e2ff3f6d205530 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -333,7 +333,7 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         bool own_req;
>
>         child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, =
NULL,
> -                                                        NULL, &own_req);
> +                                                        NULL, &own_req, =
NULL);
>         if (!child)
>                 return NULL;
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 6264fc0b2be53854598d7c37ce1c7928d2e0b507..2980c175d326b6c6ebd4acba0=
c4333f481617579 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1705,7 +1705,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>                                   struct request_sock *req,
>                                   struct dst_entry *dst,
>                                   struct request_sock *req_unhash,
> -                                 bool *own_req)
> +                                 bool *own_req,
> +                                 void (*opt_child_init)(struct sock *new=
sk,
> +                                                        const struct soc=
k *sk))
>  {
>         struct inet_request_sock *ireq;
>         bool found_dup_sk =3D false;
> @@ -1757,6 +1759,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>         }
>         sk_setup_caps(newsk, dst);
>
> +#if IS_ENABLED(CONFIG_IPV6)
> +       if (opt_child_init)
> +               opt_child_init(newsk, sk);
> +#endif
>         tcp_ca_openreq_child(newsk, dst);
>
>         tcp_sync_mss(newsk, dst4_mtu(dst));
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index ec128865f5c029c971eb00cb9ee058b742efafd1..d9c5a43bd2818c17d79d8433a=
c5dd2bdd199b812 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -925,7 +925,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk=
_buff *skb,
>          * socket is created, wait for troubles.
>          */
>         child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, =
NULL,
> -                                                        req, &own_req);
> +                                                        req, &own_req, N=
ULL);
>         if (!child)
>                 goto listen_overflow;
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d10487b4e5bff87d4ff2a7b912a826964101a163..e46a0efae01235ae7430ed268=
b92cb47309b8d28 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1312,11 +1312,48 @@ static void tcp_v6_restore_cb(struct sk_buff *skb=
)
>                 sizeof(struct inet6_skb_parm));
>  }
>
> +/* Called from tcp_v4_syn_recv_sock() for v6_mapped children. */
> +static void tcp_v6_mapped_child_init(struct sock *newsk, const struct so=
ck *sk)
> +{
> +       struct inet_sock *newinet =3D inet_sk(newsk);
> +       struct ipv6_pinfo *newnp;
> +
> +       newinet->pinet6 =3D newnp =3D tcp_inet6_sk(newsk);
> +       newinet->ipv6_fl_list =3D NULL;
> +
> +       memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
> +
> +       newnp->saddr =3D newsk->sk_v6_rcv_saddr;
> +
> +       inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
> +       if (sk_is_mptcp(newsk))
> +               mptcpv6_handle_mapped(newsk, true);
> +       newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> +       tcp_sk(newsk)->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> +#endif
> +
> +       newnp->ipv6_mc_list =3D NULL;
> +       newnp->ipv6_ac_list =3D NULL;
> +       newnp->pktoptions  =3D NULL;
> +       newnp->opt         =3D NULL;
> +
> +       /* tcp_v4_syn_recv_sock() has initialized newinet->mc_{index,ttl}=
 */
> +       newnp->mcast_oif   =3D newinet->mc_index;
> +       newnp->mcast_hops  =3D newinet->mc_ttl;
> +
> +       newnp->rcv_flowinfo =3D 0;
> +       if (inet6_test_bit(REPFLOW, sk))
> +               newnp->flow_label =3D 0;
> +}
> +
>  static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct s=
k_buff *skb,
>                                          struct request_sock *req,
>                                          struct dst_entry *dst,
>                                          struct request_sock *req_unhash,
> -                                        bool *own_req)
> +                                        bool *own_req,
> +                                        void (*opt_child_init)(struct so=
ck *newsk,
> +                                                               const str=
uct sock *sk))
>  {
>         const struct ipv6_pinfo *np =3D tcp_inet6_sk(sk);
>         struct inet_request_sock *ireq;
> @@ -1332,61 +1369,10 @@ static struct sock *tcp_v6_syn_recv_sock(const st=
ruct sock *sk, struct sk_buff *
>  #endif
>         struct flowi6 fl6;
>
> -       if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> -               /*
> -                *      v6 mapped
> -                */
> -
> -               newsk =3D tcp_v4_syn_recv_sock(sk, skb, req, dst,
> -                                            req_unhash, own_req);
> -
> -               if (!newsk)
> -                       return NULL;
> -
> -               newinet =3D inet_sk(newsk);
> -               newinet->pinet6 =3D tcp_inet6_sk(newsk);
> -               newinet->ipv6_fl_list =3D NULL;
> -
> -               newnp =3D tcp_inet6_sk(newsk);
> -               newtp =3D tcp_sk(newsk);
> -
> -               memcpy(newnp, np, sizeof(struct ipv6_pinfo));
> -
> -               newnp->saddr =3D newsk->sk_v6_rcv_saddr;
> -
> -               inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
> -               if (sk_is_mptcp(newsk))
> -                       mptcpv6_handle_mapped(newsk, true);
> -               newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
> -#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> -               newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> -#endif
> -
> -               newnp->ipv6_mc_list =3D NULL;
> -               newnp->ipv6_ac_list =3D NULL;
> -               newnp->pktoptions  =3D NULL;
> -               newnp->opt         =3D NULL;
> -               newnp->mcast_oif   =3D inet_iif(skb);
> -               newnp->mcast_hops  =3D ip_hdr(skb)->ttl;
> -               newnp->rcv_flowinfo =3D 0;
> -               if (inet6_test_bit(REPFLOW, sk))
> -                       newnp->flow_label =3D 0;
> -
> -               /*
> -                * No need to charge this sock to the relevant IPv6 refcn=
t debug socks count
> -                * here, tcp_create_openreq_child now does this for us, s=
ee the comment in
> -                * that function for the gory details. -acme
> -                */
> -
> -               /* It is tricky place. Until this moment IPv4 tcp
> -                  worked with IPv6 icsk.icsk_af_ops.
> -                  Sync it now.
> -                */
> -               tcp_sync_mss(newsk, inet_csk(newsk)->icsk_pmtu_cookie);
> -
> -               return newsk;
> -       }
> -
> +       if (skb->protocol =3D=3D htons(ETH_P_IP))
> +               return tcp_v4_syn_recv_sock(sk, skb, req, dst,
> +                                           req_unhash, own_req,
> +                                           tcp_v6_mapped_child_init);
>         ireq =3D inet_rsk(req);
>
>         if (sk_acceptq_is_full(sk))
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f66129f1e649248e00215d254c925f66c3fffa6a..8b25dd86ffeb668b98fd41026=
fb084dab7dc23b8 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -808,7 +808,9 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>                                           struct request_sock *req,
>                                           struct dst_entry *dst,
>                                           struct request_sock *req_unhash=
,
> -                                         bool *own_req)
> +                                         bool *own_req,
> +                                         void (*opt_child_init)(struct s=
ock *newsk,
> +                                                                const st=
ruct sock *sk))
>  {
>         struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
>         struct mptcp_subflow_request_sock *subflow_req;
> @@ -855,7 +857,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>
>  create_child:
>         child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> -                                                    req_unhash, own_req)=
;
> +                                                    req_unhash, own_req,=
 opt_child_init);
>
>         if (child && *own_req) {
>                 struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(c=
hild);
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d8201eb3ac5f3d87a15f385862c4ae82ae3a24ff..18c56b0d7ad531e575266ad7f=
38187973422151f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -124,7 +124,9 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
>                                           struct request_sock *req,
>                                           struct dst_entry *dst,
>                                           struct request_sock *req_unhash=
,
> -                                         bool *own_req)
> +                                         bool *own_req,
> +                                         void (*opt_child_init)(struct s=
ock *newsk,
> +                                                                const st=
ruct sock *sk))
>  {
>         struct smc_sock *smc;
>         struct sock *child;
> @@ -142,7 +144,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
>
>         /* passthrough to original syn recv sock fct */
>         child =3D smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_u=
nhash,
> -                                              own_req);
> +                                              own_req, opt_child_init);
>         /* child must not inherit smc or its ops */
>         if (child) {
>                 rcu_assign_sk_user_data(child, NULL);
> --
> 2.53.0.310.g728cabbaf7-goog
>

