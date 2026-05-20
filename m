Return-Path: <netdev+bounces-289953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NtIOIDBDWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:13:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798058F622
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D9443030D73
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0F3BD644;
	Wed, 20 May 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+WMwZvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06433344DA4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285225; cv=pass; b=AQhztoY8qAfbHDc80D3LLKR8htkGqlYMCQFglyz5f5ul7yND0dERwRw7PJqXkRnyBSIU+rrPs4WIUR+fTR1RXaS+kl//Xz1isPo+LTPt/iLNKUSm3yexNg9+GsRbR6Cpww+9hAKxKhcnJGA6lGtr8zhuVKpLfnBO0eoZvRfS08o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285225; c=relaxed/simple;
	bh=ghMB5I3ZznM6B+uIBYnjRUhxHcZcmdpqsz9B+Q/n7tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt8jd+BNP6YQd6iEZwIY08+OmJjT/iDhgi2+GEcjdlJfi7ejYEMGPF3ZXnbrf69Ea2KM7TjUawpQwg9N9kXiH6KaXZ+sTZOwV+F6uV18m+ywJd1KDasVK2IcDwhH8Tkjhb/d7LhMY+0yYP5xZlbvsCNGu82W7T7QP7VrgrHURKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+WMwZvW; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c5361142fso4800835d50.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285222; cv=none;
        d=google.com; s=arc-20240605;
        b=V/Y0C9qrhXCSBsv3L1698c1eCrhZWXWWhNsYLQXYRxyzOeWsi2D2gaorsysZx6D6Ch
         xbkOAtm0psjlUdaId8t8q6qQYyXKyg9R3wG84D5ZKs7+fNh0z09/jlKFAyIm+P883G/E
         kctsMDMyrzSsp6ZRHiiPjGI+Nmbazt8dq0APFjcQlfnawIfyPTZuMwPlMWWBeyCMYnJ5
         8nhdB8kiw+jBNE/fZraJ7FjbaYEweU+CxZYtMiTxHQXyEYmB2zbD62AuAInQPQ4Aj//F
         GzV7ecf7BiANZ6rGmZlu7cOw2kr3hRbsFgrUOyzBomhQuUnGpsHrkY18lRpMu4EKBlZ+
         Yy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        fh=i9wXgLyguSCrOHEhmrLfd1dJ0TvRmqzyUcjzs30PkUA=;
        b=WaU0P0SvtFPpVJpXKDmQhE+F1R/A9QAZ3nslZb4xVhva5gFRPsml/KrtdGZfv88ThV
         lN2x2TUKrZJjhdSyyFTtWwO+P4tbKQimys3Y410m6WgvsNyDCcEQcGV8xWZdwsV+91v/
         7+402dsL/irh7aj2OC8rMAtLF9HJmbKrmSGaWVADLtkgbrHblA5xLaIoGyXmgPS1pqWk
         OWiKE85/ZpIyRArJyb8E4e1zKRj+l2hA+Fd7J2vv8iElKpVJW6guP0S2zrNv4f9+xLWm
         iNp6R5TK5iIH5evJcf4fCZbi34rOrGYXLFK4XBb1xIEsf21hLkTpwZCw6f0E0atYEAT+
         xaoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285222; x=1779890022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=G+WMwZvWwOAZjnjJinSzsWiknyErZJ0rmDpkLx2DfwUs0luhGtNBAFFk+5BCKOmBK0
         ofWrDt1W06hqHQPmpmok+qh4AsoP+7nG0s0OoHqOL+nciQWEuBRU/A0rjBsZkTiHIHIx
         8Z8tRQKieYPg9zwIn+0Tg9zHsNXmycGpPBj4WnGNyb/+fbSEFS+0+dndAvm1x7aE7grH
         jkZOniV01U7K8/6BLE5wlSB1YlIDXTj4TjoUoLA7jFv4FR1EC7QciKijYeCMGCPzJXc5
         MpzDPAFpHuSRgmBJfyjIay6ZSP9sNPoxEi28626XphFdQKJ+uJHZVks09mToBpXKQa6h
         Vjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285222; x=1779890022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=f56QAJkfciEFw55ahwqQA5rT9kdEvZjTPqrkpy+4fHVscLR3p0s3QIgDQaIWQuIinJ
         26Wm6aHrGemIlkYYIF1ICY5zMoSQ9VUivnEfHxbbTBGLFFXO7Jw0NXN0D9GGRiSzr758
         4JiTdYUjyDnC6WNDvhERGAyKjaapOtfsc6MJ++/UzYQnhzCqCBXw5LDi51nHpcaASlS9
         GFGNR4SuPBxQYeGDmi5xpsvTm1V5pqNLdjL81KTudOiTjt3rWS27X0afhzHYnuS8Rqrx
         1whj5FEY6x2C1IuW1kKzyRzxzdsYXAHTYuMtjvLt1GYgc9GD0Mpp2xS0upc3kIu6hB4P
         cAug==
