Return-Path: <netdev+bounces-289509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPW7LkGODGpCjAUAu9opvQ
	(envelope-from <netdev+bounces-289509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA258234F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DFD6313FDAB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BB33985A;
	Tue, 19 May 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEiXkpkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861413546CA
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205801; cv=pass; b=D7fHscDS9fJgZFZfKVZssNdnnUx/K73bKC7pit/Avx2IxbZxde04lc9OBZk2MwRu47389jcWR+WMm8p31+BpmA84ltGjDCkcbT+lU1mSaJ8bo3ElVOaLGB/geHRxwAZY7VwTrOsmPGZI5/shFDl9PWvKAFWtqcgEv15QMZOlaO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205801; c=relaxed/simple;
	bh=x/7cCwdNDXXJxtXg1SGsgN05u2+rsVMZSWA2qFFjjh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9jcmAwa7xsVn2/4azz+diRoCyexoiBR8uLGjETnsZvqqDobf/+GL42vzHYcA1mAU3a3vE7R8ekEyglx9jTxbMb5AmmQ6ENi4ojY8fRGZ7lg9BlNcr+OqV8uHpdvYpIdmdwEVGnwh1g0f9o8xAHPIzO9KIg9UcP4FHVnI6nWM+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEiXkpkR; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65e15fb394bso2763858d50.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205798; cv=none;
        d=google.com; s=arc-20240605;
        b=NqTppGFWyihmJ1LuBFXmkS9u97CYSffiLho6OUMWJHOwyoxRbuH5x+umt/rhCgJlzC
         T5YozTaSJitVNy+rLrze6lxDDb/9nB8kls49Slb6sEwbLCFa6wiQXf341rG+nPwGCD8Z
         GqeOwQnJjF4yY0l9DpYLSSLllt2fdxFDMgbLAi72Xdtc1DXUFhs8ue43/DtMNVV6L9uP
         2GtjVNrlWu+twCMatKikiW6JLLo+oLj7RnTHChIo+if5zsJmM/pkFql69Ih4vPPT01Do
         2zhoZEAm7eba2wVLT3L2DjO7CPxyL/nC2skTKCLGLToBKslZHyQL6s+LjbqXpEpfVmHI
         wzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        fh=cFhrOeKJul2HVMyrBzIytTnMwp6fmwY1h0pzc2jd3NY=;
        b=ZusF4kw81+F/MT7O0AwJ3MzyRkfJoCJmV7Wj5h3qi26DjkDz2gIpntFpHYAFOy1Y6w
         Hke/79m7WB8x+u5D2DZv5EF5pUe86SRRvJCQKUxK4ixeYl6M7mR3A2212vw54ap/qQFP
         c+i5yWiC2eQgELQu2iu1XvIspMWlruv+fKRcJUXtkkkZBhtwZ1xW41txSxo6lCLo5OXh
         wfHWeZnP9J8LJa56uAqhahrDb7vEdc3wlkePKffBbVbriKbW5Pvg3focSJUif2GcDp8F
         IhuOqFzR/uFOTWIGxPyYlG3jJ4qiWii4XoWQFLZQSEk5Ie7ocykvG/0UgSm+zTVLdX19
         YLMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205798; x=1779810598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=QEiXkpkRj4+tE3U+2AlitOx/CXjgde+D3wyFc+K/ivxh2pXy0UmTqgrtXuqMm68o1V
         jOZkrPoI1ajdVVx6Mlz0Z7jN+VSM8k84LKF0NZAUCLgnZS8eNTSxAXSZZ/QGhTpmjoi2
         cfUrsM7wBc7xOOos/MtU1uyfZqKSkKqhfAImmnQte4ywipgLktjLiuSGOarn2fD35y3G
         lMaa1Z8nt6DZA/18qQaXmFlA7lnM0e4SnMgqAnW53oKmw/q8ZmaJedqbOKSrrhQYw4io
         eUF6rjZIC4zrgXcW5KyaXU9XYjEe8NMJLeNUFq9xf6GJUHYFsfbmTkHPRLlnpSilp7hF
         yw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205798; x=1779810598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=rYiho55obl+VVfn6rerXVM87YqRzoliS7Ij/jKOO1DbM4180uRo5ES/KdIm4AD7zd9
         IwE7FrPkKmeHZR5g5yjURPUFII/LRR85Z3qXqrBOC45C2u+GTFlzwI5JnzP6HQpe472q
         7n7DXDEZ9uM7ok0EzaUDfUsMuL4aRtPOiOCpOu56Gt1C01na9l2Oxqh+o6wXUFwi8yca
         F0WOKN7zge3/5dP5wg2DRmvKkZlq5Sxj2RfWO+iAmdiSe4NwuIcD0JmYTHR3mbdNP4EG
         wTQRqiBXtMcVQ4VhYalpVlNNgIn+hhevBqmaDugLqp2/5+nFIBRFugTZT5bIoUoMbAHP
         Ifhg==
X-Forwarded-Encrypted: i=1; AFNElJ+aRlOUEZVoR/d2Lf8x+aEBCxg7CfoVS/yEZE6ROyq+fToKsrUnJKG+JCrKSoZibMyL1Xi+xss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVEXSJ5QjqxsxmVO+FjplrMbkj+pWlog+J4Xgdy9KHcUbEmHs
	IPeF5nJ/QgkmOg61SyE30bCCFM9lrrqRBh0pLf1RGfHjfJqWkxgv6AdYdNYXc7/gPmoJ2e8xTMj
	7DQtz10hFS6EfUfGNoj6lMbEAC9Y5cJipZ5nPMRuxNQ==
X-Gm-Gg: Acq92OHil/zgx+vLO+u4dqFUyWgSlfYQagc34O/o1UsjXO6J1VeOkoNVjof9ZknYLmY
	XbHysOlmtNewsrqDXZhHTlR8NuA7KRZXqg5vVIkjrmEWJwiwHJcie8khAtRwtGp/dK0SiKOSUMR
	5Ojhm6YkEeAO50scG/UpnpUwljvErTIxPB6POCuNP2D6clVdjSQFZDIPpu33T/oFhVEoYIgU+6q
	KU3HgQ9Jw/UbveHftYlYtuUTCz/M0JIO/qhsIJAAzbHtbnx3dyaamhwvTYNKFGZbJh9wjLT2/4D
	pzyHd9WCrxlA7MI3fvLxrCs4ZFtB4wfKMANLi1EcbYoQPtUajYLKQlIKIw/gAHKVNwXxaQ==
X-Received: by 2002:a05:690e:12cd:b0:65e:41dc:e8de with SMTP id
 956f58d0204a3-65e41dcecd9mr12441208d50.61.1779205798318; Tue, 19 May 2026
 08:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
In-Reply-To: <2026051942-uproar-drainpipe-6370@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 11:49:47 -0400
X-Gm-Features: AVHnY4L0X8LYGYt87xzFEQmSQ0jaH-sWR5xnvms9EdsiDiaiEGK8SYnDvpGiMU0
Message-ID: <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289509-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21FA258234F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote=
:
> > > > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > >>>
> > > > >>>> The following changes since commit c78bdba7b9666020c0832150a4f=
c4c0aebc7c6ac:
> > > > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15=
:17:12 +0200)
> > > > >>>>
> > > > >>>> are available in the Git repository at:
> > > > >>>>
> > > > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blue=
tooth.git tags/for-net-2026-05-14
> > > > >>>>
> > > > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6=
275c00282:
> > > > >>>>
> > > > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026=
-05-14 09:58:08 -0400)
> > > > >>>
> > > > >>> It seems this PR sadly came too late for this week's net PR to =
mainline
> > > > >>> that was merged yesterday.
> > > > >>>
> > > > >>> TWIMC, from my point of view, it would be great if we somehow c=
ould
> > > > >>> still get the changes from this PR or at least the btmtk fix it
> > > > >>> contains[1] to mainline this week before -rc4, as it is fixing =
a
> > > > >>> regression known since 2026-04-24 that at least five people enc=
ountered
> > > > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btm=
tk:
> > > > >>> validate WMT event SKB length before struct access") [006b9943b=
982 in
> > > > >>> -next].
> > > > >>
> > > > >> Greg, Sasha, that [1] fix I was talking about now reached -next =
as
> > > > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTR=
L
> > > > >> events") and will likely hit mainline on Thursday or so with the=
 weekly
