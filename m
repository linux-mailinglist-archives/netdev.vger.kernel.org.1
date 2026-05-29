Return-Path: <netdev+bounces-292960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGlwF+cKGWpjpwgAu9opvQ
	(envelope-from <netdev+bounces-292960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C83865FCCD8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B40593028F52
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A19364EB6;
	Fri, 29 May 2026 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDeR0rLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3831A045
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780026083; cv=pass; b=b46NvI/r487927PQCm515ARuJYMkTghtU6g4QAArEG67G5rpT3RF2NMuSf/3lttcolaPOQRK86Obm9RAixn4ZsLDO9cyqiqLYQ1qCaYRCeiaRX/YSWRagWy87Ce5M6o9L6RlmeWpE9MyqIaBXM9zbth6qvcYX2rLqNUHhhkZfpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780026083; c=relaxed/simple;
	bh=i6JYTRjm4JXejcRLaJhLR1YR6Ikw12Sv3JIRSgFRLr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzPEcSQFgvyfSeIeWc2uQsga/uXMS+KCcnAroT9ufxoRaS/y/2/ZF2JP9UtwAdrQn5i8BJpbmU88rHOaNhsIBL7c4Y1cQ1fhhLWDeEPP+YcVz3Km/yR8XtxTm5kqRKwU5oRwsaO1rOHf9MwBjsevNYFDY84TkzAuTwQwVFRfi6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDeR0rLT; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-132d1b2519eso9599364c88.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780026080; cv=none;
        d=google.com; s=arc-20240605;
        b=Fek88M6A2ulq/jDxQo64KJuJi4pqxYRlcVby4Ju0b8bfBvVeEaXfWtDNCWfG2Fliml
         G836VkOvydNhcO1xnxEI+UY344xVrROmEvoUAqESTcGmVY2m8ftTjWCEfO1d1lrbxpoO
         IixvvX5lIb2DrC09BzB0VYzmIgqQY+EBJ16AOm6fz5NU5Zkqw4V7LAImupz4yAOtnIjT
         Gy7MJ5d9jz2HQjL5Ho5X60ZsuL6rn5ajTJCpmjeM73z+tdC6Uv1z2uXPC3s+9JH72K7A
         aQcEcRHkW+YeowVUaFJC7s6ABrevW013OOXd7whc3VvhDe89mdu3n9ZCn7y3si3Q9qJ+
         d5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNKxgDovCOq+Ul4OFwE0rhhGQh17y9vA7PTe6i4EqtU=;
        fh=7x/LyHY5pE8qn1lx2Vvk+OlVE01WjBNeKeKrfu5D7J0=;
        b=ZkVQrsZP2sSMBlawJek2xqc07F7DcQ2pf3tgDgl8owW8SB7vsbTUbjWsm47Znc5Q+m
         lyEJVjVvfWL5Fq6WSvTMWzJz1aRxvunoQ9mG83i8020G7Ua4qNIXNFoVupWRU0iChojN
         3s2HBpjfdpY0RY9Bs8kYEy/VXrittV+nycPcRwS6E9lH1iB/Bz0a025m0pCZ8i6PGvri
         VcKdqY4vV/ziO7GLY0vk40i6ZeODXnPXyilB/H7QMEOMLDk950Kw9pXKEF1MdvsUVveI
         9BSsRAexrJWbBldURst1QpPpmnfwxWwq9SYkbrT0qxWeJIRha5ADt+aYHqJDhdoYkQM3
         4z9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780026080; x=1780630880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNKxgDovCOq+Ul4OFwE0rhhGQh17y9vA7PTe6i4EqtU=;
        b=HDeR0rLT5Hp13SrFhUv3CEJx5lpUAexbFmv6umr0mab0+91doiV+ApUj2Ng2C97inY
         sJxxHxaA0jfiVyY3TiIg0e1pJsSaS+OAJXa2wdgsYZDhqzxRtVqknnv40UIe3JBkcAJ4
         XSSo4cCVBGkbKF32siEUEQod1L+KqgH/8r6rJOqPpccOTBwrTjrapZ9ehExBnzCPgUIB
         HHwsH84/xwA8DL0Y1/Is9MbuAeI2FbcOuVdbAlYNo9/GVU74pL5Q0lpt41ZNCVfAeyy0
         QRmbOxYEuCxVbqySeBExNxxjVWh/OC5N4YmaHOr/ZIVZCLr+Up2wvDlk8MfFhATLdNrp
         PR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780026080; x=1780630880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNKxgDovCOq+Ul4OFwE0rhhGQh17y9vA7PTe6i4EqtU=;
        b=BIyroOP0reIwiHSw+CkdNzGIYC4FM69zDQMTcy7V3/Tr4wsQp+cS5Jteo+5TYDpEfo
         EvzRjfT+gbhQ5tBbThNIwqW9UTYUeR4bzxhyiQ8HpW3tJURP87GVgzhu59igWSCYhVdi
         GkD7NkavCRNfwSsOrjT1/h7wmO7E+RJTHzTJx/AA7noEJ/S5rkeGIjxReS5tc47a+L0U
         O4AzD5dwa0GTlbjs9NXPq8yg7HgAfAs8YXMefyi3gMXjRUbdcEWjVXUS3x8xFOMqlnuO
         7c8IDpaConnmcelPm96ZmfqcZw8vl5FyKAPeG91OSfHpy0aoV0BZ3WVs3Kw8WL0+rHbx
         69wg==
X-Gm-Message-State: AOJu0YwPnDnZlLeiLWG9lt2NS84FbpPEu7FigwfcwDktxs7kXCJ7XMEi
	6lfHvEfHxkynWz+Uta4p9/3bVvIN4z3GX5ItALZ24G2K49agxb60XjJf7KmC8vMAbzAdw768TAg
	ZlZaWofrKUxabDaTDHFm5nfC4it1FdEfDEMLtRWqO
X-Gm-Gg: Acq92OHBXXRvdTgrDBe0qd+FWb/drAtJQ2jItGhqlwWhhU+tFMhY1ppzUt+4ct/f8+X
	NWSsTk/Sru0K+XIDuDOhSayJ/j+w/uJAzKEIMF7u5+F42I3/SYyC0zyvyWHCTaayatg3ORQgfvT
	55e1RApjxoByCl8UkXA0Fp++ogMIkJNz5A4Sa2Dxe3R0XjV5l/B5HoEuRw+VcKO2te9ZPUQDIbE
	GqI8O2owON0okyBuXBn+TF8nS7bC8lXy/foTdWks4TIUM/4GCCIvi+IEnn0xVAWpJIXcTH2TfXN
	QZWjzaGWaJvGfpsrVognm/UaSKsg+MO47iULIwdndyr2eYASJyK7CjVs7Qa55WseoCg4aRgXuv1
	4vreLNAGQeV8QbMS1TmukHB9b9e6zuHrtQZpNOMDuSa/ha0XE+YBqKau266b7
X-Received: by 2002:a05:7022:397:b0:130:aa42:167b with SMTP id
 a92af1059eb24-137af863b19mr444180c88.36.1780026079351; Thu, 28 May 2026
 20:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529032026.363856-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260529032026.363856-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 May 2026 20:41:08 -0700
X-Gm-Features: AVHnY4LyHWveM15GXyGtNcmp8lh-hR06yFfs4exejVzeulQhKS0sSffUxqsQ-kU
Message-ID: <CAAVpQUCJxaPTsA8DJ-KzPpWM2_GQr1LBHfdyEo9ziCA4sEqv-w@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: anycast: insert aca into global hash under idev->lock
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,linux.dev:email]
X-Rspamd-Queue-Id: C83865FCCD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 8:20=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> syzbot reported a splat [1]: a slab-use-after-free in
> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
> under RCU and dereferences a struct ifacaddr6 that has already been
> freed while still linked in the hash, so a later reader walks into a
> dangling node.
>
> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
> aca_get() bumps it to 2 to keep it alive across the unlocked region.
> It is published to idev->ac_list under idev->lock, but
> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
> can slip into that window:
>
>   CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
>   ------------------------------   ------------------------------------
>   aca_alloc()              refcnt 1
>   aca_get()               refcnt 2
>   write_lock_bh(idev->lock)
>     add aca to ac_list
>   write_unlock_bh(idev->lock)
>                                    write_lock_bh(idev->lock)
>                                      pull aca off ac_list
>                                    write_unlock_bh(idev->lock)
>                                    ipv6_del_acaddr_hash(aca)
>                                      hlist_del_init_rcu() is a no-op,
>                                      aca is not in the hash yet
>                                    aca_put()           refcnt 2->1
>   ipv6_add_acaddr_hash(aca)
>     aca now inserted into the hash
>   aca_put()                refcnt 1->0
>     call_rcu(aca_free_rcu) -> kfree(aca)
>
> The hash removal becomes a no-op because the insertion has not
> happened yet, so once CPU0 inserts and drops the last reference, the
> aca is freed while still linked in inet6_acaddr_lst[], and readers
> dereference freed memory after the slab slot is reused.
>
> This window opened once RTNL stopped serializing the join path against
> device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
> section so the ac_list and hash insertions are atomic with respect to
> teardown: a racing remover now either misses the aca entirely or finds
> it in both lists.
>
> [1] https://syzkaller.appspot.com/bug?extid=3Da01df04303c131efbf3a

Closes: and Reported-by ?

>
> Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAS=
T.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Change itself looks good, thanks

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  net/ipv6/anycast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index 67a42e01dfc3..cd8c02a1ad4c 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const=
 struct in6_addr *addr)
>         aca->aca_next =3D idev->ac_list;
>         rcu_assign_pointer(idev->ac_list, aca);
>
> -       write_unlock_bh(&idev->lock);
> -
>         ipv6_add_acaddr_hash(net, aca);
>
> +       write_unlock_bh(&idev->lock);
> +
>         ip6_ins_rt(net, f6i);
>
>         addrconf_join_solict(idev->dev, &aca->aca_addr);
> --
> 2.43.0
>

