Return-Path: <netdev+bounces-286952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEIEN/uyAmpVvwEAu9opvQ
	(envelope-from <netdev+bounces-286952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC47519AFB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C0B73004CBB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6E320A24;
	Tue, 12 May 2026 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMeeNvg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A72F8E81
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561781; cv=pass; b=kYjPrZNcbX5fL8jWu4dJnTCBLPAAF2sdo0TIIj/WVHWk+2ghpNPULf5ufR/71DK6n8U/ybB1sgTMvTLqehEmPXlPBZoTVMp+HPP16eFSOj44c0l2DbdwCkuVGXJg1zdNrrHYiQHsKYYqRe0qSlAYV0XotZXFJKTBkaRRr8fTmdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561781; c=relaxed/simple;
	bh=iT8BlHfhQS4G2L5/IwjBmbKuibbzlZnZB84vaFftcqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svCvjcuLl6IuCrYQgO+dUApZLXCzmrafZH3yYAQKLzhpnrs3CTwWL6Ixp0+ij5k2AkLDGdDcVLQi6dbJhunqokj0KRUoOXlcfrfJS9VKTKbgDp2b+Ip4CSi/wBGXyc0PHoTxweV6AGgMyVSIBedZWJkKmI94nRWpuApEEM6Qgr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMeeNvg6; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-694932346a1so1787420eaf.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778561779; cv=none;
        d=google.com; s=arc-20240605;
        b=DpF8H8eTwdro/FjaSK4NTSHIEhDdKcVCTcH95DDsf1eZLO0cAn253t/ORfvYH/VZzS
         lAuks3BozcAEgX4THEeDf4wUF+uklGQp5MwW2ufLSvQha1Q6miMEUJtdZrkepIWoEDA8
         iP3FWFt2/Rg01zW6ZRLrAh6RWJNeLKCYlBxAzISoL+qqj0kBtRY8JD8niHHDCytyS1+g
         sB7w9DbeZQNUo+eN078pOw9iFYIFG+/Wa5MIoneESs69jbHfrC3ihBqrV14j2Qhdy43z
         xdDv7loGcEoSIu3jQ+myDkuwjtc0KKa4iKl2iFrZUw2PdxMsz1AS3x+wtpHyys2w7u8Y
         NzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+rpjM2McnsZp4nCRKCEe4a0FrHP+HbJB+L7yyR2/vkI=;
        fh=iCtzEdywDk8KW/vigBK9zELTTM3+tJKikZdJODcrFHM=;
        b=igFcUJ8wXmqnnbX74uBnuKgs+L28vm1MtNEKkMiwft64NfZzhjhmMIE8Y5edWnJ7Sv
         wPu5D3eBWLC8MUuyZesmu8P1RUSWOipGWzdHFEaUeaBno3A5ceaqmuwDVr5lUrZmwvs9
         eeM7rBCc5Bz7dl2xKuYWWYjAtGFAfKUT/VBCm0y0v9jWhHMrF2cnuzzVWOf/WoTCfdfh
         7aAyZ/fnSx1SLsSKmzlzsVuQ+Y4CtlkLA4xjQonjxgYVpnsuy/vuSHhbHh5IpSqz35yV
         TKWiR5lv4y+X2+mrlG2GU3bOyMec3aC0rqToCRFJ7InSG0YV+2EkXEWJCNXVl8az/W1B
         UsWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778561779; x=1779166579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rpjM2McnsZp4nCRKCEe4a0FrHP+HbJB+L7yyR2/vkI=;
        b=XMeeNvg648b3PLqCWlPz+jPPKCoguqxtJURYs3Tw6lkqgf7u1ipKSpP4TwSg580ltz
         24k7cez4C9mu9QsMsUL0OU4IAWj4LA61F3BB/1B7t+BYFoDAe8ELXbGSFQoQOF8uO4AK
         mDttrWqwvNzZJ1oTgx7HiWQRUjLLpKy7Wwab0YftEN3zFYyXmcd0zsW2i0N5a5kWnk4+
         B5cfZq30gLr5NV8LV5VpE2f0vLAUX1WcTa9fV94bfPBPn96XrJPvLtEU1FBz9NmBMPhF
         c170I9sH6zLM5n23OKup/McvpGmuX822Fe6YuZOcf4kUdEoLOIewqK4u5Eyh+m9jjFX+
         0NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778561779; x=1779166579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rpjM2McnsZp4nCRKCEe4a0FrHP+HbJB+L7yyR2/vkI=;
        b=iYUnfCl6lGuoZc68YoL03hm75/Nild0IG7Fm74UaQlF5OQlXlzgKKxceHkKDCozaE7
         5ZiqebGzglBMiUrvzDrguEet4R1979V1KZ0A4JPdOIpN2d9WjgBtlfp+nJmNQUm8+MWj
         W1bLys6VCo7YklrWeMP39RkA1M/kXK/QDCIVcbMpLZk/DENw6ut6WykoCxFVHt71jtLC
         klhdkiWg4fs0CGd4LLjfORbIxZu5SbU/hpNnzBL6ND5sao+ciXT1zDSYKlA6SRiabT/5
         YeSoNfoRft9jPEv501X1RqCR6TgeJ0h6+SZiKAarWZoPJpdjQa6SErM78F6oGDGEIk+z
         sukQ==
X-Gm-Message-State: AOJu0YxEgA2HTd3qOt2Bft2N689y+HO6vRXAWxSbFRqQ3MElfqL2i8nQ
	zQyEKfVtxg6QkoKAdS3ath1ilb46hvuZdk1M66wSdWxms0E2b2jhgN6PE3UwKkQiErQLMooc0Y+
	fHRnH4RNHGbeY3AL4/3Uf4WfeVkz7dFI=
X-Gm-Gg: Acq92OEYp58yWBmA7Gq85rJvF/hEprvYRGzjSoH/VQruF2tw38fSsgDyKsQO2mwhJaW
	uCejDt+4KJZhoawt7N7c9y1Vjk+LCdUikxjW0uzScnTgwotkFiWOzDY7ipSls/7kfTyw9tdBRZp
	AEeGLtTFDdDSEy+STE3zTS5DOB1Pe2qvuivxo7t0AgnYz9V/R3iV6GrGiJl/djiFsY/EmItMPLk
	67Iei1ZAnj+LZA+8OkYMd10xdGRtUQNyfT0gODjxHghOTDCrN5FB3uxg53H3GhFRqf0xQYMGxZV
	35UsrBw9OEIvTXoFEOFJ5qVcUqaA+pNd8jfZIVCPnB4DOkJJ
X-Received: by 2002:a05:6820:4c15:b0:67c:1e60:3e90 with SMTP id
 006d021491bc7-69b69cfd202mr769316eaf.6.1778561779375; Mon, 11 May 2026
 21:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512042036.19870-1-devnexen@gmail.com> <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
In-Reply-To: <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 12 May 2026 05:56:08 +0100
X-Gm-Features: AVHnY4KxtPArgknVUc6znU9iTGi30Eors7_P2pQfeefda-YpZx4KLFPnCYEPRCU
Message-ID: <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CDC47519AFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286952-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Eric,

On Tue, 12 May 2026 at 05:29, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, May 11, 2026 at 9:20=E2=80=AFPM David Carlier <devnexen@gmail.com=
> wrote:
> >
> > ovpn_tcp_close() loads the ovpn_socket via rcu_dereference_sk_user_data=
()
> > under rcu_read_lock(), takes a reference on sock->peer, caches the peer
> > pointer in a local, and drops the read lock. It then passes sock->peer
> > (rather than the cached local) to ovpn_peer_del(), re-dereferencing the
> > ovpn_socket after the RCU read section has ended.
> >
> > Unlike ovpn_tcp_sendmsg(), which uses the same "load under RCU, use
> > after unlock" pattern but is protected by lock_sock() held across the
> > function, ovpn_tcp_close() runs without the socket lock: inet_release()
> > invokes sk_prot->close() without taking lock_sock first.
> >
> > ovpn_socket_release() can therefore complete its kref_put -> detach ->
> > synchronize_rcu -> kfree(sock) sequence concurrently, in the window
> > after ovpn_tcp_close() drops rcu_read_lock() but before it dereferences
> > sock->peer. The synchronize_rcu() in ovpn_socket_release() protects
> > readers that use the dereferenced pointer inside the RCU read section,
> > not those that escape the pointer to a local and use it afterwards.
> >
> > A reproducer follows the pattern of commit 94560267d6c4 ("ovpn: tcp -
> > don't deref NULL sk_socket member after tcp_close()"): trigger a peer
> > removal (keepalive expiration or netlink OVPN_CMD_DEL_PEER) at the same
> > moment userspace closes the TCP fd. That commit fixed the detach-side
> > of the same race window; this one fixes the close-side at a different
> > victim.
> >
> > Use the already-loaded peer local, which is held by the
> > ovpn_peer_hold() taken under RCU and is the correct argument anyway.
> > The remaining lines in the function already use peer; switching this
> > call makes the function consistent and removes the dangling sock
> > dereference.
> >
> > Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  drivers/net/ovpn/tcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > index 65054cc84be5..ed4782de141a 100644
> > --- a/drivers/net/ovpn/tcp.c
> > +++ b/drivers/net/ovpn/tcp.c
> > @@ -588,7 +588,7 @@ static void ovpn_tcp_close(struct sock *sk, long ti=
meout)
> >         peer =3D sock->peer;
> >         rcu_read_unlock();
> >
> > -       ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCON=
NECT);
> > +       ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> >         peer->tcp.sk_cb.prot->close(sk, timeout);
> >         ovpn_peer_put(peer);
> >  }
>
> I do not see how rcu_read_lock() can protect sock->peer changes.
>
> I think we need to be more careful, in the prior code which reads
> sock->peer 3 times.
>
> If RCU is used, we better use it properly.
>
> rcu_read_lock();
> sock =3D rcu_dereference_sk_user_data(sk);
> if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
>         rcu_read_unlock();
>         return;
> }
> peer =3D sock->peer;
> rcu_read_unlock();

You're right. sock->peer is only assigned once, in ovpn_socket_new()
  under lock_sock() before the ovpn_socket is even published via
  rcu_assign_sk_user_data(), and never touched again - which is why the
  three reads happen to be stable. But that's the kind of invariant the
  next person has to go dig up, so the pattern is doing nobody any
  favours.

  v2 tomorrow with sock->peer read once into the local up front, and
  all the subsequent uses going through that.

  Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
  ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
  - happy to roll those into v2 as well, or punt to a follow-up,
  whichever you'd prefer.

  Thanks,
  David

