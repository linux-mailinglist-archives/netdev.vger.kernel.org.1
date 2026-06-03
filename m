Return-Path: <netdev+bounces-294829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GBUBIRdUIGrQ1AAAu9opvQ
	(envelope-from <netdev+bounces-294829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1145B639A49
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:19:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="BggW1/Di";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294829-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D073093749
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191713E3164;
	Wed,  3 Jun 2026 16:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69933E3D8C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503051; cv=none; b=T8O5gp8WWo50wfPvpMxacBx8w3D2tEddG+GB5ZQf0kfb8gyuPsk89U4Uf/xD7/gAkEKiLq8PFnL2R3wbdLjOcayfyLTr0lZJbzgqLzLAVwsuwLSuWfUN7wbF3fBhMcKy8XeFdtw/9pCfslse3Py6UFHZ3c/wP+55Cj7a5amjTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503051; c=relaxed/simple;
	bh=vcNCBYpMd3GNl+Nv+ZqL1miedUHcnfgEH5HqLFmzhvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0CJanw99Y4lby63o0tF6avXprELbM24GjBc+6kJes7ONwj62wD/uhHBt6npoZCfLFPaYIHUo8ToH6lJmuB6eZ7gMyswk26wnz5qNfv9TlJ8lYCeyNzO4hmXBl0aeBZWUNEecckMB+dX+zP76AmVm04AlUsG9SV16PunvaXAU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BggW1/Di; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD11F00893;
	Wed,  3 Jun 2026 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503049;
	bh=tMGWl3y2yD1smshZAAFSEzj45qRIcV6N4Z0FpgXqeVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BggW1/DifwjC6dcwIpt4g4WGql5WGQ9Ce3bDyU8IdEC/B8QIbPG5n1l/2tXNK2oDG
	 KTEhpHuSJsz0Lvg5z6ZyrzxOadISXJ0oxIq/ABn5EevUnhMBrnxc7qde1z99L05yV2
	 HnbVOt76YRxTcSs9XtU4tQI+wtFNaCuIA3UnBbkhRFM7EP50AQmebvAeu8e8L5/L8C
	 kyyxotw9Svn3Ek7U5JJyYvVN2GgzQU3wmymCsAijGdjkgkV8dbY7p6wTmqPDeWbSm0
	 5QnVtWUEM8Gwv1xSbVe8mj8CJoZnoJjXPGbfLPcmeqidGXVXbkR7BBN+taEYStZ+xF
	 94Aicw+upJ5Dw==
Date: Wed, 3 Jun 2026 17:10:46 +0100
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 2/3] net: libwx: add support for set_coalesce
 in wx_ethtool_ops_vf
Message-ID: <20260603161046.GE3766816@horms.kernel.org>
References: <20260529075147.88398-3-mengyuanlou@net-swift.com>
 <20260603152324.3795898-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603152324.3795898-2-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294829-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1145B639A49

On Wed, Jun 03, 2026 at 04:23:25PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I am not doing so well with forwarding these reviews today.
The URL above should be https://netdev-ai.bots.linux.dev/sashiko/


