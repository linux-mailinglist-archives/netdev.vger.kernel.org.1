Return-Path: <netdev+bounces-61478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EF823FE1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3989C2863E3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2020DC7;
	Thu,  4 Jan 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQj782Fz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D120B3F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 10:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C95BC433C7;
	Thu,  4 Jan 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704365427;
	bh=+bfZ1zCP2eUKn4PAQqX98Wr6EOEGOjVs1PBsxtXMR9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQj782FztLmtna+2mGedReIuak5R57ooapb9HADP5icRNTwqeVuDNjT3eJQlnvA8Q
	 +n8GrtHjd8qbxY0vWOk5EDHc/wfhXPeFASwvN5fxIKIwPAgV+cRzUWo1cyxxxzEFIu
	 /0eEpsvbQrBgcKELzxfW6aRHuHvE6c8r3/oJCrC5R8M3hSazhJd363/1C4HpskxNMP
	 1SxKwEgtEpHvtx+hVqSWbESPHDKA68kJp6TWf34eDWOCejMpfGLul+v2YB/bhHDo7/
	 k7iy5GJxF7TTF38NypdI/IPSWCLObidWaAUwXTdDorGtBx5mRJxfqlycEX5idauQ/1
	 lYF89tYXhMmGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16A55C3959F;
	Thu,  4 Jan 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates
 2024-01-02 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436542708.7373.1181873652581436770.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 10:50:27 +0000
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  2 Jan 2024 14:04:16 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Karol adds support for capable devices to receive timestamp via
> interrupt rather than polling to allow for less delay.
> 
> Andrii adds support switchdev hardware packet mirroring.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: Schedule service task in IRQ top half
    https://git.kernel.org/netdev/net-next/c/00d50001444e
  - [net-next,2/7] ice: Enable SW interrupt from FW for LL TS
    https://git.kernel.org/netdev/net-next/c/82e71b226e0e
  - [net-next,3/7] ice: Add support for packet mirroring using hardware in switchdev mode
    https://git.kernel.org/netdev/net-next/c/aa4967d8529c
  - [net-next,4/7] ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()
    https://git.kernel.org/netdev/net-next/c/2a2cb4c6c181
  - [net-next,5/7] ice: remove rx_len_errors statistic
    https://git.kernel.org/netdev/net-next/c/f9f9de23dc88
  - [net-next,6/7] ice: ice_base.c: Add const modifier to params and vars
    https://git.kernel.org/netdev/net-next/c/b8ab8858190a
  - [net-next,7/7] ice: Fix some null pointer dereference issues in ice_ptp.c
    https://git.kernel.org/netdev/net-next/c/3027e7b15b02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



