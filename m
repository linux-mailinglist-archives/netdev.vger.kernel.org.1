Return-Path: <netdev+bounces-264045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BgjN22jqGnywAAAu9opvQ
	(envelope-from <netdev+bounces-264045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:26:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82738207F33
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 449213014A26
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D0386C19;
	Wed,  4 Mar 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUz6Unsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D11386444
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659563; cv=pass; b=VXjWw/+IOI0lrmKJt4NJoMgpwk56Ry/LXbaCMvKl249GDJgf7UidmZNsvAOIXXnZfMfYlphPcOb2zD88CyURRdTydSr0YmUkEm6n8RALzhUQSUOTBQfuqvV3JyVI+xxIdAVg68Nx803OFL0Yac+z5Pk9Dll4fpAko6q3VFk/cOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659563; c=relaxed/simple;
	bh=KLXKEYtmB4SEqI4A4FSyQZAfj2jvvWR0iwdwG84js9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwW77ltkVxle1YQk7V7aMYOVdm23toWiKdelZaGTQeYZMf7jesd+D0baHeNri+wPMwbdvhXnq9Pbfqa9a3cTtM6Qj8V7umXxidO+bsvBo7M+4LYqA6AYObmsHRS8zD0KqNrUoVdCHC9CFLJfc5ldQAH1LU5J1Oaavg4rH6xLTK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUz6Unsk; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824af5e5c81so7393751b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772659561; cv=none;
        d=google.com; s=arc-20240605;
        b=TDfqdndqHWjvDwFM+T6uS1+x0xarp3rmKYlF0iMr/Xz8KvWYrZtHwI1ngXvvLJjd6N
         ARoNHcGl4RuJjwj9h0LL+SnZGgEZT0UTAgcLFlJyEkDY5RPwFfZy7gSMV/ZVcQWXZuZT
         ZzUVfTduDjU53xqjaQ7Q+Huihs26r7At4KerX5Nslv3mB+Fnd5tIrLUy8lHHutqcZ1h7
         aYpOYFfWKSS/gu+8+2k9bax25On9qOz5mUAzg0TQiTP17eH2jOptTpOXZhNq3LcIQuJ7
         2cJ8Q7z3gES0vpjykk6vJByGZHGn00UOCwBfl65OPeaiY+wJPd2ErZ+Rwn5e+Xx4cKCz
         gcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yL8TME+Vn0JkBONxs9K32ojI9vGSbFL0WZFBDJPwgpg=;
        fh=jiW4o1YYuf7adDSeK5niuRv9/SknMoORELQnL4wb4GE=;
        b=i70qn96D0F7RyRVOmNZQh/LqflcGa/EMaz96UD6HYBg+R9ZprcNvRoDnfY83Mueo7p
         nma5smk8HLTnN0uDTlvsDzjwAYXJCiJfQBqNCYQRXHKMDsbJHQouFyOafnYXWwxWaNuM
         rTIZyW9F0NoQ/mJJ1SIiUxXEC2uKKV9MfCf/ECzM935gFwbHwZ/C6sbxKhQYP21R959C
         jmgJv3CXMXsA2CriThqn9CJX/uVklJgrGlRT5RgKNQUYT5t3cz7uFSSIheG6aQTbRw54
         sZJ9jbsTkkb5xS3F3D11WmNg42Kdx9OueC+Nv+uCaut3RTbcTKCYTwv5AgQ2hI5/weza
         mTGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772659561; x=1773264361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL8TME+Vn0JkBONxs9K32ojI9vGSbFL0WZFBDJPwgpg=;
        b=dUz6UnsksJVnNjKspySrj7AbDMJEOZ7hTzpeudxEtfvE6vkR8/AMGgblfReCFAwPPF
         bzjPHwRt4GPPOd5G2FwMcEVkyk2yKWgK5L/+s6dydsdLP1SSkvMig3awN/D/We2M1AL5
         UQQpIVrHj4Whry5s23NhgWSiDenp8ZpPSdlHkB+/1xyMzX3VuZCEbyQ7BAmDoqCHHiUe
         WMTxi5kHeI45qyiMDPORbaBWjwzFODEc9MNcFF5L1qBDFkJ/tAr+Exa8S4VEa57bhyEq
         dkmgvqJnkMaLOxrJdbMok1e1/ASRCaN8WNI/+roS2AEcUJJh+tAmc+TaPDZP6SpaHlP4
         y4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659561; x=1773264361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yL8TME+Vn0JkBONxs9K32ojI9vGSbFL0WZFBDJPwgpg=;
        b=lnWQ6j2bqOzu613gAPO3nAHlmfg6BCqBLSU0jVbV8IHQ1nYrmc0qAyXFOwNJ5hSoFm
         bxrMnsnemZlkPRKgKNvaVNwilQmyu0ugt3v8abfrBUf+8rvy68aIeIOTo96saBxy5PDe
         7DulS5+9H2Y/wBQxoKku3rvbDI2AgcEN+ahUYnmolhNHu0x7T+Cf5V4Jj//+ui00HVeb
         GSYsZB6gFzE3JUeNa1xVEWJgSkv2C13g20zmHDaZ590mEDXE2RVY/WxanSSqBit63CpL
         Hcb6KDUAdM1OfkPNvq41m9d8aUFOfvOTEMp0Y2MA+Z9whWpF3AmCMd+OE+1sjH5KYKtv
         sDow==
X-Gm-Message-State: AOJu0YxLSfCXyxC4PqZgKQ8bxh4EvM7NWGG6dJ60DXjddfmrbF4GN/JU
	OQhZPkyJ0GBQs1qSBK/Ko0WJA9Fkp/UEVWOmbLk+tS8C5G5N32Q98e/aptvgwjoDyg0sWLLvsYi
	HIbhQgDg0UWY7Gd6905sbyIXIxocNQS4=
X-Gm-Gg: ATEYQzy3vCPTN7we4Y/ekE7uDgK2WmUQfc/Y3C6Dy99FLQNfQUob4ZHlBuLB4asvWsz
	obzd1CF3wedUyrJbKDcHAWT9Gg2/fh9UIFOwcKYUOnpVU4U2oyCKjE+nYVjnEKOQEbT7JhBdlfw
	wSYu7UqWLVPPK/vZVL/OaVUstMjQ23pbYd00kVJi4smnh1VSv6sjOtMyyyfiH4I4yGUsoUcjz2k
	bU+vm/WoVA8GL1TBnZ2qtLSEHVjSqwHxcmO3T1lO6teVJ9UN9gOmem3wG0vGL47kLCawnTmOHvw
	mM/hhLSUIXn8kIpHUEIJUHzxcO6fbTWw7c+dU0fGqxZXS9hNU4Wdk58HiMMSkbLfX2Ln2Xu0UGo
	zRrQEYautuAckrUltdqmR25DHGFLhnswYz2KP2mtk
X-Received: by 2002:a05:6a21:44c8:b0:38b:e9eb:b12c with SMTP id
 adf61e73a8af0-3982defa8fdmr3188341637.31.1772659561307; Wed, 04 Mar 2026
 13:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <4e03deebdc944d9c963b0732abe8ba631893d82e.1771986861.git.lucien.xin@gmail.com>
 <CAF6piC+W=QKU53vix1f8JxxFhRKCcMvXaX1NKBT3kcZLfCydEA@mail.gmail.com>
In-Reply-To: <CAF6piC+W=QKU53vix1f8JxxFhRKCcMvXaX1NKBT3kcZLfCydEA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 16:25:50 -0500
X-Gm-Features: AaiRm50sq6Q3ttOp0vRNqW0uaev0YqHa-ggFkCiWTmshlDbHcjOdnyr83v7j-LI
Message-ID: <CADvbK_f84jwQPRq-xztO9mN+m_NWXaf6Q+9Ao-YtDiGQfmudLw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 08/15] quic: add path management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82738207F33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264045-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/25/26 3:34 AM, Xin Long wrote:
> > +/* Binds a QUIC path to a local port and sets up a UDP socket. */
> > +int quic_path_bind(struct sock *sk, struct quic_path_group *paths, u8 =
path)
> > +{
> > +     union quic_addr *a =3D quic_path_saddr(paths, path);
> > +     int rover, low, high, remaining;
> > +     struct net *net =3D sock_net(sk);
> > +     struct quic_uhash_head *head;
> > +     struct quic_udp_sock *us;
> > +     u16 port;
> > +
> > +     port =3D ntohs(a->v4.sin_port);
> > +     if (port) {
> > +             head =3D quic_udp_sock_head(net, port);
> > +             mutex_lock(&head->lock);
> > +             us =3D quic_udp_sock_lookup(sk, a, port);
> > +             if (us) {
>
> When the quick socket is already bound to a local port, reusing an
> existing udp tunnel sock is allowed, but when the quick socket is not
> bound, UDP tunnel sock reused is prevented. This looks confusing and not
> documented, please clarify the behavior and/or make it consistent.
>
Yes,

/* Reuse of an existing UDP tunnel socket is allowed,
* but if it is currently being freed asynchronously by the workqueue,
* it cannot be used now =E2=80=94 retry later.
*/

Let me know if it's still not clear.
>
> > +                     if (!quic_udp_sock_get(us)) { /* Releasing in wor=
kqueue; retry later. */
> > +                             mutex_unlock(&head->lock);
> > +                             return -EAGAIN;
>
> Why not -EADDRINUSE here?
Because in this case, the us is being released in workqueue, a retry
will likely succeed.

>
> > +                     }
> > +             } else {
> > +                     us =3D quic_udp_sock_create(sk, a);
> > +                     if (!us) {
> > +                             mutex_unlock(&head->lock);
> > +                             return -EINVAL;
>
> It's probably better to propagate an error code (PTR_ERR) from
> quic_udp_sock_create(), or use -ENOMEM
>
Changing to PTR_ERR looks better.

> [...]
> > @@ -332,6 +333,12 @@ static __init int quic_init(void)
> >       if (err)
> >               goto err_hash;
> >
> > +     quic_wq =3D create_workqueue("quic_workqueue");
> > +     if (!quic_wq) {
> > +             err =3D -ENOMEM;
> > +             goto err_wq;
> > +     }
>
> AI review noted that:
>
> This isn't a bug, but create_workqueue() is a legacy API marked with
> __WQ_LEGACY in include/linux/workqueue.h. Should new subsystem code use
> alloc_workqueue() with explicit flags instead?
>
> Looking at include/linux/workqueue.h, create_workqueue() implicitly sets
> WQ_PERCPU, creating per-CPU worker threads. Since quic_wq only handles
> infrequent UDP socket cleanup via quic_udp_sock_put_work() in path.c, is
> per-CPU allocation necessary here? Would alloc_workqueue("quic_workqueue"=
,
> WQ_MEM_RECLAIM, 0) be more appropriate, or could this simply use system_w=
q
> if memory reclaim safety is not required?
>
This workqueue is also used for processing some backlog packets, which requ=
ires
process context.

I will move the infrequent UDP socket cleanup to system_wq as the AI sugges=
ts,
and leave this workqueue for the backlog packets processing only.
Then the allocation becomes:

quic_wq =3D alloc_workqueue("quic_workqueue", WQ_PERCPU, 0);

Thanks.

