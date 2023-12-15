Return-Path: <netdev+bounces-57916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CD8147B5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66137B2243A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE792C851;
	Fri, 15 Dec 2023 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgedJr/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B82C6B1
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A308FC433C7;
	Fri, 15 Dec 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702642225;
	bh=59ZZJ5aRinxyoSDuffWOWcKIRH35CieEgBH6uWp9yu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgedJr/blEU35GidrZNii22N9UtLt7gRGRq9H493jC/Ds7SiLDigEBY2aD4sOvFCA
	 b+VTfDOAflgofs3YlKzDOVhiwiZwzY5nv2nZxSVpmb9Gny44OUG1iXalQtUai6grkQ
	 9W2ASV/QwbOeRTQ3DKneIbvZCaIcl3vToF9pwDCr/Fk+fJLGpmmaIU/E9JIPit6yfU
	 Nuny4PAUtQyXy2uZtDCpSpKKl+TB9p2Yto/DNINsctwyZhleg+t76dunashLSpG5aZ
	 lxnTHJegxkQgIckMY3VVOnlXS5eyw4+ZgwlR0kP2/tGkQypSJtAHsdsuPBeZIXJb/1
	 LAzKy923cGqNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DD16DD4EF7;
	Fri, 15 Dec 2023 12:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5][pull request] add v2 FW logging for ice
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170264222557.21512.9658938859232248683.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 12:10:25 +0000
References: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, paul.m.stillwell.jr@intel.com,
 jacob.e.keller@intel.com, vaishnavi.tipireddy@intel.com, horms@kernel.org,
 leon@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 14 Dec 2023 11:40:35 -0800 you wrote:
> Paul Stillwell says:
> 
> Firmware (FW) log support was added to the ice driver, but that version is
> no longer supported. There is a newer version of FW logging (v2) that
> adds more control knobs to get the exact data out of the FW
> for debugging.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] ice: remove FW logging code
    https://git.kernel.org/netdev/net-next/c/1953fc720e60
  - [net-next,v6,2/5] ice: configure FW logging
    https://git.kernel.org/netdev/net-next/c/96a9a9341cda
  - [net-next,v6,3/5] ice: enable FW logging
    https://git.kernel.org/netdev/net-next/c/73671c3162c8
  - [net-next,v6,4/5] ice: add ability to read and configure FW log data
    https://git.kernel.org/netdev/net-next/c/9d3535e71985
  - [net-next,v6,5/5] ice: add documentation for FW logging
    https://git.kernel.org/netdev/net-next/c/d96f04e05f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



