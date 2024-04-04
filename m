Return-Path: <netdev+bounces-84944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C9898BFE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B397B2837C3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4312A16A;
	Thu,  4 Apr 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbGImSA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A3224DE
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247630; cv=none; b=sZgv2Brnu6QJArHlycBy0XhNwGKa1FeTrlMF9oT1TksGUoLrM1x0DM78IEhZach0+WkMEuMlj/gVHvjohYrm4Kk+S9ggnnHEWiCq3M0EmdYFgiZydSFSoe/90VYmrlY/aDvHX7qIN48NIk2wKYtAGWPggs6kSbYT84LoXG96ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247630; c=relaxed/simple;
	bh=QWFxYnjb6JePFDRmvS2MUFIbG2Gqmv8vd6JlBRysqcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYwavYMin1HU5434MQkTT19jgq88IWXT7Cq/7myklNKAzuwkNvW/ewhrjXSNXNY6KZTcDdpA6BVQ5V0p3oD+QDHNq55FxGAUpj71vUrkYUMJL+slbhvxzP6M6DbfkGJGRgjhlVYATE+tqo+0RSU5obVvcQSSV/i1hgIqmTTMsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbGImSA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BBF3C43394;
	Thu,  4 Apr 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712247630;
	bh=QWFxYnjb6JePFDRmvS2MUFIbG2Gqmv8vd6JlBRysqcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kbGImSA1GfacRwBlgMROsg1jebkPBveazPNjDFNqsrKv8TJHVRuqN16KtqNWYDqN1
	 BaV98UK1/J9b3+r+VEa0BC9VcU2nbJ8TYkAM0aRmaNYyvR+awTg4FjJOg/q0mJx9dP
	 ATDGJ+Dg6siSj92Z4N3ZYZTm6YwTQGKStgZdf57XJ3L0xwBofIibOecY7zEIFDwDjR
	 yITGlxvhbZbCqKqRLa9ChlbcwXjIl/YsdWiHNC7vWqT8GTu1Fvm8AuWh8QUIT45yZy
	 elqolg6udMdBaVUUHDvnyksXHOxjrm5aRNCEHYE6pDo5GfzLv1kNH8OGYbBRkCJYa/
	 wxjUlP7/ADBSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA2FD9A153;
	Thu,  4 Apr 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] bnxt_en: Update for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171224763024.26958.13332560093774839224.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:20:30 +0000
References: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 02:37:46 -0700 you wrote:
> This patchset contains the following updates to bnxt:
> 
> - Patch 1 supports handling Downstream Port Containment (DPC) AER
> on older chipsets
> 
> - Patch 2 enables XPS by default on driver load
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] bnxt_en: Add delay to handle Downstream Port Containment (DPC) AER
    https://git.kernel.org/netdev/net-next/c/d5ab32e9b02d
  - [net-next,v2,2/7] bnxt_en: Enable XPS by default on driver load
    https://git.kernel.org/netdev/net-next/c/8635ae8e99a6
  - [net-next,v2,3/7] bnxt_en: Allocate page pool per numa node
    https://git.kernel.org/netdev/net-next/c/fba2e4e5dbab
  - [net-next,v2,4/7] bnxt_en: Change bnxt_rx_xdp function prototype
    https://git.kernel.org/netdev/net-next/c/1614f06e09ad
  - [net-next,v2,5/7] bnxt_en: Add XDP Metadata support
    https://git.kernel.org/netdev/net-next/c/0ae1fafc8be6
  - [net-next,v2,6/7] bnxt_en: Update firmware interface to 1.10.3.39
    https://git.kernel.org/netdev/net-next/c/4e474addc05a
  - [net-next,v2,7/7] bnxt_en: Add warning message about disallowed speed change
    https://git.kernel.org/netdev/net-next/c/e193f53aed21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



