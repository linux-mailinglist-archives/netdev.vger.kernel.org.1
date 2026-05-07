Return-Path: <netdev+bounces-285462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGXGF2De/GlFUwAAu9opvQ
	(envelope-from <netdev+bounces-285462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCD4ED9A8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 20:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC230304A0AC
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC73C2784;
	Thu,  7 May 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tOJL+/tX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361E33D6F9;
	Thu,  7 May 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179640; cv=none; b=GsqHkuAiSggJZum8M204RvXsVYgjpSnZXNPikWwRXZpKu4HncIvSvcjCXNhof0L6rsIoG3g5o1X5x4ETDLr9zsKNGSpUD00S1KblTKZHnFJOuQSyjfYbc8XYvBz3NK2aWE0pAKTmrB/OZLnBtPtrzh19Mdbv7pCN+8MN/o8joF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179640; c=relaxed/simple;
	bh=nV80bCDLgSyQneDPT+TZoCa6lKd1n1qaxJOqkPDtorc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3OKd/S+zbNVg8duB4mO0Zm+2/J284tnf4gAvByyGePdZOm/tuwDap+ImOiJrxU1fQENP4lrPItFsw96DqbSR32QRncokx4MGq019jAhyP33bhK2Q1phN7LVsumxqp1R5aszOaC1Gx+TMPpH11xmxeS4YL3A7nzP7tI45DJZFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tOJL+/tX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778179639; x=1809715639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nV80bCDLgSyQneDPT+TZoCa6lKd1n1qaxJOqkPDtorc=;
  b=tOJL+/tXczWd3bCjoUBTIgDZOq3Z9psVB4lB2G1J64ChGpcMdOIiIAbN
   oKtZ0RYu4wmDVDThVeD5YSL9Q9iPbBkbYcx+DmnV2XP7tZxqh+fx1nPij
   fGqd2ebMVL1myme4K4/lISgZfwWMFwsqLkyOoQtwwR8OffazgO7yYu+k+
   BNGlh87UNoVP4H9PUcINELRfCQyFrStQDy4dsFc5KMNUx82s3bzgDtfyU
   dSOQj471QGruD2W/xb50Pzg3xoSUpnrRGTqU12oEftKS5fuuOvqPkI9oR
   kSzXW1f60fsi7ZoDePmoTML4k709j1aLOwoGBzZLhBev/uhQrUFugwTr3
   g==;
X-CSE-ConnectionGUID: rpcJMlA7QfSsF+A+h2bwPQ==
X-CSE-MsgGUID: 4g6NkmJdQtC0Lw8C4aM6Jg==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="224434606"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 11:47:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 11:47:18 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 11:47:14 -0700
Date: Thu, 7 May 2026 20:47:14 +0200
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
Message-ID: <20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
 <20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
 <20260507090810.53e66ef6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260507090810.53e66ef6@kernel.org>
X-Rspamd-Queue-Id: D0CCD4ED9A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285462-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DEN-DL-M70577.microsemi.net:mid]
X-Rspamd-Action: no action

> On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:
> > Move the debugfs setup into a new sparx5_debugfs() helper in
> > sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> > succeeds so the netdev names are finalized. sparx5_vcap_init() now
> > only deals with VCAP state. The sparx5/ debugfs root is created in
> > the new helper as well.
> 
> netdev names are never final :( User can change them at any time.
> The best practice is to name the debugfs file by some stable hw-related
> property, bus, port number etc.

Right, but they are finalized in the sense that we have a name we can use for the
debugfs files (which we dont pre-patch).

Hmm. I think this patch fixes an actual issue, where you cannot query the
debugfs files, because a previous patch broke the ordering. I agree that the
names chosen (netdev_name()) for the files were poor, but is that really a fix
for this series? Should that not be adressed in a future patch for net-next (it
involves changing an VCAP API function that is not only used by Sparx5/lan969x,
but also lan966x.).

/Daniel

