Return-Path: <netdev+bounces-272127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M+jGVxaxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:10:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B440338299
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12A46311EE0C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535E140B6EE;
	Thu, 26 Mar 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1wjFAFML"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1F4035B6;
	Thu, 26 Mar 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540147; cv=none; b=G+7rE44W9Q8/MKqxHpvpJjDTbUXvCFDCRJCxj93wD80mwFdjTv3a+I4A2PAvxM0NgzQe7I6xNEQe5q8gi9wRgXZG7kPnBZr61Ra8UtuyShDTCt2hEfo9wLiD6/49GVxCyop/YmAIpI2/ASJdiaOu3/n+Xv7pMGglKAX6h/sZ2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540147; c=relaxed/simple;
	bh=lfc0HPiezXIbZWlN6mCvZhz9GywH5Y4IAvRgXmgoAqU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT4csGIeuwd4oOzDEUxxjnXane63I7wn9OQPMC8oznRdT3rJxmxbl+JrlBk+5B6vtd/PAqixwJMblGyAXc/E3LtwvKVCp1UMZwooh4o596nUfiVq1rYk4nrbY8oRRCYKB/PMHF1/SYA7LQxRLZaPd5mCQCVtIJy5wqFvHYIse4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1wjFAFML; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774540145; x=1806076145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfc0HPiezXIbZWlN6mCvZhz9GywH5Y4IAvRgXmgoAqU=;
  b=1wjFAFMLQLWZv/GZMIJYE0chnWRx7V7XawzOjqQ2XwW2OylmGvP+P8BV
   nIav6blClU0MeoI1DnDkSvlYyGcobmoL656f792JkRhVs2NeB83Dm614n
   7zPXpuIwwcyZChW3KMoTxOgWqKYNcB+g93L5pHs9JJFA4YNT6rxDt+o8b
   iWsOaJ19kACn45w5KfRgISnedV+0KQS+AAQuF56Cx1MDi/Aet1gPjtlw6
   y/9nMKz9UH6dDYNKMnBOAC21QyZsgWuOCyKzk7/z9OpIHz1GVO9k3fg+L
   y6F+gY90nSszXjYjv5+Z4vKemgb8TppEMYWYxLbVzOoI6ncSH/UZNHrvr
   Q==;
X-CSE-ConnectionGUID: n7j694HTQAuiI4RXyCbB6Q==
X-CSE-MsgGUID: AO7gC23YSNKbGcENH1Oxvw==
X-IronPort-AV: E=Sophos;i="6.23,142,1770620400"; 
   d="scan'208";a="55669549"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2026 08:48:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 26 Mar 2026 08:48:37 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 26 Mar 2026 08:48:34 -0700
Date: Thu, 26 Mar 2026 16:48:33 +0100
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
Message-ID: <20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260323155204.0321db13@bootlin.com>
 <20260323172640.2669232d@bootlin.com>
 <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
 <20260324090752.0799acb1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324090752.0799acb1@bootlin.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272127-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: 7B440338299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hervé,

