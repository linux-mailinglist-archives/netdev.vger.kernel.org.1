Return-Path: <netdev+bounces-44892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6357DA356
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC33B2167F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4BB41747;
	Fri, 27 Oct 2023 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlBe26tu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3D41744
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85CF0C433CC;
	Fri, 27 Oct 2023 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698445224;
	bh=msebrR1I7+vZpTi545jekrcHXVdVablbgfuJLEnmKg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hlBe26tu6ka96LmPjsAKWHl9XqjJhProga1O5/N2XPuE/7XcrlrmO3gb5Sazqp6lO
	 /Ix22R9zY0MGxNT15zMY8V6U7VHWhsxRPhRbDWKcjNF89Qeply9U54YZIHdt6erJP7
	 SrUQxSU5jkVgjZ+zi42n9SuvgUpmtrn+VgsYHEB4yBMz6kmuF8pnzNkfAQCKA86u6a
	 ht3hEOZK+WRwPjrt0L2DVoGn3PShsYQlP7nCLCipNXNmExmuMWuBNdyY2rFvftCEQl
	 B3jBt30KGxyZumJf+MojE7OaScBJuwBR8ltYwEJQG3GMl4nk2/Z8RrLQkYlzuVvt68
	 AfOhQE1A4QYIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62C3EC41620;
	Fri, 27 Oct 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] doc/netlink: Update schema to support
 cmd-cnt-name and cmd-max-name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844522440.2105.16707195646883353457.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:20:24 +0000
References: <12d4ed0116d8883cf4b533b856f3125a34e56749.1698415310.git.dcaratti@redhat.com>
In-Reply-To: <12d4ed0116d8883cf4b533b856f3125a34e56749.1698415310.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 16:04:54 +0200 you wrote:
> allow specifying cmd-cnt-name and cmd-max-name in netlink specs, in
> accordance with Documentation/userspace-api/netlink/c-code-gen.rst.
> 
> Use cmd-cnt-name and attr-cnt-name in the mptcp yaml spec and in the
> corresponding uAPI headers, to preserve the #defines we had in the past
> and avoid adding new ones.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] doc/netlink: Update schema to support cmd-cnt-name and cmd-max-name
    https://git.kernel.org/netdev/net-next/c/6479c975b20a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



