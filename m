Return-Path: <netdev+bounces-290533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKUGIg44D2rTHwYAu9opvQ
	(envelope-from <netdev+bounces-290533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0005A99EF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACEF0315CD09
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E417348C6B;
	Thu, 21 May 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdSCRWHj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964A3446A7;
	Thu, 21 May 2026 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377011; cv=none; b=IC4m0KVPNZFupRBYToIGUhDBRzBE9SsC00WnqzB2Bu3hSK7YKaoJWNNbvtx+E0YwBPLAowO2pGsS69yC4nJQYBbgHYgPtU3GXNU3MoUvBdLw7jMnGeOdHrMok38hkWaudNiP6HVK7aqOovJBjfLKr5tcXr+FzTOQJ2Cy9igqXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377011; c=relaxed/simple;
	bh=DveREk3xTvkXtuq6xr+G61/Gx442dXVYQMXGJiIIV4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCT1XUR+60COvytkxXGxrmRSaMdoSZadAfoNeqaxE5VF4weBpvNwGEvUQiDcH+Fx8xd1FBmvYiQrcB1Um5da27hq7WkTtAfbCfwm+fXzi7Ia8x9NVgYiahYmMe5EDowVvPUFvSswXRgbngeoOFxIS0NSffOTUje14lTGmcOhGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdSCRWHj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4081F000E9;
	Thu, 21 May 2026 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377009;
	bh=GK+Jeez82vfjWCBn2IWK248118X2pv5iFWU0+rDUYpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bdSCRWHjfhRB10FzSvKMuYXmpI4CxK7/fR9po2m3k/NZHAXjjeIJnQ+iSetMF+0YD
	 SBhcVverpe25b/jbh8w+qj1GJXxHhGBUKJKXVavCZWPCrrt6vI6JVzbnJaXQlADfka
	 txNRJoHCqDExXPmPHpBoNMRj/WBNWkfUpZ0JAlYDtpzduUhO6JbP0f5GCTo0uOMma6
	 6eSCKaXZZeEs7REcW6VNrnsPD2cwdXIqtp9KtHjNBiXi+9ag55CvBITMLu3R8aI7SG
	 NIjukWdc/O30E2G7HrKPqcj35LkXtYGn6Bi0UDT7BhKnp9TZTvcIBMmauYTSseDMSU
	 0Kz+/ggjffPFw==
Date: Thu, 21 May 2026 08:23:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Shuah
 Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook
 <kees@kernel.org>, Adrian Moreno <amorenoz@redhat.com>, Jiri Benc
 <jbenc@redhat.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Matteo Perin
 <matteo.perin@canonical.com>
Subject: Re: [PATCH net v2 0/4] netlink: fixes for cross-namespace nsid
 reporting
Message-ID: <20260521082328.21ac0dbe@kernel.org>
In-Reply-To: <20260520172317.175168-1-i.maximets@ovn.org>
References: <20260520172317.175168-1-i.maximets@ovn.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290533-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,6wind.com,canonical.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C0005A99EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 19:22:34 +0200 Ilya Maximets wrote:
> Ilya Maximets (4):
>   net: netlink: fix sending unassigned nsid after assigned one
>   net: netlink: don't set nsid on local notifications
>   tools: ynl: support listening on all nsids
>   selftests: net: add a test case for nsid in all nsid notifications

Doesn't look like this will make it to today's PR but let me apply
just the ynl change right away, the same code is changed in net-next.
Let me save myself the merge conflict..