> Hi Daniel,
> 
> On Mon, 23 Mar 2026 20:40:59 +0100
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> > Hi Hervé,
> >
> > > Hi Daniel,
> > >
> > > On Mon, 23 Mar 2026 15:52:04 +0100
> > > Herve Codina <herve.codina@bootlin.com> wrote:
> > >
> > > > Hi Daniel,
> > > >
> > > > On Fri, 20 Mar 2026 16:00:56 +0100
> > > > Daniel Machon <daniel.machon@microchip.com> wrote:
> > > >
> > > > > When lan966x operates as a PCIe endpoint, the driver currently uses
> > > > > register-based I/O for frame injection and extraction. This approach is
> > > > > functional but slow, topping out at around 33 Mbps on an Intel x86 host
> > > > > with a lan966x PCIe card.
> > > > >
> > > > > This series adds FDMA (Frame DMA) support for the PCIe path. When
> > > > > operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> > > > > directly access host memory, so DMA buffers are allocated as contiguous
> > > > > coherent memory and mapped through the PCIe Address Translation Unit
> > > > > (ATU). The ATU provides outbound windows that translate internal FDMA
> > > > > addresses to PCIe bus addresses, allowing the FDMA engine to read and
> > > > > write host memory. Because the ATU requires contiguous address regions,
> > > > > page_pool and normal per-page DMA mappings cannot be used. Instead,
> > > > > frames are transferred using memcpy between the ATU-mapped buffers and
> > > > > the network stack. With this, throughput increases from ~33 Mbps to ~620
> > > > > Mbps for default MTU.
> > > > >
> > > > > Patches 1-2 prepare the shared FDMA library: patch 1 renames the
> > > > > contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
> > > > > management and coherent DMA allocation with ATU mapping.
> > > > >
> > > > > Patches 3-5 refactor the lan966x FDMA code to support both platform and
> > > > > PCIe paths: extracting the LLP register write into a helper, exporting
> > > > > shared functions, and introducing an ops dispatch table selected at
> > > > > probe time.
> > > > >
> > > > > Patch 6 adds the core PCIe FDMA implementation with RX/TX using
> > > > > contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
> > > > > change and XDP support respectively.
> > > > >
> > > > > Patches 9-10 update the lan966x PCI device tree overlay to extend the
> > > > > cpu register mapping to cover the ATU register space and add the FDMA
> > > > > interrupt.
> > > > >
> > > >
> > > > Thanks a lot for the series taking care of DMA and ATU in PCIe variants.
> > > >
> > > > I have tested the whole series on both my ARM and x86 systems.
> > > >
> > > > Doing a simple wget on my x86 system, I moved from 3.8MB/s to 11.2MB/s and
> > > > so the improvement is obvious.
> > > >
> > > > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > > >
> > >
> > > Hum, I think I found an issue.
> > >
> > > If I remove the lan966x_pci module (modprobe -r lan966x_pci), and reload
> > > it (modprobe lan966x_pci), the board is not working.
> > >
> > > The system performs DHCP requests. Those requests are served by my PC (observed
> > > with Wireshark) but the system doesn't see those answers. Indeed, he continues
> > > to perform DHCP requests.
> > >
> > > Looks like the lan966x_pci module removal leaves the board in a bad state.
> > >
> > > Without the series applied, DHCP request answers from my PC are seen by the
> > > system after any module unloading / reloading.
> > >
> > > Do you have any ideas of what could be wrong?
> > >
> > > Best regards,
> > > Hervé
> >
> > Thanks for testing this!
> >
> > As part of my testing I did unload/load the lan966x_switch module to ensure the
> > ATU was properly reset and reconfigured, and that seemed to work fine. I must
> > admit, I did not try with the lan966x_pci module.
> >
> > From what I hear, when you are in the bad state, TX is still working, so it's an
> > RX issue. Could be the interrupt is not firing, so the napi poll is not
> > scheduled.
> 
> Yes, confirmed that the issue is on Rx path. Tx data were received by my PC.
> 
> >
> > Anyway, I will have a look at it during the week. Will let you know.
> >
> 
> Some more interesting information.
> 
> I tested lan966x_pci module unloading and re-loading on my ARM system.
> 
> On this system the following traces are present when I reload the lan966x_pci
> module. Those traces were not present on my x86 system.
> 
>     [  104.715031] ------------[ cut here ]------------
>     [  104.719746] Unexpected error: 64, error_type: 1073741824
>     [  104.725217] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
>     [  104.739119] Modules linked in: lan966x_pci irq_lan966x_oic reset_microchip_sparx5 pinctrl_ocelot lan966x_serdes mdio_mscc_miim lan966x_switch rtc_ds1307 marvell [last unloaded: lan966x_pci]
>     [  104.756250] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.0.0-rc1-00010-gfa357f2a6a00 #565 PREEMPT
>     [  104.765743] Hardware name: Marvell Armada 3720 Development Board DB-88F3720-DDR3 (DT)
>     [  104.773579] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     [  104.780551] pc : lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch]
>     [  104.787046] lr : lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch]
>     [  104.793538] sp : ffff800082a7bc00
>     [  104.796860] x29: ffff800082a7bc00 x28: ffff8000819abd00 x27: ffff800081a57757
>     [  104.804033] x26: ffff8000819a5d88 x25: 0000000000012400 x24: ffff800081a57758
>     [  104.811205] x23: 0000000000000038 x22: ffff00000f70ec00 x21: 0000000040000000
>     [  104.818376] x20: ffff00000f7a8080 x19: 0000000000000040 x18: 00000000ffffffff
>     [  104.825548] x17: ffff7fff9e7d6000 x16: ffff800082a78000 x15: ffff800102a7b837
>     [  104.832719] x14: 0000000000000000 x13: 0000000000000000 x12: 3031203a65707974
>     [  104.839891] x11: ffff8000819ca758 x10: 0000000000000018 x9 : ffff8000819ca758
>     [  104.847062] x8 : 00000000ffffefff x7 : ffff800081a22758 x6 : 00000000fffff000
>     [  104.854233] x5 : ffff00001fea1588 x4 : 0000000000000000 x3 : 0000000000000027
>     [  104.861404] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000819abd00
>     [  104.868576] Call trace:
>     [  104.871034]  lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch] (P)
>     [  104.877531]  __handle_irq_event_percpu+0xa0/0x4c4
>     [  104.882261]  handle_irq_event+0x4c/0xf8
>     [  104.886117]  handle_level_irq+0xec/0x17c
>     [  104.890064]  handle_irq_desc+0x40/0x58
>     [  104.893831]  generic_handle_domain_irq+0x18/0x24
>     [  104.898467]  lan966x_oic_irq_handler_domain+0x64/0xb0 [irq_lan966x_oic]
>     [  104.905105]  lan966x_oic_irq_handler+0x34/0xb4 [irq_lan966x_oic]
>     [  104.911131]  handle_irq_desc+0x40/0x58
>     [  104.914900]  generic_handle_domain_irq+0x18/0x24
>     [  104.919536]  pci_dev_irq_handler+0x1c/0x30 [lan966x_pci]
>     [  104.924871]  __handle_irq_event_percpu+0xa0/0x4c4
>     [  104.929594]  handle_irq_event+0x4c/0xf8
>     [  104.933449]  handle_level_irq+0xec/0x17c
>     [  104.937394]  handle_irq_desc+0x40/0x58
>     [  104.941162]  generic_handle_domain_irq+0x18/0x24
>     [  104.945797]  advk_pcie_irq_handler+0x160/0x390
>     [  104.950260]  __handle_irq_event_percpu+0xa0/0x4c4
>     [  104.954983]  handle_irq_event+0x4c/0xf8
>     [  104.958839]  handle_fasteoi_irq+0x108/0x20c
>     [  104.963043]  handle_irq_desc+0x40/0x58
>     [  104.966811]  generic_handle_domain_irq+0x18/0x24
>     [  104.971447]  gic_handle_irq+0x4c/0x110
>     [  104.975214]  call_on_irq_stack+0x30/0x48
>     [  104.979156]  do_interrupt_handler+0x80/0x84
>     [  104.983360]  el1_interrupt+0x3c/0x60
>     [  104.986959]  el1h_64_irq_handler+0x18/0x24
>     [  104.991076]  el1h_64_irq+0x6c/0x70
>     [  104.994495]  default_idle_call+0x80/0x138 (P)
>     [  104.998870]  do_idle+0x220/0x290
>     [  105.002121]  cpu_startup_entry+0x34/0x3c
>     [  105.006064]  rest_init+0xf8/0x188
>     [  105.009398]  start_kernel+0x818/0x8ec
>     [  105.013085]  __primary_switched+0x88/0x90
>     [  105.017119] irq event stamp: 60740
>     [  105.020529] hardirqs last  enabled at (60739): [<ffff800080fb37bc>] default_idle_call+0x7c/0x138
>     [  105.029328] hardirqs last disabled at (60740): [<ffff800080fab5c4>] enter_from_kernel_mode+0x10/0x3c
>     [  105.038477] softirqs last  enabled at (60728): [<ffff8000800cb774>] handle_softirqs+0x624/0x63c
>     [  105.047193] softirqs last disabled at (60711): [<ffff8000800102d8>] __do_softirq+0x14/0x20
>     [  105.055471] ---[ end trace 0000000000000000 ]---
>     [  105.060274] ------------[ cut here ]------------
>     [  105.064963] Unexpected error: 64, error_type: 1073741824
>     [  105.070440] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
>     ...
>     [  105.443891] ------------[ cut here ]------------
>     [  105.448536] Unexpected error: 64, error_type: 0
>     [  105.453235] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
>     ...
> 
> And after them my ARM system don't see the answer of a ping command
> replied by my PC (I don't use DHCP with my ARM system).
> 
> I don't know why those traces are not present on my x86 (config, race
> condition, other reason) but anyway, they can help to find some clues
> about what's going on.
> 
> Of course, feel free to ask me some more tests or anything else I can do
> to help on this topic.
> 
> Best regards,
> Hervé

