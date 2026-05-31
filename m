Return-Path: <netdev+bounces-293444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBjzFedTHGqeMgkAu9opvQ
	(envelope-from <netdev+bounces-293444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A81616DDB
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D86503011BFA
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49A3914E0;
	Sun, 31 May 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0RhIDHWx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01493909B9;
	Sun, 31 May 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241171; cv=none; b=YLVm5WXp5fvWYmA5tZxJS95nI+yRRNRTtV5YgfJCIfxketchvoK+DLS2fVSBMff556JbSjdxx7v5x3dyTtpJPEMOKiU9ogODTRG3D+72ottmSMmrsG7n5Tg3Tswll8o/FM6nnGRTaTvjjP/vOumK0UqrzzrxCDb1K162WBCp9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241171; c=relaxed/simple;
	bh=geeBjAYo+ZS27xmhhVpgu0J99dHFpSPuatjDStqgGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJb8/IdKR3xOz3EOkHEYHJXeTV704unVTqwwGkE1kA99Dqkqp3beBxUZe/w+mwwLs3s9bNQ+6NdA4a2UdsNntATPYcqH3s6fWk4veqRmq+PZ4CGijeVGjF2spY3hu0hVDAmc05+4o5TvChMf7UX8p+OJ8hnnfZJtlxm/bKQB9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0RhIDHWx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C017D1F0089B;
	Sun, 31 May 2026 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780241165;
	bh=Di1SkVeensE68rhHjiGO1dahyj2mqu6/cETPjqdLbcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0RhIDHWxuR/gBz86SE/3nyKYg0MJEFuMA3eMpwnathr+EzeUBYKT5rmr7fYa/WnCL
	 1wkwiGHEojoC6HSDJweVD5LefC40OrhWyFm9a8MQ+X1ctNi0NFnpHwC4Z8SFtly1F0
	 fgxdGtABIe6yY79DUP/keHC7cPsGHOaBXW903sZo=
Date: Sun, 31 May 2026 17:25:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Grewstad <dogestad24@gmail.com>
Cc: jic23@kernel.org, jacobsfeder@gmail.com, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	hjk@hansjkoch.de, davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <2026053145-bungee-flyover-840a@gregkh>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293444-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B0A81616DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 08:20:35PM +0530, Grewstad wrote:
> Dear Maintainers,
> 
> I am interested in contributing to the Xilinx AXI-Stream FIFO driver
> located in drivers/staging/axis-fifo.
> 
> While reviewing the driver, I noticed that it does not currently
> contain a TODO file describing the work required for graduation from
> staging. I would like to create such a file, but before doing so I
> would appreciate guidance on the expected long-term direction for the
> driver.
> 
> The driver currently exposes a custom userspace ABI through a
> miscdevice. While this provides a generic interface to the FIFO, it
> does not integrate with existing kernel subsystem tooling. One possible
> incremental improvement in this area could be a transition from
> miscdevice to a proper character device (cdev) interface, to allow for
> a more clearly defined and maintainable userspace ABI.

There really is no difference between a miscdevice and a character
device, the interaction from user/kernel is the same.

> Some possible directions that came to mind are:
> 
> - UIO, if the intent is to provide userspace control over a generic
>   AXI-stream FIFO with minimal kernel policy.

UIO provides a mmap of a device to userspace where it is controlled
directly.  Probably not what you want to do here right?

> - IIO, for data acquisition or SDR-oriented applications that could
>   benefit from existing buffer infrastructure and userspace tooling.

Is that what this device is?

> - Networking, for packet-oriented AXI-stream use cases.

WHat really is this device for?  What is the goal of this hardware and
how is it used today?  Do you have the hardware to test with it?  Who
uses it?

thanks,

greg k-h

