Return-Path: <netdev+bounces-274304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EF/Ko69zWlmgQYAu9opvQ
	(envelope-from <netdev+bounces-274304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568AA38217D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFF13022FB8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693E239E9A;
	Thu,  2 Apr 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRCU/wNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E871459FA;
	Thu,  2 Apr 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091079; cv=none; b=UP4ms1qv/Zws8w6DhxEUXQUg3VC8oAoaEevXz9SqAws8tPTFw7MleQYeJ8hLMJdlo1HtZMHMtbG8g+VYxIHj9D5BaB0vEgsFCq6fEe/Wh04nrdtKsxTQIZZWzEwghwP9ptUPMuYjaTldR1ub3idw/cYKCz+Ke04SCSTlhu4QK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091079; c=relaxed/simple;
	bh=cn7ed9kbxEgd4sk/24LE8HA6WBEotT5Fatalu8K3cKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owL2ovfXptL3/0koopHTfsNdZsH5aRMKZ0vJWlQzYENBJBoW45KMrISh5Z9sKMzo8OfI4+N98IaKAQ6Jrh63MU6ZxfbEAwLMRuO5nnixt9bllixe/xhnTjoarLshSvDHnvrfIJZoKfeJqxbMytwp7EXVcB64lHfG7SEBSr0sKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRCU/wNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E938C4CEF7;
	Thu,  2 Apr 2026 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775091078;
	bh=cn7ed9kbxEgd4sk/24LE8HA6WBEotT5Fatalu8K3cKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRCU/wNIhoItBrtKUXLjvlyxTbD4pVXkPLnU+pRjT2sS8b7hBsCZFZ+8bX7S5G76q
	 vas7heXm2Xd1qab4x3HaGKI34KwHFxZqnnSchSRTSZ7QQ37tjKBvDemB4dUycTg71y
	 cIefIBjzotV+CXlaiXJz7vLeuN+WlcG2E4Jbh/P5576jvYOPabIApl+QpDDMGTGULd
	 orcZxml4yu4dO8HUHLkMqP6wEnRNy1yEgYHYevt0Z6tirsIDLYBUFnccVin9OQ3/jh
	 jJDpkq+Rcal1N+9QDXYrIzmTi3RNZ6cIMGSg7hCMeXgfNJXoRt/bSOuLcFHK5lg+mQ
	 88UYZT3ZxTPnA==
Date: Wed, 1 Apr 2026 17:51:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Message-ID: <20260401175117.1e4a5e6c@kernel.org>
In-Reply-To: <aczHkqj_0ErqCfXS@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
	<20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
	<20260331185028.45dffe3a@kernel.org>
	<aczHkqj_0ErqCfXS@fedora>
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
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 568AA38217D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 07:21:54 +0000 Hangbin Liu wrote:
> On Tue, Mar 31, 2026 at 06:50:28PM -0700, Jakub Kicinski wrote:
> > On Tue, 31 Mar 2026 11:56:11 +0800 Hangbin Liu wrote:  
> > > +++ b/tools/net/ynl/pyynl/ethtool.py  
> > 
> > We have converted all the samples to selftests so this script is 
> > the last piece of random "PoC" code we still have laying around.
> > Should we also move it to tests/ ?
> > 
> > If there's a reason to keep it as is -- could you please add that reason
> > at the top of the file for my future self? I'm pretty sure I already
> > questioned this script in the past ;)  
> 
> I have no objection to this. Will you keep it as it is when moving it to
> tests/ ? Should I wait for your moving first?

Would you mind moving it as part of your series?

