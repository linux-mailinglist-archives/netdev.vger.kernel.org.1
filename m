Return-Path: <netdev+bounces-291004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIjNIF4JEWrvggYAu9opvQ
	(envelope-from <netdev+bounces-291004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07085BC6A8
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9877C30115AF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB8125DB1A;
	Sat, 23 May 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcWPDC9R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759C5FDA7;
	Sat, 23 May 2026 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501400; cv=none; b=cZNlO8C6jzzKVPGjWMU8/4gH7XGwRWADIIjzRYvwqmpiDDSFdzubBUXObpN3BXlHNaxUwoJgvVAptM6Js2sUkrlYCTvvvoNwSud+oVN1bLbuD2uibW54ipjqcda4Pk5+ZfCilg+33WSfBHG2BvJ9sZm84Vw9Org+AAguqV54iDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501400; c=relaxed/simple;
	bh=Vku50cmNoVYTqyXxZqyXTKIjkY9zNQPNwKGSt43kzSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULc+2e9DiIbyR4XAAzhhHGRsFwAAl1HaLNA4oIVsG08vHVVdupPwIxJmIEebpdPun7wvAwywWEz1IS2CpOz/nBKKv40/UCiX/VFVnkMcnyM1kCdcvmx0fFkbIdkHk/ozzKR7m1b6oQr8kRUmSxXc8x7m+2UaO6iys25DHxdx3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcWPDC9R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658171F000E9;
	Sat, 23 May 2026 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779501399;
	bh=3DOM+ISKNcSFebVAP5pIedBdmbNcMKzy4d24GOB2ZIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QcWPDC9RCLoP/1403KuaJs8HJLSSIQ4DsF8kskuKSuxiVm2hBB7Mr4nSSfG16QVTk
	 852ys8TA1iix9fyxX1jaiJo9vTE3wKe6OeKvEEqxZft71sq2QuCACpfJKeuig03E8R
	 8K7ikSqJWfGYNYGFvBum3ZTZw1QGmdyRgBUXnIIeeAGLBz6XkhxgO9uKCTN9X0CWFD
	 ZWeyFr4BFYoqzt0oxV+0bNmK9DKQmC3R2K2/ZAdo5iQQdJrplySB9TNvJjUwLuz43V
	 a2dGN9eefqE8Iyn+9PmzrWL8GAjIj1bHhhW9Hf+ZTXvOy4qUzvioOdXqnNhgyfjbQR
	 nY5lbQspCV/MA==
Date: Fri, 22 May 2026 18:56:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Steen
 Hegelund <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
 "Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Herve Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 09/13] net: lan966x: add PCIe FDMA support
Message-ID: <20260522185637.1fe72213@kernel.org>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
	<20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E07085BC6A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 10:12:21 +0200 Daniel Machon wrote:
> Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
> DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
> transfer instead of per-page DMA mappings.
> 
> With PCIe FDMA, throughput increases from ~33 Mbps (register-based I/O)
> to ~620 Mbps on an Intel x86 host with a lan966x PCIe card.

> diff --git a/drivers/net/ethernet/microchip/lan966x/Makefile b/drivers/net/ethernet/microchip/lan966x/Makefile
> index 4cdbe263502c..ac0beceb2a0d 100644
> --- a/drivers/net/ethernet/microchip/lan966x/Makefile
> +++ b/drivers/net/ethernet/microchip/lan966x/Makefile
> @@ -18,6 +18,10 @@ lan966x-switch-objs  := lan966x_main.o lan966x_phylink.o lan966x_port.o \
>  lan966x-switch-$(CONFIG_LAN966X_DCB) += lan966x_dcb.o
>  lan966x-switch-$(CONFIG_DEBUG_FS) += lan966x_vcap_debugfs.o
>  
> +ifdef CONFIG_MCHP_LAN966X_PCI

ifeq ()

would be more common in a Makefile?

> +lan966x-switch-y += lan966x_fdma_pci.o
> +endif
> +

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index cc3c7b6c65ae..7036b1d937d5 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -7,6 +7,7 @@
>  #include <linux/ip.h>
>  #include <linux/of.h>
>  #include <linux/of_net.h>
> +#include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> @@ -49,6 +50,9 @@ struct lan966x_main_io_resource {
>  static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
>  	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
>  	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)

why config option being enabled changes the targets?
Can someone with a non-PCI device enable that option too
(sure it would be useless but given that/if they can guarding
with an #if seems like a waste of LoC)

> +	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */
> +#endif
>  	{ TARGET_ORG,                         0, 1 }, /* 0xe2000000 */
>  	{ TARGET_GCB,                    0x4000, 1 }, /* 0xe2004000 */
>  	{ TARGET_QS,                     0x8000, 1 }, /* 0xe2008000 */
> @@ -1100,6 +1104,13 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
>  
>  static const struct lan966x_fdma_ops *lan966x_get_fdma_ops(struct device *dev)
>  {
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +	for (struct device *p = dev->parent; p; p = p->parent) {
> +		if (dev_is_pci(p))

If the PCIe devices also use an intermediate platform device for
probing, can't they explicitly have some flag / state to indicate
they are PCIe? The device walk in such a constrained env seems
like an overkill

> +			return &lan966x_fdma_pci_ops;
> +	}
> +#endif
> +
>  	return &lan966x_fdma_ops;
>  }
>  
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 5f4dbeda17cd..e7fdd4447fb6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> @@ -17,6 +17,9 @@
>  #include <net/xdp.h>
>  
>  #include <fdma_api.h>
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +#include <fdma_pci.h>
> +#endif

Conditional #includes make build testing harder, better to avoid them

>  #include <vcap_api.h>
>  #include <vcap_api_client.h>
>  
> @@ -288,6 +291,10 @@ struct lan966x {
>  
>  	void __iomem *regs[NUM_TARGETS];
>  
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +	struct fdma_pci_atu atu;
> +#endif
> +
>  	int shared_queue_sz;
>  
>  	u8 base_mac[ETH_ALEN];
> @@ -586,6 +593,10 @@ void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
>  int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
>  int lan966x_qsys_sw_status(struct lan966x *lan966x);
>  
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
> +#endif

There should be no need to wrap extern in an #if

