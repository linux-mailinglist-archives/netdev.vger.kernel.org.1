Return-Path: <netdev+bounces-271617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGehLwUFxGnOvQQAu9opvQ
	(envelope-from <netdev+bounces-271617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:53:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CD3287C2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 954383206E93
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69453F7E60;
	Wed, 25 Mar 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpz/DONx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7B3F9F4C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450672; cv=pass; b=YmubIQsUkeRbtXiZykbnLqSimtnwVQdsbPYsXq4yiU3eXcgPUTcFWWaR5OZu3BaoRMR0KFquTLTLavrOBnnLOjnMZTqHZdvbwtr9nQp5Wo5c40v1BffyE4FrPEbBn89AWppPK7swVHvBZ+XUtol9DxwGmP9Rs/ceq1dDpQAaUBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450672; c=relaxed/simple;
	bh=oEWpy0gF1WVNsyk2gzVo1JjQdC+56vg0pGTs/LlxHvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1VXy41Zf+1KjfkEqDABiQh+8B3Jcg8f6sujuUPvOR44KysZVlPQ/smG/Mi+ueX0G5vmVx+e65DC7/KR9rRJRqEF1MngkAEIKh2LWemvezD8wd0DefhE58UEJ1zzHaMH1b4M5IhGkHGvzUQMrpTzfOitRU+h9rbKa0kGhOhFpwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpz/DONx; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50697d6a69cso13666601cf.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774450670; cv=none;
        d=google.com; s=arc-20240605;
        b=Slr6x0p+8lzdii1xF2alSPlKY5v0Imo1ILbSJniNEQmQXTaVAZTRyyYPXqftv0/hyq
         PnUe5YC0h4s4FhFOFsdeRtYpBb51C6hqT41WXQJO1zEnI57qiq56ACMYskDB0/xY2hxa
         HajLIpsct3dGUonvbHZw/6TGVZH8uACznyZ66fsU2LTEXFj4iAJ2WOJ74TGKCUD/XUcy
         98X1+xZBdj9DlJwnWzwj+u8n4n8On+u+qHELJUpThCC4LgCXSC8KRVlcK6za5EzulgvO
         dcMEaeQ46E8W7WpwwxatN7V9HNfrQYgtujPAQJ9MrN5m9M3VgLuyASmofPhsUxhYELpP
         HBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HA/a0TFcekx6NNKkGDklqHiOTuNDuN9Klh3QqW34YYo=;
        fh=SjTO0/xMBVsqSauj0bL+3b++DpL8tCSNRXRgakjOpJM=;
        b=GHFsG4RcaloSetG5ZFtsc5kVIVJDW2sU5ExmIYJOa/ebcXTIAKbFuKjerLoEXv0H0d
         3ixqeej/rgZI9qx/CsGDLd9T5eKEx5QjKO8IeZICqwo/9OwydkUX0/swUl3nyLB1jW9e
         U2TuXs6I75294IY5n2T+ALVxYpC8i+Z1lOiOmjkRZvLRbBltwtCGKRePmQuzWtnBAkFi
         uM16CHUJskfJlLkmY7c357K56EKFL0i6BJ5rrgJ9E/KfjUPNb98ikxM1GHvlAj45l9pJ
         EIgTyV0V/D5MOzkEyshXQGk6ic4BE763+uOwNObY+5WCnSs7SbhJpGFlwV2ZgfPFHBOW
         QCnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774450670; x=1775055470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA/a0TFcekx6NNKkGDklqHiOTuNDuN9Klh3QqW34YYo=;
        b=lpz/DONxRoWYTPxn0rdkF6WAQr+rzmmCz65jeixjLEFoFxIz7TMSKmC+qDYxeTXq2o
         Qw1PlAoOCy79RCkoo6Iesl8SlioNJAj6V3lWKmpwuNnnyVuHy/2mQbqKQfH99cqSBNPK
         RT5SkCYZRXNrqaRdEXsbaAWAAVPviBazo6YM/K8rYytBe2452BhReSLz4Px5udJLCmqx
         CnYG/ziIQnMIFRe+pGbIRhc8jnxU2cVo+4ObifSwadn4oZ2jEjRN5/EORdBzLx3UkhRo
         YdkYromJevOFByAvMMyLUh9GlpedkqwmE+qnJJZCiGEE0/xnOv6Zb3Vunq+9QTFEhWlq
         Qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450670; x=1775055470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HA/a0TFcekx6NNKkGDklqHiOTuNDuN9Klh3QqW34YYo=;
        b=U6yBCs0sgFzq4KD/6rn8N+dhlb9sh0DuEUwT6ZsbGwWiLCb40oc0iuQlQmnAz9oBkQ
         BjbyPpsN+9K7MUfFozH6gXsJKWL77J7MzFVql5U/Xmw8dNHk4HVOjJZezjmsf3RoRDX/
         Glv0zCsLqDsTac9aE5IFkBWEaaKsfRKd2N4shJa+0zPK3tSdH5hR7OHnkTCK6RVIEn1r
         IwBKMltycEzhXhKZ5TIE+VyKUvXk1Rv2ViXFd+WiMqYKbmhTbYnVG7EmgUYWob5ju0zl
         8+6YSK9xJZYYOXBQmUvf/nCVQkBLjYmyWkhZRzwY4cGL6vxDpHjfMMcLHkASZt3btVSv
         CUpw==
X-Forwarded-Encrypted: i=1; AJvYcCW5onleZeHo/HWy/dWSkGQlCptc74yIlF8Sh/pm/7oXWfGRAu/tQ02LMC+vkyTaCvuEs22hk48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhcIZA5wMaX3Nm7Hf3Bg+0WT4j953NIxQHeAOYfJgbzapl2f6
	ttC2mODk8HgHKn88B6cCimeuYI+NP47N6ezEiPLq4uDEDk9aXBjRxm840+oxk7Uh+bFsGNG33r0
	M2A64QJfdfykIwvr8+4878GX43s01XhhQqZ1JZPKX
X-Gm-Gg: ATEYQzwoAo3mHGpPNtv7yZn1Not3MRCNpl3wlSxRxW0DzaxSn0ePs0uK/7nBQZ19t/c
	jIyaJJ/FGRT4iZsQe8RPs47H5/23K4DniWxrCZeZDNSGiRX+hg2bc4a2Dw/nGgP+fX+ygh9CD8v
	e/QFnvvnDFMkFMTnqcoodbQiHbmyhSstMoYE50edIJomEN+uL4+mEJ9got/a13kDDVpDxIrE18t
	DNKlkhoglkIYI7tKsRJGjTt9V6EWpCIfcG/4B6NCZvzZzPJ4A1LhGiIsUU301ajjVoHc1bKkGTK
	HezI7Sc3schKrMq6X6JmQ3XfZEcK8cVOWQcX
X-Received: by 2002:a05:622a:59cd:b0:50b:4922:4b8a with SMTP id
 d75a77b69052e-50b80cac946mr52110841cf.10.1774450669546; Wed, 25 Mar 2026
 07:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324155521.525292-1-idosch@nvidia.com> <20260324155521.525292-4-idosch@nvidia.com>
 <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
 <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org> <20260325144228.GA686135@shredder>
In-Reply-To: <20260325144228.GA686135@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Mar 2026 07:57:37 -0700
X-Gm-Features: AaiRm52n3TxnHlv-OHtpHa-p5F0eqMuWzMYjWY3iRyMm_sjdcK32dkj72v3v9YU
Message-ID: <CANn89iJ9MQ_3af3XiNAGQWwr-t1kF=E-mKmu6h-XVDVyi7c4mA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu() invocations
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, petrm@nvidia.com, 
	lirongqing@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271617-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 436CD3287C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 7:42=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Mar 25, 2026 at 08:17:30AM -0600, David Ahern wrote:
> > On 3/24/26 2:39 PM, Eric Dumazet wrote:
> > > On Tue, Mar 24, 2026 at 8:56=E2=80=AFAM Ido Schimmel <idosch@nvidia.c=
om> wrote:
> > >>
> > >> vrf_rtable_release() and vrf_rt6_release() are called as part of the=
 VRF
> > >> device's ndo_uninit() callback. As such, an RCU grace period passes
> > >> between the removal of the VRF slaves and the closing of the VRF dev=
ice
> > >> until these functions are invoked.
> > >>
> > >> Therefore, it should not be possible for any concurrent RCU readers =
to
> > >> try and acquire a reference on the dst entry while we are potentiall=
y
> > >> releasing the last reference via dst_release().
> > >>
> > >> Given the above, the synchronize_rcu() invocations in these function=
s
> > >> seem unnecessary and only add unnecessary delay when deleting VRF
> > >> devices. Remove them.
> > >>
> > >> Reviewed-by: Petr Machata <petrm@nvidia.com>
> > >> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > >> ---
> > >>  drivers/net/vrf.c | 2 --
> > >>  1 file changed, 2 deletions(-)
> > >>
> > >> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > >> index bfc9ea91ac20..75edb8eba87f 100644
> > >> --- a/drivers/net/vrf.c
> > >> +++ b/drivers/net/vrf.c
> > >> @@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *d=
ev, struct net_vrf *vrf)
> > >>         struct rt6_info *rt6 =3D rtnl_dereference(vrf->rt6);
> > >>
> > >>         RCU_INIT_POINTER(vrf->rt6, NULL);
> > >
> > > We could argue that the vrf->rt6 clearing is not needed,
> > > or should be done before the RCU grace period mentioned in the
> > > changelog started ?
> > >
> >
> > AIUI Ido's point is that the synchronize_net() in
> > unregister_netdevice_many_notify() occurs before the ndo_uninit call
> > making the synchronize_rcu here unnecessary. There is also a second
> > synchronize_net after it.
> >
> > I get your point about skipping the clearing the poiniters.
>
> We can probably remove more code than just the synchronize_rcu() calls.
> Looking into that right now.

This was a minor point, the synchronize_rcu() is far more interesting of co=
urse.

Thanks.

