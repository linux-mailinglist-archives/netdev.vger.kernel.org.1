Return-Path: <netdev+bounces-274499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cADXA5BYzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B623889A0
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07393305F299
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79C36921C;
	Thu,  2 Apr 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ETAGn2VG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C03CCFAE;
	Thu,  2 Apr 2026 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129749; cv=none; b=hP4pU0xioMTXVVXf4w1391oHK7xM7jqs/ICUityrXE8/Hu3v3kpoml1M5eq0XQmEmMBZtMHuFOlwwLYY7yksegdzj9PGOo3io2MT/nq88gklISsJl0wqmfwizS1SXOiaAbGVlqJAZviTNcrpLzY/hxKS4fi6PeJfCEx66Jh2zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129749; c=relaxed/simple;
	bh=DDcpPxNStIKhIOddN8K9dB6cJ3YY5lGjbE25N3Iu3XM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YS+COqG5Dvr8BFsi3cQKRS6f6D220aTrkMsQgmBKmD0Mv5X3CGEq9ZkEUE/D0zSqHOesRUWn/d//vscMAcZU+ud9CQTCelSMYKmXiZqUY9SlO1IdFwLO6qBdNepAjdq+ta2TtOfXAfcPnQWZqauxw5QQrFRuPKrSd/JvA1ahoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ETAGn2VG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37848A5889;
	Thu,  2 Apr 2026 13:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775129738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KC1FZpvBCsFRD+ZZsA1/QCAOrkb0VRBzQzjA60MBHPM=;
	b=ETAGn2VGHKTlOvxUNI+DlLDU3qW+DRxCyTCUUpDTIObVk92IXg7GpbCULFxxYz3D/TYM/t
	LtOViG4Akg8vf/GQhpOW41Hv3Q9a3U71/k5VNhspHO3Pg59Y/Ed2v5RzYCl5n8cnqTwGnk
	iYCTI6oMBfgX4Nx4qJSOiyMgI8Mpvz8A8VspSylPzLflosYPvclh8s5DmVPWHfit9Ki50v
	zs7S6CdbxipMqulO7el4a4PxHPxqk/GrH5uTkQsSuoSR4JbVpbewQBWOFdsOH6n7xZ+idh
	qYmTZF1R7oC0Nl9rHfY5m72qdwT22bJbktzI7PaNq/zJBghbZbkvj0+m386uSQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 13:35:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/11] net: macb: implement context swapping
In-Reply-To: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
Message-ID: <f399076d1791d9df325f967e50184c2e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274499-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12B623889A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:39, Théo Lebrun wrote:
> MACB has a pretty primitive approach to buffer management. They are all
> stored in `struct macb *bp`. On operations that require buffer realloc
> (set_ringparam & change_mtu ATM), the only option is to close the
> interface, change our global state and re-open the interface.
> 
> Two issues:
> - It doesn't fly on memory pressured systems; we free our precious
>   buffers and don't manage to reallocate fully, meaning our machine
>   just lost its network access.
> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
> 
> Instead, we shall:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass newly allocated buffer pointers to the hardware
>  - start interface
>  - free old context
> 
> This is what we implement here. Both .set_ringparam() and
> .ndo_change_mtu() are covered by this series. In the future,
> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.

Thanks for your work, the context swapping approach probably
makes a lot of sense and will finally bring proper MTU change
support that I tried to patch earlier.

> 
> The change is super intrusive so conflicts will be major. Sorry!
> 
> Thanks,
> Have a nice day,
> Théo
> 
> [0]: 
> https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
> [1]: 
> https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
> [2]: 
> https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> Théo Lebrun (11):
>       net: macb: unify device pointer naming convention
>       net: macb: unify `struct macb *` naming convention
>       net: macb: unify queue index variable naming convention and types
>       net: macb: enforce reverse christmas tree (RCT) convention
>       net: macb: allocate tieoff descriptor once across device lifetime
>       net: macb: introduce macb_context struct for buffer management
>       net: macb: avoid macb_init_rx_buffer_size() modifying state
>       net: macb: make `struct macb` subset reachable from macb_context 
> struct
>       net: macb: introduce macb_context_alloc() helper
>       net: macb: use context swapping in .set_ringparam()
>       net: macb: use context swapping in .ndo_change_mtu()
> 
>  drivers/net/ethernet/cadence/macb.h      |  119 +-
>  drivers/net/ethernet/cadence/macb_main.c | 1731 
> +++++++++++++++++-------------
>  drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
>  drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
>  4 files changed, 1090 insertions(+), 832 deletions(-)
> ---
> base-commit: 321d1ee521de1362c22adadbc0ce066050a17783

The series didn't apply cleanly on current net-next. The
base commit 321d1ee521de doesn't seem to be upstream yet, is
this based on your set_channels v4 series?

> change-id: 20260401-macb-context-bd0caf20414d
> 
> Best regards,
> --
> Théo Lebrun <theo.lebrun@bootlin.com>

Thanks
Nicolai

