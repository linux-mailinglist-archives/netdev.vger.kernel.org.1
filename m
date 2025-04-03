Return-Path: <netdev+bounces-179030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8EA7A1BA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ED77A67EF
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5924BD0C;
	Thu,  3 Apr 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7s8+41e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9724BD04
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678893; cv=none; b=ipK8YZnxg3I4owM3kvaD77HrM1uXa2BmqeL+lvkVrlxru58v0qqczwLVqLoVoJH1WnSGZGiBRKZhkr6t91HUkghI3wDHsYGQI8b+ObA0tXJd8KCjMQQLV/nhJ5cG4Phbi2Jr59FfNAC9TrEKfoRbXAztbqLMNbEeqdOPAG3bX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678893; c=relaxed/simple;
	bh=pc+J5u3rZeyam7gSABUDka++ts+lmH5JkSxFNMyvk1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5SE4G4Xzs95wx68jdchhHn+hdK4PGr1x1ENi87g0oaNdldhUJ1aoUMQ+ht51y4tQgdbRqgQ9e3Wefzv4DUbS/hMGvmrYva0bVoKgLNFoDSEonbYN34rtb1GKQ9CTPklt3cfUEaPxH0SDSdbBf89UrmcUTEignvYpHx6dfMZHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7s8+41e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6CDC4CEE7;
	Thu,  3 Apr 2025 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743678893;
	bh=pc+J5u3rZeyam7gSABUDka++ts+lmH5JkSxFNMyvk1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I7s8+41eSnrzSjh6aoNV+iHDC8PpquILe0AqDckbRRmsDL5N37UbJpGDQgVnqwcrN
	 OzAXcRLdnGabW3FCvIUNqia6cyr5OUR/9chQn4/TewsB51b4mc6H3lajomaoFNnxKw
	 AXW6WXMepdQD2ngF6n2TUt0SFNqqSPKjLtI9/PdEfajoHhiO7LWJAMCO9shRBHuix2
	 tCMhmKii2ejggq1G2sc/fSFZx/tVEPnnLbnHcVZZhiUDN1yU/NJn84LE3tac/vCyTv
	 gVafhkwS998UcZ9c0sTtmpGRw/nJENdjNyoo7Beocfc/dFsrhJpZhC9D2GDWtixlvK
	 vUYgnohLkjXtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF4380664C;
	Thu,  3 Apr 2025 11:15:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174367892998.2450004.7630299613826047058.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 11:15:29 +0000
References: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
In-Reply-To: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, pshelar@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 sbrivio@redhat.com, dev@openvswitch.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Mar 2025 01:33:44 +0100 you wrote:
> Because skb_tunnel_check_pmtu() doesn't handle PACKET_HOST packets,
> commit 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper
> pmtud support.") forced skb->pkt_type to PACKET_OUTGOING for
> openvswitch packets that are sent using the OVS_ACTION_ATTR_OUTPUT
> action. This allowed such packets to invoke the
> iptunnel_pmtud_check_icmp() or iptunnel_pmtud_check_icmpv6() helpers
> and thus trigger PMTU update on the input device.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().
    https://git.kernel.org/netdev/net/c/8930424777e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



