Return-Path: <netdev+bounces-260569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCV0BpvHnWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:45:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FA1893E0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8F531D0686
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992F28853E;
	Tue, 24 Feb 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYtwN44p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE14292B4B
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947637; cv=pass; b=TNcsMhFYBw3+nGggG4eCPHpRi94TuY0mkJ7ntUd0xSlvYnNslFfUJEEZbXbK/OWFSKvU75+KioxXiplMw7lqeN4+xrwLUoxKWlbAnPD6ogN/cnc2ZLGoCMFs4qFj+WabEsjfu02hs7DuDFYiiygQ818Qoiy6U9Ove4OlMSJ6phY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947637; c=relaxed/simple;
	bh=O3QyF9FLKTP6W6pa/p3xJuZO0tSDoqWpWsvRiZjDSKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhzFQ10W5Ya/cSc31EykX4+ZeQLrBNZw+XwrS438cJ1tEE75frikb8+i57zP+s86PXd8jep0tkHibsiqe5hDkHJPU6i5GAYhEKx7JqPnLlq/W3hSPTbycdyAVC0tS0UHmL1D7OZqhxgcAePqIY/Xa8wYrcfaMTqvHCP7ICmf+jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYtwN44p; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5062fc5d86aso53971701cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771947635; cv=none;
        d=google.com; s=arc-20240605;
        b=KI21W6ecUL4t4z7IGBzgILecXL1qelNorBUX6vmBL5u1jti4lll+2QMW+EcRDE+gUi
         qHdZHC9ax6JE+UEjrSmrxoVJfGt8b4Xz1iytYeyaveuxlUBmluhW9xgAFHg3P6t1FWqf
         F0spEhblB0BDcdthygxJqqd1qVXKwqBIhAjWs3P9Kw8nkUIU6iAx6DnGwR+pMU2+v+aj
         n/Jp34Pe72wlcI/tK5kqhbmiQQu4/GgRt79RnOt78/GEkPnC1eI3Ynmw/XQ7DJZTIhl+
         /hmg5wcTJStt+2zh4LEcm79wqiiHO9LnQuXxBNzEOGDJmr28AVecHjK5SytDLgNREPJA
         zzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1imFveo5pSvSVBui0etS47YYyKWam8zfgbleGHkHh8=;
        fh=F9Pa3NeVI0ElM4w8oSGkuVZPpQ5kQ4uD4fHIr5y8sNE=;
        b=Kp3MgBYiwUmpHUmsgRPLpJuEwahVCQkzbBmkBYqj4mlSaFrV4qd613FsOFb9pndL7T
         I+PR3Iqon7/5YwKvCk2PvkVs3m2bhvB6zfk9oYf1j+6cP6MPsZvRMhBiWwR5m1cGrSrd
         h9YzsyYL1Ul8FGX2CyP/tLLmcmZKcxJzhHvievwrvLYcpIB02s1mVKlW90cHDRSkiePO
         6Wau+htaczIGhTpX99bpmqLcSYOJHcsAlsDt7Cy5zA1f2mJBLXJHMUesM7lbyiR4Olo+
         KSQBLm0Lz/yNKReGDQJNOvrdiM6RJ/yUHvCkCKnoOE0qUpmw/YCv0zKmPHxsOSelhqOR
         r8jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771947635; x=1772552435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1imFveo5pSvSVBui0etS47YYyKWam8zfgbleGHkHh8=;
        b=qYtwN44pAzzsRjFi4t7xLa0ihOwQ8nhRGHkL8576eBlADkU6wyLDBoOUpnRgQgcPEb
         PqnK7OgqBlt9NniKN6IZ3MdxpswrU4NMGgc6deoAezK5eOgmcYeiZQoyB6JwIg87cy2+
         ph7FB2Mr94J4WJin09SwjDWdlWPks611GwxrtsPXm2lE9Tkf73WjFIdtSx5OxNap6is3
         oUowm56NJPIYC74UYWwTGi4diPjOq5h1ExMjnzWDB+csjA6s4ExuWgN0KHXL4vxYEynt
         uOGVzM69ZdwzUNDEyerZYFFzr4+SEFBvZKm/Irq+MOC49sx2LooDjDVOBtSfTQInDVLF
         nSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771947635; x=1772552435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1imFveo5pSvSVBui0etS47YYyKWam8zfgbleGHkHh8=;
        b=oxXg4JvdCPgOD/8RLch44AcCkvu4EMFDo5oz0INcJgeJwAepSLUw8ySY94hsP17ZLD
         thk2zydTmu/m0Mx2UcZx8jIW47VKUDbvETy3mvqrRHHA4JeZA9yy5AfWwHUdkRnWlGbh
         bYzr1JQiAvr6JBdDxeG0Rt46DPfU4mQbm7GpxShP7Jj7FMMuLYuPuB/MKdlvEMujmcL2
         QVqfKWozASTGHMC0v5tg1f4/RCjhGRLR842FeEX0zHoPXkrYKMzyiS1H/D2pYTFdyiVs
         f9jSTxr9QgCj0hWD3AZzHyzsyARUkOyaJrjOZFVw9mAYZxfZrC/KimRM+86WrBnhDlh1
         Yd6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjEFocb/2Js7FjIW5iaLh+/BLBfKeIW0AXTtS0PR83a6qqVZckQlE+cxQqAbtbWuaBL/f6pWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1q7qm4ozCmgGcfsFbi/3jVAhtXLKkAgnnc/sEpGChLqn+cLg
	yQJVLGRGo8uqRvVIdbe0wgcnyYtKEt10GCQjJSP1UCdOFMJWN99PDawL+mYgVxrYN2W7o9B6XvF
	jVDU2Z/6/3Y5sOeqJT9ULr98dj20U3mTkUdkXCXKG
