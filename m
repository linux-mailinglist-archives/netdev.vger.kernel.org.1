Return-Path: <netdev+bounces-292517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF+RLrekF2oTMAgAu9opvQ
	(envelope-from <netdev+bounces-292517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:13:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 386245EBB2E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 365BA3011071
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12412EBB9E;
	Thu, 28 May 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7/FfZHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9A2EBBB9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934387; cv=none; b=NwinqrpkjP0UMfc94lDSIudeTY26WZakmFaJLmZybwXIhBLY8MDQ89H/AYBF8bTmrbPDJArHLJIsdlOizh4driokr2qAX4IZVoI1G9lMjRqJx7Sc9+ScM+gNjaDnsQms62hkZpVbG+7Vhsr46iVsj68oo7PDgifp+vZ9OfkgMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934387; c=relaxed/simple;
	bh=Ciyr1abHwQgdi4uI8R47i06XGyEvBzYVlL6Morgg8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm2j/5m4HD+VeyAY2EDJ1Wk8kfuh/tWL5hfU+nvpDGuY7JTPQVuIHx59Whm1/a3EDFkJhs9+NTnpeJiz+uS5LlJLL+6ZnKZFRZ5DKovcw3mLEfkdiPDaOfgryYlT+9HrF+faSu0O/F+0rp5WUGarKZJL5jOS7Vh9j3gllszUvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7/FfZHM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037EB1F00A3A;
	Thu, 28 May 2026 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934384;
	bh=I+Edx5fLpNKrzRvGWRlcpKc4RZpUpuSOPh3zkjaQB58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a7/FfZHMxCw7kgQjtuwZPHNcsDZTxajzQBQYbjryga9CAbYFdPw9VQup3n/qgk1cf
	 YV8aEjAPxye6N0iwRjmjNhq7PKyIAFNTtQwQIu0O6aHGjM0eIbleq28g4nN9ttrhaX
	 sJd/n2oSPUwy33o7fXQWgKP+O8DSz+D1D3mp5nsTkVuuE+h31ey0f613A62w41ieLD
	 9lMApAYAwdwiInyAXAepM5bVvAd51+N04R6N3vec3vIHAXgggWpt9dPgj5XHp/cvHs
	 NPFyKQkL3NmzVlqoIgIe7c70Vb/uUzLqg1tHtjkEfXjWQ1kzbe7xRJ9h2cQRInmDkp
	 AOQ4Umw99OVfQ==
Date: Wed, 27 May 2026 19:13:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v5 00/11] BIG TCP for UDP tunnels
Message-ID: <20260527191303.78dfffde@kernel.org>
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292517-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 386245EBB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 18:11:49 +0200 Alice Mikityanska wrote:
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> Patches 01-02 are small fixups to some related code that I'm changing in
> the series.
> 
> Patch 03 adds accessors for the length field in the UDP header, as
> suggested by Paolo in review. The usage of udp_set_len is then added in
> the following patches that start using length=0 in BIG TCP UDP packets.
> 
> Patches 04-06 close the gaps that prevent BIG TCP packets from going
> through UDP tunnel code.
> 
> Patch 07 re-adds proper validation of malformed packets that arrive with
> length=0 from the wire.
> 
> Patch 08 is for proper formatting in tcpdump (set UDP len to 0 rather
> than a trimmed value on overflow).
> 
> Patches 09-10 bump up tso_max_size for VXLAN and GENEVE.
> 
> Patch 11 adds selftests.

Looks like the selftest fails on debug kernel builds:

# overriding timeout to 7200
# selftests: net: big_tcp_tunnels.sh
# 0.50 [+0.50] Setting up VXLAN over IPv4
# 0.78 [+0.28] Running IPv4 traffic in the tunnel
# 5.93 [+5.14] Captured BIG TCP GRO packets: 18138
# 5.93 [+0.00] Captured BIG TCP GSO packets: 17445
# 6.01 [+0.08] Setting up VXLAN over IPv4
# 6.29 [+0.29] Running IPv6 traffic in the tunnel
# 11.40 [+5.11] Captured BIG TCP GRO packets: 17827
# 11.40 [+0.00] Captured BIG TCP GSO packets: 16964
# 11.49 [+0.08] Setting up VXLAN over IPv6
# 11.78 [+0.29] Running IPv4 traffic in the tunnel
# 16.89 [+5.11] Captured BIG TCP GRO packets: 8951
# 16.89 [+0.00] Captured BIG TCP GSO packets: 9063
not ok 1 selftests: net: big_tcp_tunnels.sh # exit=1

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/665442/153-big-tcp-tunnels-sh/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/665442/153-big-tcp-tunnels-sh-retry/stdout

