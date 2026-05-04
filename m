Return-Path: <netdev+bounces-283915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Et4NEO4+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:16:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2113F4C08AB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3761B3009B39
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5F3E0247;
	Mon,  4 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="RQZeF6mi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DA3D75D7;
	Mon,  4 May 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907570; cv=none; b=HIZ9jqwGip/8tuWFfN9Zd+zC/Lta7DxaMmGPQu4m3K/6OibhEIZpfAm9TzK9Ikv245O/srrr4Sokb2PC0troWrf1CCILQI8d/Jpjs54sstl3a8x9GvGxuK5VAsmf/KWBjRI0CEH3JZwFkOiPGE1gRq6KlJFcaydnhdtfaoZcvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907570; c=relaxed/simple;
	bh=PEPiYfzwHxVC8iWBrgru/8Omh1AEpiov7/LLxgkS4qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcVT25KuIDb+bFwwA6Q7eju2F/+0gX3tpO55uEQimJ5XcfF6DgqxZzZjRlnR35GovislqmzDZ+liGm8zhqYR7jFDjRHAhdnPTbefun+yVKX546qCVMEMAOPyMwybMEDPiggAhrsVzKnek9UCEkDXo6TnnA4FatVIl0ChyrKnIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz; spf=pass smtp.mailfrom=nic.cz; dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b=RQZeF6mi; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from solitude (unknown [172.20.8.17])
	by mail.nic.cz (Postfix) with ESMTPS id 771CE1C1024;
	Mon,  4 May 2026 17:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
	t=1777907154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc9TalB+R1Lnx64bEIOBZEzXVkBwS4uS5dFf3lfuVJM=;
	b=RQZeF6mimvc9Tu0Pm5D96FtoXy0gEXCWNp5b7q7hkvDeEqpqPwRdkDcRzJjtqkjQf5fke5
	pU8zSoPsi08UzONgq/Jb2+5T3/SAg1lEuWz9pGJ2JK0HKyH0XC3EhFlmN8aXRvo3hSl38T
	/Yzc0C2a1aNX+GmLCFtvDFiQlxSiaBw=
Authentication-Results: mail.nic.cz;
	none
Date: Mon, 4 May 2026 17:05:49 +0200
From: Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.eckerman.ext@ericsson.com
Subject: Re: [PATCH net-next v2 0/2] mv88e6xxx: SERDES on mv88e6321 letter
Message-ID: <dxxmuzte6ntiimozgmafsx75at7zf4mm3kg5k5dgsnlnrfl3eh@yurunqpyb33p>
References: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 2113F4C08AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nic.cz,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nic.cz:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283915-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.behun@nic.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nic.cz:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]

Hello Fidan, Andrew,

last year I worked on 6320+6321 serdes support, but never send it
due to different workload.

Quickly looking at your patches, there are some things I think are
missing in comparison to what I did - I have 5 patches:

1/5: drops serdes methods for 88E6172, which does not have serdes

2/5: is similar to your patch 1/2, adding serdes_get_lane to 6352 family.
     The difference is the implementation of mv88e6352_serdes_get_lane(),
     which does not read scratch register. Yours is probably better in
     this regard, but mv88e6352_g2_scratch_port_has_serdes() is also
     called in mv88e6352_pcs_init(). So maybe this is redundant?

     Also, I rename MV88E6352_ADDR_SERDES macro to MV88E6352_SERDES_LANE
     to be in line with other such macros in serdes.h

3/5: extends 6352 serdes pcs for 6320 family.
     In addition to your code I also implement .serdes_irq_mapping().

     These depend on other mv88e6xxx fixes I forgot to send, which I
     will do now.

4/5: Add hidden register access methods for 6320 and 6352 family.
     These can be used to change SerDes modes.

5/5: Add support for changing between sgmii and 1000base-x on 6320 family
     via hidden register acces.

     This was done by reverse engineering hidden registers (trying
     different values), since it is not documented correctly.

Would you prefer for your patches to be applied first and then I can
rebase, or would you rather like to look at my code first?

Marek

On Thu, Apr 30, 2026 at 02:49:05PM +0200, Fidan Aliyeva wrote:
> This patch series add code support to be able to use SERDES feature of
> mv88e6321 version of Marvel mv88e6xxx series. mv88e6321 has 2 ports to
> support high speed SERDES but the support is lacking in the driver.
> 
> mv88e6321 version has a similar architecture to mv88e6352 version making it
> possible to reuse its pcs functions. That's why the patch series consist of
> 2 parts:
> 1. Refactor the serdes functions and pcs_init of mv88e6352 to be more
> generic
> 2. Add the SERDES support for mv88e6321 reusing 6352's pcs functions
> 
> The final code has been built on top of net-next tree and tested on
> mv88e6321 ethernet device directly by ip ping tests, performance tests and
> also verifying the switch's expected register values.
> 
> Referred document: 88E6321/88E6320 Functional Specification
> 
> Code has been built with allmodconfig and allyesconfig. checkpatch.pl was
> also run
> 
> ---
> Changes in v2:
>   - Removed 6321-specific pcs_init and made 6352's pcs_init more generic
>   as suggested by Andrew Lunn
>   - Added the correct mailing list
> 
> ---
> Fidan Aliyeva (2):
>   mv88e6xxx: Refactor 6352's serdes functions
>   mv88e6xxx: Add SERDES Support for mv88e6321
> 
>  drivers/net/dsa/mv88e6xxx/chip.c     |  8 +++
>  drivers/net/dsa/mv88e6xxx/pcs-6352.c | 12 ++--
>  drivers/net/dsa/mv88e6xxx/serdes.c   | 87 ++++++++++++++++++++++------
>  drivers/net/dsa/mv88e6xxx/serdes.h   |  5 ++
>  4 files changed, 86 insertions(+), 26 deletions(-)
> 
> --
> 2.36.0
> 
> 

