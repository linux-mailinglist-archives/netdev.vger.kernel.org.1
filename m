Return-Path: <netdev+bounces-292977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAbCJ90fGWqnqggAu9opvQ
	(envelope-from <netdev+bounces-292977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F75FD41E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ED9A301876F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765B39D6F2;
	Fri, 29 May 2026 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iv/sBu/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD753203B6
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031448; cv=pass; b=XL9rCSx6Seqgeo2puDgD13s1xvix4TP7pwbxtsVNW0i3Sd8giQnUfDEyqzJtA3Qu0SAAlzGRLepcXhjnnvVExDle9eTX/VCCWP+Y5mEYY7yp74ZFEtB+7rSQpZLQz46wM47ZXxSOKP/ypWHKA6I+OEfQgHHAhBXYD+TMPMvTN8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031448; c=relaxed/simple;
	bh=CYEw2YeoAn35uS0CcPFkQrw4+W6XQ+Mkl9K7qLxMueY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4xSXoLptKpg3tTMuOjqCKjhMRKQ+d1F38j/QWxOg6cXS0Ic/3Y5bFeMlGRsw36Od+xt4uUfN2qylXHNlb2nnVuUEaBd4tZHHuQfr/IrXiHX1SO4pU4wTH/JJkVjlIa5hWrIgFJzV0/j9R8wZPD6mbF5QpaR9iHLaoPTxGgW9Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iv/sBu/R; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137bd9ed2b1so126037c88.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780031446; cv=none;
        d=google.com; s=arc-20240605;
        b=Ic+mqIPO0CI+6zQohtzJaEimFu9ninwrenD3kEPBh3jewp7f43nwSwstfoocxi/n4J
         ZYKtrTzvJz2PZE3o3+Mc0D4XjvWiTcjfBx/tZHva6+MFiAJ+rBkStz+yP/rIBfNd7cKc
         DiL4g/Wqget82/Ki44EMJ11F4VhJJtLYSMct/pXV6BQqDUJI0St0Seo86Z2AMMrCd7DW
         Y0L7qSBdKE2+6xkJtA+5mKQgVKMVVS3yzZ8KFEegNreWOse49TeYQz8mjhw13qb4nlbh
         NocqKk0MnrD8pvhFXUijypHSDhWDf88LWXlKR/es//BLrD1c+zQ/+jDyc/C5tjxB6uuZ
         70fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGClNqfUWqmlW8qDs35RSdNZnllW/VcSASYHNWdskbA=;
        fh=7x/LyHY5pE8qn1lx2Vvk+OlVE01WjBNeKeKrfu5D7J0=;
        b=iCYXEC/IPkGc69BPfng9IJkVdsGBbSih/5q8freL1KmUvZf/q9ho48sXTkwC2XnVuL
         mdZuUQYR/Y2gFCWmmRTLLdx/tzvHreZK9332ZwukBgn+P96iCCeKOQAjEvshBLjS/c8+
         qmuIt/bs+AEySXIlEqzeIGo/mlzK1sQeCFLKTa3ssaqGit4dmlnyH0rvThmnWm+1b4oY
         3E+0kM3qiPRFjPFF7KM9y0pM3R7qClkt7EQ3WAGg2jcO8omtJlJRKTolXmCKlbWOKcrq
         2Np7nD/FUkKnuYNJ2PxN7fVUgNGcR/YWPz1fcRady2ipxi0bYRuHvokZowWxigdqxHps
         +Khg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780031446; x=1780636246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGClNqfUWqmlW8qDs35RSdNZnllW/VcSASYHNWdskbA=;
        b=iv/sBu/RYslKSualZ8pV+8Zem4KK6mbRedWawnvTdBqvx5UcWzkwPOq8K1+5pPM8l7
         If8szuTy4Oz67kFG5ZyY/pKDzWRZr41iUqoxHOxagAHBfJFpkf3dIrhBpmAyiau+9w6q
         Cpr50FNVJZ25+g8arUms2IQ2a9V/4w3Ix9USTxKAWKFXFSV1gNMLiu561u3ModrQWWy5
         JQgG+K2ueEyEtPzcD8i6MDFZGHpggx5w/MelkmItSdCz3oEpDEgGim5S0uTQO+N/qYYS
         mEp4niCb/iv3vurpSIZey4e5fLNHNV08H4c7Q6Ph1iP37ZM/FuBTEgDU5ZyRuyJsHG1v
         IMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031446; x=1780636246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGClNqfUWqmlW8qDs35RSdNZnllW/VcSASYHNWdskbA=;
        b=gStOtecdZ5CPw00sMVsbbnvWeiTt9m2JegpAPSYPKTolI4s1nqDr2D15Mz6Ffb//Fn
         fPJKo8ql534Sb2iEBewBdh3BeSemMN9nQ4wEXh60J14GldqKzk/lRCME7pK0nMNsAbk9
         NBQSt09NF15DoC5wu0ZKeiMssYPXLbkYWuz+ElrI3W4BOSxk8H36qH6E59V247OG1Hmb
         gPj9M5Y/spMdmPZgO5m3xH0tysis/giAgPMI0eNrdzspmll161/xSzEATq+gnEthpWZd
         jDG4E1jpiJF1Ly0amT1kMxuXW35oWQrZYLLJSKFQGq2ZQg+469vQBjp+KOqRvun8rO7N
         oCUw==
X-Gm-Message-State: AOJu0Yw77cARhQFX4pu79PbEunowzrxk3cN5Qo+uvETilpMCRz6zTGkW
	3fnYyZLCx77+S11ysc/lOC1dG8RycA3jOYbpb1wh9LGdzOLKAjH1ekYHPHLt8ug06B9eYGNDtxu
	NFSVzPyb1DMMjENvN+okYqgmW9W6az/hJDzrNXyYW
X-Gm-Gg: Acq92OHp61XgFWHe/QfnWbsMtE723HqIyxojXRzcEPjndhgEPyrodoPfiUfLPLIQWGL
	zpzzGiOJtsegIWkvXMS5wPw2kTFd8jQnpKTzMznu29i9IkZom2oOrNYfUx892UPbSx08XKGXXPH
	PJiu69Iedse3+6rGU+rnI9raUw9TPLpXOKr9MTyJJFKtJjHlhx53A+yjEEvOx1ViXAApyPYpTJw
	7Qj1wqetYuJDSGFnyXHE7Q2hZb+x076BQQaptKUY3VF/XFedGP/HI0K/6MeCnNC8Qv5tCmtqDmJ
	t1r61Wn1Rjsz6YhkoJh475U5aAARIqoTdrjo/qGtNExP6KXP0aFIYkhY+TMI10LxPTK+ngUYC+k
	gZAtsF7XgkNeNtReVFmEIRrbvx3FEwdHIJeLcl/F6fV56pjt6KCF0eiirE3YUdnk=
X-Received: by 2002:a05:7022:458d:b0:12d:de3e:cbfe with SMTP id
 a92af1059eb24-137aeeebfbcmr592760c88.37.1780031445432; Thu, 28 May 2026
 22:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529032026.363856-1-jiayuan.chen@linux.dev>
 <CAAVpQUCJxaPTsA8DJ-KzPpWM2_GQr1LBHfdyEo9ziCA4sEqv-w@mail.gmail.com> <2a64dc4a-ad65-4fbf-a505-f4813886629b@linux.dev>
In-Reply-To: <2a64dc4a-ad65-4fbf-a505-f4813886629b@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 May 2026 22:10:33 -0700
X-Gm-Features: AVHnY4J7RK_HRj4ZOWhSo1vuYylwWT2QM3QzqUYq1huzp-Tyui3iOidE2JInimI
Message-ID: <CAAVpQUDHX9o-hRJr8=OFOCac9jSTU-Cu7OUyZSJLf+r6HPFfZQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292977-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 180F75FD41E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 10:03=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> On 5/29/26 11:41 AM, Kuniyuki Iwashima wrote:
> > On Thu, May 28, 2026 at 8:20=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> syzbot reported a splat [1]: a slab-use-after-free in
> >> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
> >> under RCU and dereferences a struct ifacaddr6 that has already been
> >> freed while still linked in the hash, so a later reader walks into a
> >> dangling node.
> >>
> >> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
> >> aca_get() bumps it to 2 to keep it alive across the unlocked region.
> >> It is published to idev->ac_list under idev->lock, but
> >> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
> >> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
> >> can slip into that window:
> >>
> >>    CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
> >>    ------------------------------   ----------------------------------=
--
> >>    aca_alloc()              refcnt 1
> >>    aca_get()               refcnt 2
> >>    write_lock_bh(idev->lock)
> >>      add aca to ac_list
> >>    write_unlock_bh(idev->lock)
> >>                                     write_lock_bh(idev->lock)
> >>                                       pull aca off ac_list
> >>                                     write_unlock_bh(idev->lock)
> >>                                     ipv6_del_acaddr_hash(aca)
> >>                                       hlist_del_init_rcu() is a no-op,
> >>                                       aca is not in the hash yet
> >>                                     aca_put()           refcnt 2->1
> >>    ipv6_add_acaddr_hash(aca)
> >>      aca now inserted into the hash
> >>    aca_put()                refcnt 1->0
> >>      call_rcu(aca_free_rcu) -> kfree(aca)
> >>
> >> The hash removal becomes a no-op because the insertion has not
> >> happened yet, so once CPU0 inserts and drops the last reference, the
> >> aca is freed while still linked in inet6_acaddr_lst[], and readers
> >> dereference freed memory after the slab slot is reused.
> >>
> >> This window opened once RTNL stopped serializing the join path against
> >> device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
> >> section so the ac_list and hash insertions are atomic with respect to
> >> teardown: a racing remover now either misses the aca entirely or finds
> >> it in both lists.
> >>
> >> [1] https://syzkaller.appspot.com/bug?extid=3Da01df04303c131efbf3a
> > Closes: and Reported-by ?
>
>
>
> It has already been closed automatically, so I didn't add a Closes tag.
> As for the Reported-by tag, it should be carried along with the patch.

Closes: is not related to the status in the syzbot dashboard.

Also, the moderation is the stage before being sent upstream,
not that the report is closed, I just published it.

So please add both tags using this link and Reported-by
tag there.

https://lore.kernel.org/netdev/6a191f87.ce022c6e.138e56.0003.GAE@google.com=
/T/


>
>
> I'll pay attention next time. :)
>
> >> Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANY=
CAST.")
> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Change itself looks good, thanks
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> >
> >> ---
> >>   net/ipv6/anycast.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> >> index 67a42e01dfc3..cd8c02a1ad4c 100644
> >> --- a/net/ipv6/anycast.c
> >> +++ b/net/ipv6/anycast.c
> >> @@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, co=
nst struct in6_addr *addr)
> >>          aca->aca_next =3D idev->ac_list;
> >>          rcu_assign_pointer(idev->ac_list, aca);
> >>
> >> -       write_unlock_bh(&idev->lock);
> >> -
> >>          ipv6_add_acaddr_hash(net, aca);
> >>
> >> +       write_unlock_bh(&idev->lock);
> >> +
> >>          ip6_ins_rt(net, f6i);
> >>
> >>          addrconf_join_solict(idev->dev, &aca->aca_addr);
> >> --
> >> 2.43.0
> >>

