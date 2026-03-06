Return-Path: <netdev+bounces-264937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEG6I8VIq2lcbwEAu9opvQ
	(envelope-from <netdev+bounces-264937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:36:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D6228095
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0E48304150A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8584921B7;
	Fri,  6 Mar 2026 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b543YH+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7735C1BE
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832894; cv=none; b=ME/RtbW2pfFFzKqIsFmgnGlRAPQw5LEjgajcZsujYIJEyfWRwQbYK5PPbNXToyPA5+O6fZGiJZnJJBcSQGE5Qsjti7YiIYSzeGmcdtu9FoyF5eif+KaQwW/cIm7MRM65XahYF0XDKgTh3D9vth6mNEVghUWdTsbp4MnHO0lqTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832894; c=relaxed/simple;
	bh=RmOjQI27w8qt6Hy3OmiOo3U/if9ywnIgHB6qrSkuFHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr2zjxkg8E1UKdAu6UVcoOh/eEhnGchVOf+3l7a9Qdm+x6BLzDnm/spCgypL6bC7Qi7d+CJxR9FaGm7bYAhVEIoNCxE6XMCC9VAiRS5RD17k6tOsV20rd/xyrI2QVDu1pkwNf2m7brCHAZpzCI5RlH77WlVK4BgT1m6s8ZPbj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b543YH+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B93C4CEF7;
	Fri,  6 Mar 2026 21:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832893;
	bh=RmOjQI27w8qt6Hy3OmiOo3U/if9ywnIgHB6qrSkuFHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b543YH+wrtBAhooc9f2vQMw/d+KFEs2By9P7D0Nen2Vdf2REl4vTUbkIqRjqRaofM
	 EANHx091PylzvUEwA6goLN/HbgvFQcf3PT94ZrCoznfN24UXGt51dTSWggSLREK+Zl
	 DfBD7e5/g8wFF9llpBR4A1rRv7Fy2wXurej4sFjf4I4BO06p5F604YcpJlPuEJE0iK
	 7Qkfcg3q4jNf+wW8Z7Z8+wIjsV/YoBvN/G6MDTIInESkgKx+Vp0ynWjqc/d9flrQkG
	 iNUdFnJYfDeGIPdh0fJapuAZWej4R5f1+Nbggg09iCmAwa2PpUQR/J3V5kUZmZSclp
	 4jGkFsG+4Ga3g==
Date: Fri, 6 Mar 2026 13:34:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Wei Wang <weibunny@meta.com>, "daniel.zahka@gmail.com"
 <daniel.zahka@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, David Wei <dw@davidwei.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Message-ID: <20260306133452.71d27227@kernel.org>
In-Reply-To: <willemdebruijn.kernel.101ad57610d58@gmail.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
	<20260304000050.3366381-6-weibunny@fb.com>
	<willemdebruijn.kernel.2c99d96277de8@gmail.com>
	<SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
	<94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
	<1d2b02b2-0541-4a17-af2a-95345395d2b6@gmail.com>
	<SA1PR15MB5817DD5000DA78CC8187C743BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
	<willemdebruijn.kernel.101ad57610d58@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4D0D6228095
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[meta.com,gmail.com,vger.kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 18:41:09 -0500 Willem de Bruijn wrote:
>  [...]  
>  [...]  
>  [...]  
>  [...]  
> > 
> > Agree. And the current set of privileged operations should only include: dev-set, key-rotation.
> > All others should be unprivileged I think...
> > (The get-stats command which I should make sure they are called with unpriv = true. I will change that in the next version.)
> >   
> > >
> > > well, now that I sent that I realize that criteria is so broad to
> > > include things like rx-assoc and tx-assoc, which obviously need to be
> > > unprivileged :(  
> > 
> > Yes. tx-assoc and rx-assoc are currently implemented as unprivileged. They call psp_assoc_device_get_locked() which currently calls psp_dev_check_access() with unpriv = true.  
> 
> Consider a more descriptive monitor than unprivileged too. As is, it's
> not clear what privilege or capability is implied.
> 
> Perhaps just assoc_allowed?

Sorry for chiming in late. Maybe things would be more intuitive if 
we flipped the logic and called the arg/functions "admin" instead
"unpriv" ?

