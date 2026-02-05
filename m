Return-Path: <netdev+bounces-256897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DAqJc7xg2mGwAMAu9opvQ
	(envelope-from <netdev+bounces-256897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:26:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6BEDA50
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8283013D6B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D42882B6;
	Thu,  5 Feb 2026 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbBGR8QZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E31A5B8B;
	Thu,  5 Feb 2026 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770254792; cv=none; b=PWh94Kv+T5STZINi0vLl/WDFAjm+QLxPEr/Jq248/UPNrUsTwaMZvNg5eqFP75qVGqo9Sb4NqwOOBQNq6bzcl1MopXX2CJCV+s+g7kTXwGCTBlPf4fn49jI3Q1UPDRAh836aneJ7gO29GvrKUVBy6bfcOxHvBgs2HEGAAu8hM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770254792; c=relaxed/simple;
	bh=hjxysTPajKK2FZ1aXORytluX1M7dwqbn4j8lWHCg0/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6TbEU7w6UsdEb83PHXePH7Wt7pzzjIp5jDgRAh4W1Z3a4GXTG9d+sm3myWPQ5GcQYzyqb2Arg9lvlZBt4pNlzkToO2cygWDAfKeCsCVmulyglSG+o+zkGSwDj/YNmet96E/PyaOkJrbKldkpN4qTa/hlG5FMIEREcPDBhjzwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbBGR8QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7CDC4CEF7;
	Thu,  5 Feb 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770254791;
	bh=hjxysTPajKK2FZ1aXORytluX1M7dwqbn4j8lWHCg0/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbBGR8QZRyQf1w+JGOdQufOHYIHqbhaclPKXQu+FPwVTQlYMbyJh4dsZ74ICk/u7i
	 Yi+pqPsc7cWmSM5hwMlBzL2YH49kB5Bi+douYUfQnDepKf0Tr0ba2hOrn3+gGd87i4
	 I25scu4d1CtYK+hfjhOWyuOqbBmZkY+nvlq9TbMSChhO2tpFji4BLg/oNoLVtGIOf5
	 rHvFNsMv28+kKOAaOp+nh+43wyIFQ4TmylYSR17lufX08UxgD5ACPRVUmB1WM3iIaH
	 wV7D/1DSzi7r5DprXmNxWWz3xon3gs3HJOvy6uMbc+7QJ9t/+S0WxqhZo8qouhkizf
	 tJaDadsu0gvZg==
Date: Wed, 4 Feb 2026 17:26:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
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
 B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 0/6] Address XDP frags having negative tailroom
Message-ID: <20260204172628.165ac4c8@kernel.org>
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
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
	TAGGED_FROM(0.00)[bounces-256897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
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
X-Rspamd-Queue-Id: 40E6BEDA50
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 11:53:28 +0100 Larysa Zaremba wrote:
> Many ethernet drivers report xdp Rx queue frag size as being the same as
> DMA write size. However, the only user of this field, namely
> bpf_xdp_frags_increase_tail(), clearly expects a truesize.

truesize may not be the most fortunate term.
truesize is how much memory we charge to the skb (for memory management)
which may relate to frag size in strange ways for strange HW :S
I don't have a great term, but I have a feeling truesize already
confuses driver developers.

Note two our xdp.py tests covers tail adjust, I wonder if it would have
caught this for you. Looking at Intel's results the XDP tests don't run
due to missing BTF. Could you work with Adrian to address that?

