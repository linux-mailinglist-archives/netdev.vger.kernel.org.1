Return-Path: <netdev+bounces-271052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II0yKmqIwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:49:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD9308A12
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8BA3021426
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FB2C0299;
	Tue, 24 Mar 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ed3oZcZu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FC241665
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356057; cv=none; b=pPWujhco8FrvFIAM2K2hGOxLWBxQs2loKcWGMS5lLsYDwV2MOQCkl/KJpz1ZaUutpMRoM/Xy0LLexjLjbTfodyz/+yEXZNrYPpopTyhDEU5lJqJZbCLbS9iUDvY/vmuCfNPa4v2dc5lBtJVHST/TYWjQJlQZw56VJ6ogBqEcMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356057; c=relaxed/simple;
	bh=mtUz9q4etv0YHVPmOccQN1oM80hPcnvw5ZO3ZQ2IGy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqBmGS+0bRsPeo9jriCItmMaCWAkm9m2cV3G7DhIgNsgnK9INPeMk5Se15FwyzM4AOChIZija3SHvhAEwxPnhC/cUMci4dwxJaPaJtMlbxfjH92oA/dHWPejYegn5zkXsngK0VrwtnCcnKi5Q4n9GJxZOkVLiP+GZxwg0K5hDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ed3oZcZu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0C7F5205DD;
	Tue, 24 Mar 2026 13:40:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ndsuqjvj-bWZ; Tue, 24 Mar 2026 13:40:52 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6297D20190;
	Tue, 24 Mar 2026 13:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6297D20190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774356052;
	bh=ZwD3FsudODxrDtfXNfd0myxeAouVNP1Cnwc4Q+0F7fw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ed3oZcZuJC9TnESmD5WEPlCU1Yjn+d5/fV2OZWIwLV6dnOqoyBI/avcYEQ1oyPZRz
	 RSRX9mOjDuqFCh8XOo9efNpw2Ai0Q3bRHtKYGMaYHyWCDJ1hplhlZ1tbisE1Uk1RO9
	 oI5eNjqb+yp4WT/hvE34cSJiEB3ByHDV2O/d4+6Eaw7DAqnV/elZ340EQ/yYQGYksB
	 QECOfhTO3+q/+RsJyunjXvPkR0snm1E3sIOle5zeutbp3NrGi70JSRt36zlrWqtgvA
	 tzUXIgjYMkQ/bA7/1jd0n9kxFAQDl1k9Im8k2tr7Xxa0Sx/ZMnFj2YnMqGi4nklEqY
	 jTzCYpiHQw8Zw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 13:40:51 +0100
Received: (nullmailer pid 3719584 invoked by uid 1000);
	Tue, 24 Mar 2026 12:40:51 -0000
Date: Tue, 24 Mar 2026 13:40:51 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone
 setup
Message-ID: <acKGU5rF-yH2LI7v@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
 <20260323083440.2741292-21-steffen.klassert@secunet.com>
 <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
 <acJ66ndBOEs7d-1D@secunet.com>
 <75af5781-0ed2-4b05-879f-db6628af0692@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75af5781-0ed2-4b05-879f-db6628af0692@redhat.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,secunet.com:dkim,secunet.com:email,secunet.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-271052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50CD9308A12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:35:25PM +0100, Paolo Abeni wrote:
> On 3/24/26 12:52 PM, Steffen Klassert wrote:
> > On Tue, Mar 24, 2026 at 12:33:15PM +0100, Paolo Abeni wrote:
> >> On 3/23/26 9:34 AM, Steffen Klassert wrote:
> >>> From: Paul Moses <p@1g4.org>
> >>>
> >>> iptfs_clone_state() stores x->mode_data before allocating the reorder
> >>> window. If that allocation fails, the code frees the cloned state and
> >>> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> >>>
> >>> The xfrm clone unwind later runs destroy_state() through x->mode_data,
> >>> so the failed clone path tears down IPTFS state that clone_state()
> >>> already freed.
> >>>
> >>> Keep the cloned IPTFS state private until all allocations succeed so
> >>> failed clones leave x->mode_data unset. The destroy path already
> >>> handles a NULL mode_data pointer.
> >>>
> >>> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Paul Moses <p@1g4.org>
> >>> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> >>
> >> While applying this series to verify the PR, I get the following error:
> >>
> >> Applying: xfrm: iptfs: only publish mode_data after clone setup
> >> error: sha1 information is lacking or useless (net/xfrm/xfrm_iptfs.c).
> >> error: could not build fake ancestor
> >> Patch failed at 0020 xfrm: iptfs: only publish mode_data after clone setup
> >>
> >> The above also prevents the CI from testing the series. Steffen, could
> >> you please have a look? Possibly a repost could be needed.
> > 
> > I guess this is due to a merge conflict with:
> > 
> > 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > 
> > Repost will not help in that case. Not sure what to do
> > here. The only thing that would fix it is a forced rebase
> > of the ipsec tree onto the net tree.
> 
> Out of blatant naiveness on my side, how much of a pain would be that
> option? If more than negligible, I guess we should avoid it.

It is some work on my side, but the bigger problem is for
those who cloned my ipsec tree. They all need to do this
forced rebase then. This will hit them by surprise then.
So IMO, if we can avoid it, we should better not rebase.