X-Forwarded-Encrypted: i=1; AFNElJ8/P7qOZbyKnvLiIYnfdJDXCqHtDbh5+kvo0EcvUx0jE+NE+K26uqzLLbt2XP1lrpj57Rp7seI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5BjFd4GB3F+rqrmThZz1mS/T/dzBmCVmmAaCtAHHJSyJGWz2
	OPeKpLfsDTivRjZBGJZUzYC1HbxC0waUiL4lYFQfT29aWSvpM/kpzhatDW+/kOs/8V1eY6jpvhF
	hibUyxVV4WHiSj7OqDmbXgxOw+WXdx/I=
X-Gm-Gg: Acq92OERcBqi1YmEuk8mLg6SbqMe2c8q83tOkunyMLhhE6dtNE8cmg532i5TjbWREUN
	sN1+vLDpS79PZd1P+XGVAZsxsVTB5xJI6U4q09NKj7lQnststtRFdGDAfMQG19cOyRHoSXpvTh2
	qo/0IEeB34NvzAiYN1c0DaQI6Pcxh11XrZ5jydpZ8nofLgC3UKfhhbkaztCIpmkLhcrXVmpZfON
	iBxnCnfoR3Xu6Of8HpdE59Ucsd0jOIia8bBvLPcA+V0Nd/hf1KY2JK4udwLoq+7F9E9NE8iKrnn
	xhAR0lqdRksgQCetoS2l1HUoQUcWZG3zz8wSwZlTUVnCaniDhwqVUuAcAMgVJX7PrB8hKw9SKvE
	HBNNw
X-Received: by 2002:a05:690e:4290:10b0:65c:2208:8c6a with SMTP id
 956f58d0204a3-65e227dfa70mr19056657d50.42.1779285221725; Wed, 20 May 2026
 06:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com> <2026052047-silica-grub-0bb2@gregkh>
In-Reply-To: <2026052047-silica-grub-0bb2@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 09:53:30 -0400
X-Gm-Features: AVHnY4Kvielev57YNURsHMJ5Vco21acsoY0xKleOB6jrUgrO8TFy7dJIbwvPLM0
Message-ID: <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: August Wikerfors <git@augustwikerfors.se>, Thorsten Leemhuis <regressions@leemhuis.info>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5798058F622
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 9:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, May 20, 2026 at 09:11:42AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Wed, May 20, 2026 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > > > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dent=
z wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis=
 wrote:
> > > > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leem=
huis wrote:
> > > > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > The following changes since commit c78bdba7b96660=
20c0832150a4fc4c0aebc7c6ac:
> > > > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities =
(2026-05-14 15:17:12 +0200)
> > > > > > > > > > > > >
> > > > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/=
bluetooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > > > >
> > > > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a=
8c7547d088fb6275c00282:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffi=
es to ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > > > >
> > > > > > > > > > > > It seems this PR sadly came too late for this week'=
s net PR to mainline
> > > > > > > > > > > > that was merged yesterday.
> > > > > > > > > > > >
> > > > > > > > > > > > TWIMC, from my point of view, it would be great if =
we somehow could
> > > > > > > > > > > > still get the changes from this PR or at least the =
btmtk fix it
> > > > > > > > > > > > contains[1] to mainline this week before -rc4, as i=
t is fixing a
> > > > > > > > > > > > regression known since 2026-04-24 that at least fiv=
e people encountered
> > > > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Bl=
uetooth: btmtk:
> > > > > > > > > > > > validate WMT event SKB length before struct access"=
) [006b9943b982 in
> > > > > > > > > > > > -next].
> > > > > > > > > > >
> > > > > > > > > > > Greg, Sasha, that [1] fix I was talking about now rea=
ched -next as
> > > > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short W=
MT FUNC_CTRL
> > > > > > > > > > > events") and will likely hit mainline on Thursday or =
so with the weekly
> > > > > > > > > > > -net PR to -mainline. If that's good enough for you, =
I'd say it would be
> > > > > > > > > > > good to pick this up for the next round of stable ker=
nels.
> > > > > > > > > >
> > > > > > > > > > That "Fixes:" tag is referring to something that is als=
o not in any
> > > > > > > > > > tree, but that commit does have a cc: stable in it.  So=
 do we need both
