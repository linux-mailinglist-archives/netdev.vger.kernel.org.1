Return-Path: <netdev+bounces-271013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FjgGP98wmnqdAQAu9opvQ
	(envelope-from <netdev+bounces-271013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:01:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33971307CE4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3718D30BC535
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76D42853EE;
	Tue, 24 Mar 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XDn73kVm"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA3366046
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353143; cv=none; b=lM5V00wNvm8FaajVxG+mzpABcPxp42G5Ux5d6+f3CPNKnwq+okzm8jzAfEt+mn9s9rzhrKJ5mwHMvv/yS0Z8jpHszee1YFWDPOSEuWR6cznumZCQjMj17jm7cEYItjWwIFgTVaLRe75N13/f2XXiL0Td7cCcN1sQu1Qq/4lhFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353143; c=relaxed/simple;
	bh=NbViYVTxKKNajtW8MFRsXnuoZK4QJbFIThyCP7LqdWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9Vz3v1U6v+WySR+1/qj8afp/2bP9Yat1UQQtV+uKNJWOfHE4egBLA0h5puPhqYY4p9TIvVMB5f2ys95R1rZuvMlIw5eXThNlLR+QlpjssSSGwHKpOgROnIUp/XdyNAefHO2sPqXbDuD2fjp/H/Xx7F3H9JZtY0aZSpx2H79fT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XDn73kVm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 704FC201A1;
	Tue, 24 Mar 2026 12:52:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsr2lnLHMyne; Tue, 24 Mar 2026 12:52:11 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CBC5020189;
	Tue, 24 Mar 2026 12:52:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CBC5020189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774353131;
	bh=suHzHdfdSBFAI2CS1x47XLFogXEneDddsJ8T5tsfTlo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XDn73kVmwL/QuzWj36NX6sw+q+GdXlR5ONsQW+gBy3bNluvT8TR57U0SsYvJrfLXv
	 8qvoTvH7cklOGh7+LZBsb/O7gDy2YmgH7sT+7rq/wOfSZFgcAtN05Hk2JTMx4nunlf
	 P2UJZqyrYBJ0dCoY/cSCMRwLt1r52Pi2Qeqe9JyX1iHr4Yz/kbcOgDO64hmfMrQaTH
	 PYvGVAOFQRKmS6Y9S2qrKZX9vUPaYMZVD07WJoPOs2Ze+tu61e94Sto6JZF7hlT63X
	 nNrD8sSJX8mwA94Zp/bZ4/j2w720/jye+TymWZ9fbvWHnX30CozTqnjupuj4gQGmUP
	 hQ2mhfttnDBJg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:52:11 +0100
Received: (nullmailer pid 3694266 invoked by uid 1000);
	Tue, 24 Mar 2026 11:52:10 -0000
Date: Tue, 24 Mar 2026 12:52:10 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone
 setup
Message-ID: <acJ66ndBOEs7d-1D@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
 <20260323083440.2741292-21-steffen.klassert@secunet.com>
 <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 33971307CE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:33:15PM +0100, Paolo Abeni wrote:
> On 3/23/26 9:34 AM, Steffen Klassert wrote:
> > From: Paul Moses <p@1g4.org>
> > 
> > iptfs_clone_state() stores x->mode_data before allocating the reorder
> > window. If that allocation fails, the code frees the cloned state and
> > returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> > 
> > The xfrm clone unwind later runs destroy_state() through x->mode_data,
> > so the failed clone path tears down IPTFS state that clone_state()
> > already freed.
> > 
> > Keep the cloned IPTFS state private until all allocations succeed so
> > failed clones leave x->mode_data unset. The destroy path already
> > handles a NULL mode_data pointer.
> > 
> > Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> While applying this series to verify the PR, I get the following error:
> 
> Applying: xfrm: iptfs: only publish mode_data after clone setup
> error: sha1 information is lacking or useless (net/xfrm/xfrm_iptfs.c).
> error: could not build fake ancestor
> Patch failed at 0020 xfrm: iptfs: only publish mode_data after clone setup
> 
> The above also prevents the CI from testing the series. Steffen, could
> you please have a look? Possibly a repost could be needed.

I guess this is due to a merge conflict with:

69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

Repost will not help in that case. Not sure what to do
here. The only thing that would fix it is a forced rebase
of the ipsec tree onto the net tree.

