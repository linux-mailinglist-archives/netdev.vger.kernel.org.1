Return-Path: <netdev+bounces-256898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HjLNJzzg2ndwAMAu9opvQ
	(envelope-from <netdev+bounces-256898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:34:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27BEDACC
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABFD93013791
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356D28727F;
	Thu,  5 Feb 2026 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvLrpYKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231B29CEB;
	Thu,  5 Feb 2026 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255245; cv=none; b=QEbI7Vx4P8h5cpr4YszihzQfDQaJf63iKYS/mWfdnyBSgr93GP7PR6Gig7Hh+/47liG/FfOXBM8KkoEcFvrftVBXzdpSfdfmmQnSLJidoswyJ00BzRkVCNAcWdQBF5+NhWbwLJSI74q/lMblRNhwAc2qVOUEq4KWmGY4Y1Dwnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255245; c=relaxed/simple;
	bh=0u0PVRNuSSgJ24J9RSkTtvGB/Sq3SToazqRzHf3k9oM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVLlK5VM1vo41kmjKgEfgtkNovH3+1iaFlIElx4iZ2LPjOIoLB2+zbUbag+Uij2SCKwm8TgEIzNEEgtm0E5gDLrD4e4neNlrd7XjhUq0/cCYsXpNsWq5RDed6BSC875M3llo8hJ6MAD8dzWdVeq32AIXlyhoAiuv86oIBOLTDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvLrpYKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE722C4CEF7;
	Thu,  5 Feb 2026 01:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770255244;
	bh=0u0PVRNuSSgJ24J9RSkTtvGB/Sq3SToazqRzHf3k9oM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JvLrpYKJ+A2rWVs3m/oJxbPk0NKGBV3yMRqt1DguRhcao+2cLLgtrW+isjepeRdRm
	 0KBV76gfQqSSxGOhOmvMM/RyLPDWlG9S1kHtvuZWyk6AXt/sEstH8IIJifkP/p6xIB
	 BD1m4M+QGdw13h/YVfZwgxp2lTPt0aVOYTVn7ABLW4DNV9iMQ9A41ZZALHaJZNkFBx
	 RThyPw3UfVlM+waX3tvsKyhHDU7VmBVhtNfnW38PH68F25bDbuyv+t/Y1Wb2aUrgSb
	 SAdRL3rU2JebD0trLF5grO4sIulV/wTIwizO/fIbDW6lGkCaEIYz+l8uUs1BvfX/pc
	 Qqeo72b6g/UsA==
Date: Wed, 4 Feb 2026 17:34:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGniiJrCrnJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <20260204173401.282899d0@kernel.org>
In-Reply-To: <20260205005901.gnju3zmqimtgeu2b@skbuf>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
	<20260203105417.2302672-7-larysa.zaremba@intel.com>
	<20260205005901.gnju3zmqimtgeu2b@skbuf>
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
	TAGGED_FROM(0.00)[bounces-256898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D27BEDACC
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 02:59:01 +0200 Vladimir Oltean wrote:
> Thanks! This is an extremely subtle corner case. I appreciate the patch
> and explanation.
> 
> I did run tests on the blamed commit (which I still have), but to catch
> a real issue in a meaningful way it would have been required to have a
> program which calls bpf_xdp_adjust_tail() with a very large offset.
> I'm noting that I'm seeing the WARN_ON() much easier after your fix, but
> before, it was mostly inconsequential for practical cases.
> 
> Namely, the ENETC truesize is 2048, and XDP_PACKET_HEADROOM is 256.
> First buffers also contain the skb_shared_info (320 bytes), while
> subsequent buffers don't.

I can't wrap my head around this series, hope you can tell me where I'm
going wrong. AFAICT enetc splits the page into two halves for small MTU.

So we have 

 |                 2k          |             2k              |
  ----------------------------- ----------------------------- 
 | hroom | data | troom/shinfo | hroom | data | troom/shinfo |
  ----------------------------- ----------------------------- 

If we attach the second chunk as frag well have:
  offset = 2k + hroom
  size = data.len
But we use
  truesize / frag_size = 2k
so
  tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
  tailroom = 2k - data.len - 2k
  tailroom = -data.len
  WARN(tailroom < 0) -> yes

The frag_size thing is unusable for any driver that doesn't hand out
full pages to frags?

