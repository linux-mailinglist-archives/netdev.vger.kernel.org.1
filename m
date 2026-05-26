Return-Path: <netdev+bounces-291967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJiYNXshFmp/hwcAu9opvQ
	(envelope-from <netdev+bounces-291967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C725DD482
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09CD3037148
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A3C98B3;
	Tue, 26 May 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyYVfSo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96287393DF0;
	Tue, 26 May 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835204; cv=none; b=M6QOzUMADTckb1gPfVjkI2FMeUYfvN1LkXZYdV8PawJJ35eEjwvZoRy2Hll3oZ7iEQarCytuSjSJbTPZAwMCAW4HNodcLgoj2M0cOBwoSDqym4wiUcfUQpsuUe8Sm5fy01F1ZL4H+PSIysTUEh/Isyo3U6x+qiLKUr3Ui1aQk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835204; c=relaxed/simple;
	bh=h26+61KOumdj6OMx+o53TrtmL/JLA7aOTqcPn2kG/a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwWgbUouqeDZt1z87i00+8UMDE0r5QlZuNMEM/7wdRtKt9lOj/2ok+u/EFFwEv/cO/Kh9qwOm0kQgN75YISGAe+pSD8WInUby9rgD8EQprqNt+3cM8TCNu/l4iF+/YHYFAFJlxgr4076YGnRiYPYOcZDRIUSpdzKjmHlpji1kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyYVfSo6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B78C1F000E9;
	Tue, 26 May 2026 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835203;
	bh=B4teb5+2Eq3bvRCp7XbnuEPkSigdVnnMwGas0zpifgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FyYVfSo61ObFiLbv8LFz9KEEoK0Dn9OK/3KX3j7JUZYrzPnKHcltkTWHW385n0QzF
	 e+YhNFWbgyDRY3gK//JwLo+AgDdDQU46O6xai6LCYYhjK6s+qTSvRjmNeQWHTqQxGS
	 Is6FhXZJTqfQCzD+5tb2t5UYPkE9kUroVbrhpc5XZa5jaRKupPh0y4R5Y1O+EjLK/J
	 lew5T0F3awA9ZdWmJTHaFkAKgTDf7ISHLyIs2INkqr8SQgE+7mrKEBr6BHOlr4k1T4
	 7RzkFM7yi0OmvQXe8J5b0pugXXX5jtTwnFWB0L3pekm4QxVK5fGr7hCiNtKJhpCKEV
	 UHVzOjg79PzOA==
Date: Tue, 26 May 2026 15:40:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
Message-ID: <20260526154001.4a8d30bf@kernel.org>
In-Reply-To: <20260526153719.7261b7f2@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
	<1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
	<20260526153719.7261b7f2@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40C725DD482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 15:37:19 -0700 Jakub Kicinski wrote:
> On Tue, 26 May 2026 11:48:41 -0700 Randy Dunlap wrote:
> > WARNING: ../include/linux/netdevice.h:2622 Excess struct member 'ax25_ptr' description in 'net_device'  
> 
> I wonder how that sneaked in? ;) ;)
> 
> I'll clean this up separately, hopefully we haven't regressed too many
> things while the script was broken :(

Ugh, I'm still not seeing this on Linus's tree.
Is the fix for kernel-doc skipping such warnings on its way to Linus, 
or queue for -next?

