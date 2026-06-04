Return-Path: <netdev+bounces-295478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lMTxEPUIImoxRwEAu9opvQ
	(envelope-from <netdev+bounces-295478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9202643F0E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:23:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="gs t5iL5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295478-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E3F30300D3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860F2F7F02;
	Thu,  4 Jun 2026 23:21:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6025228D;
	Thu,  4 Jun 2026 23:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615305; cv=none; b=QsdaVHvOlkxQZIzazA2eu6/or/jSIAkFDHpMuPLdR2eHr5EjvO/zsLjr+CGZVt9JqABq3nIVUUg2h2aNRsxFS/A2OLe7vax4CKkydy+octtk2fKWoYp1SzIZdCZ6x184GoYncPFy/quLp7ZweWOeiFGIJNzw3OYWCURPxOVZpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615305; c=relaxed/simple;
	bh=DNn/vtLYpIYTgOpXW91wgrzsJtSwAgf8LEb/VhCHV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxnFLzr3c6UClpmG6zloLFFF0TAJAwG2aKBnMwQXXXN6L2SXoAQANE1xRbsOLQebDnwo8/X3OCQosbeU+nB/ejZIYFXrZMg7BW14K2r2IRit4SZD0LfKNPmSqx5p0eWA5qvpKksPtzeWJ5z+rQ5vUiIC/N2MDfmiZiH/ti/yI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gst5iL50; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q1FL1hGctmdWIxgu8RucdggA7YfEHVMHB+Zw3f/cFxY=; b=gs
	t5iL50sEPVcP8hhNXiKocRciN8sKmqRhvO8WLmh/nCiCi9xZHg0r6tUAj9qoyC8UxLOWi/mRKazVM
	/Hznf0I5Dsjg7jtt6xsbueSVbMqsjCF3LJ08yNN2+zDfwCJMuA06QtpO0qNqWFcioXyqkqqVfCFis
	edAzAqfq3DgdI3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVHNS-0067X7-So; Fri, 05 Jun 2026 01:21:30 +0200
Date: Fri, 5 Jun 2026 01:21:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, cedric.jehasse@luminex.be,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb
 pcp app
Message-ID: <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295478-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9202643F0E

On Fri, Jun 05, 2026 at 08:51:56AM +1000, Luke Howard wrote:
> Hi Cedric,
> 
> > On 4 Jun 2026, at 10:01 pm, Cedric Jehasse <cedric.jehasse@gmail.com> wrote:
> > 
> > On Thu, Jun 04, 2026 at 08:37:17PM +1000, Luke Howard wrote:
> >> I still need to find a similarly natural way to expose the switch’s AVB capabilities / 802.1Qat admission control. Perhaps there is none and it will need to remain a local patch.
> > 
> > There's a devlink port param command. I've been wondering if this could be used
> > to set a port's AvbMode. However:
> > * at the moment there are no drivers supporting this.
> >  eg. devlink_nl_port_param_set_doit and other return this isn't supported
> > * i don't know if AvbMode is a valid use for devlink port param, and if it
> >  would get accepted
> 
> mv88e6xxx already exposes the ATU_hash driver-specific devlink parameter, so there is a precedent which augurs well.
> 
> A per-port AVB mode devlink could configure:
> 
> - AVB mode to enhanced
> - iso ptrs to number of enabled ports * N (currently we use N=64)
> - enabling interpreting AVB_NRL entries as AVB with G1_ATU_CTL_MAC_AVB

I don't know enough about AVB, so this might not apply here....

What does the pure software version of AVB look like? Is there a need
to configure these parameters? If not, why not? If there is, what API
is currently used?

Ideally, the user should not need to know if some functionality has
been accelerated by offloading it to hardware. They just configure it
using the standard Linux model of the feature.

	Andrew

