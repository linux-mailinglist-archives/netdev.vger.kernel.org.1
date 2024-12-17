Return-Path: <netdev+bounces-152464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9C9F4061
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E728B1885B94
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2113CFB6;
	Tue, 17 Dec 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpOJ4XhL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AECF13BC18
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401420; cv=none; b=et7f4YidrXfFrQZ0a2SNahY1e4AWTWR0YkNolHoiYUR8kRPFSPf5skOyhkCfZmqfdhr9NH43+48wTmZtncdJisaqLnJa4NCYCKv//rhp2cjlmhcSvWXtyVEMSf/p2UameWQuYmRwmQ4u9RXcp7tJFsaNPUwoJvWWhJINkBsld4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401420; c=relaxed/simple;
	bh=HVEyFf+RLcDDERJl9JQhCT2bAbJyU9eWCZpb5doPhDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgXY331mQOyJmdiF9SQCWJMSa1EdPS/8c4AwZ3yfehSIpue2PGCpWvbjkDHmMxNmAB3s/9BAEUjOquWoor6VhTjmZXqLyjx6sqEzKWX+ICmWfdcri9dzj4uhEPgh2LkTyh4UsgoWYcNU9FWgvW5h4FgzzG4aoTTm2lHbp+GF3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpOJ4XhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CA9C4CEDE;
	Tue, 17 Dec 2024 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734401419;
	bh=HVEyFf+RLcDDERJl9JQhCT2bAbJyU9eWCZpb5doPhDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MpOJ4XhLX2Qo0L1UV1fa8zZyiotfxbg183VTL0s8OLSb/mT0GRQ76vgOpW4nKfCOn
	 deIzWszzz0xdQ4Ubu0yROGj92oQXs8uCtYRapsrIwPLJ/6TnZyL79l/Q83N2c2+ujh
	 rIwSvcD9shbOc3BVJDVurk6ax8s8WrEZ70/r5lB0tRMyaxQTf9aXTLwvaRqVlT3/EG
	 AoSX/ToRK41CPcROvlQGVQZDQWmQiMjysjL0aYcxVHL2bGjvmj0CluLYHIxYmjxwpU
	 SKFsUrT8nwdm1IzeuP/5ca6dIiAbNeTN4+/acquu2fh7h+RIL+u3PF9SWyX/mXuk6J
	 MQHJOsPg4mMfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6B3806656;
	Tue, 17 Dec 2024 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] netlink: specs: add phys-binding attr to rt_link
 spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440143700.415501.14462623837672169677.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:10:37 +0000
References: <20241213112551.33557-1-donald.hunter@gmail.com>
In-Reply-To: <20241213112551.33557-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 khangng@os.amperecomputing.com, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 11:25:50 +0000 you wrote:
> Add the missing phys-binding attr to the mctp-attrs in the rt_link spec.
> This fixes commit 580db513b4a9 ("net: mctp: Expose transport binding
> identifier via IFLA attribute").
> 
> Note that enum mctp_phys_binding is not currently uapi, but perhaps it
> should be?
> 
> [...]

Here is the summary with links:
  - [net-next,v1] netlink: specs: add phys-binding attr to rt_link spec
    https://git.kernel.org/netdev/net-next/c/4fe205539c46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



