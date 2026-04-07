Return-Path: <netdev+bounces-275830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHV9IOBn1GnptgcAu9opvQ
	(envelope-from <netdev+bounces-275830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C742F3A8E8D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E994C3060AFE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE12882CD;
	Tue,  7 Apr 2026 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0kvEK4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA717283C9D;
	Tue,  7 Apr 2026 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527807; cv=none; b=akAed4MCUz8t3MbHOb2PmqZT/ZWx5j7aSD7kfQVlhGcRE5L6jZ7Nk22RK3VGbkShfxanVD7ltMt3jlQb3TTs7Jn2u8sUQKHdUxEcOIbKGKjZ5M8rCeZ4WfT/LcyW5N8PjaOCwRgXfB99cQmgCP8q+gxvUWRvAZEVY2SO0JMbgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527807; c=relaxed/simple;
	bh=/bV+bTTfPhODyuYodpZsbu0E+ohIbVKUHn1OOkkT/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk/sW7J534viyjUqZuey3mfb7yRM/qIjxSO47z4PaV2+ai8SyZj5lTt+uTYf9jl03fvXORDq/DUs37m38wDZT57/5mPF4p9dOfEPdc5vNN26nUB3Bw0LEkeaodJOHU5hYbZiGh52WaaCL7Nrw2/mO/sRjAzCD+ICUfMcpOKE5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0kvEK4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD7EC2BCAF;
	Tue,  7 Apr 2026 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527807;
	bh=/bV+bTTfPhODyuYodpZsbu0E+ohIbVKUHn1OOkkT/gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0kvEK4WdPguBs68FdUXumtOEYMcAARWdKr5U9iHRFFYdhHvbwdHcBhp+l/h6qAuC
	 n/M06MPGTRWbTxt+BiTqZDCiPXOc7l7Gj2QkcFZACW4PuO/SzRqjpHzzjjXeTIS1or
	 Rl8un6WwuDy8hcdeKI9J5bJ8R5vcgKBW7dLgW62MAasDUgxMn3Gamf0OKuHA+/deXe
	 Nyn1dYZgYlrfYEhU3d0X7o/FQ4b9d41mEPJ8ABZKfFHVqOi7Hs7+GcFTLjxy0kBG+t
	 088imVURnvi+0tCIo5SBq3diHslVrb7nqhmsFwmjGfbGQ0h9moqybpKh/HS8two8F8
	 4af+y58m0ms7w==
From: Jakub Kicinski <kuba@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 4/4] net: stmmac: Add BCM8958x driver to build system
Date: Mon,  6 Apr 2026 19:10:04 -0700
Message-ID: <20260407021004.3674655-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,foss.st.com,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-275830-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C742F3A8E8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: Add BCM8958x driver to build system

This commit adds the PCI driver for the Broadcom BCM8958x to the Linux build
system. It enables the configuration option and updates the MAINTAINERS file.

While reviewing this patch, I noticed a potential regression introduced in the
previous patch of the series (net: stmmac: Add PCI glue driver for BCM8958x)
that is enabled here.

The driver defines a global static array of software nodes (brcm_swnodes)
and registers it in brcm_drv_init() using software_node_register_node_group().

Since PCI drivers must support multiple device instances concurrently, what
happens if there are multiple BCM8958x PCI devices present?

If the second instance's probe attempts to register the exact same software
node pointers, software_node_register() will return -EEXIST. The failure
path in software_node_register_node_group() then unconditionally unregisters
all nodes in the group.

Could this unregister the software nodes that the first probed device
successfully registered and is actively using, leaving the first device with
dangling fwnode pointers and leading to a use-after-free? Would it be safer
to dynamically allocate the software nodes per device instance?

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index dc55aec915a27..a1e39f65cd42e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -51,4 +51,5 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>  obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>  obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
>  obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
> +obj-$(CONFIG_DWMAC_BRCM)       += dwmac-brcm.o

This isn't a bug, but it looks like spaces are used here for alignment instead
of a tab. The surrounding entries all use a tab character before the
assignment operator.

