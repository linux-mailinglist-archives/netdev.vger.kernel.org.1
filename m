Return-Path: <netdev+bounces-294442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e7sMOxpUH2ppkgAAu9opvQ
	(envelope-from <netdev+bounces-294442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:07:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED363257B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=FyFA6oFH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294442-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9333D3010B86
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962F3AB26B;
	Tue,  2 Jun 2026 22:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7723806DB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437931; cv=none; b=mXQjtCJs5a+IrRLtgeSMykFs5HcZvrYGGCGJhM5S4Vzn00goUe9kv6iF3Y5S01HoEzwhnEKTMfdYTjogt8VYveKmPhnzTnFDFTJ1pCloSIO+2jBXm6g1T0NlCNkyFSMyl+p3wNfaT/8s2BqZ1MJH+5h1xvQLH81SdfQf6HtUT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437931; c=relaxed/simple;
	bh=B2jwSkUlIjLFtZ0+xlNiJ/fn5ceRxS3MtNEEP2hu/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo8YDNybGCOy4mBjWnKFaNfFXug3Q8Ne/xncTvHDldv2Yb68M8+xGPbvkRkdAe6W386OTbtAdyofTKKZ9Z7RsdqZQIKHFFebVwvfmLXX/itwOIC4Zr7hHIUClsgLXfSg0GWJiuycZm6wrDK4vWuShNlZpW/IiRCKI+9N+OJfogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FyFA6oFH; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ov7dAf8vwJevqPXcZ5dazG66Avmus3yiFwb0nhqKU0w=; b=FyFA6oFHnf0nx+spDryNIgH1vU
	4ljq0fKiVCwsxhTpssR2zJYKvN3FIAtHIbK/IrCSX0XvNhzh1JPawe1fqdE4ORoZrhd6b/OFRbp9N
	hqitYTbfr/ox/zevpXomkYS1Sly8fkjof9Ln8dmtDYJqdwk69yxr/dPlLIenVwOqLUiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUXEk-005ldI-0V; Wed, 03 Jun 2026 00:05:26 +0200
Date: Wed, 3 Jun 2026 00:05:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Fenton <andrew.fenton@grapheneos.org>
Cc: netdev@vger.kernel.org
Subject: Re: [QUESTION] Packet uid for kernel-generated multicast
Message-ID: <d31e7097-0adb-45e4-8e50-313334ec791e@lunn.ch>
References: <ah8aQWX60nTiHMLQ@acomputer.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8aQWX60nTiHMLQ@acomputer.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew.fenton@grapheneos.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294442-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CED363257B

On Tue, Jun 02, 2026 at 02:00:33PM -0400, Andrew Fenton wrote:
> Certain multicast-related system calls such as setsockopt with options
> IP_ADD_MEMBERSHIP, IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP result in outgoing
> kernel-generated packets that don't have an associated uid.

Just to be sure i understand your question. You mean the user ID of
the process joining a multicast group?

I don't actually think it is a 1:1 mapping. Multiple different users
can join the same multicast group. The kernel, i think, just joins the
group once, independent of how many userspace processes joined it. The
kernel will also answer query requests autonomously, and i doubt that
is directly associated to a process, just that some user(s) have
joined the group.

     Andrew

