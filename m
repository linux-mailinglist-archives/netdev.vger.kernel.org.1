Return-Path: <netdev+bounces-294827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j4kPO3pTIGp/1AAAu9opvQ
	(envelope-from <netdev+bounces-294827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917216399D8
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:16:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d8sBVlSO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294827-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294827-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2858301531D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD93E1696;
	Wed,  3 Jun 2026 16:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C91E0DD8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503032; cv=none; b=mez2MsUNA5RUUF4kUZA+oBcY0oPOiDNZ3LB1/uNTXaZRQOmYP0OMGiAu3KOWIWeKaxMfd6QSuVzXLtzGaRfynFDZ45iolYfwwIj8E2Ily51N0DtCUbFgQzWBa6w/MzxIRkMlsa2y3TN8NvQ3V45hqycxw8dUA5A1fjFJc9iVUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503032; c=relaxed/simple;
	bh=0mS6MAHGDFnKDLKK2zdSAWFRx5HJJLdbhxNv/haHv0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pay+0V828SEDh/ExxjnNCxDH04B3YIfdmlQRNjQx3qsr7Foe/X/EzbBxUYFNos0DeSL0oope5iecIqQUjXrVbnZt7UyrF2Fsb5NV2hBixoHW8fBjGoiQMVbcQXEoazew1LlvmNt/KZMKNekv5wFhz91qbHEMZb3krU+L7kCrrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8sBVlSO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAA91F00893;
	Wed,  3 Jun 2026 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503031;
	bh=dV+EP92ywJyYPu8TFnUT+rRiwLzP+37t0c5eo2vvr7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d8sBVlSOB1H2+9iaPiCARqjcWISYHPGnd9iNOxLcYjyEM7MmelGqVZz6jTCp+KuC/
	 2m2zcpVdkY9XVHpFEnzJqeobWgtVMzBFSkMMzzxSHJ0K14DpdQ02J7VZa61DcAY992
	 sIRbavZccl+AYXpnXG/IxfRPfIVW7i2dTnURjJ4B0rGKtA2FQF5jfOA3mNKDb+kppf
	 w+vgbxZx79asvzoH49ZBEgLLPHApUXziI6/V5AnDL6Q72/t0zmgFQBMp0G1lT9SFc2
	 vZikeitEuXoOBHLNhs4wz7/Ksk+qpq1BPyzKHqZ0NjzQKN2wHqZRvP/mUbTzT2GnnD
	 whLpDFKT9eTAw==
Date: Wed, 3 Jun 2026 17:10:28 +0100
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 3/3] net: libwx: support vf hardware
 statistics
Message-ID: <20260603161028.GD3766816@horms.kernel.org>
References: <20260529075147.88398-4-mengyuanlou@net-swift.com>
 <20260603152417.3797775-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603152417.3797775-2-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294827-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 917216399D8

On Wed, Jun 03, 2026 at 04:24:18PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I am not doing so well with forwarding these reviews today.
The URL above should be https://netdev-ai.bots.linux.dev/sashiko/

