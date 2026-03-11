Return-Path: <netdev+bounces-266401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRVC16+sGm4mgIAu9opvQ
	(envelope-from <netdev+bounces-266401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:59:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E725A31F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD4F303A8DD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8636DA09;
	Wed, 11 Mar 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1zLkH/x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48F188CC9;
	Wed, 11 Mar 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190740; cv=none; b=sIzFfmw1asu3iiVgqaGhnM8yya+vF/iaoC131fHq3cDehl1Qy69oIwYT4HG0KTW2nONpyYxyir4HZo0YxAnOWSix7HtSN2Hyv0v0tT/a/kfIH7vPnAiQzVGS0yDNJk7hMkHtbmzyjggIzkfLp/s6M4P2q+SxktqDbOpYkPd/l+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190740; c=relaxed/simple;
	bh=Biv6lAtnMW7SLNONV7jtLNZyXdSOyQVdv7rBF3xubrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEEAJ+KIYUZbnv3irCx9mDnBiFeo6mkTlKvDjWiay1q8ikNrZSWjpYA9HP9HYz96irc4X1RPnp4Tqne6WbtZeGuqekSS6Sq7cCZVj4zMwPZ7fDLYSwSEKh3CqQmToCOuxDMMZIVaL4wA57V8SDLNGIo8RrI+MDJ80pEamLSGZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1zLkH/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C85C19423;
	Wed, 11 Mar 2026 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190740;
	bh=Biv6lAtnMW7SLNONV7jtLNZyXdSOyQVdv7rBF3xubrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1zLkH/xLMOaz+bFw+dOKJqzGa/jWMd3Nwbwf2tfhebEh/8IVzc0FU4EDkR9KiqZB
	 5dfPwV81KTABGHh3MBNaYfT1XVnAGvsx4u+Qq+pZNrDD4XLXam4XuxETkoVfoVw6Fg
	 BqorkDdAx18/OIRNrOqXcedU8ebzKrpzLl3ktxk8wGjHlHlygnOcOOOgozd/GXl4qk
	 m85vX+/2teD7MFMiGlvjMIuQ4HqvkniHetswasRulOxkaCF1SvM9x8kXUyyxfwHB+e
	 v5x0sGwOvdqgjdMY+ubsBFXJ1B1H7BkXrQFNCpUD7ejBX8Fal3224WxSI8ET8FjUdA
	 OJl6+otLq/NyQ==
Date: Tue, 10 Mar 2026 17:58:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
Message-ID: <20260310175858.70ed0391@kernel.org>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 837E725A31F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 07 Mar 2026 17:50:52 -0300 Ricardo B. Marli=C3=A8re wrote:
>       bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is dis=
abled
>       bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is dis=
abled

Hi Daniel, are you okay with these for net?

