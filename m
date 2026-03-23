Return-Path: <netdev+bounces-270610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGQgKrZ8wWknTgQAu9opvQ
	(envelope-from <netdev+bounces-270610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:47:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 268382FA682
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B646C31F02A3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D33BE63F;
	Mon, 23 Mar 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCZcTjk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD713B38A4
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283218; cv=none; b=Zfs3VbNdIvOkDWwccxtqaWzHO+j0T9w/yYYqyGsdpi01otNKR78Ku2shEEt3QeTZLgdoizIWU4rbMtXyoOleYBGyxjd6k4/oYxLTokjPNFJKdT/Q5AwrFN8Bk+7a3KRwUIXtXlImFE7MrYKGY7r6PljFuYoBricRFRIou1EJYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283218; c=relaxed/simple;
	bh=ty/hlROjAFutjxKPtIH8wLEeJtfnPct//1rXrPvOkHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ+GQT5OHYJgiFv+kcw1Rmi6gaR07mukYVhvagFAaMaonQFIz+Y6nl0wFoajSInakYS5nGgXlUc8LoGtyqMBsGDAD+m1yEDPOvSUvy0XsYhjEY+kB54AYSiRJv6tUQDbIsJ+l/M4reMxxfWXdX9GxpTkt7gn0HnLkvk6llbs89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCZcTjk/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 36F5CC58081;
	Mon, 23 Mar 2026 16:27:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 453105FEF6;
	Mon, 23 Mar 2026 16:26:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9B0810450EAD;
	Mon, 23 Mar 2026 17:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774283211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+stKljmHE6dTCgbX5k2UqpPQqX57Vm+pSnMuyZYlZpQ=;
	b=fCZcTjk/wuSjmpjaNM1oTCFWL+V/PJbmAIvnbbWg8WmDdUVcGY7EW76MJfu9kVb8wd+d0C
	r6PUNYYghl1s8sFwGHzhRin6rrd8acmae02+75H8g6vJB20DQf9gNQEBXy+n4iYiX3Ppsc
	15jJm5EkzsGOlcU1pjDrLJ007l4nt/+2eGlJDVN0HCfRCvo6/7Yvxyh5/V0xWIp/+gQ4Ce
	RlwbJ3tR6ua93cV0mqVgbAibqUYslYVhsvuAG3bkD4DlOFTdo6azidZIAAEb7BNnUk5HUV
	urDp2yMNxHZJEIlwMavBSn+9pmktK/oV9V9rGdT35v3lVX675FY77nrlSsri3A==
Date: Mon, 23 Mar 2026 17:26:40 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260323172640.2669232d@bootlin.com>
In-Reply-To: <20260323155204.0321db13@bootlin.com>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
	<20260323155204.0321db13@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270610-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 268382FA682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On Mon, 23 Mar 2026 15:52:04 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Daniel,
> 
> On Fri, 20 Mar 2026 16:00:56 +0100
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> > When lan966x operates as a PCIe endpoint, the driver currently uses
> > register-based I/O for frame injection and extraction. This approach is
> > functional but slow, topping out at around 33 Mbps on an Intel x86 host
> > with a lan966x PCIe card.
> > 
> > This series adds FDMA (Frame DMA) support for the PCIe path. When
> > operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> > directly access host memory, so DMA buffers are allocated as contiguous
> > coherent memory and mapped through the PCIe Address Translation Unit
> > (ATU). The ATU provides outbound windows that translate internal FDMA
> > addresses to PCIe bus addresses, allowing the FDMA engine to read and
> > write host memory. Because the ATU requires contiguous address regions,
> > page_pool and normal per-page DMA mappings cannot be used. Instead,
> > frames are transferred using memcpy between the ATU-mapped buffers and
> > the network stack. With this, throughput increases from ~33 Mbps to ~620
> > Mbps for default MTU.
> > 
> > Patches 1-2 prepare the shared FDMA library: patch 1 renames the
> > contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
> > management and coherent DMA allocation with ATU mapping.
> > 
> > Patches 3-5 refactor the lan966x FDMA code to support both platform and
> > PCIe paths: extracting the LLP register write into a helper, exporting
> > shared functions, and introducing an ops dispatch table selected at
> > probe time.
> > 
> > Patch 6 adds the core PCIe FDMA implementation with RX/TX using
> > contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
> > change and XDP support respectively.
> > 
> > Patches 9-10 update the lan966x PCI device tree overlay to extend the
> > cpu register mapping to cover the ATU register space and add the FDMA
> > interrupt.
> >   
> 
> Thanks a lot for the series taking care of DMA and ATU in PCIe variants.
> 
> I have tested the whole series on both my ARM and x86 systems.
> 
> Doing a simple wget on my x86 system, I moved from 3.8MB/s to 11.2MB/s and
> so the improvement is obvious.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> 

Hum, I think I found an issue.

If I remove the lan966x_pci module (modprobe -r lan966x_pci), and reload
it (modprobe lan966x_pci), the board is not working.

The system performs DHCP requests. Those requests are served by my PC (observed
with Wireshark) but the system doesn't see those answers. Indeed, he continues
to perform DHCP requests.

Looks like the lan966x_pci module removal leaves the board in a bad state.

Without the series applied, DHCP request answers from my PC are seen by the
system after any module unloading / reloading.

Do you have any ideas of what could be wrong?

Best regards,
Hervé

