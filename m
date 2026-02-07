Return-Path: <netdev+bounces-257706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBdiByeqhmkrPwQAu9opvQ
	(envelope-from <netdev+bounces-257706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:57:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9854B104B8B
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9838301ECF5
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81D3328E3;
	Sat,  7 Feb 2026 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPkt7rGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DB22A1E1;
	Sat,  7 Feb 2026 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433058; cv=none; b=W8DyLpVrD5fuowcefVfRP/FIk+VPnnqGcPMqO+a6Tpyot06EYpfUDaMyyenX24V6/F4WrvsXnFibFxNzH8cJUckn2dbF3Ashkvy8/JtW5ue4Et6MQyY01xeOsjupx8eh88OaV2k5mjgJ/Rfg7eMelbc1+0JT32msO/bp55a21Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433058; c=relaxed/simple;
	bh=fEJXLRawPbdCf3xetPQEnbQsr9d6YyTUk64NobkmyKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkvZzwgqOwXQwxeRN+h/WPXcAPq7qiYl8VRzLrcprDMAgxUnZcqh/aCipm82gpPDJSy0GlczRHNVsEJezi2V7H73TvlabycaEkVft4HK01iQy4uvRrI1FPeRYbkFefBHAgx+LIYo3Tth0/cHTOirDonOsAObm81RA42Q64/KBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPkt7rGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30CAC116C6;
	Sat,  7 Feb 2026 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770433058;
	bh=fEJXLRawPbdCf3xetPQEnbQsr9d6YyTUk64NobkmyKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPkt7rGC0FvsPX3scZHiX4yFkazHdSma2rHcjUNE+XplJnIuJIH+g0x3qT0JrSqP0
	 e+KSmkhZHKOonSFsWFXjIEHIvSv58IFC1Tpr0o1uCEVxru8ZL6DbGmwhh1uUSSwVXg
	 l8U1urkkBbTwCEEvcsRgFEkis0kn+wl7Yy33vxPtsQcLb9F7BSPCTrfp6f3UWBfEtt
	 LOTYxIx8iHCD75aQc344YfRivo7h5oi2ynwyXCJVlE4WaAkJnbCbTaQy66xB5Yz1SK
	 C+zNBEb/vygekFf+kZ9j2c6PI+3ZP0++LJaOYsxEnBfSIMeqZEviymfulgtLZvpJde
	 JcW6+CxRddl1Q==
Date: Fri, 6 Feb 2026 18:57:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, <bpf@vger.kernel.org>,
 "Claudiu Manoil" <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>, "Bastien Curutchet
 (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGniiJrCrnJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <20260206185735.787fb0e5@kernel.org>
In-Reply-To: <aYWoBRmt-lcM_JkG@soc-5CG4396X81.clients.intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
	<20260203105417.2302672-7-larysa.zaremba@intel.com>
	<20260205005901.gnju3zmqimtgeu2b@skbuf>
	<20260204173401.282899d0@kernel.org>
	<20260205122953.lscemcctayrvszdu@skbuf>
	<aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
	<20260205124638.hxzvjiocephzlrk3@skbuf>
	<aYSZw4wbd-nvLTuD@soc-5CG4396X81.clients.intel.com>
	<20260205134046.pggwyosutj7ggi4i@skbuf>
	<20260205175408.30ab72a1@kernel.org>
	<aYWoBRmt-lcM_JkG@soc-5CG4396X81.clients.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9854B104B8B
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 09:36:21 +0100 Larysa Zaremba wrote:
> > FWIW my feeling is that instead of nickel and diming leftover space 
> > in the frags if someone actually cared about growing mbufs we should
> > have the helper allocate a new page from the PP and append it to the
> > shinfo. Much simpler, "infinite space", and works regardless of the
> > driver. I don't mean that to suggest you implement it, purely to point
> > out that I think nobody really uses positive offsets.. So we can as
> > well switch more complicated drivers back to xdp_rxq_info_reg().
> 
> As Vladimir has mentioned, if the driver does not use header split, frags will 
> have a tailroom of a size of skb_shared_info, so tail growing does work in 
> practice.
> 
> Allocating a page_pool buffer (given XDP queue has one attached) is certainly an 
> option, although I am not sure if anyone needs it. Furthermore, growing tail 
> would still fail for a single-buf case.

sbuf is a different code path, sbuf has precise frame_sz per frame,
not a single value in rxq, no? Don't mean to argue, just making sure
my mental model is correct ;)

