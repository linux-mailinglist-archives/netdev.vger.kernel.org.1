Return-Path: <netdev+bounces-267565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CY6CYlmtGm4nQAAu9opvQ
	(envelope-from <netdev+bounces-267565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC2289515
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C748B318B913
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB33DD51C;
	Fri, 13 Mar 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LImE69bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F23890E7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429836; cv=pass; b=Sv5dH5F+NFGRDkDZ+7z2xpOQptlHVQ4XXq1fca88y3fRg8WPwXSTUVMTB/6KOwnHHpAELXkUDJazC1v4+Irg/FY3OeOJT827te/nop67BC1NSWf+ks+rcPzq/58+xSRZRvnJoWW7Owxb2SNmHwpoHYxCjRF8LU3CjCxUBDynEMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429836; c=relaxed/simple;
	bh=hprIMvqXPDky5lABLmbn58PPpa0nP+LWPC9+kav2e0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKlC7hqBp2eHswWJxy4rD4QkdpP4rTsM55py7W/Sr4hruLyO5wvYEdjRrNzzZFJnyyyqxGS5ZjHSmVFeBa5PdDW1Ifx+HCxM+8VHlX8TdN5TpL2RbtIDOumN7zxsJURWVjUuDLKb0jfHWLtEBwhpS/LKitf1XhSGWJ+IT+skYFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LImE69bQ; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829b2018c94so1558016b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773429834; cv=none;
        d=google.com; s=arc-20240605;
        b=Nz1q8AdhvJOno7cLHYxVn5vf2W7ewJmh6Fzcjc+etssVFfuNagG1KTDcb/UZ/jFCau
         viKGu50lBJ8WrdVPs82xputjVOviCImzJuOINpEjy+t8klzllFxOJR5WbisoRFIpzerU
         3eW00pc8rduyxxzV3hvioYLz4YAsJqJV0/K7fsZEgig+tTB+iBeolON+MuM5G7LQ+hCd
         rLAn8TogDZum5gxCZJVb3LiqqT4mPslboxHqaGeKJAd3TMv0IhkGeMHGZ7GKeJr9e6Gj
         i3NvT2USJAC2WlOaSh+7Kg/T0xWId+gxkh2HCxNqJWLvSQO18MR+xFjFaqQzDaBeqIgi
         4cYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZwHrNk6E0E2YLvgNXjK4jzrezPEbvpT/0KLKbXl49g0=;
        fh=GwZSyst1/uwNDBzdOZIWelmvEDCuAqhGpiMErsPAPlU=;
        b=VbfhXyiwAWt0kmZRg18zJmTzK/rU+hTOTPLMaB5I63UhwXBNWIsBG0v12Z/myg9D59
         oikLNwHM3oHdZmZrLSjlNRyLXw0Vysrb0u96So6FI2slCkWB/7Z3G8/mjVmcbY6d4P7g
         5+KjE1VCEUPsPwHZx9YVUu5QIE5ENma0QH3ULg1DqptPwEb6FCfIWSzWIQHOw4lQmrUm
         6aYhC8WJpeUcKiv1gTjwUjAIkERVMcLktq3/4bdDOA6e/FHQnn47w0FrOheUWEszZi5t
         JHOCPwszXCGww17U7iUeAbVyGnVMrzC0oLEvtOENJVQPXqUCS1dlNNLN5YwD3Sbb3nE1
         zycg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773429834; x=1774034634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwHrNk6E0E2YLvgNXjK4jzrezPEbvpT/0KLKbXl49g0=;
        b=LImE69bQVf5MQ3PxSeHOoBV+0Zri7HeBRooeFdiAVONLqlACsRZ+q6MvLbIYlCoj49
         Sb/IEMlPqpGZnKKrUa/XR3gq4zzfA3IvenXFguGlkaJd2JvPQwMSJ4W5vrzcvasiDkfb
         kAPNoxJrMDkhqpZJJc21JJRUpAh0EF9PcvsJ5dBvADIDCEfjuEb7ApraTkma6ITyJqT3
         ypzdU+akj5O4yT1P1U0DbPtNuV+Z3NCJd2zJo+JyndqAsYOE8VTNZt1VrRBlcG6WaauP
         45ONlh7S+PB6sU18PLB8sjOLIvBsr36/MhikbD2lmiqes9we9DlCole67PeRxiHuVG9o
         Rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773429834; x=1774034634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZwHrNk6E0E2YLvgNXjK4jzrezPEbvpT/0KLKbXl49g0=;
        b=Tut1GiZUfx8SeQ62bMh/Uh1kPewIpOHn+my0kwq/f7vFUTCGxsSISHHThZHxx0pPk+
         B4IiI3TQX5xp3X9W4AtSlKmBYxDhOcpwLOHWijzL9XhHXKqKLs7dkhFnDxROfs+fQYYt
         TPYo+eHPHfvXLtkRLR3KFQZzSMw6NVe0iEjQkH+qPVX7PJRa1mKKB/cQlg/svjzV40Jg
         fqaye7WCSDEpNzorICZwx/3p2N7ibGVBspqyUFULLFxAhJ5KCd0aAUNtgCLQEMgfh/ls
         GuE0Vdk67R8rOHQuy6aZUpdKgMeBRkWKRAUC7kOKVd74nmTgvV94sf7WMlIA/bzGe8ST
         RUwQ==
X-Gm-Message-State: AOJu0YxuQvOLmZ8bsvDPZt7VK2F3u7EDH7YrRu8/BVp0oh2m5VawPrXj
	twD/ZB6p0q5NWTgiOsfsspRO2gaq166IBYSs1O5e35sDZRJdHxBj1NdnbOOi4pk3nVAyv6t5c/5
	Aqk5cOa8yqjV6Soet5etlGJMSsrTs4Ba9OuUutMk/
X-Gm-Gg: ATEYQzzBNrKT0UY+xMRRvEjlL+krA1mLL+GSCwIM3YgGxhEjGQfUTFi/vmzT3XBT0FO
	CHaRXzrd89/gaDlhcfAzco7+PiZlx1+A5zODUi2rF2ffzXLWx8iIbySsz+nfyTwf1VKiKJpyBC/
	8asW6UyCMjhuSISUz5smcI/m8bFcqdfcM+BCVYRW63nAeKZJXD1HmLp/JH9kf3xJmx3XAs7D9rG
	8YYMAKljHGnbGANZhA9UMr+Az4cKUz5mZXLDNkivr7HumzxpZZJsbvYNF+EZ0UbeshSmgX/yVgm
	gF1mt1p6q9DCywo=
X-Received: by 2002:a05:6a00:94d1:b0:827:298e:b7c0 with SMTP id
 d2e1a72fcca58-82a198afd10mr4323267b3a.47.1773429833723; Fri, 13 Mar 2026
 12:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
 <20260312165757.GA3411905@mingi> <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
 <20260313133810.GA3431035@mingi>
In-Reply-To: <20260313133810.GA3431035@mingi>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 15:23:42 -0400
X-Gm-Features: AaiRm50vr5rExQeQfkC-DPR4jLfnuwjr4OzpSSum2UrgxPYqlj88IlZDtGuWtR8
Message-ID: <CAM0EoMmKnARRQxNNaEKO5Vg5vZBUgUmsximAgGfA9W-MO2iFJw@mail.gmail.com>
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to root qdisc
To: Mingi Cho <mgcho.minic@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, mincho@theori.io, 
	victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [13.84 / 15.00];
	MW_SURBL_MULTI(7.50)[test:email];
	ABUSE_SURBL(5.00)[test:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	CT_SURBL(0.00)[test:email];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	DMARC_NA(0.00)[mojatatu.com];
	TO_DN_SOME(0.00)[];
	CRACKED_SURBL(0.00)[test:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267565-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	DM_SURBL(0.00)[test:email];
	NEURAL_HAM(-0.00)[-0.888];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,test:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69DC2289515
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi,

On Fri, Mar 13, 2026 at 9:38=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.com> w=
rote:
>
> On Thu, Mar 12, 2026 at 04:21:07PM -0400, Jamal Hadi Salim wrote:
> > On Thu, Mar 12, 2026 at 12:58=E2=80=AFPM Mingi Cho <mgcho.minic@gmail.c=
om> wrote:
> > >
> > > On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> > > > This patchset attempts to move the GSO segmentation in Qdisc layer =
from
> > > > child qdisc up to root qdisc. It fixes the complex handling of GSO
> > > > segmentation logic and unifies the code in a generic way. The end r=
esult
> > > > is cleaner (see the patch stat) and hopefully keeps the original lo=
gic
> > > > of handling GSO.
> > > >
> > > > This is an architectural change, hence I am sending it as an RFC. P=
lease
> > > > check each patch description for more details. Also note that altho=
ugh
> > > > this patchset alone could fix the UAF reported by Mingi, the origin=
al
> > > > UAF can also be fixed by Lion's patch [1], so this patchset is just=
 an
> > > > improvement for handling GSO segmentation.
> > > >
> > > > TODO: Add some selftests.
> > > >
> > > > 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bb=
b6a@gmail.com/
> > > >
> > > > ---
> > > > Cong Wang (2):
> > > >   net_sched: Move GSO segmentation to root qdisc
> > > >   net_sched: Propagate per-qdisc max_segment_size for GSO segmentat=
ion
> > > >
> > > >  include/net/sch_generic.h |  4 +-
> > > >  net/core/dev.c            | 52 +++++++++++++++++++---
> > > >  net/sched/sch_api.c       | 14 ++++++
> > > >  net/sched/sch_cake.c      | 93 +++++++++++++----------------------=
----
> > > >  net/sched/sch_netem.c     | 32 +-------------
> > > >  net/sched/sch_taprio.c    | 76 +++++++-------------------------
> > > >  net/sched/sch_tbf.c       | 59 +++++--------------------
> > > >  7 files changed, 123 insertions(+), 207 deletions(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Hi Cong,
> > >
> > > I tested the proposed patch and found that the reported bug was fixed=
. A qlen mismatch between Qdiscs can potentially cause UAF, so I believe th=
is patch needs to be applied.
> > >
> > > When executing the PoC on the latest kernel without the patch applied=
, a warning message occurs in drr_dequeue() as shown below.
> > >
> > > Before applying the patch:
> > >
> > > root@test:~# ./poc
> > > qdisc drr 1: dev lo root refcnt 2
> > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > > [    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?
> > >
> > > Testing after applying the patch to the v6.17 kernel shows that the w=
arning message has disappeared.
> > >
> > > After applying the patch:
> > >
> > > root@test:~# ./poc
> > > qdisc drr 1: dev lo root refcnt 2
> > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> >
> > Please test against latest net-next kernel then report back on the UAF
> > - not a "potential" but a real one.
> >
> > cheers,
> > jamal
>
> As seen in a recent patch (https://lore.kernel.org/netdev/20260114160243.=
913069-3-jhs@mojatatu.com/), it was possible to trigger a UAF using the QFQ=
 qdisc when qlen was handled incorrectly. I don't think this is the only wa=
y to trigger a UAF. Since it is obvious that qlen is also being handled inc=
orrectly during the GSO segment processing, I believe it would be better to=
 remove this potential risk.
>

I may not be remembering the sequence of events correctly, and i am
not sure if after all this time if that potential UAF hasnt been
resolved. Your repro was fixed by:
https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.c=
om/

Typically, a message like "is non-work-conserving?" means you have
some bogus hierarchy. Find a way to create what you suggested is a
potential UAF, and I will be more than happy to invest time.

cheers,
jamal

