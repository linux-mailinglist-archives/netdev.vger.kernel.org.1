Return-Path: <netdev+bounces-14268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25B73FD4D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934831C20A96
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37918AE8;
	Tue, 27 Jun 2023 14:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EA12B66
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7075BC433C9;
	Tue, 27 Jun 2023 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687874421;
	bh=ZEwQrb/fi5vfcUlclM+i6WFurE6qdtrAMyjekMsn2ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1v/qG5rZyuf5SOAJR+J6lY80Y/Eia6qfIYguXUB+KkFX4/BgwumlQypCqBCivDk5
	 Vf6CGTOoAFWQlQy1t5B7geOL1Z3Lk+JiVlNS33vjJek5r+AEme9QLX7dknkO/DbLWh
	 vPU6E0gXcSxAsxRb5xMI/63PKjC0rIIkRayIO6HicYi8c+kOi+IC/u3AkMWUGFCPPO
	 cOdlNelRoORFFQSeemf/ORMBwDIOWtYG9bIYmcaJ3ALaeDqOt77h33ux5QgOgmWTpr
	 DSzuM1lyaxkEOu1lLGtzMh7+6OvIUV3I0AGBui1U8eWDl3Wzk3htBu8r1tFUlY0+XN
	 B6iDC/3/zN3Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51330C0C40E;
	Tue, 27 Jun 2023 14:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add u-blox 0x1312 composition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168787442132.17759.5399865184186405381.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 14:00:21 +0000
References: <20230626125336.3127-1-davide.tronchin.94@gmail.com>
In-Reply-To: <20230626125336.3127-1-davide.tronchin.94@gmail.com>
To: Davide Tronchin <davide.tronchin.94@gmail.com>
Cc: bjorn@mork.no, netdev@vger.kernel.org, pabeni@redhat.com,
 marco.demarco@posteo.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Jun 2023 14:53:36 +0200 you wrote:
> Add RmNet support for LARA-R6 01B.
> 
> The new LARA-R6 product variant identified by the "01B" string can be
> configured (by AT interface) in three different USB modes:
> * Default mode (Vendor ID: 0x1546 Product ID: 0x1311) with 4 serial
> interfaces
> * RmNet mode (Vendor ID: 0x1546 Product ID: 0x1312) with 4 serial
> interfaces and 1 RmNet virtual network interface
> * CDC-ECM mode (Vendor ID: 0x1546 Product ID: 0x1313) with 4 serial
> interface and 1 CDC-ECM virtual network interface
> The first 4 interfaces of all the 3 configurations (default, RmNet, ECM)
> are the same.
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add u-blox 0x1312 composition
    https://git.kernel.org/netdev/net/c/eaaacb085144

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



