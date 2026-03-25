Return-Path: <netdev+bounces-271463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLZ+BNKhw2lssQQAu9opvQ
	(envelope-from <netdev+bounces-271463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9F321A4B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 032F0302B75A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D139B95C;
	Wed, 25 Mar 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eG92Zk38"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD927E05E;
	Wed, 25 Mar 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428604; cv=none; b=mOR/np1vdeof5HHe2Oth27LXqaQoXNU5IWxny757CSCfLghwn7bXWFOdpIPCQPPif2OHjoGrIvwXqW79isdcgnMv8Kgb/suJPn+EryhdgAUCHJ7K5YIKgkVbL3kVm2dozuxQK/O2+frlJdxwhERXD5owy6E3xa3xma4JdKBtN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428604; c=relaxed/simple;
	bh=bQ+CJQDwbZW3Oi7e9RlQbLka0OhY6yoNqsgqQHob88w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGFWQ5SAjduBU1In97WxUcIYMm+PWq88u4NBStpowLGDkrTg5lEGHDVvo0UEoIAWAfw9Yz63UC2e+nJne00CKjai22UXXZgWqFP8JvL96zqbCHai97LS/lf7nU4qsNh7Y+XipfbDL/iKR5fdwTYb7YgWuuTEifdvm3qdIepaizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eG92Zk38; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774428592;
	bh=bQ+CJQDwbZW3Oi7e9RlQbLka0OhY6yoNqsgqQHob88w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eG92Zk38pbK9DxyhO41Ir2kizPaFRKfDet/UzSAjpAZ+ZutyQAS4ZoCv93AjQgkSS
	 GPxRYNbxp4Hw0tp6cckNvktc1J2y9aRxj7xZrR84m+nJYKfE3WdswKWVS9LzLwzClb
	 Z/5QHavT/b9MA71vjcBInq3CVjFoJG9LFYhJLXE9v/C4DQVz/ZtbhWTGV21cYzVjr5
	 zrciau+7dQju0imAcO/eKZLFjP4wlB1usUEvlBEuUJuBHBPwi+Vd4zg9UYyh17kQJG
	 i+mhbZNV033HsgcLZldUQZEZvzgkyNduNxPO2WUrJocZsxDgOBqGRctF2Gi/cCft7j
	 5/yCRRQHxgdvQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6F6CF6452E;
	Wed, 25 Mar 2026 16:49:51 +0800 (AWST)
Message-ID: <91e228ea442ed3d0726ceb4d2b5a962f570e0805.camel@codeconstruct.com.au>
Subject: Re: [net-next v35 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@os.amperecomputing.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Wed, 25 Mar 2026 16:49:51 +0800
In-Reply-To: <20260324211235.938599-2-admiyo@os.amperecomputing.com>
References: <20260324211235.938599-1-admiyo@os.amperecomputing.com>
	 <20260324211235.938599-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271463-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78D9F321A4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

Only a couple of minor things inline, but overall: now that you have a
one-patch series, you may drop the 0/1 cover-letter. The content of that
will be dropped anyway - I think what you have in 1/1 here is
comprehensive.

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..f8d620795349
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024-2026, Ampere Computing LLC
> + *
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_=
1.0.0WIP50.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hrtimer.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/skbuff.h>
> +#include <linux/string.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <acpi/pcc.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +
> +#define MCTP_SIGNATURE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "MCTP"
> +#define MCTP_SIGNATURE_LENGTH=C2=A0=C2=A0 (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_MIN_MTU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 68
> +#define PCC_DWORD_TYPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0c
> +
> +struct mctp_pcc_mailbox {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 index;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pcc_mbox_chan *chan;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *ndev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_device *acpi_devic=
e;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_mailbox inbox;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_mailbox outbox=
;
> +};
> +
> +/**
> + * mbox_write_to_buffer - copy the contents of the data
> + * pointer to the shared buffer.=C2=A0 Confirms that the command
> + * flag has been set prior to writing.=C2=A0 Data should be a
> + * properly formatted extended data buffer.
> + * pcc_mbox_write_to_buffer
> + * @pchan: channel
> + * @len: Length of the overall buffer passed in, including the
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Entire header. The length value i=
n the shared buffer header
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Will be calculated from len.
> + * @data: Client specific data to be written to the shared buffer.
> + * Return: number of bytes written to the buffer.
> + */
> +static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, vo=
id *data)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_pcct_ext_pcc_share=
d_memory *pcc_header =3D data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The PCC header length inclu=
des the command field
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * but not the other values fr=
om the header.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc_header->length =3D len - s=
izeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);

Minor, but you're using two different calculations for this: here,
and in rx_callback(), where you use sizeof(pcc_header.command) instead
of sizeof(u32), and have swapped the order.

However, it's a bit odd that you're setting ->length here anyway, as
you seem to have already done so earlier mctp_pcc_tx, but there using a
(third, different) calculation?

Perhaps just set up all pcc_header fields in mctp_pcc_tx, rather than
casting skb->data back to a pcc header, then re-setting fields in that.

With that changed, you may not need a helper for this at all, as it's
just doing the length check and the memcpy_toio().

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len > pchan->shmem_size)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_toio(pchan->shmem,=C2=
=A0 data, len);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return len;
> +}
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *ms=
sg)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_pcct_ext_pcc_share=
d_memory pcc_header;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_ndev *mctp_pcc=
_ndev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_mailbox *inbox=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_skb_cb *cb;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sk_buff *skb;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int size;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_ndev =3D container_of=
(cl, struct mctp_pcc_ndev, inbox.client);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inbox =3D &mctp_pcc_ndev->inbo=
x;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_fromio(&pcc_header, inb=
ox->chan->shmem, sizeof(pcc_header));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size =3D pcc_header.length - s=
izeof(pcc_header.command) + sizeof(pcc_header);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size <=3D sizeof(pcc_heade=
r)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

This condition (size <=3D sizeof(pcc_header)) reads a bit strangely given
that you have just *added* a sizeof(pcc_header) one line up.

The only way this path is taken is if you end up underflowing `size`,
before adding the pcc_header size back on, which seems awkward. I would
suggest checking the raw value of pcc_header.length, do the drop if that
fails, *then* adjust for the header/command sizes.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (memcmp(&pcc_header.command=
, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) !=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size > mctp_pcc_ndev->ndev=
->mtu)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");

We only got half way through the discussion on this, my bad. In that,
you mentioned:

> They get dropped by the MCTP layer in the Kernel, apparently, so the
> dev-dbg is to help someone debug why.

... which isn't the case. We're fine to receive packets larger than the
MTU. It's a MTU, not a MRU :)

Your driver is still fine to impose a limit if suitable, but you're not
constrained by the MCTP core here.

Cheers,


Jeremy

