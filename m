Return-Path: <netdev+bounces-280431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBaCI3rU6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68E447006
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7F6D3011C7B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B983EBF16;
	Wed, 22 Apr 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VUtuRdGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8743EBF01;
	Wed, 22 Apr 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866420; cv=none; b=eLda/QqKeEngM1SGu+2JhYDNN8V/2Zn8maJmtKY3NfP0mbx4GSSMyawN/1xbxd9nuSrqwuQIuAZ1ITNjkLlSSkhCIT+ebpA59fBS2PFkx3D1C3cAxr+BmZ8OhnBW9I+wdm0SIBtW7Rc7xpKgQ2jRVwIeGAx3kkltuZ5eyOFqa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866420; c=relaxed/simple;
	bh=gdL64+Qt/cF/o5cbMQ4KeBp1KMIjmyyoQ7x0SORSRds=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=n6Yj6FpPfi/MjZIbJ1Xqkk8hUZMxTKiAgggSG3RTJvlrvM3JfPEG16Uch+1qLeEdmkyN++fLIEopD9fqA1GSKRaCKKdblQWfjkuNrtJnvwOqTVobdVHOPgrhYdCsFDsG9rvjOpCdjSQC7pzB9/Y9KA8C7NmE1+ohoq8uOA+ny+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VUtuRdGl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 38424C5C9BF;
	Wed, 22 Apr 2026 14:00:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58B455FA8F;
	Wed, 22 Apr 2026 14:00:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C6DA10460ABF;
	Wed, 22 Apr 2026 16:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776866408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w6JMDY2tstBcjczR0i0ETmZM5aZhcEJ4CRFQ90Ng9Xs=;
	b=VUtuRdGl8zd2mj7hELaN2albsclKHC4LLW0o1AyZw1rEiHmHF7fu0COGt6b5HzHhFwyjGe
	sm/CdksQXUd7cjEKBHvqezxOoxFsCUqmu6OTzWhPmgKsC1Q/qcgqqYe4Z55Z3LNBOQF61R
	iGPLTBUes59k50AmSdd2yUyVSnsBbqCnX9wcdT7pirMZOwso7LgPk4VS2CfXh0EcloYNRW
	q+Lb1oP7qQWLZgqioU/cSZDSzM/yeb+RArmyirjm+hsuOpKXNUT39x4v/LZT1pXlW/mVOb
	xyShYKsGRFP3iWOIwqFk6Hb3E7HP2VFl2rH1p9SufOGM8+osTeVGVkjQpJA1Qg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 16:00:02 +0200
Message-Id: <DHZQKKGKWDKE.DZ2HM54VPBT6@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 13/14] net: macb: use context swapping in
 .set_ringparam()
Cc: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <pvalerio@redhat.com>, <conor@kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>, <maxime.chevallier@bootlin.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
 <20260414005654.3766959-1-kuba@kernel.org>
