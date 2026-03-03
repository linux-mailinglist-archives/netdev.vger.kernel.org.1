Return-Path: <netdev+bounces-262990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAekK6NEpmlyNQAAu9opvQ
	(envelope-from <netdev+bounces-262990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F81E7EDB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34CC3076B7F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993243750BC;
	Tue,  3 Mar 2026 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwpnMPRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7C1D8E01;
	Tue,  3 Mar 2026 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504129; cv=none; b=H7IdoN7wwFN6yhTXk3mYSNJma2pp+FiciOWGAPz5k9PdKfc/dWnmmnCww4eSi+E9kzLBwAkNCkz6X5xttci95uYEDE+IJaniuKa/0+1RssyziG7ZUjoK/yY7CQ8eDv/Lcf1Dv3GFrP0kO+sc56Q/wWI9ApibGLdSbb6C13bPLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504129; c=relaxed/simple;
	bh=layB5LA8+dcyOKxj045Y7HQN8iCgxk4lNYJcu+E3XBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWTxQrG/kdKZF4y7qfq1P088FYQvTKNZhWdGehCwUpTb8XfAOkYEA+T0Mr1ZuqGbgX/2+igs5FRn5/dsHL6LoxceLRI9mhwcynglq9TrzxAz1nDk/+u1PBSjyNh8gFJ/AINpmoR+Vatju0+YYC1JR0zMq+uoZp8/Wea4rvHr63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwpnMPRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7967C19423;
	Tue,  3 Mar 2026 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772504129;
	bh=layB5LA8+dcyOKxj045Y7HQN8iCgxk4lNYJcu+E3XBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwpnMPRYH1YQrjDi/qBkJve3mS9BZzHSB71Ms+NCI1dM59BSJ+HuSHaFAQX3Mtbp6
	 B74ByMBUHqQhWZZDg0hhu1YMebrg9F7B2Ny3oggpZ1aP2Xq3ltuBoNSvz4iLfkTb1z
	 JnhlofmLLlEwy0ySet8RtHe397dRbRnMIEvoh6f6MnaT6wnHJwBcliDRs+8I4ok5or
	 7KXUrfA0rpRXPm1CqZkFf6xSZa+nvOKEaQuY3AeZTRYURE7sl+WQw4Vsr3TaL6gn6h
	 KZHeb5pt3+hbqZMTpObCwSsCs7z0hm2fU+Mkv+6smf3jRRqQi0OSxPBiLpKcKXs89B
	 Lu+apYgDjpzng==
Date: Mon, 2 Mar 2026 18:15:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 linux-kernel@vger.kernel.org, theo.lebrun@bootlin.com, phil@raspberrypi.com
Subject: Re: [PATCH net-next v5 2/5] net: cadence: macb: implement EEE TX
 LPI support
Message-ID: <20260302181522.068f4715@kernel.org>
In-Reply-To: <20260227150610.242215-3-nb@tipi-net.de>
References: <20260227150610.242215-1-nb@tipi-net.de>
	<20260227150610.242215-3-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 195F81E7EDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262990-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 16:06:07 +0100 Nicolai Buchwitz wrote:
> +static bool macb_tx_lpi_set(struct macb *bp, bool enable)
> +{
> +	unsigned long flags;
> +	u32 old, ncr;
> +
> +	spin_lock_irqsave(&bp->lock, flags);

we should optimize this function for the past path caller.
xmit path does:

+	macb_tx_lpi_wake(bp);
+
 	spin_lock(&bp->lock);

So it immediately takes that lock again, can we move the lpi_wake()
call under the spin_lock, and make sure other callers also take that
lock? I think you can add a lockdep assert to make sure spin lock is
held

> +	ncr = macb_readl(bp, NCR);
> +	old = ncr;
> +	if (enable)
> +		ncr |= GEM_BIT(TXLPIEN);
> +	else
> +		ncr &= ~GEM_BIT(TXLPIEN);
> +	if (old != ncr)
> +		macb_writel(bp, NCR, ncr);
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return old != ncr;
> +}
> +
> +static bool macb_tx_all_queues_idle(struct macb *bp)
> +{
> +	unsigned int q;
> +
> +	for (q = 0; q < bp->num_queues; q++) {
> +		struct macb_queue *queue = &bp->queues[q];
> +
> +		if (queue->tx_head != queue->tx_tail)

Does not not need tx_ptr_lock technically?

> +			return false;
> +	}
> +	return true;
> +}
> +
> +static void macb_tx_lpi_work_fn(struct work_struct *work)
> +{
> +	struct macb *bp = container_of(work, struct macb, tx_lpi_work.work);
> +
> +	if (bp->eee_active && macb_tx_all_queues_idle(bp))
> +		macb_tx_lpi_set(bp, true);
> +}
> +
> +static void macb_tx_lpi_schedule(struct macb *bp)
> +{
> +	if (bp->eee_active)
> +		mod_delayed_work(system_wq, &bp->tx_lpi_work,
> +				 usecs_to_jiffies(bp->tx_lpi_timer));
> +}
> +
> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
> + * and wait for the PHY to exit LPI before any frame can be sent.
> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
> + * we use a conservative 50us.
> + */
> +static void macb_tx_lpi_wake(struct macb *bp)
> +{
> +	if (!macb_tx_lpi_set(bp, false))

Does this lpi_set() not have a relatively high cost, even if eee_active
is disabled? Reading registers is usually pretty slow. Can we add 
a eee_active check here as well to short cut the lpi check? 
If we do we probably want to make sure that the code paths setting
eee_active are also under bp->lock, otherwise this new check will be
racy.
-- 
pw-bot: cr

