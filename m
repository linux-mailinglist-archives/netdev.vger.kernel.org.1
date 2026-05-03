Return-Path: <netdev+bounces-283652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJNWKlaY92nCjQIAu9opvQ
	(envelope-from <netdev+bounces-283652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E424B707D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66708300463A
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4C39DBCF;
	Sun,  3 May 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IL6242g0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05919D07E
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834067; cv=pass; b=GwfI4vemVytj50yjEXf2pBRcSSp1GcUiu7eIDhVQjEA0+wONhIMDmiMHjCs8e3PG0lDWNaXjq335CITp/UVoEyQqM7MjE0nGfTURRZXN2/zQ8TP6S9S2syX7hzyq2Sa3cY1lD06qDnJw+a36XdoGnq3aC8xV7YUPd97Fo8Nwx9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834067; c=relaxed/simple;
	bh=PMkU7itcEbnVXNt/wihEuuHDvyNd185qmqcLXZNYNYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1Uxps8LKN3omUKqn7T6scXQrEDg20szAph6AX3uN6qlz/W2NISNwmDEY+eoDdUrReb+VRegcsfKYrbJe1hIDJrsrs3N/SVh1hgKgcYvAVOYvosEiEK7kGpiyY67KR+nI4M0izwDl3XBW1wzl8PM40+Gvvq8JgNWIayYKZUzTk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IL6242g0; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8f9846c8so4429712c88.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 11:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777834066; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2INaOHVIxz7P1JLWiwxchioSCB1PsRDQhQYObay4GELs0L2yoY3QGeU+3IyUWayt3
         RwKg1d1T0mGOESnJq9sNe1OhM1LA/sZMLCYgAtSZBBnZxXt8HnZycad9mphCFDqdL2jT
         yTBKUVojXh+vI7XeTRcAZg9ugjspbgAeEnZKQGTHwjFgko0rP0He9j3EO0u0huMUOBn4
         z9K//gBLJZ405IVXDf3Jo5RIubn/kwj6gTrPA57RGeF+2CKu0Z+Va6bPVz94dIGf+SOC
         5fSzvGFiYm0wGmjsgzREYKiBvo/uT9/I7PXZXOobbJz2qmPJez7YPSFdGS/l0DzrvU9y
         ug/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jzsea2GxDCYxoTI8hwgvx9HkNfkwQrYQv+CQ9c8pkY0=;
        fh=uuCikU+0o4pxwyE1qUlEFwjv7fe2ww+JoR8HmpsRMGA=;
        b=hFwLZbMbCVRfZireP4eOq7/sLE71rrIU7FUh+gHuBSn4GKfd5S9ZT/YJ2a3sRbVMLD
         QyzZd0Mm+kyTJ9dk0enzOzb3ogNDY8qj+fAgG0BakBiuMUIo8LOAqMuqH9E6uA3kxBO2
         aVlg8nqdesEFMpBIc2LuVhTLngyQqYL4R85zBgU53Ci+y4r57mjy5v6xZwNs5Ha7My4u
         3egFolT+ABBhqoPs3F5633AaGGvAAz50HL5pI3wwcG3yUtpHse0ipL1dapcV1WmmP/DN
         yrLoCmsjNGnhE8U8bHZCstmH11l5+8UoW8zTSGJ+mHLnWGau5ka/skOM/Mcs3Cbw7E0Z
         vmHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777834066; x=1778438866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzsea2GxDCYxoTI8hwgvx9HkNfkwQrYQv+CQ9c8pkY0=;
        b=IL6242g076+lGy4e1tDt6iG1Q0l/ZXzqCnvz7yGirZnQdvdMBLUaL+7kEA7KISy+pY
         lnKOh2ZhVATzkO6RSD5G2QNMDLx5yZu7TW3OUpdE6WV6gcDEAg0PYiVr4xc6sYipC6TT
         kQwhRX8nttVWqqjgJzSbmCEF7QLRoMZJ3Yp3OSW7uBiQ3IoiT5KLrF6RaMZe6bDrnEFE
         qrg7gcqYf3uA/DDJLTFNtcTUFTrVnkGACyHzDGTUDJrR/1sj61LA6RCZgKtxlII9r22S
         iRDkrweNfiilZffp5VRxm9aFJITmwe5ZTbvuXjM881sSJjQZ9iDqYvXHmsjVVyA7CzXl
         +Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777834066; x=1778438866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jzsea2GxDCYxoTI8hwgvx9HkNfkwQrYQv+CQ9c8pkY0=;
        b=BESxxapMQLECUffYIFnMK3drzK3bcjWD5M2r51bhvikM9V6xKbK3EnmyySiIRAPzIS
         hMSFfW8LNAwPg67eOCFPv6/mfVakJU6OT1V6GQnJQZIVRg7Tz7AJMHntX/rwNCEGF8AI
         OHow2hj7+glbHKFrBTj+qBGqrDKPZLTeR/ZmsxoanjOjari+ZDTO8JUB71sPsRDeFRHK
         0Z1yN7y/bLOB+d1XhDlOcDqPFbzyX5HlM7yq3O7wPeDO0MauE1MRjT9iTos1A702Lyls
         HJW4Qhgbpqm3Ky4FSDt6FuI5mNZy99lC+NlVnNzcpNzhaZk4UI5ZaZQo8FIH21Fzf6uN
         A7SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FNm6QCW4h2ZXhqUeLbXXjwq3x2YbWRWP1xJs5qtxVG1AP1iUxTIANj/4y/Ee/t9o0yziO0lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjiFslvLY58GQy5UoSTkavLfogpZ8qy2Oot1ZSCHD1GWbR89Y
	iJb1T1bCih5i38IjLpd8qjHYyhy8787+wZbj7nvR11fgdd/PASvARm+dO4ISlmDyXtU3rN60UCq
	ZxIUcvkz1xqY6jse+Khkg0wV7Xj1DjlIkWeVFh5L3
X-Gm-Gg: AeBDietLEGL/QGbIqAxNbo21k45s5p+gmRxOIXFFrC8i7AOBuhgwdy2iRFRCelwhFjN
	oOEg10EC1wZU7IVpCTXkCf6o+QLb/ClF94frXL2VubmRFbdO0Oky+AwRfvWOftjM6o6/pm4mQhZ
	2wyxI/gGFKDwJGlf8wJ04LFSCvf+vl3KHDOTnyrr0x59yAkqCryrAisis7eqQgUbBiVQGJepqb1
	pqXZlIlqyZOHy/onaEEcrujx/vVMfwaDH9C6o1WtBvgjm+8kg8obiXFYaN/Am43w0pqY2aIz/U1
	z02LKrTQeCIMlLz10HKClWtHAlIC/hxCvBgR5HXXtXC6ZLaHSHxHVGf8osypQUjOzwm9c8omlP+
	X/qhw87PFvI5lVeDUQQ1qkt7QFg6aF8IqLM1U7KuGsTOM+7tLJgdmB4CoQYnGlzCbpswO1YZxxA
	==
X-Received: by 2002:a05:7022:23a5:b0:12d:ce69:1109 with SMTP id
 a92af1059eb24-12dfd7bb063mr2538790c88.4.1777834065059; Sun, 03 May 2026
 11:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-11-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-11-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 11:47:33 -0700
X-Gm-Features: AVHnY4LPc7d5qg-Ahd21WKEKfmFuTNurA35XFp5XHuzo2B70XXM0qfjiweiws24
Message-ID: <CAAVpQUCEnbKJJycUU0K+DmKCVJ8uvkf-gzSsxL4nGP965Zb10g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/15] bareudp: Store struct sock in struct bareudp_dev.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 11E424B707D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283652-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

