Return-Path: <netdev+bounces-259160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gILJKV3nlGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:10:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC715159A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E43AA3024123
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348DF313547;
	Tue, 17 Feb 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KauAiK2R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E526B0A9;
	Tue, 17 Feb 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366113; cv=none; b=S6IqI6RxF09Pf2fZL/jbG7CM7PYk1XLV/WGMXSlfHe5lmqJSNaL9KM283hE2Qa8ChM2XDWVKyTtIc3hwK/pvm2+IAq4QUeE7nR9FGGoc66CZ8aBIaGYH8aO+i1KCHxk5uRipOgVbZ7TaxrDuFXUPSsOL9H3960gZuTsjnp3zG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366113; c=relaxed/simple;
	bh=zIwCo0jmxFRZsEDqRMaqYmvvZJGYdVREl1QvazmykW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahyAD/TNWJZHBXfZlOD+F++aHElkibnYxwncD0GousW6Bq3djroqM/SHxdcapAeTIRZLzYPyyttdTmIG2J6pSRoT054EmoeNCafbhaKdu7icBvtM6fMacDKRTtMMqRfhvwKbp2R92BMjv05VUTSarkXkLGGvDVRGPxXsURZU/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KauAiK2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBCBC4CEF7;
	Tue, 17 Feb 2026 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366112;
	bh=zIwCo0jmxFRZsEDqRMaqYmvvZJGYdVREl1QvazmykW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KauAiK2ReggbudOBeR9PyyjDjf35pOp4E692h0tcwRcqMEXj12XKcnBpovTMmRpct
	 y/+Aoo9TzJIipsbvswhttNfTNV1vXkOWowlk9cPEQf58Qjc3fcJ4VCbfNIcWyU9Jik
	 grkXqP8Q5emSKuG9AbJFRbhV1EA5o51xTY7pvIvWexDk+1k2mNFb70sOhfTKCINzQf
	 XChkdpl7jGKx3d7HlEdW8FsuemxHfeMPON7Oclu7CiSzwRrP/F1+C/cWDtharDVmsm
	 TM6Tz+fGiobnpmRbwcmoh2XEl/QZ2liOtUYO2lSK+7j8VtRgX45CzjWqDClCWVt7YE
	 6LHdvi3/gZNig==
Date: Tue, 17 Feb 2026 14:08:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference
 issue in bpf_lwt_xmit_push_encap
Message-ID: <20260217140831.52fac4ca@kernel.org>
In-Reply-To: <6528c028-1224-4737-b902-e631641ddb37@linux.dev>
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
	<20260211075240.70095-1-yangfeng59949@163.com>
	<6528c028-1224-4737-b902-e631641ddb37@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40DC715159A
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 10:08:29 -0800 Martin KaFai Lau wrote:
> > The reason for the CI test failure.  
> 
> Make sense, but the early point stays the same: the user-provided skb 
> can have unexpected data. Either an skb->protocol is not handled here, 
> or the earlier dst lookup has an error. I don't know what the current 
> active users left in lwt are. Unless there is an issue with missing 
> skb_dst() in other mainstream program types (e.g., tc), I would prefer 
> to add a check in bpf_lwt_push_ip_encap() instead of complicating 
> bpf_prog_test_run_skb() further.

Can bpf_prog_test_run_skb() simply not support LWT then?
Having fastpath checks for test harness really feels like duct tape

