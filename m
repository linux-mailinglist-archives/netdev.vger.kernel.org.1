Return-Path: <netdev+bounces-280420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKJcGEvP6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:38:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61924446D45
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D4E3304212B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092813E9F60;
	Wed, 22 Apr 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E2ttJwcn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C133CF02A;
	Wed, 22 Apr 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863070; cv=none; b=KjNsn+ob4uNcZ4qDg+t61g0uD5n7R1U84/fqTRJrDW1W5YPas1LDELa8T4KHKUcyauK7EAmpr/4nJYbj9qvLCRymnXR/KQ+cbL0E89CznsEaInn1w84XpFhZTJ9X+fcndTN8NftIpZXB3XQefXVZRcPWQs2wCj9XicSc8XP5N2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863070; c=relaxed/simple;
	bh=uKVADmxDIvEoGE6cGJhJA1LPz+dQWUZQFQqaF9FWYf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czXYkCAVGGdhmcyRy4/5mMZUscqmFHI/jyEHrTZgGYaFT1yn9UvZNK/WnUqu12eWeVb87+0z0cLmHNKEA0XGVmdeosUSXmmPeob43ZuyN3MwL5ThdJ31BFO34pc426Hc8/pRiwJu0nWWeS6DJCbd/SeM6ja51IKbF6NQ46lHruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E2ttJwcn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=msVM0Z7nWQ/M2JHQQDaKFBklUSOvhst7cLU997D7X1g=; b=E2ttJwcnxR4bUgm3e0XYP+NZ4b
	NWEPfgCfatWH9L12T1gxzJ10EYWXDoIRafhJh6i27JAlTaHHCVGj52SpjEomr5KsnEi15J05ldd8q
	5hN2+MR6+OP7uaRCGdX6kgXr/O1kYHkF/MSTHGecwccFkdE+g/+DPF8MvorxfF0xexok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFXFd-00H26c-5G; Wed, 22 Apr 2026 15:04:21 +0200
Date: Wed, 22 Apr 2026 15:04:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: packetengines: remove obsolete yellowfin driver
 and vendor dir
Message-ID: <5e8e2117-e183-4eaa-8946-3f077e528b57@lunn.ch>
References: <20260422044820.485660-1-25181214217@stu.xidian.edu.cn>
 <20260422044820.485660-3-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422044820.485660-3-25181214217@stu.xidian.edu.cn>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[lunn.ch:s=20171124];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_SPAM(0.00)[0.304];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 61924446D45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:48:20PM +0800, Mingyu Wang wrote:
> Similar to the hamachi driver, the yellowfin driver supports hardware
> that is over two decades old and no longer in active use.
> 
> Since yellowfin was the last remaining driver in the packetengines
> vendor directory, we can now safely remove the entire directory and
> drop its associated references from the parent Kconfig and Makefile.
> 
> This eliminates dead code and reduces the overall maintenance burden
> on the netdev subsystem.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

