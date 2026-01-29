Return-Path: <netdev+bounces-254950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A+lcHTjye2lUJgIAu9opvQ
	(envelope-from <netdev+bounces-254950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:50:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23AEB5C47
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21A4300E700
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9934028B;
	Thu, 29 Jan 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUpYwyau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9319E98D;
	Thu, 29 Jan 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730611; cv=none; b=CwzqVvCvsl/GbLCJ64/WsMhIcX/adhMpmf6hPrggpP1Rk0SLibTPrjyQov+J/O32zP2TepKWiDPsA+sW37vd8HEAMx3vQe+5FKNsKlS/9ijqj9yOL3/9N0VBNehu61cNSZ7Za/3zrkTnEFog/KvohCSJw/VBZp/OE/eh4Ri9NXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730611; c=relaxed/simple;
	bh=beUftDkc5bV8cl152qEMKb2KQTi02v1rbZ9UrvM4d+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEmYg3p2BQMSXV8HwlYHWid5Udn7oVx1RVDlCvjNxoG1KXOmCOoVEAHhB2gCa0zcy+Kwluap4zXsuYxuJvHXfmHgCBD1TSfOmeeEUrtbtIpJ6Hw2DtHk/dAx71rg1/jnBKYEGIY9kcQNzpZEqoab4Vb4px7dsLvbypZcFCEpOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUpYwyau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD02C4CEF7;
	Thu, 29 Jan 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769730611;
	bh=beUftDkc5bV8cl152qEMKb2KQTi02v1rbZ9UrvM4d+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uUpYwyau8JqVuQ0sBy0ksNomK9coJPRFh25GFM+Uafiu+y3BkB8deJYCbipB1IAcb
	 DemToZ658jCQQCwOCI1JeDoeLfq0tlxKvemccWv2B8OQzx2g2TVDsO6FSKehd8fN25
	 FhVXeAHGzJ4Dq5LFZ/vvhhGRdKS95ZCgkzPh1jxgcu7bDq1AK4HUx3ntODLtzY1g0E
	 vT+WPgOCzjpq6GGL3pCYo36RUDq63nNu+cP0QoTYDWzFiy9oNVzU/giCb7Ojmx2wsx
	 qJt7jFCmHiAn0SCe/Qs20lX9Tfroeqotu74XfHos1H87c+x6dgl9INCEYf1t9IY2eb
	 f5aA/IW4HqTCQ==
Date: Thu, 29 Jan 2026 15:50:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <edumazet@google.com>, <sumang@marvell.com>,
 <linux-kernel@vger.kernel.org>, <sbhatta@marvell.com>,
 <davem@davemloft.net>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>
Subject: Re: [net-next,v6,01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <20260129155010.64297c67@kernel.org>
In-Reply-To: <aXrutHgsKEuJUlGK@rkannoth-OptiPlex-7090>
References: <20260128071235.3577206-2-rkannoth@marvell.com>
	<20260129051301.376533-1-kuba@kernel.org>
	<aXrutHgsKEuJUlGK@rkannoth-OptiPlex-7090>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254950-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C23AEB5C47
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 10:53:00 +0530 Ratheesh Kannoth wrote:
> > When cnt is odd, the final loop iteration has i = cnt - 1, which means
> > subbank_srch_order[i + 1] writes to index cnt, which is out of bounds.
> >
> > For example with cnt = 5, the loop iterates with i = 0, 2, 4. At i = 4,
> > the array access subbank_srch_order[5] overflows the allocated array of
> > 5 elements.
> >
> > While CN20K hardware typically has 32 subbanks (even), the value is read
> > from a hardware register at npc_priv_init() without validation beyond
> > checking for zero. Could this lead to memory corruption if the hardware
> > reports an odd subbank count?  
> subbank count is 16 or 8, depending on SoC variant. i will add a WARN check on
> odd ?

Or just a comment may work to prevent the false positive

