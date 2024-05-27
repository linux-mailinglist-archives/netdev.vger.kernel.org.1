Return-Path: <netdev+bounces-98157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE698CFD4E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF54282985
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322313A3FC;
	Mon, 27 May 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op0KTvwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE124778E
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802965; cv=none; b=BA5S5AQk48TVNnlxNYas3wWz3SUqAX+zIQhMEs7Cody51XGVPPbQuFWOhr+HPBsoTtEG62hzwm16iLgz8wwn10rDRlzynHk4ZU4X+zMer8qYZBSXo0y9gbgqk3cB4MTczMjuMv1UZ0prKZTGOyUBofEQeJbjnZOhVQCScEsboDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802965; c=relaxed/simple;
	bh=M47g3uKNSYYLqjkK1aF4LxVyRzx8quWIs11iu+i5DxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RfNKQ/uZ7RVU4YYiSsUsq2NUcLiJyjGqZ6ff8W4bU2h3DWDcrw2+hJR+jZXTGU/Txk2xZlcDpG6+DQskXNMaST3Vqg7w1Ida8L0Y5B/6IKM5fOT3ccDIkqiWtmggpf5JFvYhUig4UgD8kZ9nkzY15J0OVyRGLLXep6zAyRx8on4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op0KTvwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A64FCC4AF08;
	Mon, 27 May 2024 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716802964;
	bh=M47g3uKNSYYLqjkK1aF4LxVyRzx8quWIs11iu+i5DxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=op0KTvwehvCpyiUgnWB59jZ1qjuWqjZC5Igf4WBuw2E3rj/BybV49CsIrDyn4K+/D
	 WJXAF23z9zMrL3T2ih2fPzq7i2OnB1jH1NL4CXjEzL0cfzMLDMlgGc4yJEar27vfR/
	 u0pd7gKkFyeB+sNixJ7L+2qimjoCLkny1agWjXrufJspoSGbvF/EZKEKEwTWw3xAnz
	 0NKuZMTeFG+l/XuOLwwz50V9AJbUAEZb/Lm4pT+LOURtF4+zJ5YyhmZkNLPiIDCMSM
	 GyeOYVvEZfz21dlOqz5vHsUunqOeY7F83yZLAAy1tDi5SnOUydmYiDgdLaLLhRw3yY
	 yFboE4q4TH/TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CC3BD40191;
	Mon, 27 May 2024 09:42:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] enic: Validate length of nl attributes in
 enic_set_vf_port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680296463.9196.1896374308140927218.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 09:42:44 +0000
References: <20240522073044.33519-1-rzats@paloaltonetworks.com>
In-Reply-To: <20240522073044.33519-1-rzats@paloaltonetworks.com>
To: Roded Zats <rzats@paloaltonetworks.com>
Cc: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 orcohen@paloaltonetworks.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 May 2024 10:30:44 +0300 you wrote:
> enic_set_vf_port assumes that the nl attribute IFLA_PORT_PROFILE
> is of length PORT_PROFILE_MAX and that the nl attributes
> IFLA_PORT_INSTANCE_UUID, IFLA_PORT_HOST_UUID are of length PORT_UUID_MAX.
> These attributes are validated (in the function do_setlink in rtnetlink.c)
> using the nla_policy ifla_port_policy. The policy defines IFLA_PORT_PROFILE
> as NLA_STRING, IFLA_PORT_INSTANCE_UUID as NLA_BINARY and
> IFLA_PORT_HOST_UUID as NLA_STRING. That means that the length validation
> using the policy is for the max size of the attributes and not on exact
> size so the length of these attributes might be less than the sizes that
> enic_set_vf_port expects. This might cause an out of bands
> read access in the memcpys of the data of these
> attributes in enic_set_vf_port.
> 
> [...]

Here is the summary with links:
  - [net,v2] enic: Validate length of nl attributes in enic_set_vf_port
    https://git.kernel.org/netdev/net/c/e8021b94b041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



