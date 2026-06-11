Return-Path: <netdev+bounces-297951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOVxHmhQKmphnAMAu9opvQ
	(envelope-from <netdev+bounces-297951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CE66EE31
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zohomail.in header.s=zoho header.b=QlDXpLst;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297951-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297951-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zohomail.in;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A60630074FD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C62F7F19;
	Thu, 11 Jun 2026 06:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AD1F4C8E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:06:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157985; cv=pass; b=LFrrtw/41OwUwpBZqfdu5laPgyLomjknjkMktF/G/H+Cp3YveAxpPy+4LzraRo8i/RRaI10NZgiOelaPishkDpI4yd9iGgNpFcVHhxYL/weytJ4EKRiVtyzYZJh8V6FEH1bX0p+OYh3p4rFYZyf4bMleRjs/fCf+vtN9XzJzsGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157985; c=relaxed/simple;
	bh=/zM+i0APeQfIkn7ae/K/HeV4qmyG7PZgY9XTG/QDqEc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=s5ZOXzC42qaZoCpyClPzlhRdxxiuLFK4C2P5hi6/c8EkO64BdFFLTOtyph4JJvg/DFYRyb6bFhNf8pF/eEKEFLGjNzO3jvNjdWyltwSnEqykKHTyOXwME8UVFp6yRam2/YEFbPVWBMiY6or4IFiVLrlzozY7bvT7M7Zgi9Pk8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=QlDXpLst; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal: i=1; a=rsa-sha256; t=1781157929; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=TMjTp3zeIK6uw/cbwKlAx9dyiBHjfSds/CzSqgab180ExLHIre1s8A+HFB8VnuwKsDvshzdbfuFaK4kyLlx4t7dvdywFYlvWc6T+ZiqnbRUH3P4EhxK/46W85oLlvvwc4Md8IMCp8FuQlBFBcGEp5lRfgwlx+iJLNfNuW70bers=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1781157929; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r0Kg9efrQxEut61eww4Xt0pjV45uZm/MNUVicYS+0EA=; 
	b=RjKJnO48OGOMYNVV0etwQWOBm2VYI2P6oQqKE2YXkF3dLy/ek1OL3zyCQJxTZdZ6lv0b4P8m/WYqp0bbx1OEZKxGzTnmsV182W28GsuWVBXIYhREsOgSOpP4QHU3pnxE39a9f0yCBy36MU3ym2EQelIERdheJd+VYN+FT2/X1aY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781157929;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r0Kg9efrQxEut61eww4Xt0pjV45uZm/MNUVicYS+0EA=;
	b=QlDXpLstGe/4JNoSwERAFlqVNcO9c6+FWXLptBLMIzqNpdIwrZVfS//GFWjNKn99
	IMERLDyvfvI6cDzEsy05CHuhdAjB/ym2hgZtI+NdPUMIFwwalCwBvVM1y54NGgz+eL9
	CXUyRWEw0z08EYxoBa4cUM5RCFIAIhrLOTijPqwE=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1781157923106916.71298730993; Thu, 11 Jun 2026 11:35:23 +0530 (IST)
Received: from  [192.188.171.47] by mail.zoho.in
	with HTTP;Thu, 11 Jun 2026 11:35:23 +0530 (IST)
Date: Thu, 11 Jun 2026 11:35:23 +0530
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: "Simon Horman" <horms@kernel.org>
Cc: "anthony.l.nguyen" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>,
	"aleksandr.loktionov" <aleksandr.loktionov@intel.com>,
	"jacob.e.keller" <jacob.e.keller@intel.com>,
	"jedrzej.jagielski" <jedrzej.jagielski@intel.com>,
	"piotr.kwapulinski" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19eb549091a.56e4a82b51051.8566636820791024878@zohomail.in>
In-Reply-To: <20260608184733.GJ3920875@horms.kernel.org>
References: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in> <20260608184733.GJ3920875@horms.kernel.org>
Subject: Re: [PATCH net-next v2] ixgbe: implement get_queue_stats_rx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297951-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.in:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 695CE66EE31

Hi Simon,

I was thinking of making these changes in a separate patch, as it could make a single patch big.
I'll do the changes as suggested and will v3.

Thanks,
Kshitiz


From: Simon Horman <horms@kernel.org>
To: "Kshitiz Bartariya"<kshitiz.bartariya@zohomail.in>
Cc: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <aleksandr.loktionov@intel.com>, <jacob.e.keller@intel.com>, <jedrzej.jagielski@intel.com>, <piotr.kwapulinski@intel.com>, <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 09 Jun 2026 00:17:33 +0530
Subject: Re: [PATCH net-next v2] ixgbe: implement get_queue_stats_rx

 > On Wed, Jun 03, 2026 at 11:18:51PM +0530, Kshitiz Bartariya wrote:
 > > Hook into the netdev_stat_ops interface to expose per RX queue
 > > statistics through the netdev generic netlink API.
 > > 
 > > The following counters are filled:
 > > 
 > >  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
 > > 
 > >  - csum_bad: maps directly to csum_err, which is incremented for both
 > >    IP header and L4 checksum errors in ixgbe_rx_checksum().
 > > 
 > > The new per-queue stats can be observed with:
 > >   $ ynltool qstats show scope queue
 > > 
 > > Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
 > > ---
 > > v2:
 > >  Amended commit message with command to get RX queue stats as 
 > > suggested by Jedrzej Jagielski.
 > > 
 > > v1: https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/
 > > 
 > > 
 > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
 > >  1 file changed, 16 insertions(+)
 > 
 > Hi Kshitiz,
 > 
 > There is AI-generated review of this patch-set available on both
 > https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
 > I would appreciate it if you could look over that.
 > 


