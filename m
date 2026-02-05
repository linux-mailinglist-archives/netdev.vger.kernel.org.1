Return-Path: <netdev+bounces-256896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sObDJxPxg2k8wAMAu9opvQ
	(envelope-from <netdev+bounces-256896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FFEDA1D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCCE3013A4D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945E287503;
	Thu,  5 Feb 2026 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy6IkTgR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57574BE1;
	Thu,  5 Feb 2026 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770254604; cv=none; b=YeE76Z9QVCsfN+HRHdzS/KXc5JWxIHiE98567zz7eifrHIpxIS+dgwLwtnfeRUedMzaFi6lcX0vG4/5L/DO3v7uyHUFYdVwkATQXNgGwgSZYwmirORGOAsXUntAmq0HUcE0ItnHSAI5Tcl1sfiEvCtnYspyE7pFwfVf09v3uf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770254604; c=relaxed/simple;
	bh=dbbWH00AN9nxQSpcSlC8OhEK9W93kMW4Kq/rZuG81/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kew+BVKq//Gvu82zB1JeTfEfeg6yUFJcUeI7jpqpK1PxaXAFlrdEE0h7kl6lqC5Hdjye6rYgfEhnUgOPTLQT21FQl2wpwtqzb07JocWCYMzWhzK85fGGpDURMtMPoTfR5JOWagrxTWo0bgOjJsXiOsK/43unYyl67wtOWU9PD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy6IkTgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535EC4CEF7;
	Thu,  5 Feb 2026 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770254603;
	bh=dbbWH00AN9nxQSpcSlC8OhEK9W93kMW4Kq/rZuG81/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uy6IkTgR8XWjTCd6f2j73ACmERhNylK2D/W1b8L3PcvbVq3lMwSx5aHO9+WtsRFeC
	 4BcINPYnCAyOYJt6dKizKPlRAocw9j8KABcmEHvf5m64XbnIRcZfaY24uXIYDLyiU/
	 1MpcO2NLy4X2BUbrXtWyUox0LjVskACBUNwA7vMRFfQr14i5lEvTtzRW4V7ttZdSBD
	 40K8I+B0x7mIol1mtAUvWCtBH4U4MwSOpf4Um5wObb37pb7TmO29OEd5H15Xfa9IFj
	 34rIBWL/KXZC6AgrVAWnBTQP4kXztdUCLqqux9Qi3sbaL20bM6AEcLFboL+n2iSnqa
	 WtRPy8pzOAgDA==
Date: Wed, 4 Feb 2026 17:23:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 0/6] Address XDP frags having negative tailroom
Message-ID: <20260204172320.0cf0259c@kernel.org>
In-Reply-To: <e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
	<e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-256896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[42];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B8FFEDA1D
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 14:57:13 -0800 Martin KaFai Lau wrote:
> On 2/3/26 2:53 AM, Larysa Zaremba wrote:
> > Larysa Zaremba (6):
> >    xdp: produce a warning when calculated tailroom is negative
> >    ice: fix rxq info registering in mbuf packets
> >    ice: change XDP RxQ frag_size from DMA write length to truesize
> >    i40e: use truesize as XDP RxQ info frag_size
> >    idpf: use truesize as XDP RxQ info frag_size
> >    net: enetc: use truesize as XDP RxQ info frag_size
>
> Jakub, can you help to take it to the net tree? Thanks.

Will do. I think I also have some questions, first, tho :)

