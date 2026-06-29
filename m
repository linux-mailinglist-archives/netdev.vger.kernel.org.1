Return-Path: <netdev+bounces-302810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwR2Jd/AQmozAgoAu9opvQ
	(envelope-from <netdev+bounces-302810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:00:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A896DE2F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:00:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FMe2I6qM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75163300DD51
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38DF3F6613;
	Mon, 29 Jun 2026 18:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86D2DA757
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:59:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759589; cv=pass; b=lTXGXH0IrPr8EMs1MjGHlbjdtF+IIUTTIW+PKYTOD3PSeo3oYmXx9GoT8lexy8UB/FDydErMXgW4VjCiIcba3TvB1hAo/7X2hxhyU5F8DMIxajtOZPIPW5cZcCSXn1jvvY9HHyQdS5gUoXDxge7CQZADZby1GlLlhra6vhskxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759589; c=relaxed/simple;
	bh=/ppjw+9i9erFK1fn8kUdcRFpo/f2oNDJ9sxQJUfMET0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utxxhPOHbY8PqyQi8JNNL+bB3srobHk2CLd3uvQygumzYf2e1pvghL37IGq4Ja3K6BMfi1V8lQPQKVoxHyE2hGyMGXHkER90o8Ow8Gw1qYKPbo+2tL46LxoOBkYyxCN2pV8yhW/ig1cgkn/pGXi0KLRv50EBl9GH9RkKfCjXYo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMe2I6qM; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139edc6bfc0so6745648c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782759587; cv=none;
        d=google.com; s=arc-20260327;
        b=RguBdGlk57MfkvCRIbGJgjmWlV50VW+4DvQARc1sBK0kMA5eUQPbtTRSdorh/eMtZc
         CzQwvuYrpDZmy+6l2m7k3GHxvDjANWyizEFUiirE+njshdHNw5fF3a8TDZ+NMvxJOT3P
         U7KdA93UaGOMNd/TUCPK9HiXNrRpX32lYrb64ZbdxtB5A0b9luWcnNSOLzABbCPOYXpa
         2uQnBNF6zwVfJvWITb6CJgpyMRtDU0kl7sXCwowH1Ub9PAp1zR17UvGBU9WEOY7VEzcK
         31TPZ/fpa+TzXMBu2+BK5OX3i0Qxo4rWfi5mUzmK3z7FIMwGUmu77Ihr5WOaZFYxSCYP
         VHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wALb6KLXlZ4mXmC+H09CM1/S3+SenRrlKE9JtUdolw=;
        fh=mAUzy9Wpf4SYAEjvgxyF4HBbXCQ6od2ZKrNb3oNb0y4=;
        b=dLcyzUWfE+a8Kp1nLQyhBQWo7plIempP7P918XNHiChx6CiH2qBaCEhprbUURbS5xT
         ipij9r01px0rf5gfLNvzFzgJMPgoIXRtdwWlK3Y5UMIqpZMDtvVPCXK26lcI6zN3haW9
         0CEd4aGcPfzm6fqdkUkw7rMFDmarmgmRZhY7VYFWqYqNarTWI/DnehnS8J5lDPH5L/O6
         cy7PRggVqnilB2C53awpaVubd0PeeNhqDUYV6UJFeSHBGB2l5epmmoMnRHA9pgyKblYQ
         erqLbc8Les3h+S7YkyJXmXzKI6TcXjAVcY6qp5b+NEYnPI8wS2QDFaRPGYr5qJIk/CcL
         pUMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782759587; x=1783364387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wALb6KLXlZ4mXmC+H09CM1/S3+SenRrlKE9JtUdolw=;
        b=FMe2I6qMOPdzbSdHLNLPsMFmyX2OYSK6/L87EoT3SDw04tQlGGCYftvpiEBS9/Uslx
         o6d2syoBXiis/LTS2YykXhaN/UXnxoQ0peRcTDhuuToCtGYeD4q/h04HmuwYRrmiEe/J
         D2swpWOKBgWCaE8UaVTUSwp0X8x6wtPEISUtmiiGPEQ5SnxU75GGBDWnRXWeCoastFeK
         SVVfvDtH6k89v7GfHWiIjwS/Y/hXeP0J3HiZMmB0DGxN0DAN8B6puyJq299WUgTIecqi
         Dt02HPRnSuC/tYdYOCsmKLuWm1VK3l+3I+ajcFM7t81ieYD9ykR6cDAKa+M3eH91gBgU
         fgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759587; x=1783364387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wALb6KLXlZ4mXmC+H09CM1/S3+SenRrlKE9JtUdolw=;
        b=b/2j04vPFeDaPYh9wqKYqb5Bxxz8/JZlSBa6N21d9SfbK8Mb0Et1DWCgZ4mx2loeNx
         XBlk+UdKz+jzJP6vMB+jacg2Jm5NqmJkDfiyfxE7HrcEdwhGDbPa4bJOrcBQV0elBait
         GT/b0+NQr38y4+mBPDZsHRuyVyO6gUnpnYlfsrPmZxTfLJdw9F3q4/J+k1m7g9wjSJR4
         c6KRDlWcZ2rcTI0eFbyVj6DZ+9U46uiE51TAQ9Rzav6vCiWsOFd3k0khaK90FxVZpjKJ
         v3igxltqGjdNs809hr2DLVWSFpsHt89o/pC+qjSJ6IDwvqR6aH3P4ONgi2i8kOm6CVMs
         z2mw==
X-Gm-Message-State: AOJu0YwuMJiE5/OOgo4vWqnND+lHNtYUT0zAbXwbZbsM1Vm1WxgJXYuv
	UmIK5/R4Qz7ZghDi3CvRsl30zfryV46+dK9O1ldjc//bSuoBRfvimN0spPtvUthJ9qj4zAVEHAp
	H86ICGhMkKK8WtqHTpgNJUCcV8boPDO/QU6Sw05Ye
X-Gm-Gg: AfdE7cm5Hy40VScDWskTjOxqG2hfS8kEQlNfVEite3EfRW+/y/dqd4gLCm1oktr8S6S
	jDIFk1tWlstrCOaGL/yDHr/APkkcZ48QRrEH1tCY+DwGaWo9D67YR96iV40Y1c3zqLEpe+5OWQL
	4PkU8hX08SYBCr0VdB8TT9yI3grNXSgiV4/M3CyUs3YEomWElcMUv7tJWOVWLDJy7T0Eu5gkfKq
	fK6kNo6/bvyO1p5j0i/UJoM1S5wYLNBdTLWU1ZecjX7NTsUSBWh2MMY2Q4TtEj8OOdL7fGX0zdY
	LOg/+P5064qGNxct/lnWiI3ES8EIineSYa3mdylP3ocIA0y2sgjGElGg2QO3i8LmbvV4Dq7Riyc
	jc6WfHvtjsfyf+Mvyb34JQCNUnF0W85VC4ibSamS2DA==
X-Received: by 2002:a05:7022:1b10:b0:138:104:439b with SMTP id
 a92af1059eb24-13b2a1686d4mr375031c88.19.1782759586936; Mon, 29 Jun 2026
 11:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629155748.715754-1-paritosh.potukuchi@amd.com>
 <CAAVpQUADJeSx0njB96i90Upq8zw-pcfZX0HqWkqjcuKm17XZ3w@mail.gmail.com> <CAMfiSeZYLF0sa+hga-fiAyqPK1kLKwxJ1HfgbNMOwhuNvZTcbQ@mail.gmail.com>
In-Reply-To: <CAMfiSeZYLF0sa+hga-fiAyqPK1kLKwxJ1HfgbNMOwhuNvZTcbQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 29 Jun 2026 11:59:34 -0700
X-Gm-Features: AVVi8CePkPB4EOVKI5olxCFeVGwPsLxhef4KPDpUp2PWNUz_Q1wDvlqiKJWfBcg
Message-ID: <CAAVpQUBf+asQukcRw7sJz6vS2VdeNO5+Q5ucoCxf4JgK25nZ7g@mail.gmail.com>
Subject: Re: [PATCH] net: neighbour: add neigh_parms_lookup_dev() helper
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:petrm@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302810-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A896DE2F6

On Mon, Jun 29, 2026 at 11:35=E2=80=AFAM Paritosh Potukuchi
<paritoshpotukuchi@gmail.com> wrote:
>
> >  Please post a series of patches with the neigh_parms_lookup_dev()
> users.
> Sure. I'll post a series of patches, with the neigh_parms_lookup_dev() us=
ers.

Please wait 24h before the next submission.
https://docs.kernel.org/7.1/process/maintainer-netdev.html#tl-dr


>
> On Mon, 29 Jun 2026 at 23:53, Kuniyuki Iwashima <kuniyu@google.com> wrote=
:
>>
>> On Mon, Jun 29, 2026 at 8:58=E2=80=AFAM Paritosh Potukuchi
>> <paritoshpotukuchi@gmail.com> wrote:
>> >
>> > Provide a helper to lookup neigh_parms associated
>> > with a given (neigh_table, net_device) pair.
>> >
>> > The existing lookup_neigh_parms() helper is internal to the
>> > neighbour subsystem and cannot be used by other subsystems.
>> > Some stacked/virtual devices like bond require access to the
>> > underlying device's neigh_parms.
>> >
>> > neigh_parms_lookup_dev() is designed to be a wrapper around
>> > lookup_neigh_parms(). The function provides controlled access
>> > to per device neigh_parms.
>>
>> Please post a series of patches with the neigh_parms_lookup_dev()
>> users.
>>
>>
>> >
>> > The caller is expected to hold rcu_read_lock().
>> >
>> > This does not break any existing functionality.
>> >
>> > Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
>> > ---
>> >  include/net/neighbour.h | 2 ++
>> >  net/core/neighbour.c    | 8 ++++++++
>> >  2 files changed, 10 insertions(+)
>> >
>> > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
>> > index 8860cc2175fc..1b3b06eda886 100644
>> > --- a/include/net/neighbour.h
>> > +++ b/include/net/neighbour.h
>> > @@ -438,6 +438,8 @@ int neigh_sysctl_register(struct net_device *dev, =
struct neigh_parms *p,
>> >                           proc_handler *proc_handler);
>> >  void neigh_sysctl_unregister(struct neigh_parms *p);
>> >
>> > +struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, s=
truct net_device *dev);
>> > +
>> >  static inline void __neigh_parms_put(struct neigh_parms *parms)
>> >  {
>> >         refcount_dec(&parms->refcnt);
>> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> > index 1349c0eedb64..6d32c2668af3 100644
>> > --- a/net/core/neighbour.c
>> > +++ b/net/core/neighbour.c
>> > @@ -1757,6 +1757,14 @@ static inline struct neigh_parms *lookup_neigh_=
parms(struct neigh_table *tbl,
>> >         return NULL;
>> >  }
>> >
>> > +/* Caller must hold rcu_read_lock()*/
>> > +
>> > +struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, s=
truct net_device *dev)
>> > +{
>> > +       return lookup_neigh_parms(tbl, dev_net(dev), dev->ifindex);
>> > +}
>> > +EXPORT_SYMBOL(neigh_parms_lookup_dev);
>> > +
>> >  struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
>> >                                       struct neigh_table *tbl)
>> >  {
>> > --
>> > 2.43.0
>> >

