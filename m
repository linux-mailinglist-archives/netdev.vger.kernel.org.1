Return-Path: <netdev+bounces-275221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGE7OhMr0GkH4QYAu9opvQ
	(envelope-from <netdev+bounces-275221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:03:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69698398540
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E48309ED2D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C583D5656;
	Fri,  3 Apr 2026 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JET5BVFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02003D8121
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250042; cv=pass; b=dg3TgcwMN66AgCt+k3Od6bw78vRyR6MXoWg14r2lMUfnP0DQyg0zjB49hLE8hdpSEPK/esSxEpw5t3JpzqDhkboCzvJPDOLusBG7gUyOyHQeh+yyzVv0goag2pVOv9nvh5D27x0ivqL3GxkDeIq8UR0QMip6oAy9vcT3gj+x6Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250042; c=relaxed/simple;
	bh=g7N1AjuszHh4vBXJ4dF4/QtF40k+BYywS/f2CGePukw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgpvhsmQdb5fHRarh96KiBtEMI3Xo0p3vhMS2NfVvxZTKR++Djq+NdwBWlytFIihihiu2Gfd4c0adzBZ3YWtBdf3bY1WiCdLNEuixDnCzpkjwo98MrL1yWUdq5JmQvlDBIpOXd7gFz+zbBPwVAoASj2tIXJvGq/jVELJFhDqGe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JET5BVFA; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506aa68065eso19212411cf.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775250040; cv=none;
        d=google.com; s=arc-20240605;
        b=R8OQ/3cP/tV6klD2jqQgsVlpqxY7s/yz/tZMCdnXtQCPnsRVXqtMGN+/DH+UYKLOA1
         5JpiTsfE1YkwZbX/+29IBEMTZGvs0Zn/KwUdJ8Og177Z2mIFOV/xP0g8BeEwyJwzs3Qa
         NGU9HUCtvgdS2ccXa22tyLtp7w9MU1tvXEbn+TIcjwlF+c9VHcq9k5hYF4a6Qqm8OxBh
         XIG0aoixMHf7oUkx8hVy5OYijmxtkUKI1tS8EXbW4exOnQomJkGFR2J6LsrVxdOZrQvh
         9xGBimkQBBlKM7iT8EDZrYUxb22AQgUkxezarhBvsECKswGO0ditnhpNTK0YrbsXgMmH
         fRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGmwWO1ugMXrfwr2Q4qsgY1WK3ylxcw6oMChLGY+H7Q=;
        fh=qj8Ldhi5W0NwnJdP3fd/g6q6Hd1NRR0xyikjI2NfqRI=;
        b=a8Da1RC8lc+nweRDlQOjG9wwKwwNTZOX6mAn2JteSCnfrt4h1cn/gAEKuQbQLAjLny
         jdR7V8pbpSljMkZakF8aE9mTrHYkjt/XxC4WfVmMGJV+sqEmcIG75GwtJt4ZTwYtwHQU
         ZV+l0sjQllfrSIeNiSoRPqTs4kosA6Vp7CO1MSOihEOefc0MwFagyIQ0s5bRNRy2Pah7
         HSMcGAK06G/eO+tNwlTG8YnYsq0+eN1LLBi6unGiNOSGVq8+AU5gQxPZN79TlZF6lB6i
         mO1O2nRapeGIfXqDkvXoB1vvZZj5LRxKoWqsMD/w6V3pHj98n258bd/0kOWFVsiWAE6g
         ywaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775250040; x=1775854840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGmwWO1ugMXrfwr2Q4qsgY1WK3ylxcw6oMChLGY+H7Q=;
        b=JET5BVFAj8FWGvB6SBfxfLeyiicvrdv/9a+zLs6wd/NJiMsgLVWaOx1RZ2OqkpkLXk
         Xz2/uu4PSagG0hzP+TXrU4J5DQmElEveM97GDRWJbwOy5aZp8BT0J19LGXlsiNuBL23r
         8ZS7CZhUeWlap6mH+V6LoVtaJ1gvKBHl3yI8Hu4h9VtJiJMVtXzELygDyrdKaCRET1qb
         ERiVA/hUXiU7AEQL3wllcQIujbm96njiXfV818+2AR+BVicAGnOIhWVk2D127UmZMDnM
         Wrs3d7NkzFtJCSbGGk4wPfD+GCbirNxbUki1mW8/wSq4fm484fvVpCBgJXttzeMRcMPw
         L+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250040; x=1775854840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGmwWO1ugMXrfwr2Q4qsgY1WK3ylxcw6oMChLGY+H7Q=;
        b=ogLuIvW1+IaM6xCS26jTg0flS9Y9RYo3oGHMKPIxQAYePI9wPMs+8+k5NLPLQIoo9B
         wpL7tHELg1ir7yd+phhoDqd8scTMF420nMnN5FE45yoQCWOROjlYWK64HFHCj+tzHU2q
         kljIkXa5gt0R1ovzhddN3Ie8vbb9HrAGV7PEJ1toadUeNWvjCaV7xVxnVrAKIJAUe+Xk
         Bl2o6nuJxfCR1mW/sS1/hSPLU5MDKx3pf4Mr43qspxIv6+Dhrb1fLemKoINwqKZ5qfad
         zHpjXPpyV3M7hJ03tIdV4W+hrWYRnqKsKBrmFcUQsnyemmHWdEhAj97GxB/yHbzQMxV1
         0Spg==
X-Forwarded-Encrypted: i=1; AJvYcCXamOaEAwPTMjXl746vpG8MwBsLu2LIL0u/REZUbxml6OdVMCI9/JDXefmi5JaL+gztbv+pYVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPgC0jyTnHdX8xAxEzFzdo1ItYxBACDWbEkNkjVjJlG0YTDxp
	6Z3d+q8Evr9Zxb8LBQ+y+S+ivMUbJHJtMX2v1ClZ9sMthdi+GjhL8Fb4CYti49nY51XQu87F532
	UNNy6hjy1dzCN0/epai2xRQtz4p/m2d9xRIKQ2cDE
X-Gm-Gg: ATEYQzz9iE0bjrfqRDvZgd5yZa6g+UlM04atVZcFFk+Q5SuQtu7lAt8ZWuqyKCKnqN8
	qiwWQdeEIZEE11y4Ljh59NVX7NPdEDeBwikrjLw3N145u3/okeRD7w7d9yIYCj781fBeApEvK9r
	qeqbOJByPJ5FAO2ZxXbn4xhqTeHz2zuL3eZd4YKCifkytu+//d23qacIlCEL9NdLJdWPS0aXI0U
	AGA8aJMzQoUmWPZisCq298/hzBCAh0dMy/vjfH3cDaUf48MmQFQ5mRzUxSfFBtJNYH9NG1QMVRu
	Cv+D
X-Received: by 2002:ac8:6906:0:b0:50b:3d9f:384e with SMTP id
 d75a77b69052e-50d62cbf981mr63400381cf.44.1775250039039; Fri, 03 Apr 2026
 14:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com> <20260403043237.3909226-2-edumazet@google.com>
 <CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
 <CANn89iLUN1F-NzdCpaPhZBFVZR6KjEuyPNhNXtWr6Hu4BFdyMw@mail.gmail.com>
 <20260403134732.26e39509@kernel.org> <CANn89i+SnfFboyNed81NvBDXHMGe6oWgE3AGcGfDb7eqg7z4jA@mail.gmail.com>
In-Reply-To: <CANn89i+SnfFboyNed81NvBDXHMGe6oWgE3AGcGfDb7eqg7z4jA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 14:00:27 -0700
X-Gm-Features: AQROBzBwhqstNhxseg-yWdTfwNMDastoExI8GSaO56w0_AC-DcopHc5BsK1H1X8
Message-ID: <CANn89iLHKyPa8aMFFcjCfzzOEv_quAtz6PokPV+3cszX0NcdbQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net: tso: add tso_features_check()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275221-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 69698398540
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Apr 3, 2026 at 1:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Fri, 3 Apr 2026 00:20:13 -0700 Eric Dumazet wrote:
> > > > I forgot that netif_skb_features() uses:
> > > >
> > > > if (dev->netdev_ops->ndo_features_check)
> > > >     features &=3D dev->netdev_ops->ndo_features_check(skb, dev,
> > > >                                             features);
> > > > else
> > > >     features &=3D dflt_features_check(skb, dev, features);
> > > >
> > > > So I need to call vlan_features_check() from tso_features_check()
> > >
> > > I could be wrong though, vlan_features_check() is about  skbs with
> > > multiple vlan tags,
> > > and net/core/tso.c should support them just fine.
> >
> > But we probably still need to clear NETIF_F_IP_CSUM for example?
> > Better safe than sorry. (I won't repeat the sashiko complaints
> > assuming you saw those ;))
>
> Ah not yet, let me check ;)

Oh well, lots of orthonal errors.

It is probably time for qdisc_pkt_len_segs_init() to pull the headers
(at least for GSO packets)
and return an error if this pull fails, instead of letting malicious
packets continue their way :/

