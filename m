Return-Path: <netdev+bounces-292853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEjPNQa0GGr9mAgAu9opvQ
	(envelope-from <netdev+bounces-292853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:30:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D05FA6C3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF4B3006963
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA733451BB;
	Thu, 28 May 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ovujxswl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E01AA1D2;
	Thu, 28 May 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003578; cv=none; b=Nfmc/157yu7H4hKlD0hmI7K1+Wmrc5KNmRsds3I73Zc0XcdxDLdcQg1fhZN9cj7KFXOhFjl+EJSX61AIT+9w89kfg+9Jq8hLnLgpGoueH+QbIm+FG8u7R2rrjNHcoDOFkSetYBd7L7regMnsupzZu7T+uCJGVIIQn80zv22VW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003578; c=relaxed/simple;
	bh=S98SDO0f+qJR7ZqRLSy/M0Ouv7PvcgrKB3dYMIaLu2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUGQ28m+HUl5MZgCV+vfOG1T32h8aio0ZwCCiN7CoujB50w2GQ0a6BWyBX6p3jxjch9qI0fbFd3WAq7TOnnRJQowV1aB7r4SQE+lx4L4Tho+Uuevf+Cr2coqhV0pa32J5OTZnMOTq4OloMsd/OAZbPu3+OI39tw3ikdJRvle8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ovujxswl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rr+MRh041lkmNv/9tr/XvEVM86YHXbcseFG44X/WavI=; b=ovujxswlhjmGbV3v0IySIDVmvC
	/ll1hu7t04vi4SH4hxvSvXRJAFuVurWgJM/D+xJKiVk06/yMDMtINQgZvEC5tfTgMNbuY4V5hSPiM
	C+EfoJkKehDDcYuDDhBIwz8NQ3BVIBXhvmYgl/wNum/UMPGIqy/Bhu4/9z0MWKhAgePM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSiEu-004xtA-4I; Thu, 28 May 2026 23:26:04 +0200
Date: Thu, 28 May 2026 23:26:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next v3 1/3] mv88e6xxx: Add mv88e6352_serdes_get_lane
Message-ID: <f72a700f-76a5-40ee-a24d-ecc8b24af290@lunn.ch>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
 <20260528210310.1365858-2-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528210310.1365858-2-fidan.aliyeva.ext@ericsson.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org,ericsson.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-292853-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B7D05FA6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:03:08PM +0200, Fidan Aliyeva wrote:
> Changes:
> 1. Add mv88e6352_serdes_get_lane function which checks if the port
> supports SERDES by calling mv88e6352_g2_scratch_port_has_serdes. Then
> returns the address of the SERDES lane.
> 2. Add this function as .serdes_get_lane member to all the chip
> versions which use mv88e6352_pcs_init.
> 
> Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

