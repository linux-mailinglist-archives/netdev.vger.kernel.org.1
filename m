Return-Path: <netdev+bounces-289944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHpOBEezDWo62AUAu9opvQ
	(envelope-from <netdev+bounces-289944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CD258E8FC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCE533020648
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9293E2777;
	Wed, 20 May 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inyTVbbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C903A6B7F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282725; cv=pass; b=I5M3QhPXnCANkk3Hvj9DSPDLUMl9dnA5ayHpGDfEOnYUG3ofbubizdHrDuPabfrEEzBA5l5zAFXl6s7ivia4cpzA2YZHfK1KDgn1NZh9IwHSAVhHDCbE7893dvpVQWxxvHEgreWe5X5Tzp9LGP9XkQebMi4nJJBAe9CPOKztFro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282725; c=relaxed/simple;
	bh=cKw5YCzuiQEJpUmrAp3fl4H1ttFJuOreCSz37WERLgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQAp650uG6G4/C3hAJTi91fvdxr1OKe/UhvCD+Y9tubjC9p/0L0IUUS+GQwVgku2dbsopSRY3oJiNCHsUCb+Bqw3ZcSGOVAGt13ZpZbtaf/1fvvRUb+E5EySA/ejm7KzUzwg8tT0UeHNumiAsbKqcnx/Bc0vR3/h5mjumLDwmg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inyTVbbN; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c24be9e4bso5076804d50.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282715; cv=none;
        d=google.com; s=arc-20240605;
        b=MYEt6fUUy6V5p4DB5TevCmPgCbAfAeDfVsqD6qWrWiTy6+az3i2UasrfzFLV6fsEoC
         YHToI1tn4HDzKrn6Gmh9roSXvPSmw3mc/yFIj32cY1NO68EFrZXVt82WLZmqiznfCR/H
         qr52aJm9PDDQyJBJjG7ElIEmLvuHvutlHJjFpDKr6vFMG2WbRs8dI/QzglaYDH48TbrW
         XAcVL9i+2oC4fXBgYn1tDA2ZX891G9fT6ifr9HTyqo73q5/yvuGKG8BBBgn05j7rcfVg
         dEhk1c59S9NI2zboo5s7ZLzMblGfboZQuM7QPOjG0Vt4AUGsyo4FK6Wiiu+Sjc0MF1q6
         wLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        fh=c1tJaVQ/iTsiVGqbw13cNyjQW81oPfWVAHMvhC3OUgg=;
        b=gu/SOhFuVjT57Ozb+ofWi9J7JPcNSTgtfAoXiEBOz4b2J/GuZEmATk1TB8oCB+xAE9
         PwQQ1sL9Zx4ciZ6hT55v/I2E2sRWtqGkG8RF0/g24TMQ2mlxJRtlyqO1WfSl4NrOzxD1
         UYvRFSA2l6huBo/UyhaiftpiOI0neptxFXVWwOHfiPF0n92v3zfTPvdyowA+QomZqeP/
         MXVK7ScSSmLAbf8NFU0XDHa/QsrKHxTZ2Su+sOwdNQ6H7uvi+Mf6kSKMwUPG6dyjGRMS
         NtsFfQA0Gl0rAT9MRt7kMRHiYEnIXPhXSy3QuUyI1yDcYIlmYC0Kq30cQP0f+7VTEOWo
         4nQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282715; x=1779887515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        b=inyTVbbNzTuiposmSrNgPgMIalkPP+hJVHHhzuFz2FnpJN+87C62ww4hNucqitd41n
         4GXdGjO42oKfyUoKPDB3S1I6zU2smCjfVAPuMQBrM+6W1PSqlh8pysJH5NTdJXXlzbAg
         fs8GUIcls83VE184Zp9uY3V+3m75eZxx/u10Wd9JKPVNFvg49Eu6RGMBkWpYZ2GjKJwV
         cE/QQN5iOlKLlezblU09l8wC/z3uFqXxkRrEvProEeQqjR1LN6S3pRDpgmq0rYDlXMK3
         +g3Waq/rfSxJ/WZTvTMLy2XeBCoecpoXLg0YsifC50brRAL3r90zA7WOZe14eNBh7zfL
         dtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282715; x=1779887515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        b=XJvgPQSDhjmu3xW5VRWRwXAZc1Wyy+BNB0cgcGaZPHJoBwamcOZXeuZBBkkFtgX2mr
         6EDR+e1yaRV0NipiKp+dU5I63skNe2FqkD+kx0wpIYyiZhNZtEApTYvx4ZT7g1q/P23o
         5i0NWOhlbIwz51h12OdDH7fckLZyd+V1jyqIx8e0gTqV184kKfahwD3ciw1V1d/+bfrl
         pvxn56muPlQRFroIphFymrlSYhN6ijk/TfF6w86psjxt8XL/gXLzC3LKvjtGGAMfP5OQ
         /z6dKErNKjUUn5elh0oqA2mwA4dJFVUNE3fDcrjN69zKDhM3PRaVNQsShQHysuwwtba7
         6+cw==
X-Forwarded-Encrypted: i=1; AFNElJ/0y+MPJTJripXuD3si+tc5nWWB8bc+Ry0ZT7TWo27/qrCBTfYKTaSM42Fxa+90UmJyxmzKSvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZkEclbaxbuYqnS1Lwg5/Zbc4R/1iscr5b3EtNRtSlNCV1+Lh
	ReD2EtZ6tb3e+tc4Cnyc+gxEGgiXFG3X7LjkuY9TWDA5WXXLiqLHvfCm92vslK6p0R2GZYBZMka
	QCFnzLDhWYSKaUxPX1gAfouhs2ZPFukk=
X-Gm-Gg: Acq92OHXRdhQDP0tNzr3JpIOr19ps+fsUg391+HbJ1jOk4z57p3L2/w3xhN3kHcFtHy
	bo0a7gR/NhBTydSAJcLQGI9l7wJB8Y+j4rO451dOuaI8VOJExGnozADSothaBbV7wphotTtS3Ot
	+4lEZ7lc5hVioIJAAukcm+eTA6N4jUSgDu5/a3UoZPPqMuj842TexFL8vuQkGw1Q6U4dkcNLCR6
	glWtjoUUTyr+0vgFQ5qb+S7DM8RMIX+CHbEoVRWFj8iBXzcg7T7uO7HcOZ4rhvXergvCv5DsH+v
	0MBb+MK/+L2OormiiQDQ3Nm5Gh3doaxqftO0fMkp0Aa3S/BZ2V7g0HN66F5EDdfWlSF1l/0X32/
	zJNoP
X-Received: by 2002:a53:c056:0:20b0:65c:4066:d177 with SMTP id
 956f58d0204a3-65e2264ffd7mr18238658d50.9.1779282715259; Wed, 20 May 2026
 06:11:55 -0700 (PDT)
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
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
In-Reply-To: <2026052026-barber-espresso-1d9a@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 09:11:42 -0400
X-Gm-Features: AVHnY4LMSkZgfnRrbpGkQ3oSEmfCsbIHkLmvULkOOnK2PiOJuvWBImpmmtpycYc
Message-ID: <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289944-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9CD258E8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > Hi Greg,
> > >
> > > On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > >
> > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wr=
ote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wro=
te:
> > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis=
 wrote:
> > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > >
> > > > > > > > > > > The following changes since commit c78bdba7b9666020c0=
832150a4fc4c0aebc7c6ac:
> > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities (202=
6-05-14 15:17:12 +0200)
> > > > > > > > > > >
> > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > >
> > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/blue=
tooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > >
> > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a8c75=
47d088fb6275c00282:
> > > > > > > > > > >
> > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffies t=
o ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > >
> > > > > > > > > > It seems this PR sadly came too late for this week's ne=
t PR to mainline
> > > > > > > > > > that was merged yesterday.
> > > > > > > > > >
> > > > > > > > > > TWIMC, from my point of view, it would be great if we s=
omehow could
> > > > > > > > > > still get the changes from this PR or at least the btmt=
k fix it
> > > > > > > > > > contains[1] to mainline this week before -rc4, as it is=
 fixing a
> > > > > > > > > > regression known since 2026-04-24 that at least five pe=
ople encountered
> > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Blueto=
oth: btmtk:
> > > > > > > > > > validate WMT event SKB length before struct access") [0=
06b9943b982 in
> > > > > > > > > > -next].
> > > > > > > > >
> > > > > > > > > Greg, Sasha, that [1] fix I was talking about now reached=
 -next as
> > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT F=
UNC_CTRL
> > > > > > > > > events") and will likely hit mainline on Thursday or so w=
ith the weekly
> > > > > > > > > -net PR to -mainline. If that's good enough for you, I'd =
say it would be
> > > > > > > > > good to pick this up for the next round of stable kernels=
.
> > > > > > > >
> > > > > > > > That "Fixes:" tag is referring to something that is also no=
t in any
> > > > > > > > tree, but that commit does have a cc: stable in it.  So do =
we need both
> > > > > > > > of these:
> > > > > > >
> > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > >
> > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB len=
gth before struct access")
> > > > > > >
> > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c0=
8 is the
> > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluet=
ooth:
> > > > > > > btmtk: validate WMT event SKB length before struct access") -=
- the one
> > > > > > > that is causing the regression that I want to get fixed. So w=
e now only
> > > > > > > need:
> > > > > > >
> > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_=
CTRL events")
> > > > > >
> > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is goin=
g to be a
> > > > > > nightmare to track over time, ugh.
> > > > >
> > > > > Hmm, did we get the wrong hash or something? Usually, that would =
show
> > > > > up in the verify-fixes.sh, but perhaps it didn't capture it this =
time
> > > > > for some reason, perhaps I'm running an outdated version or somet=
hing
> > > > > similar.
> > > >
> > > > Something went wrong if we ended up with a patch in the stable tree=
s,
> > > > yet this fix is referring to it as a different git sha.  Don't know
> > > > where the disconnect happend :(
> > >
> > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
> > > struct access")
> > >
> > > I don't have that in any of our tree either, this is actually
> > > 634a4408c061 on all trees in the chain:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/commit/?id=3D634a4408c061
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3D634a4408c061
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D634a4408c061
> > >
> > > Or actually that was the hash before it got rebased on bluetooth-next=
 tree:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-n=
ext.git/commit/?id=3D041e88fb0c08
> > >
> > > But I didn't send the PR from that three so perhaps somebody else sen=
t
> > > it to stable with the wrong fixes tag?
> > I believe the confusion comes from "Bluetooth: btmtk: accept too short =
WMT
> > FUNC_CTRL events" itself currently having different commit hashes in
> > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The former
> > correctly refers to "Bluetooth: btmtk: validate WMT event SKB length be=
fore
> > struct access" as 634a4408c061 in the Fixes tag and was merged into net
> > yesterday heading for 7.1-rc5. The latter still refers to it as
> > 041e88fb0c08. Both are now in next-20260519 but only the latter was in
> > next-20260518 which was the latest at the time of Thorsten's message.
> >
> > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 should re=
sult
> > in a valid Fixes tag.
>
> Ok, now done.  Be careful of duplicate commits in different branches
> that are marked for backporting with different ids.  It can cause
> massive confusion (i.e. don't be like the drm tree...)

Noted. I guess I need to dig into how other trees do to avoid that.
The problem seem related to using 2 trees: bluetooth->net (fixes only,
rebased on each RC) versus bluetooth-next->net-next (development,
rebased once per release).

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz

