Return-Path: <netdev+bounces-260258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLpHNFvgnGnCLwQAu9opvQ
	(envelope-from <netdev+bounces-260258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:18:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45C17F253
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE73F3007493
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E137F733;
	Mon, 23 Feb 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlZbVIG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323934D4D8;
	Mon, 23 Feb 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888728; cv=none; b=I6QTFIwSzbgE0C8hoSSY+/oW2+1Cx077EQOC9lQLMTDztjnGJNqh3VAzJ8Q7qPnLBFET3+xtLI/tHcnKYKR+Gb39moaQc5vCEsChJlmxyA62sU2Sr7tkgrsHx2ytn6GHiK1CVS9csd4gTCmLQSFQMWVvOMnGvjwezQjYwBQy0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888728; c=relaxed/simple;
	bh=CYLrkQbplhVLWpLwYQI2kVgix50aUPHsmv7SwhslwTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxrXQRdZZ/Dkz2PYtlz0/7z/SAJHXIC7TdbA9ijhYsxfjKQzWFmOwlSC2Q/DiQ3zkfoFIQO11RlzTXyPzOO1R4g9xkCrADxTk/D+B+axkvef1skBjk3OQ3zKx1VrEhSNfVBwYNfo4lkBCr7r31g4JDAqWiYEHhEIA/qlcPQuLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlZbVIG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC4EC116C6;
	Mon, 23 Feb 2026 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888727;
	bh=CYLrkQbplhVLWpLwYQI2kVgix50aUPHsmv7SwhslwTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlZbVIG0zfxSp01GgD2+JrWlDWhpRYIi9iTBhCrYsyrhBEvafKGrz2Sy10Zr/MQkO
	 X1SL7F61crQZeQWRjiwxV8hbfegSYseFSQVFEm3T0eSv7L1gLYAWcFx88Chz+qnBzR
	 qxzUVv9nXlsD5qoFeVw2MpDIz2ZJBws9y/8zBWThrTv1CUFXmms+yQKrqAfBJe58Rj
	 wzoFidKhPfAGKJtuWuzd3CSqX6uLhqXhwQPvDkLXHlNpf/7Xie1DnA9YPLi/1rPJUG
	 2Uvl9A1L5WmKRP7FY64FUyfKI4LTjN9DyLsOPBIVeTR5NmcYTzMkfxsK50Z4nHKidf
	 m7ZoZ1PlpHIWg==
Date: Mon, 23 Feb 2026 15:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <20260223151845.06db43b0@kernel.org>
In-Reply-To: <aZyKWoxnywXKWth9@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
	<20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
	<20260218174742.62a4074f@kernel.org>
	<aZbuWBnmh_SQJyVf@lore-desk>
	<20260219091344.1d8517f3@kernel.org>
	<aZyKWoxnywXKWth9@lore-desk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260258-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[30];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B45C17F253
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 18:11:54 +0100 Lorenzo Bianconi wrote:
> > Off the top of my head drivers prefer reporting UNNECESSARY when they
> > have both, and reserve COMPLETE for cases where L4 could not be found
> > or is incorrect. Why don't we report both? We're using 3 args, we still
> > have 3 to go. We could turn ip_summed into a bitmap and have explicit
> > output args for both level and csum complete value?  
> 
> Ack, thx for the explanation. Just for sake of understanding, is there
> any NIC capable of reporting both csum_value and csum for the same packet
> in the DMA descriptor? Or is this change needed to be future-proof?

Both nfp and fbnic definitely can. Off the top of my head - mlx5 also
can, but I haven't double checked.

> > One more thing I'd like us to at least have a plan for at this stage
> > is how to deal with COMPLETE + modified packet + XDP_PASS.
> > Right now some drivers discard COMPLETE when XDP is attached since
> > they can't be sure if XDP modifies the packet. Other drivers don't
> > and we end up with bad csum splat. Do we have a recommendation on
> > the correct behavior? If not - should we have a kfunc to adjust /
> > discard csum complete explicitly?  
> 
> At the moment there is no way to store the csum value we got running
> bpf_xdp_metadata_rx_checksum() in order to be consumed during
> xdp_buff/xdp_frame to skb conversion (this info can just be consumed in the
> ebpf program bound to the NIC) but

I think the scope here is much narrower than the xdp_buf to xdp_frame
to skb conversion. We are just pass information between the program and
driver which owns xdp_buff. Very similar to your new xmo.

We could either tell the driver to discard the csum complete or even
add a helper to "adjust" the the csum value. Similar to the helper
we have to adjust the csum in TC / skb context.

> I guess the issue you pointed out can be solved in the verifier
> during program load time. What do you think?

It could, but at the verifier level we'd probably have to be fairly
coarse-grained. Any write to the packet data would mean csum complete
cannot be trusted, that's not too hard. But also any tail call / fentry?
I'm not really up to date on the latest in program chaining in BPF but
I think a lot of real-life deployments would use either chaining or
fentry. So in practice it may be a lot of complexity for having csum
complete always disabled w/ XDP, in practice.

Up to you. I'm totally okay to just say** that drivers should never
report csum complete with XDP (until appropriate API is built).
Perhaps this will force those who care about XDP+csum_complete to
tell us what their requirements are?

[**] "just say" == document and add driver kselftest that validates it