As I remembered, doing rmmod on the lan966x_switch followed by modprobe
lan966x_switch works fine. This is because neither the switch core, nor the FDMA
engine is reset, so they remain in sync.

When the lan966x_pci module is removed and reloaded (what you did), the DT
overlay is re-applied, which causes the reset controller
(reset-microchip-sparx5) to re-probe. During probe, it performs a GCB soft reset
that resets the switch core, but protects the CPU domain from the reset. The
FDMA engine is part of the CPU domain, so it is not reset.

This leaves the switch core in a reset state while the FDMA
retains state from the previous driver instance. When the switch driver
subsequently probes and activates the FDMA channels, the two are out of
sync, and the FDMA immediately reports extraction errors.

Theres actually an FDMA register called NRESET that resets the FDMA controller
state. Calling this in the FDMA init path causes traffic to work correctly on
lan966x_pci reload, but it does not get rid of the FDMA splats you posted above.
They get queued up between the switch core reset, in the reset controller, and
the FDMA enabling. I tried different approaches to drain or flush queues, but
they wont go away entirely.

The only thing that seems to work consistently is to *not* do the soft reset in
the reset controller for the PCI path. The soft reset is actually the problem:
it only resets the switch core while protecting the CPU domain (including FDMA),
causing a desync.

A simple fix could be (in reset-microchip-sparx5.c):

+static bool mchp_reset_is_pci(struct device *dev)
+{
+	for (dev = dev->parent; dev; dev = dev->parent) {
+		if (dev_is_pci(dev))
+			return true;
+	}
+	return false;
+}

-	/* Issue the reset very early, our actual reset callback is a noop. */
-	err = sparx5_switch_reset(ctx);
-	if (err)
-		return err;
+	/* Issue the reset very early, our actual reset callback is a noop.
+	 *
+	 * On the PCI path, skip the reset. The endpoint is already in
+	 * power-on reset state on the first probe. On subsequent probes
+	 * (after driver reload), resetting the switch core while the FDMA
+	 * retains state (CPU domain is protected from the soft reset)
+	 * causes the two to go out of sync, leading to FDMA extraction
+	 * errors.
+	 */
+	if (!mchp_reset_is_pci(&pdev->dev)) {
+		err = sparx5_switch_reset(ctx);
+		if (err)
+			return err;
+	}

Could you test it and see if it helps the problem on your side.

/Daniel

