Return-Path: <netdev+bounces-205623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A03AFF6D4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3074F548936
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6E27FB2E;
	Thu, 10 Jul 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5hQpsav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4927FB15;
	Thu, 10 Jul 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114616; cv=none; b=sUOC6p9rsQmdCQV+PD0c3gZPGt69bo5ssKiqmXqbLWYOHxRKhYgsHa5xnIhEo4tOa4jp+qi/MbeE2h6898ubIjg8hSH+RhQLchWwCgo1JOHasxvlSf1ZRD2VD7XhMNGUPEvqwjBOc9dDTF9YZIgb3fHRQr+PhwjZn6nOhRy09uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114616; c=relaxed/simple;
	bh=2fA8pPj3CirGI1XbwELZkyUbdwGc9Cb1v77k1T5uJSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1og2bAPgTKnfCNNQxVvyRX6D66NhCL4qoSGGO2w3UT0GvytdZJhDtWBV2FdBl5xELQVAQZNsgB8sNCg90xaXCjmTD68u8WifQojB+8jkjayHRqBAeZ0DjsNVS6VMC4/FEMka4zgc7q02cXaQg3AjS/PQtzRWQDcuGL8Vgjx/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5hQpsav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B96DC4CEEF;
	Thu, 10 Jul 2025 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114615;
	bh=2fA8pPj3CirGI1XbwELZkyUbdwGc9Cb1v77k1T5uJSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K5hQpsavSiZEUBHW8GK3RSCOh2dJtoqGGFmrL67FERSZfs45a/ZzO0fEgQ/a50sXj
	 f3f8+K8p4UdZLN19F9BpPVhVl6xHmCnInvxJpnVvlyPzWdijEPF0a0KcDhxC+OIL/P
	 t7f+MlQtRrg8qtFnyD9pDlkvgjoK0zLEe1OcvXoybTJioTto1pw7MA12SRxxyXUmgk
	 IY9XUD7O2y0XXWz5Rh8zvo2L9fK/uU+PyHnBt9rPWAq+3XSd/Alb83d8zwMkdR2gCD
	 SiAfvr9HSTqeQcH99QWrEXcELekFMabCN9buadk3H78TOsmNUHOMY0HuDdHtTuKNKc
	 ikF4oiqZzNXRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB018383B261;
	Thu, 10 Jul 2025 02:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v13 00/12] Add Microchip ZL3073x support (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211463746.963219.2173385068913716730.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:30:37 +0000
References: <20250704182202.1641943-1-ivecera@redhat.com>
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Prathosh.Satish@microchip.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, jgg@ziepe.ca, shannon.nelson@amd.com, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mschmidt@redhat.com,
 poros@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Jul 2025 20:21:50 +0200 you wrote:
> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the core functionality and basic DPLL support.
> 
> The next part of the series will bring additional DPLL functionality
> like eSync support, phase offset and frequency offset reporting and
> phase adjustments.
> 
> [...]

Here is the summary with links:
  - [net-next,v13,01/12] dt-bindings: dpll: Add DPLL device and pin
    https://git.kernel.org/netdev/net-next/c/0afcee10dda1
  - [net-next,v13,02/12] dt-bindings: dpll: Add support for Microchip Azurite chip family
    https://git.kernel.org/netdev/net-next/c/9f149c5d6dbe
  - [net-next,v13,03/12] devlink: Add support for u64 parameters
    https://git.kernel.org/netdev/net-next/c/c0ef14469591
  - [net-next,v13,04/12] devlink: Add new "clock_id" generic device param
    https://git.kernel.org/netdev/net-next/c/de9ccf2296ac
  - [net-next,v13,05/12] dpll: Add basic Microchip ZL3073x support
    https://git.kernel.org/netdev/net-next/c/2df8e64e01c1
  - [net-next,v13,06/12] dpll: zl3073x: Fetch invariants during probe
    https://git.kernel.org/netdev/net-next/c/b7d907d1f84a
  - [net-next,v13,07/12] dpll: zl3073x: Read DPLL types and pin properties from system firmware
    https://git.kernel.org/netdev/net-next/c/a99a9f0ebdaa
  - [net-next,v13,08/12] dpll: zl3073x: Register DPLL devices and pins
    https://git.kernel.org/netdev/net-next/c/75a71ecc2412
  - [net-next,v13,09/12] dpll: zl3073x: Implement input pin selection in manual mode
    https://git.kernel.org/netdev/net-next/c/9686c8b01676
  - [net-next,v13,10/12] dpll: zl3073x: Add support to get/set priority on input pins
    https://git.kernel.org/netdev/net-next/c/12ba92f0a6de
  - [net-next,v13,11/12] dpll: zl3073x: Implement input pin state setting in automatic mode
    https://git.kernel.org/netdev/net-next/c/bf33c93c1a16
  - [net-next,v13,12/12] dpll: zl3073x: Add support to get/set frequency on pins
    https://git.kernel.org/netdev/net-next/c/ce26d7ca50a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



