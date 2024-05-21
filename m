Return-Path: <netdev+bounces-97353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18148CAF8A
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1884A1C219EA
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D817CF39;
	Tue, 21 May 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj2MpE1B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDB71B48;
	Tue, 21 May 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298882; cv=none; b=cq4Q18fol47QbporK5TP7thX19cvdAlJc/NDVgXkKhLwnZlCUS5xw1BQocTwYTLHEmHPOTQqEWWg5cXB4xUFZZBk8JsdmxnnSIhnkC8BxOfYZW6yxLCyZmKq0v4xyxrseFg9sK+sB5SZ5cqkEHRlYbYfzvUw76wJz8kzhFYBP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298882; c=relaxed/simple;
	bh=QsCpNPWVAP11wS/oCn4UMHOx030abCVcy2yNRatBuQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UJrEY4J9Egb3/eey+oLWK2KvWN9tJCxF1Dxkt7tcTWN6/GNqLhUtE7utZ+mrTdZXgrBjp4O9Hey0JJuOTDKhoahIhpAkOe2wi9vunfQAWN+Qi0uYhWd+Zi7YXH82ZUTy+MZ3ubtEis73H3PkngmM6uOFMYnz9I5rlnLA+ibbi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj2MpE1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B201DC2BD11;
	Tue, 21 May 2024 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716298881;
	bh=QsCpNPWVAP11wS/oCn4UMHOx030abCVcy2yNRatBuQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fj2MpE1Bna0iH5UkMrpzvSbYEJN/hR2khqBxR+jKZubYynkdhl4YWFGAJ+JamLEHO
	 QcB2EEeq6nvLoY0TEA6surqtQcRNKDsKBEESeoeoA2OM5OVOfhX3CDtjGfi3eSwZN+
	 GAr3xwqWXVikGEQSFO9CgkbafdgbPHRGC7FWb5sIRp2/9+qyOOlQcW1mfQi+qWygJo
	 55VSYloLX5AQJIw/dW7sM7iviakA8NYB/+veSIwbcpXZzHzFlhet0fk2OQV42SoMzc
	 iQH9WSaoBiQiBl/I1acsPPDa2uZgvkQzhZ88ehGot32mM7gURgya4dc2uLq4gci/jl
	 aL25FplfSTtYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A762CC54BB5;
	Tue, 21 May 2024 13:41:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] openvswitch: Set the skbuff pkt_type for proper pmtud
 support.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171629888168.10197.12754177627496640695.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 13:41:21 +0000
References: <20240516200941.16152-1-aconole@redhat.com>
In-Reply-To: <20240516200941.16152-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jesse@nicira.com, echaudro@redhat.com, i.maximets@ovn.org,
 horms@ovn.org, jcaamano@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 May 2024 16:09:41 -0400 you wrote:
> Open vSwitch is originally intended to switch at layer 2, only dealing with
> Ethernet frames.  With the introduction of l3 tunnels support, it crossed
> into the realm of needing to care a bit about some routing details when
> making forwarding decisions.  If an oversized packet would need to be
> fragmented during this forwarding decision, there is a chance for pmtu
> to get involved and generate a routing exception.  This is gated by the
> skbuff->pkt_type field.
> 
> [...]

Here is the summary with links:
  - [v2,net] openvswitch: Set the skbuff pkt_type for proper pmtud support.
    https://git.kernel.org/netdev/net/c/30a92c9e3d6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



