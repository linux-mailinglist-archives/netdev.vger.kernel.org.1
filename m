Return-Path: <netdev+bounces-252950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FKaNHDQc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:48:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2697A496
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D0E305617E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B72652A4;
	Fri, 23 Jan 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6mZiIu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349F2C0F78;
	Fri, 23 Jan 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197563; cv=none; b=GwYiEOdmc42AYqlFv8wlOOCEpmMWNiAYvbDwOX0daAV4ZluJn9Scq0sKCSG2gh6T9shsWPvdaigpLJPhJoYsH8rOK52pddxeODinYOasWAmk+Hzo/eaBOqdJEqe6FPVKluiGed8ymGSwsXeZ9VJlc9FbuBjXT7LbSN2a+K/nnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197563; c=relaxed/simple;
	bh=KpWHRkgHxM8ujOwupKUgR/mrJU1qGt4znmoaFr2IaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvoykQ+Il3ucHiLsQ6HU2vk9B59seiePpOVzLFfOsJUuh7wJBqZwdrR5W4MyBDY8cSc5+BqVPOJTKT870l7PDMoskK7DfMZTowH3zDdiAhR7EVNywCslstix6zzzUiyUr7XZzzdzBPZPBau3uY0t+SysSH//C4E5OKri0UUEqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6mZiIu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8478CC4CEF1;
	Fri, 23 Jan 2026 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197563;
	bh=KpWHRkgHxM8ujOwupKUgR/mrJU1qGt4znmoaFr2IaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6mZiIu4EagJqR86BtSnqeUOYWx8dWdbiP8XsAnj0P17ZxbJmyBy0hKs1Vy0xT9JV
	 AZDeAzFK/A0BPplqn1ttqQ5BqllGsww1zwGhKipIjuArS75JMpAlG8jsrqfikuKztZ
	 DjDeUukHoKWX1nAjqwxvROdW2QiuKOjA1cnh5ZS6hulVuMIqBJrnki5e3pRGNZ4hBl
	 pCaQqzR2KKSEWsaNmmaHqPGsN2vRj1LjFrQ8siTpfTpziI5ty66a3ztHeyEMfDVX/z
	 4SpiHTipvYowFCT3y8EarLe8yJk00OnBVIhbG/+57HnPiYRqSE+Cxx4UDpspW3FQoM
	 UfzCRp24d4/1Q==
Date: Fri, 23 Jan 2026 19:45:59 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
Message-ID: <aXPP9_z3Iu9l4C4G@horms.kernel.org>
References: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
 <aXOsp3T2BC5Gxzaj@horms.kernel.org>
 <20260123101807.27beafe7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123101807.27beafe7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F2697A496
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:18:07AM -0800, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 17:15:19 +0000 Simon Horman wrote:
> > On Thu, Jan 22, 2026 at 08:46:09AM +0100, Lukas Bulwahn wrote:
> > > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > > 
> > > Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
> > > driver") removes the hippidevice header file, but misses that there is
> > > still a file entry in MAINTAINERS referring to it.
> > > 
> > > Remove the obsolete file entry in NETWORKING DRIVERS.
> > > 
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>  
> > 
> > Thanks Lukas,
> > 
> > I agree this is the case.
> > 
> > But unfortunately our CI seems to be confused about which
> > tree to test it against. So could you resubmit targeting net-next
> > like this?
> 
> It's alright, we don't really have any tests for MAINTAINERS in the CI,
> anyway.

Yes, silly me.

