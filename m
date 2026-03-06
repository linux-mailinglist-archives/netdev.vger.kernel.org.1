Return-Path: <netdev+bounces-264622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMaqKog6qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:23:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9821A933
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D88E3023D75
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F633556D;
	Fri,  6 Mar 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNYEmJXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063932E68F;
	Fri,  6 Mar 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763781; cv=none; b=qzysPCmvKqw2qZCNI2k2hPvXKNFWugzVio5aJ6TJdRBmnEE7XA/x/eioR/X9b7tT0asXkTcXBf8nS5KW7PSCVpCOYRhee4+15qL2ZaPdB/LW5zuH/MFwDo/nhHWxxoHWBCQg9EFbHS/m7f2AoD2ghsUOg6ZyI3ih5qfTwJ2JaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763781; c=relaxed/simple;
	bh=IEoxs28u1fVOb8Sor9of1alADUpK2rwKo540PzQDZMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBLnVS254HEf10n9htbs4QmWPBQE6MY6TVZBMESOQZ6r581h5c99pCPazgqbJgfbwPEXArraE/oKSP/FKNfS542fN8KWyyHX1viTQ6p4aO3KZ1pCXPDtIU9Z/2BOocGFfWqHlHyWAjh+iAR+jAETF1fPk1GMa8r7SOA2DpiH0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNYEmJXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AA1C116C6;
	Fri,  6 Mar 2026 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772763781;
	bh=IEoxs28u1fVOb8Sor9of1alADUpK2rwKo540PzQDZMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNYEmJXcGUiTFqGaAKMlFPgbJDdwIgll1w7/eLfiGe2YboFbaSYz4fMZwe/LXPnXL
	 9ROQT57JQRZ2XLL3AYibHuxohpOr/u+ne2TGtFAdaAo+otNAy55oI13FYSpLB/hnn1
	 hLNgnESxath3GwwhsEvzijkj+oyYjrJwqmqZyJCK3Dle34GNIb+5M6dHCHBgLGLtYp
	 QdV9uvI5ayoBZ9+oV8ykxDyDNxRCg7c7tdvoUAHMtheRyAmxeR4wfjEqeOXHSCkze4
	 00udfcLtYb0Fi16hqD8AgIFzg/344JvGf9CbeSGHLM2Hw/Vv965WAbO1M6bZW8qcmG
	 MAulqEog1+W0Q==
Date: Thu, 5 Mar 2026 18:22:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
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
Subject: Re: [PATCH net v3 0/3] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
Message-ID: <20260305182259.0887cd14@kernel.org>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4CD9821A933
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 18:29:54 -0300 Ricardo B. Marli=C3=A8re wrote:
> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
> ---
> Changes in v3:
> - Don't use ipv6_mod_enabled() in net/core/filter.c.
> - Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7=
177db1a9f3@suse.com
>=20
> Changes in v2:
> - Used ipv6_mod_enabled() helper, guarded by unlikely().
> - Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b=
2a274df9bb@suse.com

Please add some content to the cover letter, you're basically sending
an empty email now. And please read this:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
--=20
pw-bot: cr

