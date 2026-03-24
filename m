Return-Path: <netdev+bounces-270863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBSlMK0EwmnOYwQAu9opvQ
	(envelope-from <netdev+bounces-270863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:27:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A46D301AC8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3ECF3019077
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49B392C58;
	Tue, 24 Mar 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cto8vUuM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08070382378;
	Tue, 24 Mar 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322765; cv=none; b=U7/hf1CTgioQa2I3sINnk8YR/X2whR2vBKm1fVAvVgfSVDVOMJlhEo2ejnMObDI1E642tt78gaqgL0NC6zJ+VOTDo+ZUvaMUx1pX5hwAKjuWlTsMABukz+fPhxW9h6Tsajw5l3iOADk5tFabnckL/UlWRxbm3dMIct0mwzKBIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322765; c=relaxed/simple;
	bh=dM8xcvzdCwGP0xEYUTAqBoCTq5vz7t0JFOfYavbXA0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvnNtuLLOOLO1Onw7Z1NVEPW6mQQAueQ/lmgewaSNzh77E90EnwMakuOyrNnsbT6pnmdo4hNuxSUPd76hDnqdxDn1gHWk7WnwaTYu/gZvKjG3T/F1aBTHDAvRkxtoS7xv2a5zx1HU0GpjW0gdaC9uBtZTv5Y8z4QMCT4oaFN3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cto8vUuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12008C19424;
	Tue, 24 Mar 2026 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774322764;
	bh=dM8xcvzdCwGP0xEYUTAqBoCTq5vz7t0JFOfYavbXA0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cto8vUuMLqYBM/NA3AfRulMTa8ydKlDxXVJVkojPdMuQKJRPnyp4LS5p4qPD6AY8p
	 CLTWh1YY605CylZHdPLpvKUC5nzVkvSq26p95ojrZjxorSvyjeQd11po/kVF8iy/12
	 wA52DtZM9RJ8+DbJScg6WOF1pXg8v4tdUWYzirDureRZC1pV8igDx2U0W/pcPO6lVV
	 EiLk3RHbYft/dbNlGf9BtJVSZ3MZybXCUWCO5bPjPj+2kudt1g4YTwcEFlpDi81fCE
	 9kEBfT8CAOemmTfKfTBnZaK4Ivypkki4vOwm32cTCPnI6wc0QjlCEoj4Py1ZOEkrgs
	 fKzzcJ1nBgg3Q==
Date: Mon, 23 Mar 2026 20:26:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Buday Csaba
 <buday.csaba@prolan.hu>, Frank Li <frank.li@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Bence =?UTF-8?B?Q3PDs2vDoXM=?=
 <bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Message-ID: <20260323202603.2897abf4@kernel.org>
In-Reply-To: <PAXPR04MB85106975EB34F6B1652953FC8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
	<PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<20260323172842.7a62979d@kernel.org>
	<PAXPR04MB85106975EB34F6B1652953FC8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
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
	FREEMAIL_CC(0.00)[gmail.com,prolan.hu,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270863-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 2A46D301AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 02:36:55 +0000 Wei Fang wrote:
> > > Reviewed-by: Wei Fang <wei.fang@nxp.com>  
> > 
> > I don't understand why you think that we should be exposing 4 channels
> > to the user when they can only use one. And have the user guess which
> > one should be programmed. Please explain (and Buday will have to update
> > the commit message), to me v1 looked like a much better fix.  
> 
> As I explained in v1, I think the "channel index" parameter of
> "/sys/class/ptp/ptp<N>/period" refers to the hardware channel number,
> rather than the software mapping to the hardware channel.

Can you cite any documentation or examples?
What would be the benefit of exposing the ID within the MAC IP (not
even the board) to the user? 
As I said the benefit of having just 1 is that user doesn't have 
to poke around to find out which one works.

> Although the current driver only supports one channel for output,
> the channel index should specify the correct hardware channel instead
> of a fixed 0. Perhaps Richard could share his thoughts on the channel
> index parameter.

