Return-Path: <netdev+bounces-256903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKc5H4v1g2kwwQMAu9opvQ
	(envelope-from <netdev+bounces-256903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:42:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E0EDBEE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F033021980
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0728DF07;
	Thu,  5 Feb 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYFxS/Ij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650F288C27
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255635; cv=none; b=WoroYDZKhd2+EvZ/DCbHJguUR40eqhSzZNkyxEHsVk9l6RpVGk8tLP9f4j+EsU4spDPYlm7a1OzNx3GUBbXN1+us+BqybCeLrSq+L/Op0JGGkJoqBHxLFv0y6QagH1/X4KsuMXJ78jYQhXZABrKiGY0f8EOPv3SV/ezpS9uOt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255635; c=relaxed/simple;
	bh=uTrsxGdHfJzR7evoyQV4W3EjM818czShb7pzEfoHKM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj6u99mm6ixr6TFtiPM3ucrq9qFR4gLBOchAdFEYmPz1qCxTBYPW8d1G3uuSEr8Z3UKqaanSznlxMnKkbCr+pqU6mc8eKIVTf2WZZANfCzDNGZiIrxcYdLCO9sBmp/tYhE2Qrsz3uxJJpTa4n5IRHGL5lbi3wotNlKmqDZKLO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYFxS/Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D23AC4CEF7;
	Thu,  5 Feb 2026 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770255634;
	bh=uTrsxGdHfJzR7evoyQV4W3EjM818czShb7pzEfoHKM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YYFxS/IjDvToGeQ/zY0WFvhW5OjotxHVMWKPlhXCltHJtf0BVtyVmDmSDyu3jkvVY
	 BMF2PJs0vwRiNS8eabvdPWR2drkwJCRWDxL32O09L2+MPzqcTiahVkxlUzw40ky6ZZ
	 K+QJGePYXoIfqPw0CGidNKBDEmJ5IoyYYkmOJJpQg1LomrKqguff8SxbeA4EbpG853
	 q3FZM4pZzEA1dzMTl4USaCGGO8roZhxfdBz1nNNqomQhly9RECWQrtd388ej8k1KzO
	 5lfmyJaITEf0MQndrT/zrT/4BId+SGIUwT+os9pMpe9Y8F0ZM8wneOUeqh5fSgjMCp
	 YQrLs81vshZFQ==
Date: Wed, 4 Feb 2026 17:40:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <andrew+netdev@lunn.ch>, <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci for i40e
Message-ID: <20260204174033.5aa7dc6a@kernel.org>
In-Reply-To: <a29bc22b-a1e3-4a9e-a63c-5d1c71a6f08b@intel.com>
References: <b5446385-1f51-4359-b484-6dfccb50dad0@intel.com>
	<20260203190811.1f9e7530@kernel.org>
	<a29bc22b-a1e3-4a9e-a63c-5d1c71a6f08b@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256903-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB9E0EDBEE
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 13:15:03 +0100 Pielech, Adrian wrote:
> On 2/4/2026 4:08 AM, Jakub Kicinski wrote:
> > Looks like the GRO test result parsing is off, the test cases are
> > reported as for example:
> > 
> > 	gro-test-lro-ipv6-ip-tos # XFAIL Device does not support...
> > 
> > Looks like this affects all your runners, I haven't noticed earlier.  
> 
> I have fixed that, XFAIL should be reported as fail even if further
> message suggests that the test should report SKIP due to "device does
> not support...".
> 
> Historical results were parsed again to remove test cases:
> "[...] # XFAIL [...]".

Looks good now, thanks!

One more note, the "driver metadata" is currently reported as:

{"devlink":{"driver":"i40e", ...

looks like you have some extra nests there. That's perfectly fine,
but we need there to be a "driver" key in the outmost object.
Right now our UIs show "undefined" for the drivers here:
https://netdev.bots.linux.dev/devices.html

