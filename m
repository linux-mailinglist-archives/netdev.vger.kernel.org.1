Return-Path: <netdev+bounces-286943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fM1HDKCsAmoivgEAu9opvQ
	(envelope-from <netdev+bounces-286943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C188951993F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD07A301D584
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9283233F4;
	Tue, 12 May 2026 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y41Oucc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B38333C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560155; cv=pass; b=bIAhb4b2I5S/6XYHVot9NkzWoN9dAbMBp2OXPn0ApldTqoIugxQRGu8YXlOEcg95lbz6TYNHMZ+svKy4oWsG5y/jSNe350u6pmeVgicktbrsy3/8OqOQsWpnZd7IAjkVjS2L6ZwI50yjZV0CMZ14z/xRpKJuTcAhO2chaKry65I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560155; c=relaxed/simple;
	bh=h/eDt5U0lo/VsAgIzzeYz1DPV4ivHHhcV4oJhaGwY+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH9ztboh8CFR0VxivVLrwGDDc67leF5QLkgnzbDya7ttTKwrgqDX+HGEqY5ET6gQnPAJ1ac5FyktZcw28M8YSMjaLeJS+C3SquXMIS33v3hgB7l4NzBpa4HKUC5Jds450N9MrOfAwmpd7LNOObncOavq8fQJaDIlDWTsY4lP/xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y41Oucc2; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51306c9f2e1so50759631cf.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778560152; cv=none;
        d=google.com; s=arc-20240605;
        b=MqMDeepzT0Zmu7p24S1G1EsDeYlJmWpmVqU9610kFxe1sHnSTg/uBAsTcPFF16/edj
         x1wXxQ0vw8SKZaN5vzo1EnUBb2D75ZtMDZW23BNnCsjOOzmesXCjYH3nlsWQZRHinGNB
         JZ/zPgUL8L1WN0FluCZGULOHuv6ftvqoTwBy1OwX+xic6oB4FolCR7M69ogswZFmZI4V
         yvPaV7ie16XHekBcVBHPYBWvgLZHm8KgH5nCftzW4kVBHxcH1oUNNiB0z1poMAovMJmF
         T+K1+41U/rxJozweeOS85hA7en+mbyTlYrBslisSjUHAZg9sq1IlajlUaEEer/WyvUlp
         AhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=939ns/TUn86bI2I+n+B6oe1x+aDpF7cMJp/F84rvGRU=;
        fh=8SeOBvxmEU7nSvoFgN6fZHLgGOLQ21FBKBF24EwFi0A=;
        b=j7AIq0wXTWaCvge9UrH9IuEM+ISiKuHlSjkmU64RQnXYyPBQjWOzinXhFI58ZDYjZa
         cL4Zl4pXDDD+yr2WxG1OYc3dJhDV+I7XrAlqdkWUs0mGBrcNXL3L5bXDxxgc1A04OSFs
         oqLywtNwUn+gt46oooYjW3SKtaZ72SRpwEAoK9/hAkLKOSjFGXJ0SMEA6cgX4cEeRxoB
         K4Qn73yPyhTdmkrv4baGuZeWkgLpIjqGzsie7WRoRhXh4des91JYGFX8XXlzOmOl+FXL
         wst+z+KrRIKz+VO6a+weI1i0ucM4pKicTnSbUSGv6sr42NvVokmg9jzOh7hveOhe3Sg/
         zI8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778560152; x=1779164952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939ns/TUn86bI2I+n+B6oe1x+aDpF7cMJp/F84rvGRU=;
        b=Y41Oucc2FvWSqRp0/Kfia9Tdw/2lbOYCni0wzWNbK4NQgXpdelOyB24Ia5vmSi4bv/
         ANGR1t29EttEP4HcvOkk00s6izLUczlLNyqrNDpzpnKHNYKrblhGIetESG2rNoRVggpH
         P7zP9CyqlG0caam12+woUNtDy/888N83BDuLk+JH9shJaQYTQX6og6Ve9eSKqH+FpdWD
         DaQzVXmX+e/Ek7CG6ubZviKO3Va1Cc0oelBYXlc57mQjcuAkJI8WivCpfuXuFf55fzNl
         CtgFTVdvH9L9wMcK8o2NBjrr9ns9vKwV3uzuCn96HIiu9PfWnQLM16gqz0550fSWJCFF
         tt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778560152; x=1779164952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=939ns/TUn86bI2I+n+B6oe1x+aDpF7cMJp/F84rvGRU=;
        b=QV60FY031NpkldPvWvf2OzOLBcfUhS0MhvxEcvSzw6UGhM8zoPdkMaeScAuhHqKDTL
         YMngVOIxzTI+2dfVn21ECPThH8wEGLoqVTkm4/9fk3USqqaIOXbjBOzROg0EZpXLAoiP
         bvcZQ6tGWYPz8cG7OZZ7oukPFuuM3DWPW+fdyLfh54w0jfqsTgw8EKB4Ja/zQBet547V
         6Hy3VfnbKzY7DWwuT1Zndh/5LIBgNyk3bsNXDxDtZB2HzmRoquJNk7g4r17AaxYxurcC
         QcDS2CCfiEDHOzPXZXus9Fe7Qty8YBlu5PSXQwVrBaDVUO45gIBV4g2jszDHd9XpIJQs
         hdPQ==
X-Gm-Message-State: AOJu0YzivZ7ZM7Cl4kWj8VH5QdsfstfnWgyFZxQp9DCWSFwTmsNPohs3
	i1pcxy2nkJdLncHFhBxEeakTD9Jcb0AjstU+K1huGGJLaefr7yoLiqVJGKga7RdvSeYgwEZf5qB
	C6lmhrhkW7PpLXV3xCo+TJJkHdjJNkMqRxkI65gwv5at9FxcBE3sJK1sFlRo=
X-Gm-Gg: Acq92OE1qZRAWYXcdq5kNkvl5cZNtjUY0EXMMbsHjVcaToFPX+Cstwt8mK0i+qVm0BJ
	exMp42mFkw1qiZNhkjhf27UieiaosR9xhxDqJ70+XQH3CB7SREI7z53+13hr1sBz2bm3SjIykae
	4vvTLdkPRLTroi5HOJ3E642ILB1wdKXz7D4nY+Jwg7HJ3ehJntcI410K3t3B4nOMQVoMVDEACQb
	Rz2TcD70dVuYlOkvVajmGvrc687oQ4wMumU+WVNd14vB5Z5jOXDhkIs6JhieNuFaDLeSmCZzVRk
	j5OtAXpCilLJw6e+q3tEcNYrzholbVwE+YwNFy2FyiFbDRk4hdH6pNmUO38iTAzBTbADXKNtxgd
	/Q4bVKSYxzC3DdpzCY2bQ7MhPbuxgtg==
X-Received: by 2002:a05:622a:5408:b0:50b:3e64:9b2a with SMTP id
 d75a77b69052e-514a0a57111mr168584451cf.20.1778560151802; Mon, 11 May 2026
 21:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512042036.19870-1-devnexen@gmail.com> <20260512042036.19870-2-devnexen@gmail.com>
In-Reply-To: <20260512042036.19870-2-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 May 2026 21:29:00 -0700
X-Gm-Features: AVHnY4LpOo7kTLrbzrhIlUg9oXEQsaC4vfMuAMG_EOIAgXPE3cbxD4lG7naRDSo
Message-ID: <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C188951993F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286943-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 9:20=E2=80=AFPM David Carlier <devnexen@gmail.com> =
wrote:
>
> ovpn_tcp_close() loads the ovpn_socket via rcu_dereference_sk_user_data()
> under rcu_read_lock(), takes a reference on sock->peer, caches the peer
> pointer in a local, and drops the read lock. It then passes sock->peer
> (rather than the cached local) to ovpn_peer_del(), re-dereferencing the
> ovpn_socket after the RCU read section has ended.
>
> Unlike ovpn_tcp_sendmsg(), which uses the same "load under RCU, use
> after unlock" pattern but is protected by lock_sock() held across the
> function, ovpn_tcp_close() runs without the socket lock: inet_release()
> invokes sk_prot->close() without taking lock_sock first.
>
> ovpn_socket_release() can therefore complete its kref_put -> detach ->
> synchronize_rcu -> kfree(sock) sequence concurrently, in the window
> after ovpn_tcp_close() drops rcu_read_lock() but before it dereferences
> sock->peer. The synchronize_rcu() in ovpn_socket_release() protects
> readers that use the dereferenced pointer inside the RCU read section,
> not those that escape the pointer to a local and use it afterwards.
>
> A reproducer follows the pattern of commit 94560267d6c4 ("ovpn: tcp -
> don't deref NULL sk_socket member after tcp_close()"): trigger a peer
> removal (keepalive expiration or netlink OVPN_CMD_DEL_PEER) at the same
> moment userspace closes the TCP fd. That commit fixed the detach-side
> of the same race window; this one fixes the close-side at a different
> victim.
>
> Use the already-loaded peer local, which is held by the
> ovpn_peer_hold() taken under RCU and is the correct argument anyway.
> The remaining lines in the function already use peer; switching this
> call makes the function consistent and removes the dangling sock
> dereference.
>
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ovpn/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 65054cc84be5..ed4782de141a 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -588,7 +588,7 @@ static void ovpn_tcp_close(struct sock *sk, long time=
out)
>         peer =3D sock->peer;
>         rcu_read_unlock();
>
> -       ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNE=
CT);
> +       ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
>         peer->tcp.sk_cb.prot->close(sk, timeout);
>         ovpn_peer_put(peer);
>  }

I do not see how rcu_read_lock() can protect sock->peer changes.

I think we need to be more careful, in the prior code which reads
sock->peer 3 times.

If RCU is used, we better use it properly.

rcu_read_lock();
sock =3D rcu_dereference_sk_user_data(sk);
if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
        rcu_read_unlock();
        return;
}
peer =3D sock->peer;
rcu_read_unlock();

