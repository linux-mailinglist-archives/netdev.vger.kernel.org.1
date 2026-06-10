Return-Path: <netdev+bounces-297666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 96ERBwBcKWqcVgMAu9opvQ
	(envelope-from <netdev+bounces-297666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:43:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E4366961C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zohomail.in header.s=zoho header.b=c2G6Zjh2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297666-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zohomail.in;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BDC300DA78
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2A406285;
	Wed, 10 Jun 2026 12:43:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E376312826
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:43:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095420; cv=pass; b=oq8HK8bv9TOgPXsh63tTP9Ta00d/zq4hc71Cv2iGtW9Ltay0TMdb/KY6R6FYXe4K0jWFO2dGlFtyEzD9PIS1PwdB8zQIZ/egstheBOHmlYUoBKf6Wq3dmOpLhDatUix2piD4JrP2vn5xXZTVNYY5IDH551DfVW88PfN1oRupLTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095420; c=relaxed/simple;
	bh=sRuN7NYI/oEnriq+ccgftIIiwTFx1NfVCZXQu9yCWRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=c5oIfMe1YeLHAsgXsRN7mXoHDOpNUWfaBTLL5eCvW0Z29WekumEEGRCoxui/ZR0gYT3mQqBH+U8E1Ed6QgR2O2+5kgXuqs79FRguEtqpX8zGVOk5NRAZsljSol1E0OZcEEVcjU+NagTZq6eqvyjFBg7ixilIGl6AqMY2twFFCQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=c2G6Zjh2; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal: i=1; a=rsa-sha256; t=1781095369; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=NW9pnk9PMvTCsmO6+s39b1bHhZmg648WmkDqZ/A1OD3/+qgucgU4eybtKH89vKLTV15rNG4QSDGljae0DILfU2HYPB69tuCxuEGiLqTvL2QJ/a2sk6+EtD+g6j9Zs/B/dl5bGmJD+LuwoH+GOIvX6IrqR+RFRQtmBpEtmiIVDK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1781095369; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bkA0tMMUQyfUMrss1iwRHja5fOtU2rvvX/8sjrFAtFo=; 
	b=NU2r8h1u2fntl2LN1GK5K9Q87JmLJgp6ACW6djaH4rzO99jkZBNJwayoB/+rEf3UWCTPSv1+cpRo/rC4SpP3eeGCgwEqBnTyalrxjzOux6kMq3OWJsd0ZRGV2uSLy7bs6aOACtzUfwXvIsxdho7VXUYJ5JKsUy+IqtD2UEoRxkU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781095369;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bkA0tMMUQyfUMrss1iwRHja5fOtU2rvvX/8sjrFAtFo=;
	b=c2G6Zjh2D7Ckt4coW77nM73IE+wg6TswFQuMq9MNIPPugHxxK125paDOuLIREOMH
	RuRfCJhn6h763hcX/ipBOJNxYCQHabrgvuFWfcdHnJMysq4Brb7BU5bd55Iu0tt2aPo
	/MhZgenqRb+4qXa5/ODJ77/HBCatW/IPRDF/1EzA=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1781095367536569.4455143305725; Wed, 10 Jun 2026 18:12:47 +0530 (IST)
Received: from  [152.57.154.252] by mail.zoho.in
	with HTTP;Wed, 10 Jun 2026 18:12:47 +0530 (IST)
Date: Wed, 10 Jun 2026 18:12:47 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "Simon Horman" <horms@kernel.org>
Cc: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
	"anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrewnetdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>,
	"intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19eb18e8367.af9d0ca196779.184115242384250371@zohomail.in>
In-Reply-To: <20260526200114.GD2256768@horms.kernel.org>
References: <19e537fa55c.56218d6244367.1765806925055659075@zohomail.in> <20260526200114.GD2256768@horms.kernel.org>
Subject: Re: [PATCH net-next] e1000e: fix memory leak of msix_entries on
 MSI-X failure
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
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-297666-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linuxuser509@zohomail.in,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.in:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxuser509@zohomail.in,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82E4366961C

Simon, you're right. e1000e_reset_interrupt_capability already frees msix_entries. I'll drop this patch.

Thanks, 
Ashwin Gundarapu


From: Simon Horman <horms@kernel.org>
To: "Ashwin Gundarapu"<linuxuser509@zohomail.in>
Cc: "anthonylnguyen"<anthony.l.nguyen@intel.com>, "anthony.l.nguyen@intel.com"<przemyslaw.kitszel@intel.com>, "andrewnetdev"<andrew+netdev@lunn.ch>, "davem"<davem@davemloft.net>, "edumazet"<edumazet@google.com>, "kuba"<kuba@kernel.org>, "pabeni"<pabeni@redhat.com>, "intel-wired-lan"<intel-wired-lan@lists.osuosl.org>, "netdev"<netdev@vger.kernel.org>, "linux-kernel"<linux-kernel@vger.kernel.org>
Date: Wed, 27 May 2026 01:31:14 +0530
Subject: Re: [PATCH net-next] e1000e: fix memory leak of msix_entries on MSI-X failure

 > On Sat, May 23, 2026 at 11:52:14AM +0530, Ashwin Gundarapu wrote: 
 > > From: Ashwin Gundarapu <linuxuser509@zohomail.in> 
 > > Date: Sat, 23 May 2026 11:49:40 +0530 
 > > Subject: [PATCH] e1000e: fix memory leak of msix_entries on MSI-X failure 
 > > 
 > > When MSI-X initialization fails, the driver falls through to try 
 > > MSI or legacy interrupts. However, the msix_entries array allocated 
 > > earlier is not freed, causing a memory leak. Free it and set to 
 > > NULL before falling through to the MSI fallback path. 
 > > 
 > > Found by code inspection. 
 > > 
 > > Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in> 
 > > --- 
 > >  drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++---- 
 > >  1 file changed, 6 insertions(+), 4 deletions(-) 
 > > 
 > > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c 
 > > index 7ce0cc8ab8f4..1526069d7fc1 100644 
 > > --- a/drivers/net/ethernet/intel/e1000e/netdev.c 
 > > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c 
 > > @@ -2065,10 +2065,12 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter) 
 > >                                  a->num_vectors); 
 > >                  if (err > 0) 
 > >                      return; 
 > > -            } 
 > > -            /* MSI-X failed, so fall through and try MSI */ 
 > > -            e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n"); 
 > > -            e1000e_reset_interrupt_capability(adapter); 
 > > +                        } 
 > > +                        /* MSI-X failed, so fall through and try MSI */ 
 > > +                        e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n"); 
 > > +                        kfree(adapter->msix_entries); 
 > > +                        adapter->msix_entries = NULL; 
 > > +                        e1000e_reset_interrupt_capability(adapter); 
 >  
 > Hi Ashwin, 
 >  
 > e1000e_reset_interrupt_capability() already handles freeing (and NULLing) 
 > msix_entries, and it does so after calling pci_disable_msix(). 
 >  
 > This patch seems to have the effect of bypassing the call to 
 > pci_disable_msix(). 
 >  
 > Are you sure this is fixing a memory leak as described? 
 >  
 > Flagged by https://sashiko.dev/ and https://netdev-ai.bots.linux.dev/sashiko/ 
 >  
 > >          } 
 > >          adapter->int_mode = E1000E_INT_MODE_MSI; 
 > >          fallthrough; 
 > > -- 
 > > 2.43.0 
 > > 
 > > 
 >  
 > 


