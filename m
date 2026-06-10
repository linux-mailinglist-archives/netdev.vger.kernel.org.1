Return-Path: <netdev+bounces-297801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBhqN1yxKWpRcAMAu9opvQ
	(envelope-from <netdev+bounces-297801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9166C5D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:47:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oVwLEts/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD12F317C683
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5D32BF41;
	Wed, 10 Jun 2026 18:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CE230BDB;
	Wed, 10 Jun 2026 18:47:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117265; cv=none; b=doUPGRJaDNAd4pw5zezK+ZmU4XEzTXRIm7gzB3gKPzMCdFj5bKkcmlXs/iLBwTy8qQnk0ep5G85ru4HWuFh6oV/XaffHWc3+/A30F8hb6ffxDJTW6ta5CDvtYXELGfK3xaF/04FFQS9QB0OVVHV+IvIxlDiJcunij7Dcqn9LT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117265; c=relaxed/simple;
	bh=KsvmJh7IyuacrRWVq+rg/XNNyRPcnypfQsBxgaOCsKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM1LSl3tgpoHDJxNaIv4VfaSeegFrRexmA4jrBUaFVSHyCk8GSNVY2BHHMZ6/V1TVcXGex5E3v9FcXnUCNMNavDm6n760hwd0vBw77XXp6b84HhEB55WOad7nFdGw057mry+wSqXcuAZGDXRSxHvsFZ4+kzHGCILHecrF4g8aWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVwLEts/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B611F00893;
	Wed, 10 Jun 2026 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781117264;
	bh=NbblqeNKmNEyk8tHqt+WNyhAvwCFyPES8lnSCQQ/rlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oVwLEts/auDkPFZ/GfhKGEDCghkVguAQHYJ+jyRFNX7VW53lhIMH9M9q5HTQWOn/Q
	 Q2e7pCkghC3ixOJWfGWE1LqHmCHIWExyNOV48WIOgGhFTusPr9Hqz1sNkoOkEw9IhS
	 hjk1RekyW4scWsCOKq1GK+QSNQCaCI2uOMZSRUKGGk/JCKvb+CERUiAtEajupMCMbm
	 xicv/jrnzm3SuTAoVdEktTWGkZZJDGsfBIV3uW6RcXT2wnmuEbyAo/0s24xu3I0kXb
	 NtKUjMJsWDSso87NyA9gulSwRwyXoqKmdTsAdYoifngiJH/lci3d4vvhzFXEDdvpWn
	 4s7M7KhzbInYA==
Date: Wed, 10 Jun 2026 19:47:37 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Meghana Malladi <m-malladi@ti.com>,
	David Carlier <devnexen@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>, Himanshu Mittal <h-mittal1@ti.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jan Vaclav <jvaclav@redhat.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v3 0/3] Add standard stats for HSR/PRP
Message-ID: <20260610184737.GO3920875@horms.kernel.org>
References: <20260608100930.210149-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608100930.210149-1-danishanwar@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297801-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:danishanwar@ti.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:h-mittal1@ti.com,m:liuhangbin@gmail.com,m:elfring@users.sourceforge.net,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,users.sourceforge.net,suse.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,horms.kernel.org:mid,linux.dev:url,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DC9166C5D2

On Mon, Jun 08, 2026 at 03:39:27PM +0530, MD Danish Anwar wrote:
> Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
> related stats for ICSSG driver. Based on maintainers' comments on v2 I am
> now adding support to dump standard stats for HSR/PRP.
> 
> The drivers which support offload can populate these standard stats.
> 
> This series only implements offloaded stats. For software-only interfaces
> Felix Maurer had said he will do it later [1]
> 
> v2 https://lore.kernel.org/all/20260514075605.850674-1-danishanwar@ti.com/
> [1] https://lore.kernel.org/all/ag87pBZfOyccPZTc@thinkpad/
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Felix Maurer <fmaurer@redhat.com>
> Cc: Luka Gejak <luka.gejak@linux.dev>

Hi MD,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch-set.

