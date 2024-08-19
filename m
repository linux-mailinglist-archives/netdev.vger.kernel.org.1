Return-Path: <netdev+bounces-119646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94A95676B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903DB282F99
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187215B14D;
	Mon, 19 Aug 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4b5/GFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137113C81B;
	Mon, 19 Aug 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060834; cv=none; b=VpQcpPlFINofapcxOemiaYdq2MBeJMROyMzxhNTD0bAZ8jYjO4uKLZsWjvLYccpylhm1wPCgpg2qRFsnVqLZhHS0Y/VGvHQqJ8fVcC1p6KmHTZfw81FtNWuNPASX7f4M+ItOt1GM3G1e3k5mDd27tFdfazUAjVTPWQeQR7rVxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060834; c=relaxed/simple;
	bh=ZzcK0fCwbDX+LhNHK79l7SJCmLFi7ccNT7raE4MJ7E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTGSkNsr5NG4ccAWvMaiW8hkaY63zDvJrLDsggZkng5EeYjRnlfzPUybGXjLS72qvotTe01uDAqnSTcH4UwAjh9KjFOQ0woDfaxdgOOqqCZTNLIigkVlzAVWSus5eFt7o5HI8SLUFMi6+fQBDU1W7XZptfBpPt4xjAh1mmDbj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4b5/GFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB0AC32782;
	Mon, 19 Aug 2024 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724060834;
	bh=ZzcK0fCwbDX+LhNHK79l7SJCmLFi7ccNT7raE4MJ7E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4b5/GFhNrbzrhaNFb2ByhWoIpUIOf7Omkkds7mUOkMbsZv1x7eQKSbZvfennVJXU
	 I40tUb9C2++g6uMtJtXqty9oB2aZm5DaW+Z3WasOwlipZBLIQu6/2G+2y1ilj09hP+
	 8HqXNOUaHgz4T4+BDHXsStNALX0U/enpeWzu+DqzoCiG09NuQn1HAFLx68KyCIhicp
	 8WwQZtCeJQCBVvYP1/keK7hR+/A4dTDARwP8LIV2OPu+SP2pH+FN6y2yBPAm8o3WQi
	 ytdWArNjtEE+8axkP9PtP8HQnQ0DKg5+m1JuNNpSrwMGQKlp5Mtj2hL/pc0E4E9DjK
	 rwHx98brpp6IQ==
Date: Mon, 19 Aug 2024 10:47:09 +0100
From: Simon Horman <horms@kernel.org>
To: Rodolfo Zitellini <rwz@xhero.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH net-next 2/2] appletalk: tashtalk: Add LocalTalk line
 discipline driver for AppleTalk using a TashTalk adapter
Message-ID: <20240819094709.GD11472@kernel.org>
References: <20240817093316.9239-1-rwz@xhero.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817093316.9239-1-rwz@xhero.org>

On Sat, Aug 17, 2024 at 11:33:16AM +0200, Rodolfo Zitellini wrote:
> This is the TashTalk driver, it perits for a modern machine to
> participate in a Apple LocalTalk network and is compatibile with

nit: compatible

     Flagged by checkpatch.pl --codespell

> Netatalk.
> 
> Please see the included documentation for details:
> Documentation/networking/device_drivers/appletalk/index.rst
> 
> Signed-off-by: Rodolfo Zitellini <rwz@xhero.org>

...

> diff --git a/drivers/net/appletalk/tashtalk.c b/drivers/net/appletalk/tashtalk.c

...

> +/* Called by the driver when there's room for more data.
> + * Schedule the transmit.
> + */
> +static void tashtalk_write_wakeup(struct tty_struct *tty)
> +{
> +	struct tashtalk *tt;

I think that tt needs an __rcu annotation. Sparse says:

.../tashtalk.c:290:14: error: incompatible types in comparison expression (different address spaces):
.../tashtalk.c:290:14:    void [noderef] __rcu *
.../tashtalk.c:290:14:    void *

> +
> +	rcu_read_lock();
> +	tt = rcu_dereference(tty->disc_data);
> +	if (tt)
> +		schedule_work(&tt->tx_work);
> +	rcu_read_unlock();
> +}

...

> +static void tashtalk_send_ctrl_packet(struct tashtalk *tt, unsigned char dst,
> +				      unsigned char src, unsigned char type)
> +{
> +	unsigned char cmd = TT_CMD_TX;
> +	unsigned char buf[5];
> +	int actual;
> +	u16 crc;
> +
> +	buf[LLAP_DST_POS] = dst;
> +	buf[LLAP_SRC_POS] = src;
> +	buf[LLAP_TYP_POS] = type;
> +
> +	crc = tash_crc(buf, 3);
> +	buf[3] = ~(crc & 0xFF);
> +	buf[4] = ~(crc >> 8);
> +
> +	actual = tt->tty->ops->write(tt->tty, &cmd, 1);
> +	actual += tt->tty->ops->write(tt->tty, buf, sizeof(buf));
> +}

actual is set but otherwise unused in this function.
Should it be used as part of checking, with an error code returned on error?
If not, it should probably be removed.

Flagged by W=1 builds.

...

> +static void tashtalk_close(struct tty_struct *tty)
> +{
> +	struct tashtalk *tt = tty->disc_data;
> +
> +	/* First make sure we're connected. */
> +	if (!tt || tt->magic != TASH_MAGIC || tt->tty != tty)
> +		return;
> +
> +	spin_lock_bh(&tt->lock);
> +	rcu_assign_pointer(tty->disc_data, NULL);

I think tty->disc_data also needs an __rcu annotation, which will
likely highlight the need for annotations elsewhere. Flagged by Sparse.

> +	tt->tty = NULL;
> +	spin_unlock_bh(&tt->lock);
> +
> +	synchronize_rcu();
> +	flush_work(&tt->tx_work);
> +
> +	/* Flush network side */
> +	unregister_netdev(tt->dev);
> +	/* This will complete via tt_free_netdev */
> +}

...