For Sashiko's review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> bareudp does not need to access struct socket itself in the fast
> path; it only reads struct sock, and struct socket is only used
> for tunnel setup and teardown.
>
> Let's store struct sock directly in struct bareudp_dev.
>
> bareudp_sock_release() is called from dev->netdev_ops->ndo_stop().
> synchronize_net() in unregister_netdevice_many_notify() ensures that
> inflight bareudp RX fast paths finish before bareudp_dev is freed.
>
> bareudp no longer needs synchronize_rcu() in udp_tunnel_sock_release().

---8<---
While synchronize_net() ensures bareudp_dev is not freed while receive fast
paths are inflight, does it protect the underlying UDP socket itself?
...
Since UDP sockets are allocated from a slab cache with
SLAB_TYPESAFE_BY_RCU,...
---8<---

Sashiko is lying.  UDP doesn't use SLAB_TYPESAFE_BY_RCU,
and rather it uses SOCK_RCU_FREE and the socket is freed
after RCU grace period.


[...]
>  static void bareudp_sock_release(struct bareudp_dev *bareudp)
>  {
> -       struct socket *sock;
> +       struct sock *sk;
>
> -       sock =3D bareudp->sock;
> -       rcu_assign_pointer(bareudp->sock, NULL);
> +       sk =3D bareudp->sk;
> +       rcu_assign_pointer(bareudp->sk, NULL);
>         synchronize_net();
> -       udp_tunnel_sock_release(sock->sk);
> +       udp_tunnel_sock_release(sk);
>  }

---8<---
If an inflight receive packet is preempted right before calling the encap
handler, could the socket be freed and reallocated here?
---8<---

No, RTNL is held here, so no one can allocate a new socket.

