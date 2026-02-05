Return-Path: <netdev+bounces-256948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGywAGgahGmyywMAu9opvQ
	(envelope-from <netdev+bounces-256948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:19:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 669CDEE7FE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1B7300A774
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79472D8372;
	Thu,  5 Feb 2026 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0df59qI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A6287246
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265156; cv=none; b=YKcHVdIixw4uoqcMcsO+Pg15PDILXzcU3mGzIZA1xOeoGAGcfo1JA/lv+EpxbUA3IXvhCwyjKc6V7vdAnmjR34e3Zxqjbu1JiAeQRM8YkGRXwZmK9SIOUvqk1WYtc06UlN28vNAzMIQPQj9CH/1Z28IU97FWgB1iXkoUNJ43UHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265156; c=relaxed/simple;
	bh=r3rWarUlr8ZEa9xcSykQN5668mZqh3AigD3eblKD3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8cshhUpgcO++iLiE/37yy3AGfpTAA9bJdwMvowO/Q+D7s64NCU9JWeBsLdLppvZKnklx2qWYvERIXPVp90KEZ+oeWhp9y+7UPey1YcsH8bFgI0suINVt43c1R7BSD7xWtAZ9zZYrnlewjoij8j3mx8wCeGJ90NSaRIn51mYiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0df59qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829AFC4CEF7;
	Thu,  5 Feb 2026 04:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770265156;
	bh=r3rWarUlr8ZEa9xcSykQN5668mZqh3AigD3eblKD3KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d0df59qIQvIziQUABBU9Dp2OeGTdJGwo9msH3M/9zDmIbUTcKLc9G4a+NqAdeFEGi
	 AHh8q9GMwGYRW4sk9l0PusaP3UvGrKM5qem2CgYf6nG5jLqBdTk4RucP6X92Bs4XZY
	 vzR44ye8i6REOHDIYGEW2jgRB9vD/eZCh55P3LaUty+XYonBnCFX2f4JVddUWCA1HH
	 7tBvHQqdhYOoQA8zmuEAy7/A2UVRPmcSEFZBNXL4Dc6JrvflFai8rb8ebt2BwoXHiv
	 uTKuo5qLjUvLqDmZOHy7fQxXiekQmcSn35sllWahssTM1MAWEA6gmGdIEbi7eCw3Pj
	 R3i2QxXS8CP9A==
Date: Wed, 4 Feb 2026 20:19:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: haokexin@gmail.com
Cc: horms@kernel.org, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 elfring@users.sourceforge.net, byungchul@sk.com, andrew+netdev@lunn.ch,
 h-mittal1@ti.com, danishanwar@ti.com, pabeni@redhat.com, m-malladi@ti.com,
 jacob.e.keller@intel.com, rogerq@kernel.org
Subject: Re: [net-next,1/2] net: ti: icssg-prueth-sr1: Remove unused
 workqueue
Message-ID: <20260204201914.73fec717@kernel.org>
In-Reply-To: <20260205041702.2354424-1-kuba@kernel.org>
References: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
	<20260205041702.2354424-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-256948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 669CDEE7FE
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 20:17:02 -0800 Jakub Kicinski wrote:
> > @@ -883,8 +878,6 @@
> >
> >  free:
> >  	pruss_release_mem_region(prueth->pruss, &emac->dram);
> > -free_wq:
> > -	destroy_workqueue(emac->cmd_wq);
> >  free_ndev:
> >  	emac->ndev = NULL;
> >  	prueth->emac[mac] = NULL;  
> 
> Removing the workqueue creation here is fine for the SR1 driver's own error
> path, but doesn't the shared cleanup function prueth_netdev_exit() in
> icssg_common.c still call destroy_workqueue(emac->cmd_wq) unconditionally?
> 
> void prueth_netdev_exit(struct prueth *prueth, ...)
> {
>     ...
>     pruss_release_mem_region(prueth->pruss, &emac->dram);
>     destroy_workqueue(emac->cmd_wq);
>     free_netdev(emac->ndev);
>     ...
> }
> 
> Since emac is zero-initialized from alloc_netdev_mqs(), emac->cmd_wq will be
> NULL after this patch. Can this cause a NULL pointer dereference in
> destroy_workqueue() on module unload, since destroy_workqueue() does not
> check for NULL?

Maybe it's not worth separating the removal into two patches if there
are surprising dependencies here? Squash them into one for v2 perhaps?

