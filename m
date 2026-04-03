Return-Path: <netdev+bounces-275216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cApdHiko0Gko4AYAu9opvQ
	(envelope-from <netdev+bounces-275216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9DE398473
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB053030B2B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0323D5251;
	Fri,  3 Apr 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWDw1SSb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD723D7FB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249253; cv=none; b=NaiX4Ay5X33cT+lgte0pACPFF4doEP/2WhOPrEfl3MfN+yGBSUCPdBKidfNN7NjTOkp4b7mll7vMNSH57E/+hdQyHH0E/ocdpWdk1QI9Vm/gL0Sl91kgS4hyXm1Vd81NNA57ybKyrb++wnVGZ82ORmMukyCjrM1vXj0Eups+ATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249253; c=relaxed/simple;
	bh=gy1VbiVNi32rhXZAQ8HHpdHdI9besj8H4pcd/DYfB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo7onk6Fo0mS2j1DUpnfevwyddnqjCJmNWveBbOAkz87Ge0y+0+ukzD9oj1Ii1RS/GOXjhUjNfeMxGdMe7s5A4qObuOITImp4pwV/qOpOmVoe0jlrj2AHtZ+4qEStbw5U1p12waPDvCJn5uR8K5U41NC3JJWa7I0U7myCUHuniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWDw1SSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFEAC19424;
	Fri,  3 Apr 2026 20:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775249253;
	bh=gy1VbiVNi32rhXZAQ8HHpdHdI9besj8H4pcd/DYfB/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWDw1SSbNfC1xpHy3Hjv8T+0CoswruO0CJ4ZSNQrBmeCFmk8KIarv0VsdLPDquO+J
	 E74zeeILtcgi7srjUvQPSM2b5LiHfZo5FiK4T0dANR6Sqh5miw1VKH1V25mou+dpAr
	 5JK+9oWUkiV3mAzJ9nN10JpXqVMm9WtQ58j0H1H7BsWZoyLO53DShR3eF++BvVjcDy
	 IG8fykoq85CcyzDWf7rjS4+hTthb5QtPC7UOQM5+uo/OE/aa5mUt3p0ZoRu2j3U67i
	 Bou1fgzMgWD7qHflW98aG3IxAru9qe771iZcqEHx1hPmDQ2sgN+TaiqF8AYj6waAl1
	 BZ0EFJHDrxI7w==
Date: Fri, 3 Apr 2026 13:47:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/9] net: tso: add tso_features_check()
Message-ID: <20260403134732.26e39509@kernel.org>
In-Reply-To: <CANn89iLUN1F-NzdCpaPhZBFVZR6KjEuyPNhNXtWr6Hu4BFdyMw@mail.gmail.com>
References: <20260403043237.3909226-1-edumazet@google.com>
	<20260403043237.3909226-2-edumazet@google.com>
	<CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
	<CANn89iLUN1F-NzdCpaPhZBFVZR6KjEuyPNhNXtWr6Hu4BFdyMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E9DE398473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026 00:20:13 -0700 Eric Dumazet wrote:
> > I forgot that netif_skb_features() uses:
> >
> > if (dev->netdev_ops->ndo_features_check)
> >     features &= dev->netdev_ops->ndo_features_check(skb, dev,
> >                                             features);
> > else
> >     features &= dflt_features_check(skb, dev, features);
> >
> > So I need to call vlan_features_check() from tso_features_check()  
> 
> I could be wrong though, vlan_features_check() is about  skbs with
> multiple vlan tags,
> and net/core/tso.c should support them just fine.

But we probably still need to clear NETIF_F_IP_CSUM for example?
Better safe than sorry. (I won't repeat the sashiko complaints 
assuming you saw those ;))

