Return-Path: <netdev+bounces-100010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364158D7722
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17791F21430
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675E43ABC;
	Sun,  2 Jun 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s5btemq9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CC3FB1C;
	Sun,  2 Jun 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717345279; cv=none; b=AqvtnyNJy3TEL3kES6H0DNjJygwVgJm1OY4rGVBMWTWdxNOToYZ8afsVmZwZ3W+falCtWL2G2Kpo1grft+uEvwuE9HAIFDEAm3VItMUocyDPU9oel8evZvR5xP14/lLLW9IdoHbTJQQAKzToPft3mkKPFJj22h8dAuT8zl+XrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717345279; c=relaxed/simple;
	bh=rgmgH6ZXXN6LnOGXXD8uWUrImhsUMJz2+a2zP1CzdCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQtAEBLQ0OYCOkv5kIJ4LndDyMg0WZKiCxv9v4zKMh6wSEvOWLM2c4CUprntRbWsF62Qng9L4I/89X/+MVrm1oofVaoeyqLW6OSj6Vo7QY8dTtU8p4f8CobfL1vAS+dnE7lxXNwDaYrZwUA6b0QLMxziEFMjNBJa/NFjZaVB4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s5btemq9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i/1kvhUhUqUDyhq2DiabkGz9MoU8dADRCCFSjMXz4/g=; b=s5btemq9YwafbTJodrRPM1Unpf
	PRFpUjQnn6Z1cd580gsJEWvkZT+C1lidH5k08GKNwi4KON/A+QgkENgFwsUS2ns71aJIxYYXhhfVQ
	5D3cpbmXMbzzc7h+eHmdSFyEMDN91unuINBylIrve+fKTwUN9QJx46F3Mc5hUbIeb294=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDnxC-00Ge5Z-2H; Sun, 02 Jun 2024 18:21:06 +0200
Date: Sun, 2 Jun 2024 18:21:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
Message-ID: <389e1f57-1666-4298-a970-74f730740e4c@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-2-y-mallik@ti.com>

> +struct request_message {
> +	u32 type; /* Request Type */
> +	u32 id;	  /* Request ID */
> +} __packed;
> +
> +struct response_message {
> +	u32 type;	/* Response Type */
> +	u32 id;		/* Response ID */
> +} __packed;
> +
> +struct notify_message {
> +	u32 type;	/* Notify Type */
> +	u32 id;		/* Notify ID */
> +} __packed;

These are basically identical.

The packed should not be needed, since these structures are naturally
aligned. The compiler will do the right thing without the
__packet. And there is a general dislike for __packed. It is better to
layout your structures correctly so they are not needed.

> +struct message_header {
> +	u32 src_id;
> +	u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
> +} __packed;
> +
> +struct message {
> +	struct message_header msg_hdr;
> +	union {
> +		struct request_message req_msg;
> +		struct response_message resp_msg;
> +		struct notify_message notify_msg;
> +	};

Since they are identical, why bother with a union?  It could be argued
it allows future extensions, but i don't see any sort of protocol
version here so you can tell if extra fields have been added.

> +static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			 void *priv, u32 src)
> +{
> +	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
> +	struct message *msg = (struct message *)data;
> +	u32 msg_type = msg->msg_hdr.msg_type;
> +	u32 rpmsg_type;
> +
> +	switch (msg_type) {
> +	case ICVE_REQUEST_MSG:
> +		rpmsg_type = msg->req_msg.type;
> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
> +			msg_type, rpmsg_type);
> +		break;
> +	case ICVE_RESPONSE_MSG:
> +		rpmsg_type = msg->resp_msg.type;
> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
> +			msg_type, rpmsg_type);
> +		break;
> +	case ICVE_NOTIFY_MSG:
> +		rpmsg_type = msg->notify_msg.type;
> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
> +			msg_type, rpmsg_type);

This can be flattened to:

> +	case ICVE_REQUEST_MSG:
> +	case ICVE_RESPONSE_MSG:
> +	case ICVE_NOTIFY_MSG:
> +		rpmsg_type = msg->notify_msg.type;
> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
> +			msg_type, rpmsg_type);

which makes me wounder about the value of this. Yes, later patches are
going to flesh this out, but what value is there in printing the
numerical value of msg_type, when you could easily have the text
"Request", "Response", and "Notify". And why not include src_id and id
in this debug output? If you are going to add debug output, please
make it complete, otherwise it is often not useful.

> +		break;
> +	default:
> +		dev_err(common->dev, "Invalid msg type\n");
> +		break;

That is a potential way for the other end to DoS you. It also makes
changes to the protocol difficult, since you cannot add new messages
without DoS a machine using the old protocol. It would be better to
just increment a counter and keep going.

> +static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");

Please don't spam the logs. dev_dbg(), or nothing at all.

	Andrew

