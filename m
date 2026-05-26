Return-Path: <netdev+bounces-291966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAspGKQgFmp/hwcAu9opvQ
	(envelope-from <netdev+bounces-291966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:37:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AAA5DD3CF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5413029E75
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F33C8C47;
	Tue, 26 May 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtIR2Glq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02593C5823;
	Tue, 26 May 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835041; cv=none; b=RiJ8PgjyLRI27kbik5XxoDPkh6tPA5e/hJM5/wXtVFSx1hc6fyrxadY80ij0vP2omFI11OqSsFSST3WO0eXm2p4CZgDyK1O51iAo7+gcxjl4cDFyIDYX0JCkyGXij0jfWmZeZeKKcP3lF8qv9ly1yUnnm83gBY6F5bSTuEA8qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835041; c=relaxed/simple;
	bh=t3DDdLoiDpa5mzDeyTIAK0ED3ZALYS30CX3shJvZjNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0phnpGx/F+yPEGtXWI1NENA4rB91QvV6zXSgPJ4E+1dT0JfTekXLsHoQO4LEdG+mC3eMt2LewbQzqqXB1UFPP9go7zDiu6DQz0nBa9TXVZflrlgJTC/pqdflhckNqjfAVRNV9wRQhjJQP3Do5I4uW3JB3ZYb5yewHpcgV2buss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtIR2Glq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082271F000E9;
	Tue, 26 May 2026 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835040;
	bh=t3DDdLoiDpa5mzDeyTIAK0ED3ZALYS30CX3shJvZjNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DtIR2GlqYowlJKZ/IiOqFfgZPFXIFmw+EyJGl8R2Oi6Nv5TM9WfpLxSMQlXsc53rU
	 q3oy3eg8h/BsMh6eGUMMmQO2dA1Osw6VmkvlJw5p3WFUjyD9SvP9YWqzsxMDhIb3Q7
	 l5jFMpAMZwOS9LgPsD2wvvRpUZfR4ccsby+Tke0YdupjlppBLcEWaOZqDIR96V5FQ0
	 R5CK4U08pLzhgP7CvR/DTDm40QByuiy4KYUVjnTn8cfVD/NseLl8ATrqw3MVppYyoV
	 2TwW2iSGVBWNM+zl8ORfUR48vEbZ0SiJLcL+MYBLyCIgfZeUqIUPvSOneFQPpLNCfm
	 f9vCHAebIY1bQ==
Date: Tue, 26 May 2026 15:37:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
Message-ID: <20260526153719.7261b7f2@kernel.org>
In-Reply-To: <1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
	<1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-291966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E1AAA5DD3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 11:48:41 -0700 Randy Dunlap wrote:
> WARNING: ../include/linux/netdevice.h:2622 Excess struct member 'ax25_ptr' description in 'net_device'

I wonder how that sneaked in? ;) ;)

I'll clean this up separately, hopefully we haven't regressed too many
things while the script was broken :(

