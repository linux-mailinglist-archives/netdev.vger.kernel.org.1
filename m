Return-Path: <netdev+bounces-304552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OX8oHqm3R2oreAAAu9opvQ
	(envelope-from <netdev+bounces-304552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB144702CE1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eSxTZz2t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304552-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304552-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A89DD30699C5
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AD3D75A9;
	Fri,  3 Jul 2026 13:18:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B253D6470;
	Fri,  3 Jul 2026 13:18:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084684; cv=none; b=GePoaYAmdtZmVFzwG0CrEYyuPkZ4iNsn81qNkpw3epo9kGQeQaFcQA1KqE2zM4trYh5qytmVSyN/1RnSBDj78T2s2dYaoWUo0FUPXFkkPIkNwajPMGOPpkE/6CCQ5aiJRMTKEl3mH8aufhIM9q1kl3Ex96OgLHXVrr8dGqRWoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084684; c=relaxed/simple;
	bh=6W21t04zsig41ZGK4yP5vmdeiSeuqMAWNJ/8tz/1jF0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dhLMZoz+En60f0HXizAjQkuUa868XHE86QsTzbpEpODphELsFxJUMr8yXiBOZ54e2LRVJUr9EM1BfRtRf5xFlO7qtn1u94R7UHZ1XOr4Lsjkpn+OUcO0yBeTQaXAyKM63BrBAMlRHAfFz9nrT5sFb/Q2kBwBV/K9UjBfd3az+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSxTZz2t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29CB1F000E9;
	Fri,  3 Jul 2026 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084682;
	bh=4uzDfoTwkfdbFHkCUQ1tshn8zcfMCx855BQAs0GpqXw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=eSxTZz2tETgzCCPZR7nAkwKRL3WdbxS1Eij5f/SQeD1puzmaMpa3AnxcSk+PkMYSc
	 va31yRhgj6fo3vhhqiIoj8byX+cG7nSsgWDTqZieRE2+TvpLCnGbpHDvs8dVoVr8lk
	 7wQ3vTr7ZlYVH4REPgeq2g3N9VobPBdH2M7CfhjPijyWodk50oXrym2JnfUvmO+9sy
	 tQQNkPKqwLdKV6xNtJ0hTQ0wLCEf/7ksAcBmlFtGtv0zD51aBVANaIXOyetLqMl8jW
	 pIxLek2mvLOPkbw8EZ3nVnG9QU6RAmcpzAOX1gGUmtM6D+dAbB3Sy/r3s1prrnMLoW
	 0JGfsRGVdH/0A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v2 3/3] af_unix: Clean up error handling in
 unix_listen()
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 John Ericson <mail@johnericson.me>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
 <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
Date: Fri, 03 Jul 2026 15:17:46 +0200
Message-Id: <20260703-nachzahlen-plagt-tierwelt-38485ce22091@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=516; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6W21t04zsig41ZGK4yP5vmdeiSeuqMAWNJ/8tz/1jF0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5b2uI1vNsTb7z4bwQ59udnq9jTD4+33P6z7nDugw5Y
 jNmMUeKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk2TlGhv/1KQq/jpm1dRzl
 V/iqvY3vztkTk8O1jcXmr929x/f9xLOMDLNeP9yiF2vwekWUuo39Rj6NZeL1mU/X1/WKpfdzbT2
 xnh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@Obsidian.Systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304552-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brauner:mid,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB144702CE1

> To avoid the sort of bug that was just fixed going forward, switch to a
> style where `err = -E...;` instead happens right before the `goto`.
> (`err = other_function(...);` is not changed.) Then there is no
> spooky-action-at-a-distance between the `err` initialization and the
> `goto`, something which is easier to slip by code review.
> 
> Signed-off-by: John Ericson <mail@johnericson.me>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>