> > > > >> -net PR to -mainline. If that's good enough for you, I'd say it =
would be
> > > > >> good to pick this up for the next round of stable kernels.
> > > > >
> > > > > That "Fixes:" tag is referring to something that is also not in a=
ny
> > > > > tree, but that commit does have a cc: stable in it.  So do we nee=
d both
> > > > > of these:
> > > >
> > > > Valid question, as yes, there is a slight mixup here:
> > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore struct access")
> > > >
> > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is t=
he
> > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > > > btmtk: validate WMT event SKB length before struct access") -- the =
one
> > > > that is causing the regression that I want to get fixed. So we now =
only
> > > > need:
> > > >
> > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL e=
vents")
> > >
> > > Ok, but that "Fixes:" tag pointing to an invalid commit is going to b=
e a
> > > nightmare to track over time, ugh.
> >
> > Hmm, did we get the wrong hash or something? Usually, that would show
> > up in the verify-fixes.sh, but perhaps it didn't capture it this time
> > for some reason, perhaps I'm running an outdated version or something
> > similar.
>
> Something went wrong if we ended up with a patch in the stable trees,
> yet this fix is referring to it as a different git sha.  Don't know
> where the disconnect happend :(

041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
struct access")

I don't have that in any of our tree either, this is actually
634a4408c061 on all trees in the chain:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/com=
mit/?id=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D634a4408c061

Or actually that was the hash before it got rebased on bluetooth-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D041e88fb0c08

But I didn't send the PR from that three so perhaps somebody else sent
it to stable with the wrong fixes tag?

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz

