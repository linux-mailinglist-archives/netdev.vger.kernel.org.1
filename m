Return-Path: <netdev+bounces-298187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RneWJBHaKmqGyAMAu9opvQ
	(envelope-from <netdev+bounces-298187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:53:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8886733AB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=InqXw1qT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298187-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A909331AA6C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81D35E1C8;
	Thu, 11 Jun 2026 15:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C42D593E;
	Thu, 11 Jun 2026 15:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193050; cv=none; b=WT53wrsT0U9rBN3eaNqGJ9YNW4yXz78rmZIzIrSiZvWeT1a12gBFMHnw5k9Dobm448sySQ8fOjVI8SWwMsRu7N2iBTZphAV3G8djSloMlY394LO+nsoFRfP0yLHV3qmnKDmLq/m1kaj/ribn9FfpAm/LR6CrV0mSg4eqD9WekFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193050; c=relaxed/simple;
	bh=C9Wz+326V6lLAkyQkqUwoBDeBjlimsAoy9A//VFYad4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pldjwaUy5W8FkKiedWocY/BAun6sp3se7780To87mB6yRms9q49iv9EQ74UCGeDFBaZ9ffJJjrtVUDTW3w1jT35j49Zaj9KG0CVvFSj2cutjL5KWfCb+VmRJfnBESoxX2JAt4m3aVrikkMElJW+6SSu5kU8M4ntXdD506OlSG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=InqXw1qT; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sX+gVdKxQAFtgOnc3Ye54B2febFesWu+jtpodVkLRc4=; b=InqXw1qTMWyJj3LqY2qNa30o8u
	HN+5Xj4LNlPzK7VjqtJe1SYjEcsEMoYe9HfJQsphZFd2dnG9juPdMv/B+s5JGclqspjY7Qh3Usc8W
	XYh4hKdEG5DesM/KEGnJa0by+rgFEJdZPpclV0q0F0NadoA7mwY4SmNH+LEf3fYzAOD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXhfo-007BME-Ba; Thu, 11 Jun 2026 17:50:28 +0200
Date: Thu, 11 Jun 2026 17:50:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Carlier <devnexen@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jan Vaclav <jvaclav@redhat.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v4 0/3] Add standard stats for HSR/PRP
Message-ID: <e8965004-f286-4589-a834-309ccaa1d575@lunn.ch>
References: <20260611095035.852370-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611095035.852370-1-danishanwar@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298187-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:danishanwar@ti.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,ti.com,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A8886733AB

On Thu, Jun 11, 2026 at 03:20:32PM +0530, MD Danish Anwar wrote:
> Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
> related stats for ICSSG driver. Based on maintainers' comments on v2 I am
> now adding support to dump standard stats for HSR/PRP.
> 
> The drivers which support offload can populate these standard stats.
> 
> This series only implements offloaded stats. For software-only interfaces
> Felix Maurer had said he will do it later [1]

That is ideally the wrong way around. Offloading it used to accelerate
what Linux can already do in software. Statistics should be part of
this, you first define software statistics, and then get the hardware
to report those.

So please get the software statistics merged first.

   Andrew

