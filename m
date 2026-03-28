Return-Path: <netdev+bounces-272702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GELQDN4fx2mDTQUAu9opvQ
	(envelope-from <netdev+bounces-272702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:25:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B95E34CAF9
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F8A3013A87
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF411A9F9F;
	Sat, 28 Mar 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEBdSegW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECD40DFC9;
	Sat, 28 Mar 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657499; cv=none; b=hPk6bDvJMNPQ747tg1PlTpLofws/+c+gUoZyBrWMrZtm7A+K+G8Ma6cBNbUvoO5qd6YGhiVydXfF/G7narDd5qp0Qk5xm5lHemzCSiC+kz4lVFaNRJw+XHhv11SxePEE8NU/RN72R66NTblwqOyCe9s/Ehp3WtIqJHYhjs7GT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657499; c=relaxed/simple;
	bh=eTCuq4xez0vRuryl1L76sF2NU8W9lCO8PmiMdzIiDBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhe2ugqdG/3X7rs3RQO3vjMNOc5cU+xohnDyc5+gKHaca2iOXnFftHzjCcDBiob7FALigc7yBXKLTedktU0L9WwibwSe8wWcCzjH5mjLsGlnf5Ocdvcwc9mb9Oxzxsk2fhmwzTE7X7Nu3PO1chGpDbCszxvF8RtPbU5COSzYk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEBdSegW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B26C19423;
	Sat, 28 Mar 2026 00:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774657498;
	bh=eTCuq4xez0vRuryl1L76sF2NU8W9lCO8PmiMdzIiDBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEBdSegWlvIzxkGddNU4cuLR7KNEE8qw7KFyCV+XCSbjlJKtyWcmrXZhjn87Xa1is
	 3jQsSumSCMyPH4bKcZqCWIMJqRbbs+no3tkcOtwKTCZI7A/qdmr3oTwbjdOLGG06Eo
	 0HuYkmdaYUymjYR/gJ1koCwTAoUAJ0+dwYRRkQZkGouHqu0/2u8RStlmsbFmtt4JQm
	 yneA/AKnljzIqoif7IPncCfh+z030qsGGGkZjZJKzotvPIl12VJFheqUwR5BnzTILt
	 BAHAHI9c8v1nbFPGXUpxkmwCct350914tiiVRYWtbsOwQjVgoS8+0zKHdCbz4WuKv/
	 GkqoC1VWPsjvg==
Date: Fri, 27 Mar 2026 17:24:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Message-ID: <20260327172454.6b9bc8f3@kernel.org>
In-Reply-To: <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
	<20260326120342.6429fbdc@kernel.org>
	<5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272702-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,local_termination.sh:url]
X-Rspamd-Queue-Id: 8B95E34CAF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 09:32:22 +0200 Ioana Ciornei wrote:
> On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
> > On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:  
> > > This patch set aims to add the necessary support so that bash written
> > > selftests are also able to easily run with a remote traffic generator
> > > system, either be it in another netns or one accessible through ssh.
> > > 
> > > This patch set is a result of the discussion from v1:
> > > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
> > > Even though the python infrastructure is already established, some
> > > things are easier in bash and it would be a shame to leave behind the
> > > bash tests that we already have.  
> > 
> > I think this introduces a bunch of regressions, eg:
> > 
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
> > 
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout  
> 
> I cannot reproduce this unfortunately. For example, local_termination.sh
> gives me the following result with the exact patches that I submitted.
> Any idea on what might be the difference?

Hm, the system that runs this on our end is:

# cat /etc/redhat-release 
Fedora release 43 (Forty Three)

And it has this added on top of default install:

# cat /etc/systemd/network/99-default.link
[Match]
OriginalName=*

[Link]
NamePolicy=keep kernel database onboard slot path
AlternativeNamesPolicy=database onboard slot path mac
MACAddressPolicy=none

