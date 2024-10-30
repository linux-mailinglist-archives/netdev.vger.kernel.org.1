Return-Path: <netdev+bounces-140219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875609B58F9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328961F23C2D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066112C530;
	Wed, 30 Oct 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E/ghpaqq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE741C6E
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250810; cv=none; b=D76OlOA+PCCjplwJwgHx/o712mzYSXxewcNjikp3ZpxKfnfKyDhx7jYA9SYQaoV1m0F+uiIsf+6KbMKvGJuQHkjwjSY5iFRrAhPWi1OOAT7qmqIQJDO1PTdhHZpDnEyDKF3UU5RQXtd8EooKjdKbGLqDB+sl1U00XFZ+kB/daEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250810; c=relaxed/simple;
	bh=JTzwFOh6LamUfOEaitZME1WVwXLlkPLtDo2IZWVRlTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAnyiRt1MSLRKgr0I9xOQ2k8OZn9F1KCfrtfiviI72qtE15oAFEQ8mEyO/sr5KcPZVADaKZz8fMgPWkYq/ZAfXmJEg5kUpWxocaDk190x1sC7hEOpdPZrQA5ObeNNUCwLzQg8kYqvpunA5dTMGWn3kojGk5VePkKQR07RXYgEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E/ghpaqq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QeF9Kve2LdhqXBoqaDk/YD6fbYgFypirl7Tb73uB6nU=; b=E/ghpaqqHt2mO6RmFcSxr1J8wD
	0orZ+625pxm7ftZYt+bDcDf/4WVpyfvRn8WAR6EUrvnCBEsaWdmKlxuTu2fiIMjJC/dTUcv1FUwSj
	hh0bb8roEytTTdSIPMMbFs/0O0dotZN2/2HFjnsXEXzxM11Hm+dvxYyOMOyYWKRYtCWA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5xH3-00Be11-Dj; Wed, 30 Oct 2024 02:13:25 +0100
Date: Wed, 30 Oct 2024 02:13:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
Message-ID: <1ec74f2a-3a63-4093-bea8-64d3d196eac6@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-9-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-9-ouster@cs.stanford.edu>

> +int homa_copy_to_user(struct homa_rpc *rpc)
> +{
> +#ifdef __UNIT_TEST__
> +#define MAX_SKBS 3
> +#else
> +#define MAX_SKBS 20
> +#endif

I see you have dropped most of your unit test code. I would remove
this all well. I suspect your unit test code is going to result in a
lot of discussion. So i think you want to remove it all.

> +struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int flags,
> +				       __u64 id)
> +{
> +	int error;
> +	struct homa_rpc *result = NULL;
> +	struct homa_interest interest;
> +	struct homa_rpc *rpc = NULL;
> +
> +	/* Each iteration of this loop finds an RPC, but it might not be
> +	 * in a state where we can return it (e.g., there might be packets
> +	 * ready to transfer to user space, but the incoming message isn't yet
> +	 * complete). Thus it could take many iterations of this loop
> +	 * before we have an RPC with a complete message.
> +	 */
> +	while (1) {
> +		error = homa_register_interests(&interest, hsk, flags, id);
> +		rpc = (struct homa_rpc *)atomic_long_read(&interest.ready_rpc);
> +		if (rpc)
> +			goto found_rpc;
> +		if (error < 0) {
> +			result = ERR_PTR(error);
> +			goto found_rpc;
> +		}
> +
> +//		tt_record3("Preparing to poll, socket %d, flags 0x%x, pid %d",
> +//				hsk->client_port, flags, current->pid);

I also think your tt_record code will be rejected, or at least there
will be a lot of push back. I expect you will be asked to look at
tracepoints.

> +		UNIT_HOOK("found_rpc");

I would also take all such calls out.

	Andrew