> > > > > > > > > > of these:
> > > > > > > > >
> > > > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > > > >
> > > > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB=
 length before struct access")
> > > > > > > > >
> > > > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88f=
b0c08 is the
> > > > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("B=
luetooth:
> > > > > > > > > btmtk: validate WMT event SKB length before struct access=
") -- the one
> > > > > > > > > that is causing the regression that I want to get fixed. =
So we now only
> > > > > > > > > need:
> > > > > > > > >
> > > > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT F=
UNC_CTRL events")
> > > > > > > >
> > > > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is =
going to be a
> > > > > > > > nightmare to track over time, ugh.
> > > > > > >
> > > > > > > Hmm, did we get the wrong hash or something? Usually, that wo=
uld show
> > > > > > > up in the verify-fixes.sh, but perhaps it didn't capture it t=
his time
> > > > > > > for some reason, perhaps I'm running an outdated version or s=
omething
> > > > > > > similar.
> > > > > >
> > > > > > Something went wrong if we ended up with a patch in the stable =
trees,
> > > > > > yet this fix is referring to it as a different git sha.  Don't =
know
> > > > > > where the disconnect happend :(
> > > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore
> > > > > struct access")
> > > > >
> > > > > I don't have that in any of our tree either, this is actually
> > > > > 634a4408c061 on all trees in the chain:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/commit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/co=
mmit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D634a4408c061
> > > > >
> > > > > Or actually that was the hash before it got rebased on bluetooth-=
next tree:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git/commit/?id=3D041e88fb0c08
> > > > >
> > > > > But I didn't send the PR from that three so perhaps somebody else=
 sent
> > > > > it to stable with the wrong fixes tag?
> > > > I believe the confusion comes from "Bluetooth: btmtk: accept too sh=
ort WMT
> > > > FUNC_CTRL events" itself currently having different commit hashes i=
n
> > > > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The for=
mer
> > > > correctly refers to "Bluetooth: btmtk: validate WMT event SKB lengt=
h before
> > > > struct access" as 634a4408c061 in the Fixes tag and was merged into=
 net
> > > > yesterday heading for 7.1-rc5. The latter still refers to it as
> > > > 041e88fb0c08. Both are now in next-20260519 but only the latter was=
 in
> > > > next-20260518 which was the latest at the time of Thorsten's messag=
e.
> > > >
> > > > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 shoul=
d result
> > > > in a valid Fixes tag.
> > >
> > > Ok, now done.  Be careful of duplicate commits in different branches
> > > that are marked for backporting with different ids.  It can cause
> > > massive confusion (i.e. don't be like the drm tree...)
> >
> > Noted. I guess I need to dig into how other trees do to avoid that.
> > The problem seem related to using 2 trees: bluetooth->net (fixes only,
> > rebased on each RC) versus bluetooth-next->net-next (development,
> > rebased once per release).
>
> Just never rebase any public tree please.

I guess the alternative is to do merges, right? While I understand
this will not be changing the sha-ids I don't think it changes the
fact that fixes applied on the bluetooth-next cannot be merged into
bluetooth. Is there a way to retain the IDs across trees? The
alternative, I guess, would be to apply fixes to bluetooth tree and
then merge them back to bluetooth-next to preserve the IDs. This would
make the CI job slightly harder, as it would need to detect if a Fixes
tag exists; if so, it would probably need to go through the Bluetooth
tree first.

--=20
Luiz Augusto von Dentz

