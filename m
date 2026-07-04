Return-Path: <netdev+bounces-304675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SbivK21lSGpRpwAAu9opvQ
	(envelope-from <netdev+bounces-304675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 03:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C17065FC
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 03:44:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=t4lHBtkQ;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304675-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5D6301303C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10837187F;
	Sat,  4 Jul 2026 01:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212319E968
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 01:44:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783129449; cv=pass; b=f5pRmli86+X6xz2tbF3kV0alD1OU6h5z7JBd663Biw4jkBrFMnZUBiTnsLmb4u7X6Um/ZgZTierEGcSFbMmIR5C2xr5xfOR5MGGjJBb3umka85izMRo4UEC2/NBGh5qkO9XLbUEMZnblzZMNJoOTwvDUkRJSBmDJA3PyoQkQP1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783129449; c=relaxed/simple;
	bh=8fCmQy6ML7ezv8pk2jK71Y9cUzBUA7pu4GfaSx91aD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scpNlJUYnsIW5l1K3e0Z2+yPm9DOkuCPCagO5UVKMoWveSjsMh+GFTxix9NWaWEGAD+D0nxOUr7fQkvt8s8WOLYzqaDOHCOhsvU6l9s+SIHVnBdS7vqc5KiHZK1gVDhsRbMF6vyvbtalDa/iXpa2gHaqtfWY2MEhKgezkJ/AgOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4lHBtkQ; arc=pass smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c88cc025f54so702067a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 18:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783129447; cv=none;
        d=google.com; s=arc-20260327;
        b=SMU0qMl9Y1n8mzOa31+g9+6Codtb17wIy3OQ4ix6JHopz7rVCE+3wADT8ugDtrqzNx
         R0csK8w2w/TAiGZdl6BD2qRfspZxdcJXJ4g/Q//L7u9vPQARHL5Yq3B/URa7Wg9Pv+me
         0SwHv/Znvt0DNM5g0lNxn8i/n+aGAQ9lgkPh3W/xawwX8mf2/oIkyIduoYrZea31TM8X
         f1zshcs6gKMHMkQQciUxYrNOiDINuf1I1w8HISjpJmi8QBSybm09A3FbkiJtqg6t+qyr
         yyiQvUr15GHBxLu2aIvqubvWu0UymW70rCRgC8bxByNxkZi6NvhV0pWwW17nWg3mb5nw
         Q2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxQy9j5/rhqYFhoIBk1TW9Ac42e+EECea0GJDCa97bw=;
        fh=0ZEtUzf7AY7FhGn645bc9njZaQB5hytJZNoZt990akk=;
        b=DIL4uaCXXDGS8Pt0qB/7FghDx+KXv1dyP9gOOouJG7MRZJBj55FPk84MoDlvDr+Dpd
         88hPCHl2dJvoQ4vgkp3JZ98Sx2RXWK2HxxpV3rCamSCTUWimZJ0VK7k1bKtIqvLekgGr
         oxOxfcap0pzFY2vMyT2hYjaH1kYLdbQz1TxuLVDf7EwztekoMCLiuhPsY1Ghsav0hu/P
         HyayhQkUnJOplaZPmObl+U7c3r4w1zaJj8oIksh85Vv/7EENCUA24Schmj25MD2SZIGZ
         tPDWNpDaA+RN89oRMkUy8k0SIy6PWMOOizD8B6ZJ/qsaSVu57s0uv8mxG9o/JvKMJw/+
         d2ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783129447; x=1783734247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxQy9j5/rhqYFhoIBk1TW9Ac42e+EECea0GJDCa97bw=;
        b=t4lHBtkQ/CGvSe3u/qOmEIWZcVC3VFff5O4u7YAGWdn7QBFrLep7EK7rv8NN0OJVkj
         8X9AX+xD7uFU+LPtMhOTAywtRDEimQuuHXF7N526F0PaHTUSJFhNa8dAfuZ9Bgctn7wY
         czFOznvFXhadEvMQ0o0VmiV/beudMyyJ5y7nvfwpnKaIO56pAq/XqiQobkmuWa2BT6Rr
         qkEzJOSVuYE99ZwMB2ZVbUkMXIpVZzCRtPyNXesazeGpMc07KwsREkj1JidNX8tIUE7F
         DBczCxyrGhf30S2EdtD7MNgKPIOoeVh+sQlZoCyjEgaesc6zKy+G7QqWwc51Xbiuzr/U
         5/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783129447; x=1783734247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxQy9j5/rhqYFhoIBk1TW9Ac42e+EECea0GJDCa97bw=;
        b=L/ykyiZwxuCXnrsKbxWj/g+lmsCzpSZY0LPcen+mM9224GUx90Z+Devyr3vPB1/bmL
         I+y7kxtREFQt7Hw34H45w4oLlXVQkWvcMGz62wh1DNSfDEDW41zOFl7u3wJRc12adE89
         bpUGV199uGstt+wh7CGqB3GnD8mVsERbvbNCByFpDWtad8cO5DlBKdo9Jqx2g283aYP5
         gMBrGX2FTdK45ixiF+OBX9oQXA0X6jWYY9nVN6wwTcR24Wx16/+KdGRVR2JeAegmSU6I
         jPeDAgBVNByp4eleoIJxKsYaSfqEbkZ9E5SJ3vZJfNSxIqCHxNw6WKCqnJR4iHg97okb
         ITfw==
X-Gm-Message-State: AOJu0Ywyv8cPfkEsmr8WK5K4KwEPEF5YhsmQUBcersqIBH+Mk9xltGHC
	THZqkDhkdPZOqw6YDm9Ppbi3BKlAPqLukw61ToZlczyciAapLpLYnpHe6GULelpmFkG4rIslJux
	V9ovEsQd/iDwIZO1Cm76jtzC0bfxAkSl/8NG5vpfX
X-Gm-Gg: AfdE7cl1WdaxcBNr1QMJxEBKWnQqODjb2dd28938Xi50sgPnm7YCvcyzPfJem/q6pCI
	xIF4xr03chySsKdXDhUGgODzEDjWKBr14t/OHY5FBm321XoDpG6IPme0QzTXfHJdhEybIikaQJa
	4mueI3A+++2GrpPF8Q4IMZdCqp3XRPakeGdeXPQq/M9Y7A5h/c/VUQUFEGz92o6+bzTPHnM0OGJ
	05V/yuVkI4uJV3o/i0w6DQcqbVGCdE/zJDg5O9KPav5AtInFfXq8rwg5z1BtngDvVmgpnlQZQ6a
	pLK0cFp1CnAKsFcokjBYXpvhXKVRmCANo2ZMAcWffzfeHd86sVg3Y1MwrdQfCIItCK1JGQrNFzl
	uGagp3mhHACfG6pFY17Ngabr0STiiCvf3LvmYJL+4fUGgBjVP6k4=
X-Received: by 2002:a05:6300:2287:b0:3bf:b3d5:ce1b with SMTP id
 adf61e73a8af0-3c03e20875emr1669167637.12.1783129446528; Fri, 03 Jul 2026
 18:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703064109.1836070-1-kuniyu@google.com> <20260703094735.678916-1-paritosh.potukuchi@amd.com>
In-Reply-To: <20260703094735.678916-1-paritosh.potukuchi@amd.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 3 Jul 2026 18:43:54 -0700
X-Gm-Features: AVVi8CfBSm5BVhMfBG6yfFVb8SaeeXYRAY16cYIVFHc_BiaAnf2EgPAQXgaDJXc
Message-ID: <CAAVpQUChEhWDxVPXOOQQcPMBLNocCACKNiX6AZwy5O-3+wgbtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bonding: reuse neigh_setup from slave neigh_parms
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com, andrew+netdev@lunn.ch, jv@jvosburgh.net, 
	davem@davemloft.net, pabeni@redhat.com, paritosh.potukuchi@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304675-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:paritosh.potukuchi@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1C17065FC

On Fri, Jul 3, 2026 at 2:47=E2=80=AFAM Paritosh Potukuchi
<paritoshpotukuchi@gmail.com> wrote:
>
> Hi Kuniyuki,
>
> >This introduces O(n) list traversal while it can be done
> >with fixed costs (3 dereferences + 1 call).
>
> >Since neigh_table is global (arp_tbl or nd_tbl), the O(n)
> >list traversal could take longer and rather de-optimise.
>
> Yes, that is true. One reason why I chose to do that is
> because ndo_neigh_setup is a function primarily meant
> to setup the neigh_parms structure, when neigh_parms does
> not exist.
> On the other hand, lookup_neigh_parms is meant
> to search for a near-complete neigh_parms structure,
> that is already associated with a netdev.
> Even if we want to use ndo_neigh_setup, since it takes
> less time, I would suggest using it as a fallback to
> not finding an already existing parms, setup.
>
> Moreover, time complexity might not be an issue in this
> path since, this is rarely used aggresively.

The real user is qeth_l3_main.c only and it's not compiled
on 99% host.

We usually bail out at if (!slave_ops->ndo_neigh_setup),
which is called after your neigh_parms_lookup_dev(), and
there is no need to do O(n) traversal.

With 2K netns, it could incur unnecessary 4K traversal (lo
+ another dev) for each neigh creation, which is done under
RTNL or from interrupt context.

So, it will be a problem.

>
>
> One issue with ndo_neigh_setup in bond-like devices is
> that, to get the underlying netdevs neigh_setup function,
> it expects us to pass a dummy neigh_parms structure that
> has been zeroed out. This seems to be fragile as suggested
> in a TODO in bond_neigh_init().
> Generally its main goal is to fill the parms.neigh_setup
> field.
>
> Can we populate a few more fields in the zeroed-
> out parms structure, before passing to the driver in
> ndo_neigh_setup? That seems to be a much safer approach.

It does not help.  Just populating fields does not change the
loop detection logic.

