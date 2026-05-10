Return-Path: <netdev+bounces-286399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBhcJ5zpAGqMOQEAu9opvQ
	(envelope-from <netdev+bounces-286399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2D506359
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 846AF300683D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B51332ED0;
	Sun, 10 May 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2jxPbuFy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610E30648C;
	Sun, 10 May 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444670; cv=none; b=SXNEKMYk8SHVdv9rCAnh4haEnMITGIAym8LWj3G7cYXHUIBN03NdAXBvJztbRTtvM/0alZIPARaldQ+hX7Mz37UBC3+YzE3mIao/K8bVQqOutaAzlwwEsos4F69Pdnyy0+IsuQOOSg4KMz1MNOuexjPnqkursRnOAxqg2TcSxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444670; c=relaxed/simple;
	bh=Bfc/WB8MtSNuuBFsXsab/2ISoT0JMcdHR58RLdjA2M4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td847tMgdnUWGWZclx5gV/CSyCXqVdZBAVWvyXxSKiCsEV3P3zenIbDb4Rxa457IUI2GamcFB/DEOGj4nL9nYUFxC6eN5LEoKZSCe9NwXC8Sb2hZEM1wuMUg6yr4o7cVy9oj8u5AowwxmEcZfNyewZvsN5448w6gAZ5H3JCfO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2jxPbuFy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778444669; x=1809980669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bfc/WB8MtSNuuBFsXsab/2ISoT0JMcdHR58RLdjA2M4=;
  b=2jxPbuFyt4H3EswIQqzQN1Vq/BcjO0Zrte2t8CVRy87rGREKG6WRhxqe
   cCWF5D7+1wKGEa1mD2uPle5SmEc8EoAGFrL7gY2a22tw1iay2Ph1tqbtQ
   c164QhRsFMDwtklvrgkI3PDR6A1t0DoGwFgAdqS1+G/oi7nbwkq7v/+Ue
   EfT3N6ZnUYRztzunXv2HD9/JKtRBuNOXNI4sL/DP5e0/xXJl2NlmXUq0G
   //j29xUHROGfv5FBCd/Y0BmSs+x/KyHEcX2W+DKxTw541E7SfAATnnUmf
   WQCjPmTTKWcS4cLrdaMH0SVeGROKzswGFYQG+pFphfqiT1UsewNONB2wp
   A==;
X-CSE-ConnectionGUID: VbcRMQGTQ6+eWcqm1CbgYQ==
X-CSE-MsgGUID: KIoiOUpwQPeOQIJgCqsT8A==
X-IronPort-AV: E=Sophos;i="6.23,227,1770620400"; 
   d="scan'208";a="57698493"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 May 2026 13:24:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 10 May 2026 13:24:22 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 10 May 2026 13:24:19 -0700
Date: Sun, 10 May 2026 22:24:19 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net v2 1/4] net: sparx5: defer VCAP debugfs creation
 until after netdev registration
Message-ID: <20260510202419.zlh3nej2ohx237by@DEN-DL-M70577.microsemi.net>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
 <20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
 <20260507090810.53e66ef6@kernel.org>
 <20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
 <20260508162213.6b755d8c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508162213.6b755d8c@kernel.org>
X-Rspamd-Queue-Id: 40A2D506359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286399-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> On Thu, 7 May 2026 20:47:14 +0200 Daniel Machon wrote:
> > > On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:
> > > > Move the debugfs setup into a new sparx5_debugfs() helper in
> > > > sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> > > > succeeds so the netdev names are finalized. sparx5_vcap_init() now
> > > > only deals with VCAP state. The sparx5/ debugfs root is created in
> > > > the new helper as well.
> > >
> > > netdev names are never final :( User can change them at any time.
> > > The best practice is to name the debugfs file by some stable hw-related
> > > property, bus, port number etc.
> >
> > Right, but they are finalized in the sense that we have a name we can use for the
> > debugfs files (which we dont pre-patch).
> >
> > Hmm. I think this patch fixes an actual issue, where you cannot query the
> > debugfs files, because a previous patch broke the ordering. I agree that the
> > names chosen (netdev_name()) for the files were poor, but is that really a fix
> > for this series? Should that not be adressed in a future patch for net-next (it
> > involves changing an VCAP API function that is not only used by Sparx5/lan969x,
> > but also lan966x.).
> 
> Dunno, if we are aiming to switch to a different naming scheme we can
> just do it now, I reckon. It will not make the fix much longer.
> And presumably it will alleviate the need to reshuffle the ordering.

OK, sounds good to me. I will make the changes for v3. Thanks!

/Daniel