In-Reply-To: <20260414005654.3766959-1-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280431-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: 2A68E447006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 14, 2026 at 2:56 AM CEST, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: macb: use context swapping in .set_ringparam()
>
> This patch modifies the ethtool set_ringparam implementation to use a
> context swapping mechanism. Instead of closing and reopening the interfac=
e,
> it allocates new buffers, stops the interface temporarily, swaps the acti=
ve
> context, and then frees the old one.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 3deab87c565b5..d1536cb1e40bb 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3081,6 +3081,89 @@ static void macb_configure_dma(struct macb *bp)
> [ ... ]
>> +static void macb_context_swap_start(struct macb *bp)
>> +{
> [ ... ]
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		napi_disable(&queue->napi_rx);
>> +		napi_disable(&queue->napi_tx);
>
> This isn't a regression from this patch, but does calling napi_disable()
> unconditionally crash on EMAC devices?
>
> EMAC devices appear to not initialize NAPI, which leaves the NAPI struct
> zero-initialized (n->dev is NULL), potentially causing a NULL pointer
> dereference in napi_disable(). Additionally, does this path also blindly
> call bp->macbgem_ops.mog_init_rings() which is NULL on EMAC?

So the LLM is correct in that queue->napi_{rx,tx} fields are never
initialised on at91 platforms [0]. Then we use the fields from many
places without checking.

Most are safe because at91 uses its own netdev_ops.
Functions that get called on at91 and do NAPI calls are:
 - macb_suspend() & macb_resume() =3D> system-wide suspend =3D> ignored
 - macb_{close,open}() called by macb_set_ringparam()

The codepaths for at91 are so different, context swap support for at91
sounds unrelevant. I'll update both change_mtu and set_ringparam to
return -EOPNOTSUPP if netif_running() && IS_EMAC.

[0]: NAPI fields are initialised in macb_init_dflt() which is either
     used as the default config->init() or called by some of those init
     functions. at91ether_init() doesn't.

>
>> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
>> +		cancel_work_sync(&queue->tx_error_task);
>> +	}
> [ ... ]
>> +static void macb_context_swap_end(struct macb *bp,
>> +				  struct macb_context *new_ctx)
>> +{
> [ ... ]
>> +	/* Swap contexts & give buffer pointers to HW. */
>> +
>> +	old_ctx =3D bp->ctx;
>> +	bp->ctx =3D new_ctx;
>> +	macb_init_buffers(bp);
>
> Since the new context swap doesn't call phylink_stop(), could a concurren=
t
> macb_mac_link_up() execution set the RE and TE bits in NCR during the win=
dow
> where bp->lock is dropped?
>
> If so, macb_init_buffers() would write new DMA ring base addresses to RBQ=
P
> and TBQP while the MAC is actively enabled, which violates hardware
> specifications and could cause DMA corruption.

Again this is correct. We can have a race inbetween the swap and phylink
callbacks. However running phylink_stop() would partially ruin the idea
behind context swapping.

bp->lock is not the solution. We need either to disable phylink
operations for the swap duration or to synchronise with them. We cannot
grab bp->lock for the whole swap timespan because some calls might want
to sleep.

Both .mac_link_{up,down}() get called by phylink_resolve() which
acquires phydev->mutex [1]. Getting this mutex for the swap operation
sounds like the solution. PHY status updates will be delayed until the
end of our context swap operation (or the opposite).

Accessible from bp->netdev->phydev->lock. A few drivers already grab
that lock, but no one is for context swapping. Looked at fbnic for
example and there is no sync inbetween phylink ops and set_ringparam.
See fbnic_set_ringparam(), fbnic_phylink_mac_link_down
(), fbnic_mac_link_down_asic(). Maybe the sequence has been crafted to
work fine with concurrent accesses?

=E2=9F=A9 git grep -l 'mutex_lock.*phydev' drivers/net/ethernet/
drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
drivers/net/ethernet/broadcom/genet/bcmmii.c
drivers/net/ethernet/cadence/macb_main.c
drivers/net/ethernet/faraday/ftgmac100.c
drivers/net/ethernet/realtek/r8169_main.c
drivers/net/ethernet/ti/icssg/icssg_prueth.c

[1]: https://elixir.bootlin.com/linux/v7.0/source/drivers/net/phy/phylink.c=
#L1620

>> +	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
>> +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues;
>> +		     ++q, ++queue) {
>> +			queue_writel(queue, IER,
>> +				     bp->rx_intr_mask |
>> +				     MACB_TX_INT_FLAGS |
>> +				     MACB_BIT(HRESP));
>> +		}
>> +	}
>
> Hardware interrupts are disabled unconditionally for all devices in
> macb_context_swap_start() by writing -1 to IDR.
>
> Will this explicit check prevent EMAC devices from having their interrupt=
s
> re-enabled?
>
> Since EMAC devices do not use NAPI and rely on hardware interrupts, leavi=
ng
> them masked might silently halt all network traffic after a ring paramete=
r
> change.

The check will be dropped. As said above, context swapping won't support
at91 platforms.

>> +	ctrl =3D macb_readl(bp, NCR);
>> +	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
>
> Can this unprotected read-modify-write of the NCR register race with phyl=
ink
> state changes?
>
> If an asynchronous phylink callback like macb_mac_config() modifies NCR
> while holding bp->lock, this unlocked write could overwrite and drop thos=
e
> concurrent updates.

The phydev->lock will help here as well.

macb_mac_config() =3D=3D phylink_mac_ops::mac_config()
<- phylink_mac_config()
<- phylink_major_config()
<- phylink_resolve() (OR phylink_mac_initial_config())
   both grab phydev->lock

>
>> +
>> +	netif_tx_start_all_queues(bp->netdev);
>> +
>> +	/* Free old context. */
>> +
>> +	macb_free_consistent(old_ctx);
>
> This isn't a regression from this patch, but does this context swap leak
> pending TX packets and their DMA mappings?
>
> When freeing the old context, macb_free_consistent() appears to only free
> the pointer array. If it doesn't iterate from txq->tail to txq->head to
> unmap the active DMA mappings and free the sk_buff structs, repeatedly
> modifying ring parameters could cause a memory and DMA mapping leak.

Yes it does. I already have a patch pending. This bug has been present
since forever. :-)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


