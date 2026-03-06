Return-Path: <netdev+bounces-264623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPTPI0c7qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:26:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F121A98F
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8A83045004
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122433B97B;
	Fri,  6 Mar 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCKqfVhr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E133B96A;
	Fri,  6 Mar 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763923; cv=none; b=OLcnx4kN76mGmbb6sLbfncYPc1JbjypF5NNaouNqUyPggHeEnZxdHNt3yp1+OIflqcUWYkT7H30NzATiNeD5QM+y9dEfILM8iknlL+dhoAItd/xVn+D0MRQkOuM6tsS3NIBvsdQoofzy/xXgmhSFaYdaNlNKvWwbbgnk1z5KoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763923; c=relaxed/simple;
	bh=ooqZNkuq+MbCKB3WkGV8xm7iUfWSkkLNN9oheChyRnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkzpZO+94KtzFa2425tU7vlDnDhlWXj9OLQ8K8sW27QqN8u8kN1tbE1bSvHV5wN2jYYzHVzkZeKnAOUoj9cdr0HbvNLSVUN8pbfEli/8Gqj7vOHQWN/k+ljKxKA8kHi4U6nv56j8TwXyhghpyfIEQpSrA0b6zGbV8HRQ3LYjCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCKqfVhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD27C19423;
	Fri,  6 Mar 2026 02:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772763923;
	bh=ooqZNkuq+MbCKB3WkGV8xm7iUfWSkkLNN9oheChyRnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCKqfVhrwS4y8gd0iYWv/hkaF4e9Q1eVroZ/WB0YN5ChA8knYnj5GLsPwFuiLYS7i
	 yiSk151B1zd4Sh0URJwb2FdOsYC8fpwb6VZU86xK/O8p1X5p+v6bUnONutNCC6B0kT
	 uPqO3Qhs98CFSRivejJE4p8yIdFD08a7ML1d2k+3xi9TsuHFedBcdVciIy0RO2nSrN
	 OBvA9+xSBIbFrrmnGPiI4ubYU702BJOlV1AZC5MZMsWkGU4J02vUeNJnZk2cS6zS2g
	 HCp2NJFBuHsXd9cLpPOytOL6bP2/cn+2fuYmrC6cAX4tIfkm8Hksm16wdXOJT7/r5x
	 X56LHukUM3VGw==
Date: Thu, 5 Mar 2026 18:25:21 -0800
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
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260305182521.0ca7313c@kernel.org>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
	<20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F21F121A98F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264623-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 18:29:56 -0300 Ricardo B. Marli=C3=A8re wrote:
> +++ b/net/core/filter.c
> @@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct=
 sk_buff *skb,
>  			return -ENOMEM;
>  	}
> =20
> +	if (unlikely(!ipv6_stub->nd_tbl))
> +		goto out_drop;

So neither Fernando nor you checked whether this code can be built
as a module? ipv6_mod_enabled() should work just fine

SMH

