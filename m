Return-Path: <netdev+bounces-274107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fU8YHr4XzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:03:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA037AE77
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 534863008305
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322713F23B6;
	Wed,  1 Apr 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="axThS+31";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="b+IEA4pI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E243BD631;
	Wed,  1 Apr 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048636; cv=none; b=A+MkPXEDSJhkJgKGwq3EDhaLUZmsugvi3kPmNl4umpe8cVGjVx7hIqQzaa7NWA6R6qfTosqSAu/WxHc+v0ArjNeqLh1mu9Mccx/THG3Okd93bFTuqSLJ7pgtvl7GESfhc+aUYJff/YehjPfGEK0u33RZwuoraIwt8KHm6aVL3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048636; c=relaxed/simple;
	bh=87cKmeWrAZNRV1e8X/lhFAO/5MCoOIpIStxLRaWcoX8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=udkRaYq/amHxYGtBidap/neSquMEpKlpLM7fWHG7WIsWWghf+li7WtVAj5jD91ZKBlH0O06stsGxajq7zONnpGaG8kPbgXrchgTWPYXOvNUcWRabmPUgmCeLhjIwTBqpDGYwZoUL0n5QHFLKxdq+uPcdFtQd/XhLnc0jWoW6VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=axThS+31; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=b+IEA4pI; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 631D3614008281;
	Wed, 1 Apr 2026 15:03:11 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A222B120925;
	Wed,  1 Apr 2026 15:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1775048582; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgZsV4WNGHZgdeief6PsEJkn0/gd5bMvi9vImU74R84=;
	b=axThS+319ai/o4GBX0M1w1eW8tVmgDuKZhbMgEyZAfmjmli2BB9QxdQjxPoRoc9hNPMx6E
	4/C4CUjiu0QZAHCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1775048582; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgZsV4WNGHZgdeief6PsEJkn0/gd5bMvi9vImU74R84=;
	b=b+IEA4pIRkDtNHs3wVuZB+jGG2LiJ0+e4ccwBrircVQzyZLnLoccFKZz4qi76WmqBNft4+
	Gz3ltXLpCI2yA5MjaDEacnwH9O2CTTrp7VRhXJqoPjoFSLqKPE6OmSpOE70lz3p6TKCate
	JwOH1EbSr22V7EukO1gSjGRsvdxI27tQSHKBis7QVBayp9H11lBLBYIZeHn6s0PCttTYM0
	dZ4ixV5soCqtt/vUR6ZUSbJBcxXa6jUWwkOGBYoycB3dbOKFRJ5y7hJbA0PtchuxjBLhf3
	SBnukdTUMArYZlpsAJRfAZUW+SQYUTC2I3CtNjhQJErsV05/blTovYM9dr4lDQ==
Date: Wed, 1 Apr 2026 15:03:01 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        dsahern@kernel.org, david.lebrun@uclouvain.be,
        stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
        linux-kernel@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 2/2] selftests: seg6: add test for dst_cache
 isolation in seg6 lwtunnel
Message-Id: <20260401150301.37fc2584bb5add3a922999f4@uniroma2.it>
In-Reply-To: <b6ec7b55-d883-45fd-a227-db8fb29e48f2@6wind.com>
References: <20260331110755.25042-1-andrea.mayer@uniroma2.it>
	<20260331110755.25042-3-andrea.mayer@uniroma2.it>
	<b6ec7b55-d883-45fd-a227-db8fb29e48f2@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24BA037AE77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 18:15:31 +0200
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> Le 31/03/2026 =E0 13:07, Andrea Mayer a =E9crit=A0:
> > Add a selftest that verifies the dst_cache in seg6 lwtunnel is not
> > shared between the input (forwarding) and output (locally generated)
> > paths.
> >=20
> > The test creates three namespaces (ns_src, ns_router, ns_dst)
> > connected in a line. An SRv6 encap route on ns_router encapsulates
> > traffic destined to cafe::1 with SID fc00::100. The SID is
> > reachable only for forwarded traffic (from ns_src) via an ip rule
> > matching the ingress interface (iif veth-r0 lookup 100), and
> > blackholed in the main table.
> >=20
> > The test verifies that:
> >=20
> >   1. A packet generated locally on ns_router does not reach
> >      ns_dst with an empty cache, since the SID is blackholed;
> >   2. A forwarded packet from ns_src populates the input cache
> >      from table 100 and reaches ns_dst;
> >   3. A packet generated locally on ns_router still does not
> >      reach ns_dst after the input cache is populated,
> >      confirming the output path does not reuse the input
> >      cache entry.
> >=20
> > Both the forwarded and local packets are pinned to the same CPU
> > with taskset, since dst_cache is per-cpu.
> >=20
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > ---
>=20
> [snip]
>=20
> > +test_cache_isolation()
> > +{
> > +	RET=3D0
> > +
> > +	# local ping with empty cache: must fail (SID is blackholed)
> > +	if ip netns exec "${NS_RTR}" taskset -c 0 \
> > +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> > +		echo "SKIP: local ping succeeded with empty cache"
> Nit: maybe the same message as the forwarding case:
> "SKIP: local ping succeeded, topology broken"
>=20

Makes sense, will fix in v2.


> > +		exit "${ksft_skip}"
> > +	fi
> > +
> > +	# forward from ns_src to populate the input cache
> > +	if ! ip netns exec "${NS_SRC}" taskset -c 0 \
> > +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> > +		echo "SKIP: forwarded ping failed, topology broken"
> > +		exit "${ksft_skip}"
> > +	fi
> > +
> [snip]
>=20
> After that:
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks for the review.

Ciao,
Andrea

