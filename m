Return-Path: <netdev+bounces-286369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGxzGq/RAGoxNAEAu9opvQ
	(envelope-from <netdev+bounces-286369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D4505C04
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C390E3008207
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FA3101C8;
	Sun, 10 May 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Vc8CGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C22BE7D1;
	Sun, 10 May 2026 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438572; cv=none; b=Q409Sd+w1YPUerUnUe+WEccrFQNXwMPPnpc8QhS9ujEVpEbeg3+g9Dy9LOLmwwT4RMIlMR5McAvDHlxovQk1Kyku0G9xgsx0zzE8FF88oqDwBab2+Nl8ELKZjkgj9/qMIFqyzdAdLnaVmoS8cGxqfm6pO+mC8zlzKYG3p4mTucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438572; c=relaxed/simple;
	bh=c5c2ZAL03zmKL8mHxnCnpohMbFC9CvMEM4kXlgE/Jro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYu3l3v9USJwL47YVwCp/uLXn6gyuX3XNX+tmnkZ7g2sbAKXBn+7Nm6me561/qHNQpUGaMHLdMQnfLp6E07SedVLPd58i8dws+XE6eEWCIAZF6rSZ6WzLE/h4nb5zX9uunZ1lfnBFpS2/Q2UrVr3mbbhsjCxAlELzu8Ip6V4TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Vc8CGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92FC2BCB8;
	Sun, 10 May 2026 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438571;
	bh=c5c2ZAL03zmKL8mHxnCnpohMbFC9CvMEM4kXlgE/Jro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8Vc8CGEduvYMQKW02kF20a0L74C51+hoXAZrmZlbx/uluKdoYP//PCKV4v5WPBsd
	 qSTzqD/9SfX2mNtpX7sdPY03ebZZAWdxawdhVUKOSK6sIDIWdEVSrym/JhYpqO3LM3
	 gNFhkxeu/9M8LAmF5fXojTv7SpeXheAUqUsBPjyFe4gwRW0aQcryn0X3JCGLASjJQv
	 B6/v1GeQJT1k+Tp0mNeUNr06t85/5q9LK8rpDkwKWjRyWdVk7eR0ZOHAcq2DQbJQZ8
	 dq53jygvu8w0tLXE4iLILZ7Df/PE4zzaHq046e+O4WvPZZFZL9QHaukUBv09QLzlQV
	 W/QMR/+39pvKQ==
Date: Sun, 10 May 2026 19:42:47 +0100
From: Simon Horman <horms@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] net: xgene: fix mdio_np leak in
 xgene_mdiobus_register()
Message-ID: <20260510184247.GW15617@horms.kernel.org>
References: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
 <20260510184122.GV15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510184122.GV15617@horms.kernel.org>
X-Rspamd-Queue-Id: B98D4505C04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286369-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 07:41:27PM +0100, Simon Horman wrote:
> On Thu, May 07, 2026 at 07:50:24PM +0530, Shitalkumar Gandhi wrote:
> > The for_each_child_of_node() loop captures mdio_np via break,
> > holding the refcount. of_mdiobus_register() does not consume the
> > reference, so it leaks on success.
> > 
> > Put it after registration.
> > 
> > Fixes: e6ad767305eb ("drivers: net: Add APM X-Gene SoC ethernet driver support.")
> > Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> FTR: There is an AI-generated review of this patch which you may
>      want to look at for possible follow-up. I do not believe it
>      should block progress of this patch.

       I meant to mention that the AI-generated review I'm referring
       to is available on sashiko.dev.

