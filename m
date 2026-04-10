Return-Path: <netdev+bounces-277227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MLyGYpu2GkhdQgAu9opvQ
	(envelope-from <netdev+bounces-277227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:29:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 702643D1D22
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4287F300AD62
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1430EF94;
	Fri, 10 Apr 2026 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+Kfy7Jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7D27456;
	Fri, 10 Apr 2026 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791749; cv=none; b=q1EUFedVRlEfqSdJS+wYjIT64RgiOH/s38m2amSLb7Dm3g6j64du7n0/QKi6QQBAYlpUiiGM9hl3C0M5bDOEi606+5jXRc4BA30qk/MBcByCEHaosqAbKkHUz7Dr5Vgz9gzgHVSOntu8IK2NLRxo0Xj6pQ7J8LQ40eN/zf9lazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791749; c=relaxed/simple;
	bh=JZWPCOCn5ZB6ZRHoBFr+6SNX8egFtHmA/GvbYFuhs1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+8CKw2iQ1KLHM4ucWTqkl4z+mlmBldHgQLlqLyaT0jPmpIENqjSVyIUK0C+C371/XZJ+BfSqtNzUVYT4q+YvMbj0L/tFHsJolQvT3KCfCT3j9aY/9xe7wEIeuWvufLEH2UM3OOcDlhLLtLZ7pZ6v9SfbUgf31BWMiAnYE/xVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+Kfy7Jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1092EC19421;
	Fri, 10 Apr 2026 03:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775791748;
	bh=JZWPCOCn5ZB6ZRHoBFr+6SNX8egFtHmA/GvbYFuhs1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n+Kfy7JxUW0NFF/PVO8ZJLFkD3iia0VOir8Yg0Aqkm0SyGPrQtlI/CvE0hlz9RRnt
	 RulRBfc3pVfcNcerdnsWhISHiRSuHBvXlg73VeWoHyuoSUY+lFa6mpMQrkcFonmePs
	 LcSehafR0Li5ANEJsFpHLF5jkKsgKkWAK6MpARFdyePWAQn56rFQcu9EYZJRGwNL11
	 VTHku3eBpFsmirElqBvGIKs8dpBnXp08mYVEX1OCgFpw2j/wzMpbUIZn6enJsUcg7N
	 JjNGRrDMVEgSLtjwLcMLFrpnsq7HeIElSovl9Qn6D91f4tlIF+TMzgA8BU3kDTprnA
	 4Vrj9nGBI9PDA==
Date: Thu, 9 Apr 2026 20:29:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [net-next v38] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20260409202907.7186912c@kernel.org>
In-Reply-To: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
References: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 702643D1D22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun,  5 Apr 2026 14:07:40 -0400 Adam Young wrote:
> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
> +	if (rc < 0) {
> +		//Remove the header in case it gets sent again

space after //

> +		skb_pull(skb, sizeof(*pcc_header));
> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct sk_buff *skb = mssg;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
> +	outbox = &mctp_pcc_ndev->outbox;
> +
> +	if (!skb)
> +		return;

Is this really ever called with a NULL pointer?

> +	if (skb->len > outbox->chan->shmem_size) {
> +		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
> +}

> +static int mctp_pcc_ndo_open(struct net_device *ndev)

dont say ndo in function names

> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox, *inbox;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	inbox = &mctp_pcc_ndev->inbox;
> +
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +
> +	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
> +	if (IS_ERR(inbox->chan)) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return PTR_ERR(inbox->chan);
> +	}
> +	return 0;

> +static int initialize_MTU(struct net_device *ndev)

don't use capital letter in function names for no good reason

> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct pcc_mbox_chan *pchan;
> +	int mctp_pcc_max_mtu;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	outbox = &mctp_pcc_ndev->outbox;
> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(pchan))
> +		return -1;

why not return PTR_ERR(pchan) ?

> +	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
> +		pcc_mbox_free_channel(pchan);
> +		return -1;

EINVAL


We are about to close for the merge window please wait until.. Apr 27th
I think with the next version.
> +	}

