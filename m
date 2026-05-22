Return-Path: <netdev+bounces-290724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLArH/IWEGrhTQYAu9opvQ
	(envelope-from <netdev+bounces-290724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:42:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FA5B0B19
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AAF8300AB15
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B1438E8C4;
	Fri, 22 May 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1pcDjLX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40234A3BF
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439343; cv=none; b=cNWgqZ1W1AA7JXc08WcYqAd+sP+vhDZQMJ6+XYKn7w4hh4K28e/5/KFAPvaNWbwNFJorVvfY9X6i1+3F5t3wYYhEBP+m4zTtaNFEWl9soB/mSuZiG7Qm6h9/W4vk0iUnLw6HdpjE1Z7zATfQdyo1V9hwQrFQB5LBYmkvlvZ4yOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439343; c=relaxed/simple;
	bh=VhIZY79QbiBRM6aNil0Rz5yp3sdQpcwNIB0p5c/IqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urrq+ROE1v4aMw7CzBODuMojEN7nfNwtxwtHPRtmokpPSsyXVsJHVvyIGeWwejwnbWF+yYdSoz9yeUd1NGv7VfPtqkfO2GYMVQQIpskis9Om6p8Zl99GsygADyVahgXG+Jvz2GjlCl8GcPCIlpEEhPj+OyR5btHqdUi7LrRirA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1pcDjLX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE0B1F00A3D;
	Fri, 22 May 2026 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779439342;
	bh=K7woSUmQ1qkgC+Tygx9BmDg4D+1VwHe1oVWIu66eemk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1pcDjLXoDj9p0ctuglQNc0j5WKtVAOIoP8JQgQpG1Qyf2908+BSlKXg5wzvgz4Kd
	 tgI8oC+O4A2OhdOb8ngwhYn5ExTRbqrbJTZEHayTbR9La6o7DsM3LPeizCDGbNiQyM
	 FUZ8dq6hTIBfkKd5Xo7AZu9BZLKfUcqDSWFeHmdupFaLuLC5HTEdnxYaTOxiF9ZDAh
	 JMb9HR0evoPSoX+CQ7Si+jJm4G6itYMZAQrxqEiOT9YRtRuzgkPnYz83ACe0ruJatd
	 GIyH2PF2n93RGPKNCVWuR6ovZQ47KHYUOV3gZvG6J9AGxxdff8rh+v/WUUbn5fR/rT
	 0eKUkjsFZ+qlQ==
Date: Fri, 22 May 2026 09:42:18 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix LAG recipe to profile association
Message-ID: <20260522084218.GI1506108@horms.kernel.org>
References: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290724-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 0B0FA5B0B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 01:20:41PM +0200, Marcin Szycik wrote:
> ice_init_lag() associates recipes to profiles, assuming that Link
> Aggregation-related profiles will always have profile ID lower than 70
> (ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and
> might not always be valid for some versions of DDP package, i.e. LAG
> profiles may have profile ID greater than 70. This would lead to
> misconfigured switch and LAG not working properly.
> 
> Fix it by checking up to maximum profile ID.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I notice that there is an AI review of this patch available on sashiko.dev.
However, I believe that flags a pre-existing problem that is orthogonal to
this patch. o I do no think that review should block progress of this
patch but rather be looked at in the context of possible follow-up.

