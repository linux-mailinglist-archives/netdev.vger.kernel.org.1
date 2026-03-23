Return-Path: <netdev+bounces-270702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC8kKIqXwWkuUAQAu9opvQ
	(envelope-from <netdev+bounces-270702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:42:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE32FC7A3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70432303933C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E523612D8;
	Mon, 23 Mar 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kjnVPtb/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B332EA0;
	Mon, 23 Mar 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294902; cv=none; b=G0XQjFvpMxtOEgfQ5QpqiEGyxH5DwmP+MqlIzMeUYBdozhUhLdV3HPynNM+CQfVZX38LMShd/LFFIZUuE0mbZH2WFtkjZl4pddWMI2pnhqDFXL8PHDpfmWfWFFir30uHQY5ThGTIBdhZ+BjPjYVtFBjl5XhSJB0SgapQNNZWVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294902; c=relaxed/simple;
	bh=s4uUGp0kBXZ5BdEk3ZqS7Hjj3JAwls9olQ6CAplQT8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaGHN38H8N/GUsHOAgk9tnutvAKZkiNzhaIGmtXnMckXtX4dcYkTPWL39TqnCacoLbiOdXyHAVFgjdSy3bO87Q4J42nVjn+tp+MSmFZGBVLE7pVI8vZLrVcCdz5WO6zAgMqgZhSwR4D9+y8PiMT7U9w/ty/al1kiCSdKMfxeAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kjnVPtb/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774294899; x=1805830899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=s4uUGp0kBXZ5BdEk3ZqS7Hjj3JAwls9olQ6CAplQT8A=;
  b=kjnVPtb/z34aNKvWWYidZGxl3Fa5dVQO9Gl+Dh2Ezo/Q5NciJ/USavwa
   gQFgMA/jjBAiW5lWdnRoLJBMO6/cEePhBUVE6ppuNFF3voEd865A3I/y1
   UfEf4HkeHJzjLWmoyRGg0RNT1M3IfV/+lNsxIq3zUOtKvpig7He8mj4Xk
   coxQW2Taoy6vuhTzDWXCR9NbhGZ4S6GYygInlUp8Hend50QLtwg2T/h76
   JpeJgG4psL8MSbpiJw0yl4B+JQIfBsArmol58PDhurT/UUZaeDdJKqksM
   WcW80f9cFRODh0yd9ra4SSc9UofjGRTCKRLL4i9VSpEXNn9iBow/Thybu
   A==;
X-CSE-ConnectionGUID: REjIOP+jQaOQoOcJQ3g0WQ==
X-CSE-MsgGUID: dxpgqMxRRfme9NUsjRLe7g==
X-IronPort-AV: E=Sophos;i="6.23,137,1770620400"; 
   d="scan'208";a="62762544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 12:41:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 23 Mar 2026 12:41:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 23 Mar 2026 12:41:00 -0700
Date: Mon, 23 Mar 2026 20:40:59 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260323155204.0321db13@bootlin.com>
 <20260323172640.2669232d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323172640.2669232d@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270702-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DEN-DL-M70577.microsemi.net:mid,microchip.com:dkim,microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 2DAE32FC7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hervé,

> Hi Daniel,
> 
> On Mon, 23 Mar 2026 15:52:04 +0100
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Daniel,
> >
> > On Fri, 20 Mar 2026 16:00:56 +0100
> > Daniel Machon <daniel.machon@microchip.com> wrote:
> >
> > > When lan966x operates as a PCIe endpoint, the driver currently uses
> > > register-based I/O for frame injection and extraction. This approach is
> > > functional but slow, topping out at around 33 Mbps on an Intel x86 host
> > > with a lan966x PCIe card.
> > >
> > > This series adds FDMA (Frame DMA) support for the PCIe path. When
> > > operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> > > directly access host memory, so DMA buffers are allocated as contiguous
> > > coherent memory and mapped through the PCIe Address Translation Unit
> > > (ATU). The ATU provides outbound windows that translate internal FDMA
> > > addresses to PCIe bus addresses, allowing the FDMA engine to read and
> > > write host memory. Because the ATU requires contiguous address regions,
> > > page_pool and normal per-page DMA mappings cannot be used. Instead,
> > > frames are transferred using memcpy between the ATU-mapped buffers and
> > > the network stack. With this, throughput increases from ~33 Mbps to ~620
> > > Mbps for default MTU.
> > >
> > > Patches 1-2 prepare the shared FDMA library: patch 1 renames the
> > > contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
> > > management and coherent DMA allocation with ATU mapping.
> > >
> > > Patches 3-5 refactor the lan966x FDMA code to support both platform and
> > > PCIe paths: extracting the LLP register write into a helper, exporting
> > > shared functions, and introducing an ops dispatch table selected at
> > > probe time.
> > >
> > > Patch 6 adds the core PCIe FDMA implementation with RX/TX using
> > > contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
> > > change and XDP support respectively.
> > >
> > > Patches 9-10 update the lan966x PCI device tree overlay to extend the
> > > cpu register mapping to cover the ATU register space and add the FDMA
> > > interrupt.
> > >
> >
> > Thanks a lot for the series taking care of DMA and ATU in PCIe variants.
> >
> > I have tested the whole series on both my ARM and x86 systems.
> >
> > Doing a simple wget on my x86 system, I moved from 3.8MB/s to 11.2MB/s and
> > so the improvement is obvious.
> >
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> >
> 
> Hum, I think I found an issue.
> 
> If I remove the lan966x_pci module (modprobe -r lan966x_pci), and reload
> it (modprobe lan966x_pci), the board is not working.
> 
> The system performs DHCP requests. Those requests are served by my PC (observed
> with Wireshark) but the system doesn't see those answers. Indeed, he continues
> to perform DHCP requests.
> 
> Looks like the lan966x_pci module removal leaves the board in a bad state.
> 
> Without the series applied, DHCP request answers from my PC are seen by the
> system after any module unloading / reloading.
> 
> Do you have any ideas of what could be wrong?
> 
> Best regards,
> Hervé

Thanks for testing this!

As part of my testing I did unload/load the lan966x_switch module to ensure the
ATU was properly reset and reconfigured, and that seemed to work fine. I must
admit, I did not try with the lan966x_pci module.

From what I hear, when you are in the bad state, TX is still working, so it's an
RX issue. Could be the interrupt is not firing, so the napi poll is not
scheduled.

Anyway, I will have a look at it during the week. Will let you know.

/Daniel

