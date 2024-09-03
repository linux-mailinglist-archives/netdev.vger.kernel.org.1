Return-Path: <netdev+bounces-124547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CB5969F64
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E816284EE9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0D1CA699;
	Tue,  3 Sep 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+8kVts3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417761CA682
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371431; cv=none; b=V6XaUlWMQzv/xXgd0zI7GJn7cdMuWcQkwKMlPnvyGFjlOTd2TZuWqlTjciQmGxgFxEYG1l6OxnHNLBpT9O8mOL+iUXcP0c1R3uhQMF0BF5o9O7HeIYC730euLT69/Sg1NtDQfHnHWRDZ1AVQo3oBth9yAip8uoTfqIRn24muCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371431; c=relaxed/simple;
	bh=nZSiFn24JmssA/jqe+rFNRS+XWynhPgs3HSfzycFdPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naulKoqSIaBVmzYDJiYLoh0hpV17p2JJAdQ+nhAme0hib8rCZmFY1xteJ43sK/fKDxSzjcAxg5aoKqj1S1QQ+H46qFs5IHHrTW6IWIbZtKvndy6xwnGVWMB4lAp/+xr5mZlT95Se/KCO0egAPx6BGFu0WekLILafqmbC8Rtk904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+8kVts3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF86C4CEC4;
	Tue,  3 Sep 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725371430;
	bh=nZSiFn24JmssA/jqe+rFNRS+XWynhPgs3HSfzycFdPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+8kVts3qDwqD+ABi+4MinotTbzMm04U2hzDMj6LpheVefe9IIAaXblJ4o92PjIAw
	 FQlDJ8FwMoGaURoSQai0OII0mcqKD0Wjq3JxuNOdxIliJ/gu8Lz86kwK4Lsf38V5Xt
	 w34yIWctuP8s9AEwbDIwE6GOkSFFh19ZTS6Q3DRpXXaedSsJQ9GRhkIzy2rgMcb+sS
	 qhO3KXXSv/klHFXPH+oOCL5BBaaXtjKloM1DcdqYyW73w74fm3WekUe2xx3s8R0cBz
	 +ccpv5lTJrtSTVJp5NHfv0Jb16Q8ufeMLM3PIXS5nqDfNNUmGCCcCrqjkbpKNAVeXk
	 zMi6VIXPR8Dmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5B3822D69;
	Tue,  3 Sep 2024 13:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/3] ptp: ocp: fix serial port information export
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172537143152.308759.15107696230975459912.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 13:50:31 +0000
References: <20240829183603.1156671-1-vadfed@meta.com>
In-Reply-To: <20240829183603.1156671-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, jonathan.lemon@gmail.com,
 jirislaby@kernel.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Aug 2024 11:36:00 -0700 you wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design [1].
> This series implements additional attributes to expose the information
> and removes symlinks for tty devices.
> 
> [1] https://lore.kernel.org/netdev/2024060503-subsonic-pupil-bbee@gregkh/
> 
> [...]

Here is the summary with links:
  - [net,v7,1/3] ptp: ocp: convert serial ports to array
    https://git.kernel.org/netdev/net/c/d7875b4b078f
  - [net,v7,2/3] ptp: ocp: adjust sysfs entries to expose tty information
    https://git.kernel.org/netdev/net/c/82ace0c8fe9b
  - [net,v7,3/3] docs: ABI: update OCP TimeCard sysfs entries
    https://git.kernel.org/netdev/net/c/40bec579d4c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



