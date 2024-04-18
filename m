Return-Path: <netdev+bounces-89099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9138A9725
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15ADDB20DB0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24915B56B;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIfzu9XS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F015AAD9
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435629; cv=none; b=MjoxdmHn0lvaUyK8Axrpo3En33PdfWXwH9Sxa9r4o3xADSbJI3d7VVr+OnkNL/jB0sPD+Ky7fP0xOIq1Qmqigxd/x4r0Mzit4sifdI+Udg/5Z/YSV0DuCIJoDfkeqYpAAR0ET8AP3Nv9EWfLcYeZvnUFLnSRhl7sGYMF6TYFYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435629; c=relaxed/simple;
	bh=6hi9Jzqi7UGzHry1/ryD6kKDBURywSC6JuxQ2oOcS+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIrCLOtU0fLwvikQBDk86i1jdi5AmkxBT3PaAlYUGZptE734WMUZ1papjwU3WZWwwE1aiSP3c6J6hpForPr54J7U7/q5++XdDsd6h6fdXyiWTCju/9S3PDgVGiYFhuGy/1DbR1ofbr0AAUi554buBZ/3DVYdDj0FGVydNvPpJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIfzu9XS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32689C113CC;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435629;
	bh=6hi9Jzqi7UGzHry1/ryD6kKDBURywSC6JuxQ2oOcS+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MIfzu9XSAzb7Kyzt5wCfgspTKji3KU1ObU+DQh92CnO8J2J6QhZzWxgf9waQ+J6v4
	 fz2pAGDWZAyvLs7ntFlmnBm6Os8JhDzMYLIAaABDCWKS3+sl9h2m/D3wFzfZkbZPYX
	 aYI3ik4R5iljpkS3c9l2ip6goooFUFI2gLB7/sHsooB9INs/BeSZLjvUd9qpg27ttT
	 4cYnS03K3DwU6SID0OGzNrIeZH4lC0BCFTyz9gLRIRGJ8x+EtrHpds2DUx23qgsOEo
	 TzWuKvaaiCKoJuEsVLUAYdqpnVEOokbcWAUPlTmAMYSetoxqNOjF40hnIzIY7DQc2E
	 W5xnWMLhcVObQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27A71C43616;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ibmvnic: Return error code on TX scrq flush fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171343562915.22936.5227395243425085286.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 10:20:29 +0000
References: <20240416164128.387920-1-nnac123@linux.ibm.com>
In-Reply-To: <20240416164128.387920-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 mmc@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Apr 2024 11:41:28 -0500 you wrote:
> In ibmvnic_xmit() if ibmvnic_tx_scrq_flush() returns H_CLOSED then
> it will inform upper level networking functions to disable tx
> queues. H_CLOSED signals that the connection with the vnic server is
> down and a transport event is expected to recover the device.
> 
> Previously, ibmvnic_tx_scrq_flush() was hard-coded to return success.
> Therefore, the queues would remain active until ibmvnic_cleanup() is
> called within do_reset().
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ibmvnic: Return error code on TX scrq flush fail
    https://git.kernel.org/netdev/net-next/c/5cb431dcf804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



