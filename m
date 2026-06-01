Return-Path: <netdev+bounces-293802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAmMFW6hHWqncgkAu9opvQ
	(envelope-from <netdev+bounces-293802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:12:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC06216DC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A88E3031E93
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034533D75CF;
	Mon,  1 Jun 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihU3/R/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32463BB133
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326264; cv=none; b=nx4y9K3XuE6iFZwvABJ/jRpWJahRsOGvnFFHAqttqO1gn2FgI2Q306jPfxO1x4kecupnD90oZjavtFuNd9x+vmQldZ4MqSIx8lNAFOSBrWSPJyF/mYt9USYtd5Uc8yLOHJPZsjzLjaFDsVm0UlUUQR6qk7z0McADEPYJ4mwdqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326264; c=relaxed/simple;
	bh=YWgu45yGwMYhj4v9kyNDwVUitvgDp51+yJVggCChQv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWW/OVgAGwGHNm5FFfpUJkESy4BRNbpvnNDl/quNMre/Wp1emE+ry64TzqceNhxiQuhdIJE8Sh/UPiEBvL2rHm3yau/FIYZtti75Ogzq4xEEn/o18mFiNrvIEi6R2T23GORx6whDvPOIAPVpxWbdlzdGRtZA4CuOXjdcjOvWxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihU3/R/M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199611F00893;
	Mon,  1 Jun 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326263;
	bh=T7WPQ1AphFikhcZRDPyNBwRUw8A3mKV74k7x3Hguvs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ihU3/R/MzVJfEj4g4LA0rEwPZG6CUS+uqToeMpPBFyt/RFHRS0PiIsk9raBmj+u5i
	 Nh6ogOby/VbrK95//1IpdadVNnHdJB5GmbB5Rf7nTdmry9CLXSqmQzY4cYOd69TRGg
	 gQUsknZ+yTya4kr4q5AIYDg6Xo4oPMTdU+iV/OYRbE2+VADa8d0Za4vhAdWsZpmAcs
	 B9JWAapNjIFqZ0h7PiAkG2i9WSn5KARRi9LWdHWr6qLiE9g22FdWL3JYLi/bALqO3y
	 T3Fl8bsoW9fQecQBGMOjIVK/ZFf6ftEsmHxgFOBvDLB9TNmwAJviGP8I9AwjTULW9o
	 VM0/nI8YgB6bA==
Date: Mon, 1 Jun 2026 08:04:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260601080422.0a210edb@kernel.org>
In-Reply-To: <20260529135938.0ba988eb@kernel.org>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
	<20260529135938.0ba988eb@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293802-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gve-netdev-nipa.static.usercontent.goog:url]
X-Rspamd-Queue-Id: A8EC06216DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:59:38 -0700 Jakub Kicinski wrote:
> On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> > We are happy to share that Netdev-CI testing on both IDPF (running on
> > Google Bare Metal) and GVE (running on Google Virtual Machines) is now
> > up and running.
> > This NIPA integration work enables executing kselftests against the
> > current proposed net-next kernel branch on real hardware.
> > 
> > Thanks to Danny, Max, and Pin-yen for their contributions!
> > 
> > The test results and logs are available in:
> > 
> > IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/results.json
> > GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/results.json  
> 
> Awesome stuff! Pulling the results now.

Hi! You seem to be pulling the wrong branch stream. Please switch to:

https://netdev.bots.linux.dev/contest/branches-hw.json

