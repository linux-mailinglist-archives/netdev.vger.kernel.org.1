Return-Path: <netdev+bounces-216481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16936B3400A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AFD3BC22D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A4D1EDA1B;
	Mon, 25 Aug 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="oCIv7t3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9Sol54t"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6E1E766E
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126244; cv=none; b=QKloEiJK2FUp4Wwvi2P9QuzVDVTqQ0L6zx63ffOGf1sPPAHUmOwNx1KmfQbetTIJD7y565Qn77Uor0d2vM/rStQD8wUiGchK4DBVn8urtHt1g0PSsXwHiHGQY/5uKUkvixQQol1K8/s1vMvfl2dx0sFIf/o+oBQ8GyDYPKPZ8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126244; c=relaxed/simple;
	bh=QmEe885vDSsDy0lPS+GgdWXoWuZLsB++7oV3cIxDabg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1DRloBeZsFNryYj+3mjS1w6MRuJ/+dqQSlePn5g9jH9JjKHVLXpLBP0Zoqon5R9IBnVXFzbOQgNQqV4oIIJRBQGuxI8kiFhLDrG8gjdPsbTP71CHdukIMqritXcwXa6TuZqKV0VnYeuJIzNgokV7ZCm4BDeB7lxxHFVVUh45PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=oCIv7t3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9Sol54t; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 558A17A014D;
	Mon, 25 Aug 2025 08:50:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 08:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1756126239; x=1756212639; bh=oBNHh1A3es
	RFb6VbZWr3WMfdMz8XkWWlIcfEgy4oseo=; b=oCIv7t3tTX+q3RA8gWcb6vC7ge
	aEEEAFzxSpKuA9nI3iKJU9HURs1S4ORKVJYrXCXALjg3N0KwDOcQrtbp1WWGggP5
	mEpUQ0m6ds/K8hw3WDnewRF/8z0lHTZhX1Ab/wGQHD7BWe/cPtdeKT+qnN6aX6wR
	1RpPYhv1okwnXUD+OgjwJfaeb8U3YVbgI57M9VD2iTX/pGD2fMmlGT4QCI/4dXFL
	15X978PMx/PnNRHSpeoQhtRdGK+PTIqawKameki2t/u7SgYkVPnft0NRJlkMOrOh
	UitcP9ST2jgCX+sFz1FuWTw34mDhk4TOOMLMe8YPWfJ0ELlXNtX5FJeD7oJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756126239; x=1756212639; bh=oBNHh1A3esRFb6VbZWr3WMfdMz8XkWWlIcf
	Egy4oseo=; b=c9Sol54tUPOEYSxbzBEMJN5PxmB4D1KuLR39MDPJA8P9iwoydgQ
	DuYSDLrZsBIEIdAitTUvgW6cmiMSb2cWgx7fV2m0kIdW0kRgRs9Psa4GIx4crH9U
	I4J5Ss9bgpb+j0nVFsT9zHd9LkVQKqaXevL3WzRUBqTuMeP9VQZHzVsyV/FaIlp1
	/zVP45fDVL9CaZMM3410tLIfcNMtE60D1YuGiExSV/T1OOBNHdDEWwGIzJfBZDL3
	v/g8n2n1sTwgruhv5At7nrapD1Bylf9NrsMFCSbuGlTjYOxjG/92tc872cZf+cIu
	nl6kobI6UPhzEf0iq9hPTA1LHBpKVWk3syw==
X-ME-Sender: <xms:HlysaDaPpcrRXBnqQfTnpyFN8HgdB2YDriI6NvOqqfZUNc-D3QHvZg>
    <xme:HlysaK3Ysyng3RjqUP8aPvoJRkR7-EUwHeHMZbRZUAOYWdVDvvRvT1XSS85grKp7m
    8jwHPHV76s3Oma7Dqk>
X-ME-Received: <xmr:HlysaGYfqP_ecTf836GieFxnhzVOzOGSwZykgpjdoegUXpj6m8MZRpbkmgz6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    peihrghnjhhunhdriihhuheslhhinhhugidruggvvhdprhgtphhtthhopehlvghonhhroh
    esnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepgihmuhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:HlysaKLRSLMm8RuqVus4S1Q8ZSmthbcF_YBDQybowyoCC7e_og8N3Q>
    <xmx:HlysaNHs4A5OzhrUrH_pB61t3mQGXEYLGbXdgWTK0DSPVSueR6gDJw>
    <xmx:HlysaJsRPQeZAkPstZBNptIH9IlXm55pdUZqowqq1PfbZ22xLpiY4w>
    <xmx:HlysaEvFg5YfjJRceJAtpEOWTjEDcO4qpuyE7fxtigFUbw7eZ6jeAg>
    <xmx:H1ysaEgUyjHxquxf27knW24-s7lnpYh3Lf0Z7wVZD6ltIWgOAF4x16We>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 08:50:37 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Date: Mon, 25 Aug 2025 14:50:23 +0200
Message-ID: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiumei reported a regression in IPsec offload tests over xfrmi, where
IPv6 over IPv4 tunnels are no longer offloaded after commit
cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
implementation").

Commit cc18f482e8b6 added a generic version of existing checks
attempting to prevent packets with IPv4 options or IPv6 extension
headers from being sent to HW that doesn't support offloading such
packets. The check mistakenly uses x->props.family (the outer family)
to determine the inner packet's family and verify if
options/extensions are present.

In the case of IPv6 over IPv4, the check compares some of the traffic
class bits to the expected no-options ihl value (5). The original
check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
Innova IPSec offload TX data path"), and then duplicated in the other
drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
because those traffic class bits were not set to a value that
triggered the no-offload codepath. Packets with options/extension
headers that should have been handled in SW went through the offload
path, and were likely dropped by the NIC or incorrectly
processed. Since commit cc18f482e8b6, the check is now strict (ihl !=
5), and in a basic setup (no traffic class configured), all packets go
through the no-offload codepath.

The commits that introduced the incorrect family checks in each driver
are:
2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
[ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
mode, thus no cross-family setups are possible]

Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c7a1f080d2de..44b9de6e4e77 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->props.family) {
+	switch (x->inner_mode.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
-- 
2.50.0


