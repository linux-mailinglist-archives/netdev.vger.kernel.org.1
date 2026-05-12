Return-Path: <netdev+bounces-287050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HpcJkz6AmokzQEAu9opvQ
	(envelope-from <netdev+bounces-287050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:00:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916551E2F0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED1DF302CD1E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8E74C0425;
	Tue, 12 May 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f06Geq8+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B939769A;
	Tue, 12 May 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579813; cv=none; b=ggX92ww3+xbv2VE1ztPaHqr8/CbRRgtq//0Jlq+Giim66wvjqnLVvXk4vToOfFhmYC6sf7PqwVxOM/sIj+LENXpU4JPc8BfjfPtHBo9teGbpOJqaUk4y/0Pb2AA6HvFZERSd0n9SG2nXUMoAzi9y+C1HROTDXiIthvFO38mlykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579813; c=relaxed/simple;
	bh=7nkYh6Qbf7lvqDosOSN3tJA/nJuPw0T3/Hd/H6IZ6/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2zcIMTLR0w+TNVdB9MUSI7VRUDqTiQNxPEbQ6b9A9ur0kzB0UHQOBuskSiu/ExPhhYPDrI/iFbSF7X3V3xTJF1hdWJeq3vWZZ1C2V1Ur5JUvjha3II+KVpegOo1ANhHyClcEOHr3HICVHx9NSuXTspGly3MtwCR+Dhn06zK+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f06Geq8+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778579812; x=1810115812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7nkYh6Qbf7lvqDosOSN3tJA/nJuPw0T3/Hd/H6IZ6/k=;
  b=f06Geq8+e8rAFkvl0iRPcSVU0XHxWRQgiUhYwRMtXDuBOX6Tgv1JHTaQ
   m/oBVcvYxY3PZvthePQBaLdmdL4s2VZLYoJHgGEuCwkusg5nGlzP0+eq/
   c7JLLxVTCGL5KHvaAwVRg+xj2buL8uLtV34lW+5ex9pXTFxnW+JiZgWNZ
   qkmwC9rgcJnsoWBeancl8s/3hD1oj0+vGu6tb2Q6FFAP5z0MYhREN1Svh
   HjTcROBYC+Qp7eNGCPVkfTunTy1F3f1kliORM/9B16QylMTTh6nHCq5ZR
   D2po8865UYo2LiksVNJF2so2zl2yZENgh8makk4Af7l+S5zbqC0HfZYs3
   w==;
X-CSE-ConnectionGUID: J3uHyACQST6Daok8jNAfVw==
X-CSE-MsgGUID: yCzirzG2SqKAi3857ifdoA==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="57384159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2026 02:56:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 12 May 2026 02:56:50 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 02:56:47 -0700
Date: Tue, 12 May 2026 11:56:46 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v4 00/13] net: lan966x: add support for PCIe FDMA
Message-ID: <20260512095646.bnrgbo6ffjk4nv5g@DEN-DL-M70577.microsemi.net>
References: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
 <20260511192018.49dfcd7b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511192018.49dfcd7b@kernel.org>
X-Rspamd-Queue-Id: 2916551E2F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287050-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,DEN-DL-M70577.microsemi.net:mid]
X-Rspamd-Action: no action

> On Fri, 8 May 2026 09:35:24 +0200 Daniel Machon wrote:
> > When lan966x operates as a PCIe endpoint, the driver currently uses
> > register-based I/O for frame injection and extraction. This approach is
> > functional but slow, topping out at around 33 Mbps on an Intel x86 host
> > with a lan966x PCIe card.
> 
> Looks like sashiko-bot responded but only CCed bpf@
> Please let us know if all the issues are false positives,
> I'm going to assume for now that at least one of the issues
> is real :)

I ran through all the issues from sashiko-gemini (sashiko-nipa only reported low
severity issues).

Most of them are false-positives, some are pre-existing and some are purely
theoretical. I have experimented a little with fixing some of the theoretical,
but subsequent local sashiko runs seem to just find new ones indefinitely ;)

IMHO, like Paolo commented on v3, I think these can safely be postponed to
future follow-ups, if need be.

Let me know what you think.

/Daniel

