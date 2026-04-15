Return-Path: <netdev+bounces-278605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOtvL9jX3mmpJAAAu9opvQ
	(envelope-from <netdev+bounces-278605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B63FF3BC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81164300B9C6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63A40DFC9;
	Wed, 15 Apr 2026 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aloffz5V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9F78F3A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211925; cv=none; b=IvsJ1VViCYM5YaPtll/AlUiFTSEGxTOujun4jvECLpQO0rDhqao/SToyJXAywdTWZ34O2M3WAmV6e/yp45ou9GtrFfOxp3hkr7BgM/l5hORlxjOF0fdBe0wr+aDj82tsPch2QbPsPYVpUiuIezEl8YGNCjhAQIPDAQqLUA2NfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211925; c=relaxed/simple;
	bh=QYX6zOhjE5SBE8f2AYjW27oGmBb0zhr0qBuZuOUAsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3rzWkXI2z5gG7HOetuGp3YIQHl++p4IOKEtIfU7/+JMybhMaa4zWkPbMIz1mtTOQ1FUY9vDHXe7FJQhSx5G1v61zoaWcQb9Moul5MpWbfY9tL8sSSv/HS5HI14BtKtAtZxRG/4eWndjek8R8Pff+Oud7ntrt+F5Wu2d1XSFgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aloffz5V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9RmvYgIcDgnjc3TN0sF76qBS1rwb8ZMn0Vhou6ML3pg=; b=al
	offz5Vqq87vLxguFsCA/k6WAw80qDV9baqw5Bs/k+iehvTjRGyWOUlrxFGMmkUlX9sqfw9CKGELOU
	kMvrERRTCciWBfB373dowONE6u0gF/1CtZCtZ+lafgKvNXTS2HMZnkpqd0sA7m9q/EAraw13aL3du
	KYns2O3mscdOH+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCnrM-00G71s-Ce; Wed, 15 Apr 2026 02:12:00 +0200
Date: Wed, 15 Apr 2026 02:12:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Beno=EEt?= Dufour <benoit.dufour@mail.com>
Cc: netdev@vger.kernel.org
Subject: Re: DMA issues with the SKGE drivers
Message-ID: <c3130329-a7ea-406c-9ac1-2fa5d9d3a8bc@lunn.ch>
References: <9df653d6-d7f8-4b36-87de-65daf28635dd@mail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df653d6-d7f8-4b36-87de-65daf28635dd@mail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[mail.com];
	TAGGED_FROM(0.00)[bounces-278605-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 228B63FF3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:23:17PM -0400, Benoît Dufour wrote:
> In 2024, I reported a bug about the SKGE driver, you can see it here:
> https://bugzilla.kernel.org/show_bug.cgi?id=219270
> 
> Basically, the problem is that the Marvell 88E8001 on my ASUS A8V motherboard
> can only work with 32bit DMA, and if trying to use 64bit DMA, the NIC won't
> work at all and after some time, the operating system will become completely
> unresponsive (on screen tty will stop refresh, keyboard and mouse input will
> stop working too).
> 
> The fix is quite easy:
> 
> At the very end of the SKGE driver source code, the ASUS A8V motherboard (as
> well as many other boards like the ASUS A8V Deluxe) should be added to the list
> of 32bit DMA boards:
> https://github.com/torvalds/linux/blob/508fed6795411f5ab277fd1edc0d7adca4946f23
> /drivers/net/ethernet/marvell/skge.c#L4150

Hi Benoît 

Could you submit a patch adding the needed entry for your board?

	Andrew



