Return-Path: <netdev+bounces-268373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOE0BzKpuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:06:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA322A273B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A89C300AB03
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5523D2AB;
	Tue, 17 Mar 2026 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omvxpP0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6F1D9A66;
	Tue, 17 Mar 2026 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709437; cv=none; b=cpuG24+3XVBLmA1nonttjlyHZb8bVbcXlNBaYgsB+C58N5Je3EalRwVto8rEnaUFLzlJwt/eIi6XPO9wpp59l6xgskPpsrHXYgogJeDFn5o8T9FqPcn7CWmP7fWrsUhtJqUx1BZGYhWciY6ZwWLgxCw8NGY5VOB88/4OLY+GYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709437; c=relaxed/simple;
	bh=GmfJjzGrEOGL1bTD1Jb99iyhPbhSiGVs6GwA3XHnmjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st4YP7YlNd25FWtm3lsegacdFrae9wHNHPqH/tBOYaYecIXwJRgkpr27AUHexaHGYZq0XyLncE9fpZoMezGLWmNlrExUThOmrTWyWukhs9scrU+n6GOJfE5AEGpbaKfnSfghh8402OpIs7GWkeyTU4TlAlZQWTDnZfpH7zD1IWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omvxpP0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E32C19421;
	Tue, 17 Mar 2026 01:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773709437;
	bh=GmfJjzGrEOGL1bTD1Jb99iyhPbhSiGVs6GwA3XHnmjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omvxpP0K4ianStaMUEBrn6iBemUmszT+Dev/O7n1PwRZpNJD2QJ8ho0dYOr2/rTT+
	 lkUvq/WC5o+vBtfAlBCLMM4ghyhazxSR1buxBVNeI5C2CALH0c8gyUSC2ey3fwTqkr
	 tJaNFNRIbD9FJHhL3iqgaDRBd3RFsYYn2zDQbRosWeXW1TW0SgBOA/dufHRaxdmrbQ
	 A55yOCRYLMKjxTjbRAzgWsjWnMEIs0a5aueJrvkLEPwvH46r8avBD21PM2T0qNxKh6
	 9IWoiqQs0+9d2JAzQoO5V7AWhzoTSE4/jnq1teKevSbkCOatrpyRm8JHRJ6vDzWqfc
	 PN/kQTuKFHVyw==
Date: Mon, 16 Mar 2026 18:03:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
 <dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
 <sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Alistair Francis
 <Alistair.Francis@wdc.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "horms@kernel.org"
 <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Message-ID: <20260316180355.37d45785@kernel.org>
In-Reply-To: <9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
	<20260309054837.2299732-3-wilfred.opensource@gmail.com>
	<abQOGm6BqAE5eEln@krikkit>
	<20260314073919.2f92b966@kernel.org>
	<9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
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
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,wdc.com,redhat.com,linuxfoundation.org,google.com];
	TAGGED_FROM(0.00)[bounces-268373-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EA322A273B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 00:53:07 +0000 Wilfred Mallawa wrote:
> > Or maybe you could refer to existing implementations of this feature
> > in user space libs? The padding feature seems slightly nebulous, 
> > I wasn't aware of anyone actually using it. Maybe I should ask...
> > are you actually planning to use it, or are you checking a box?  
> 
> For upcoming WD hardware, we were planning on informing users to use
> this feature if an extra layer of security can benefit their particular
> configuration. But to answer your question, I think this falls more
> into the "checking a box"...
> 
> I'm happy to drop this series if there's not much added value from
> having this as an available option for users.

I'm not much of a security person, and maybe Sabrina will disagree
but I feel like it's going to be hard for us to design this feature
in a sensible way if we don't know at least one potential attack :S

