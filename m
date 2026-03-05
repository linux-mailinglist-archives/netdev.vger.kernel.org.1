Return-Path: <netdev+bounces-264122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KWPBMffqGnzyAAAu9opvQ
	(envelope-from <netdev+bounces-264122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C9209F76
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D106301B730
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69DC23EA8B;
	Thu,  5 Mar 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHWGdC/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272F221F20;
	Thu,  5 Mar 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675009; cv=none; b=rD3yJt11DOMfitEcAyFyyJJ8Pvs4RWM6FOZvsMWY+HvZajTGrZbBvbRMMGRGaU8tMecKvpwrpAwF1d/sy5pnCzD+GTEZ0/kYaxdFYtrN8wxeXMKI6RSNXXJf+3h/NwVdia6S29V1THL8QUY85ZabJfj4hj0CTHU6BKWkQeRCqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675009; c=relaxed/simple;
	bh=qtAc2++xWUE/BHhkJWBWqn5Nt2AcxW8aladq0FuhIa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPucoYvhv/jRHLW0fOR8QbD03vmSwXcOVYUakIX0u1ix/yJoJPd6z93eZ12hdugQU0EACf211qgfLNd9n2VdEFsoI+bYBjYdGpJUgVGqnB7M0Rqujh3LYeUMQZTvBpNx7Qvf+wHDf02UgNKrdSHnte380ZifIzFN/nsMfnZU6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHWGdC/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC84C4CEF7;
	Thu,  5 Mar 2026 01:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772675009;
	bh=qtAc2++xWUE/BHhkJWBWqn5Nt2AcxW8aladq0FuhIa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHWGdC/Fx83rdmGIh2eXkMTlouglv7qj45nfIGOvvRkJziDqZeZg6hFoXxabT+JDU
	 JwWrUTlQVDlPdPfFwm0jHeGk8QawSqmpUwkhDfOXvDN6wCAiOa0dC/q+naznpvGZDK
	 0gIkABUVq5Fzp9HLAZoW4JIDjuv+b/y88mbwYPOQUPgTy6f3dGmJ2gQwLp/92RjINz
	 hofRE6badeJ1UAX5KnzYLQ/AeMJ90ARKaeM24vBPjGklP7gDtlTYq9TqD8W+tYz/py
	 IJPnRC2RnH3ZBPviPaewD+u4CQwfuksa4MMeiucymwnVoEcAMs8sWHGLWEuJNBAOqn
	 fTBev/pnaPsnA==
Date: Wed, 4 Mar 2026 17:43:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, David Ahern
 <dsahern@kernel.org>, "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260304174327.0a48ff45@kernel.org>
In-Reply-To: <525dab04-4e64-49cf-94d9-12084e146b80@iogearbox.net>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
	<20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
	<0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
	<20260302171131.28373ccb@kernel.org>
	<0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
	<bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
	<ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
	<ba35fa2c-0085-43c9-afe0-3b2e0351ca3c@suse.de>
	<525dab04-4e64-49cf-94d9-12084e146b80@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D4C9209F76
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
	TAGGED_FROM(0.00)[bounces-264122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,suse.com,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
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

On Thu, 5 Mar 2026 02:34:00 +0100 Daniel Borkmann wrote:
> > Maybe I am missing something here, but I believe this won't solve
> > the problem. Even if ipv6 is built-in, it should be possible to
> > pass ipv6.disable=1 during boot and therefore nd_tbl would still be
> > uninitialized, not NULL tho.  
>
> I presume you mean disable_ipv6_mod which then bails out during the module
> load process without error, right? It could be deprecated with a warning so
> that it turns into a no-op:

I believe disabling ipv6 may be legit. Some admins on ipv4 networks may
be paranoid and not want to allow any ipv6 traffic if their "firewalls"
can only understand IPv6? This is just a guess on my side, but I'm less
confident of deprecating the disable knob than =m. I'd be happy if I'm
wrong.

To answer the earlier question -- I would prefer to take the fixes now
and make IPv6 bool in net-next, feels like too big of a change for rc3
:(

