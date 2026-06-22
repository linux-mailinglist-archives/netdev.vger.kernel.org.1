Return-Path: <netdev+bounces-300993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v70ED4rwOGpbkQcAu9opvQ
	(envelope-from <netdev+bounces-300993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:21:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE7F6ADA26
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XB7uoLjJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300993-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31ACB3001A5D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FC38F244;
	Mon, 22 Jun 2026 08:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7C38F23D;
	Mon, 22 Jun 2026 08:21:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116484; cv=none; b=N2pckOY7QiGI1mVPHekW40PqBT/ZVmamyaOR+jbdlh5Pho5Rtp21n3zSpTK7hIvZv0VhjhYu1eHUZCloxpN1gFNlllXxFqahVMXVc5NoHa2kpZaCJnyI//8sorPJ/aejZlysZdMQtDEoXttM15HkSk18I1Gz9FFA1e/rjHBncKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116484; c=relaxed/simple;
	bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=u+zxj0RDGsyqBI8mW3xO2qICZrehfZ0PwGjjFmmCek32w4cjlz8g6ZX6N+dq2odSriO324jgcC5Z0wXdA1QkF1ZWJWzFlKHXjCt1IXD/OwHvQJHT1PJMgeAEYy1oMf7ktEK+evA6gRP0Gj1AIhLkNmVK1QHUriQ+FuhOLLTQhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7uoLjJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B21F000E9;
	Mon, 22 Jun 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116483;
	bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XB7uoLjJEkleWKn/h6/0LM1GCrUd4baGc2fOGJ0GlCmuiXQG2sAzA7cD7KpiSdHob
	 Ct9uN68rjkmEsAO/XrglfVEcYMuwtQgxzMS0JCOQVXdMqjKppoB66OcyWIT2v5G200
	 bTAFJJfiRSaiPASjRt6jUohUomWsyTaaBNYQQKFCZ4CWKvyk4Kyi2FdeAAJAKxroe+
	 g8ZsoiXj6X1bRBGXTDr/jMd75J29CgMwe+laiSN+i27b60wIH+/1WUo4v0z/b4dXjr
	 PXi/zDR937ZblGH9sODw6+DTwSbChBKbFfooQY4zI+zQ5rA/raHgI7KKyChgc3Aedz
	 QvK8tHhyVmyOw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
In-Reply-To: <DJDJX62AS415.2BVILN08QK149@gmail.com>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
 <DJDJX62AS415.2BVILN08QK149@gmail.com>
Date: Mon, 22 Jun 2026 10:21:12 +0200
Message-Id: <20260622-biobauer-finte-beunruhigen-51cdfc70ddf9@brauner>
X-Mailer: b4 0.16-dev-63c58
X-Developer-Signature: v=1; a=openpgp-sha256; l=116; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IdmExyROUV25/EktZki9aBpJp0ijNsEyKNDbjR9hpyk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZfKgKv+f/V9bx9BVbxmx3V4+LHUcfyBQ7sLb8SjrpK
 fntlHVnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+WjIy/K5x79Ld/o2hWO/z
 ubNb1E7sSkxQP12+5LrtH1NFZqEHbgz/87SnF2yI8/Zb/+34RNltr80vxU1ODZwj+31v5Jx3EWt
 yOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:brauner@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300993-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,zeniv.linux.org.uk,suse.cz,vger.kernel.org,linux.dev,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FE7F6ADA26

> lgtm.
> How do you want to route it? Thought vfs tree for the next merge window?

Yes, thank you for looking!