X-Gm-Gg: AZuq6aKQPuoL7KOfT5MNiHO5XhqLwIzkgbRm/2eeqLBcgiWyzpIfuHw7u3g8M/b+lIx
	0QhnliELwIrOaf4E3ixLrLYz/qbyma6y816nfFZ6U9t1EscRQQI51DltcKILg/dnVdmWlHv08NL
	mi8ZG5ElA51mWZ4A9coWIfxsF2vUJNuBSqBZ2eYs02U8htv9AaveodcFdzMBq4LN7qZm0udr4Pu
	CIDh6FSt9kdRLYQaGxuUfafwD9XmrAkiKbboSyMyI9xzmJCDUiLI6Cv6EB09LuLLlOGrC6/dWFN
	QOGe56Th3nXX+8BqXrlx3cK9zPHyygIKGTkLL+Uopw==
X-Received: by 2002:a05:622a:155:b0:501:466b:513f with SMTP id
 d75a77b69052e-5070bb81aecmr170572891cf.15.1771947634673; Tue, 24 Feb 2026
 07:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224122856.3152608-1-edumazet@google.com> <aZ2fA2x5nHsnQoBu@strlen.de>
In-Reply-To: <aZ2fA2x5nHsnQoBu@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 16:40:21 +0100
X-Gm-Features: AaiRm533J9ZDgyKQm7SRyYWq-5zpwgDCD5gGsi5iohdc-GX4zvKgIhR8q5fnwgE
Message-ID: <CANn89iLP2xFerYywu=x8bnox_+vjrDVUxkEf-nUEJM0VmNfVdA@mail.gmail.com>
Subject: Re: [PATCH net-next] netfilter: xt_owner: no longer acquire
 sk_callback_lock in mt_owner()
To: Florian Westphal <fw@strlen.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,netfilter.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260569-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 4B6FA1893E0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 1:52=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp(=
)")
> > from Sebastian Andrzej Siewior, apply the same logic in mt_owner()
> > to avoid touching sk_callback_lock.
> > -     read_lock_bh(&sk->sk_callback_lock);
> > -     filp =3D sk->sk_socket ? sk->sk_socket->file : NULL;
> > +     /* The sk pointer remains valid as long as the skb is. The sk_soc=
ket and
> > +      * file pointer may become NULL if the socket is closed. Both str=
uctures
> > +      * (including file->cred) are RCU freed which means they can be a=
ccessed
> > +      * within a RCU read section.
> > +      */
> > +     rcu_read_lock();
> > +     sock =3D READ_ONCE(sk->sk_socket);
> > +     filp =3D sock ? READ_ONCE(sock->file) : NULL;
>
> Thanks for doing this Eric!
>
> Minor nit: rcu_read_lock is already acquired from nf_hook() helper, so
> we aleays have it in both iptables and nftables.
>
> Reviewed-by: Florian Westphal <fw@strlen.de>

Sure, I will remove the rcu_read_lock()/rcu_read_unlock()

Do you think adding lockdep_assert_in_rcu_read_lock() would be useful
or would it be too much, iptables/nftables willl always be run under RCU
and this is well understood ?

Thanks.

