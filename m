Return-Path: <netdev+bounces-146100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B89D1F08
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034D91F2239A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9E1494A7;
	Tue, 19 Nov 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1cnzD7O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7D1482ED
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988829; cv=none; b=Zp7ySMAzMoZofnNZEXJeQfDyQOLd76iYoNPxRFP44zCc0tFrjkGXcmg+rEY5V0qmv5L/mZfcUBqMDKDFPc22/CjgTehfwYvG8v7Ei93oVhPI99TVxhF3ZG/noZDyc4PtpylbKuPAG8kUr71wR/o+37mad4G8KYBpMa5sA4q0AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988829; c=relaxed/simple;
	bh=KdPxLplAsYo2V4JcSQ067z2zsqzEhlAeyvAzdZG4vcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etMsxsxYbNRfO6pgMHqQ9WTfmC4b6xljmX1IBSx65lZ6ZSpB8M/1MAP3ehiWIJnD4V5CZpUKjnOYgA6A5TrBmqOhDjsLfFsw0uomvi6D5JxEDVQ0UVtJRF79nkdswakxXSgbckKrwMMU05b2h760HP5gmyHMs2OIB+VaBEVRGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1cnzD7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7720C4CED2;
	Tue, 19 Nov 2024 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988827;
	bh=KdPxLplAsYo2V4JcSQ067z2zsqzEhlAeyvAzdZG4vcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i1cnzD7OJJlJ9RZ5B2TNOT4o29N00DG4r3xD0AuNqihAkGLaG17nbAcuvOVmYJO4R
	 OkR54xvjydTzeALIcFQZDIPt025bC2Ozc5t2B/SOQAEzYggTMK8e9WI4Yu39vF9Die
	 aczJCXpCxc4Hla7RjOs3RWoCJudRpfjMuVuvrzu6oqKM9l1ILwcoZGLDz4cecaSIIt
	 MRvo5zAu/2rPseMS2dA/SOS82657h80LPF1Izs/CDErop0eFI1pY6jfqfSl5zksOYs
	 BL8/62M0j5c0FHpIC+iAepFApwEhEKT2uUB4b45XcNpcBFrQS5vghGi2p6nNwJzoLP
	 SP05cPnf8Urbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA83809A80;
	Tue, 19 Nov 2024 04:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] bnxt_en: Add context memory dump to
 coredump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198883923.97799.4092753376670679738.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:39 +0000
References: <20241115151438.550106-1-michael.chan@broadcom.com>
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com, shruti.parab@broadcom.com,
 hongguang.gao@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 07:14:26 -0800 you wrote:
> The driver currently supports Live FW dump and crashed FW dump.  On
> the newer chips, the driver allocates host backing store context
> memory for the chip and FW to store various states.  The content of
> this context memory will be useful for debugging.  This patchset
> adds the context memory contents to the ethtool -w coredump using
> a new dump flag.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] bnxt_en: Update firmware interface spec to 1.10.3.85
    https://git.kernel.org/netdev/net-next/c/ff00bcc9eccc
  - [net-next,v2,02/11] bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
    https://git.kernel.org/netdev/net-next/c/0b350b4927e6
  - [net-next,v2,03/11] bnxt_en: Refactor bnxt_free_ctx_mem()
    https://git.kernel.org/netdev/net-next/c/968d2cc07c2f
  - [net-next,v2,04/11] bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
    https://git.kernel.org/netdev/net-next/c/46010d43ab7b
  - [net-next,v2,05/11] bnxt_en: Allocate backing store memory for FW trace logs
    https://git.kernel.org/netdev/net-next/c/24d694aec139
  - [net-next,v2,06/11] bnxt_en: Manage the FW trace context memory
    https://git.kernel.org/netdev/net-next/c/84fcd9449fd7
  - [net-next,v2,07/11] bnxt_en: Do not free FW log context memory
    https://git.kernel.org/netdev/net-next/c/de999362ad33
  - [net-next,v2,08/11] bnxt_en: Add functions to copy host context memory
    https://git.kernel.org/netdev/net-next/c/23a18b91b609
  - [net-next,v2,09/11] bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
    https://git.kernel.org/netdev/net-next/c/a854a17097b9
  - [net-next,v2,10/11] bnxt_en: Add a new ethtool -W dump flag
    https://git.kernel.org/netdev/net-next/c/bda2e63a508b
  - [net-next,v2,11/11] bnxt_en: Add FW trace coredump segments to the coredump
    https://git.kernel.org/netdev/net-next/c/3c2179e66355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



