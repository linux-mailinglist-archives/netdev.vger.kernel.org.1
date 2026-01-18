Return-Path: <netdev+bounces-250760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D4D391E7
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57085300FA19
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73457080D;
	Sun, 18 Jan 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZxPgci3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA4139D
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696571; cv=none; b=OMXNaKLjIyZrXMNgJc65fpHrMIidZ8XPfJhyHvZi1e2f3KQ8v/x2oAGJVa8khbTqBKh6Mdhm8/xXD34EWOu/0q459tZDmuTG+qyYzBgqZUpTbKzfiRyAuLReRi6Ydo/tYEzewk26pI4CKrsMq8qcXgrto7QQ2p3lgXBpqaoCfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696571; c=relaxed/simple;
	bh=OdhlQN4oSR/wUV/MhJpI5ir6QzYpxJUvx+K+Mh5GyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXbliQKu7pFWSWVkd+fk3NyyHCpAiUCXsLA5XwGuU91dRmjQbQkU+yG+0aQK2ACegc3sPSj2V0cPSTOonNKbNnXnmK52/FXbbJHP9Id7AvVUKrxsvsiOKOWwALaX3f/DeOkFe4DXBzfU4gB9xbuVoLkEe5ybRwDPAul2OazAXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZxPgci3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBF8C4CEF7;
	Sun, 18 Jan 2026 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696571;
	bh=OdhlQN4oSR/wUV/MhJpI5ir6QzYpxJUvx+K+Mh5GyMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZxPgci3ARqdQA6bn0p7vTfwHB2g18pZ/a88fdUzTqoBWau+Y65X/hdmlnAHuKQ8c
	 lg2Isg4B4UqssxRvSqCZkhCuvRh1FG3atf4eAvmL5sSfG+D7ZipbgF7Ds2Bcf+ozRj
	 4yq9CWx+pvSJVKdcXaTl9T6o8Y2C1oaOtjzLDgw0opcfD5Sh1/oIuK4KNznjFhx3Ku
	 muEQPei81KKkHp/ZdKdgc+QOtxX6fFOBA3d4nBGHTwMsWmBaweObV0p4DANUadZKwE
	 VQGtUtTc5eCA7yMn94I11V2XXQb6FjV74TY3OGkAxllgI76VEIyJFM1Uii+FBwYEij
	 VeCpQ7DLKqCMw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmietus97@yahoo.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	sd@queasysnail.net,
	Jason@zx2c4.com
Subject: Re: [net-next,v5,03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
Date: Sat, 17 Jan 2026 16:36:09 -0800
Message-ID: <20260118003609.1042309-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113162954.5948-4-mmietus97@yahoo.com>
References: <20260113162954.5948-4-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref

This commit changes udp_tunnel{6,}_xmit_skb to use noref dst handling,
removing the requirement that callers take a reference on the dst.
The key change is replacing skb_dst_set() with skb_dst_set_noref() in
udp_tunnel6_xmit_skb().

> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> index cef3e0210744..d58815db8182 100644
> --- a/net/ipv6/ip6_udp_tunnel.c
> +++ b/net/ipv6/ip6_udp_tunnel.c
> @@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
>
>  	uh->len = htons(skb->len);
>
> -	skb_dst_set(skb, dst);
> +	skb_dst_set_noref(skb, dst);

skb_dst_set_noref() contains a WARN_ON check:

    WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());

Does this create an issue for the SCTP UDP encapsulation path?

Looking at sctp_v6_xmit() in net/sctp/ipv6.c, when SCTP sends via UDP
encapsulation, it calls:

    udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
                         tclass, ip6_dst_hoplimit(dst), label,
                         sctp_sk(sk)->udp_port, t->encap_port, false, 0);

This call path can originate from user context via sendmsg():

    sctp_sendmsg()
      -> sctp_primitive_SEND()  [uses GFP_KERNEL - process context]
           -> sctp_do_sm()
                -> sctp_packet_transmit()
                     -> sctp_v6_xmit()

Unlike the network device transmit path (which runs under rcu_read_lock_bh()
from __dev_queue_xmit()), SCTP's control plane transmit path runs in process
context without RCU-BH protection.

Will this trigger the WARN_ON in skb_dst_set_noref() when SCTP sends UDP
encapsulated packets from process context?

>
>  	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);

[ ... ]
-- 
pw-bot: cr

