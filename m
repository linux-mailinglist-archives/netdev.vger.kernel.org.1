Return-Path: <netdev+bounces-140139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBE9B556D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E32B22CBA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7320820A;
	Tue, 29 Oct 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eWr9VvZU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC4194AD6
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239185; cv=none; b=kqpwrzJ1Io+teclDtvV7A/UiIYH7oIQFonG/2S+TgZ75ZvfTKh/I9qSyGrEC16VAjY1h2InfewTpPipWIGuJFUTLAWGC/NRq/Igzq1ANcnQfM/csqdilh6frby3jVXDR2mEpjhrkgaIT3QG8M1M0KzspcYWFCJ6JazR09iyouHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239185; c=relaxed/simple;
	bh=Y/whVYpBMqfoT+U1kZbdqTQxekP/mwfS+xOSnfHZQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2yELqqrNHPfFlXnVIshrafTrYtbvAEDZeenpN9tgRLrUjx6BluITTJ/ImWqd521OapKONkckLURNrOeppoYyTGQ3z1ObZ7CmvpTJaOD8/0YlmlNylJlOYG6U0EICGUsQV4USlq6y2+WVkEcC1T8HvCbsSAVqCmqRCCAqoBXInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eWr9VvZU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qq4z6xtqor1RFx8A7YU23rywzOqmQmKSqZMJvBHeAZs=; b=eWr9VvZUynLtt2EgBeFWRfkP3z
	uAC9e8DubMT/f3G4Oh0a1mJrd2URmE8k55e4cGQnYP7oe8dj4YX7JAQMiEnXanirIbZCTsO6FeVnI
	vQFwTq+Dvia/9HS8brzlzYKfBAutKGdc5cNC9IaDkP9EZepmQr5ugglJOpamcIceYQXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5uFY-00BdEQ-Gp; Tue, 29 Oct 2024 22:59:40 +0100
Date: Tue, 29 Oct 2024 22:59:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
Message-ID: <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-2-ouster@cs.stanford.edu>

> +/**
> + * struct homa_recvmsg_args - Provides information needed by Homa's
> + * recvmsg; passed to recvmsg using the msg_control field.
> + */
> +struct homa_recvmsg_args {
> +	/**
> +	 * @id: (in/out) Initially specifies the id of the desired RPC, or 0
> +	 * if any RPC is OK; returns the actual id received.
> +	 */
> +	uint64_t id;
> +
> +	/**
> +	 * @completion_cookie: (out) If the incoming message is a response,
> +	 * this will return the completion cookie specified when the
> +	 * request was sent. For requests this will always be zero.
> +	 */
> +	uint64_t completion_cookie;
> +
> +	/**
> +	 * @flags: (in) OR-ed combination of bits that control the operation.
> +	 * See below for values.
> +	 */
> +	int flags;

Maybe give this a fixed size, otherwise it gets interesting when you
have a 32 bit userspace running on top of a 64 bit kernel.

> +
> +	/**
> +	 * @error_addr: the address of the peer is stored here when available.
> +	 * This field is different from the msg_name field in struct msghdr
> +	 * in that the msg_name field isn't set after errors. This field will
> +	 * always be set when peer information is available, which includes
> +	 * some error cases.
> +	 */
> +	union sockaddr_in_union peer_addr;
> +
> +	/**
> +	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
> +	 * Passes in bpages from previous messages that can now be
> +	 * recycled; returns bpages from the new message.
> +	 */
> +	uint32_t num_bpages;
> +
> +	uint32_t _pad[1];

If you ever want to be able to use this sometime in the future, it
would be good to document that it should be filled with zero, and test
is it zero. And if the kernel ever passes this structure back to
userspace it should also fill it with zero.

> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_recvmsg_args) >= 120,
> +	       "homa_recvmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_recvmsg_args) <= 120,
> +	       "homa_recvmsg_args grew");

Did you build for 32 bit systems? 

	Andrew

