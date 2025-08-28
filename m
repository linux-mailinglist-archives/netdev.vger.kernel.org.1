Return-Path: <netdev+bounces-217800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3379B39DBB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8051D7AB6EE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFEE30FF3B;
	Thu, 28 Aug 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zit8OrOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BC30FF21;
	Thu, 28 Aug 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385410; cv=none; b=uBhvUaxW8KEBB8zlWAyyxeVpOBtvDe2FnNQsPnyIYdc1Iu+2GylqhzKFbYzDsBf+xJWVzPrcvDKqyCjpnXDWNsq5DlyThCSgxcaEkRcjkEMBHZRtcwYFAilW7c3sAzZTDBkznWhcwerbT/akj7pjKDCSmOZinq70QfhS4tKXw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385410; c=relaxed/simple;
	bh=QTINwd/QqBhIYgXde29F2+UpQIPQdTSbWl0u2Gaukk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVkjPya5AQn5lrq3p2DS9++5nphRINuNtDhKpwBAKAdRYq9PyVnv2Kf7FQwSypjQWIIlaY79Xjb19UuuR9du7PnmtngsHk23OLfznhQjUV+3isHRrKWhGNGFzJLcWow1dKw84GywOjExEooyQ2EfR4/VoDGAphMWKaKFLGkdG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zit8OrOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635C0C4CEF5;
	Thu, 28 Aug 2025 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756385410;
	bh=QTINwd/QqBhIYgXde29F2+UpQIPQdTSbWl0u2Gaukk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zit8OrOlyNemXZhMSNKy55GcCT+AozWTMS+UsssYOWUBfRPUX3v8GhLEcusyr2xE8
	 xRzL9uv+jhnWvKQIqRihg6hdn8UI0xhTBvv7HCbGSu3oT1b54uKe3whzFn64yfM13C
	 m7Oujs9H29FwFSET9S2Wvt+xELAaVfYZ4XRC2t8Ro36RxoH5OgSLJx+WKqh5p1gN3P
	 sJMg78ixXMvkBlWnEUFRKR9j6RGiaNcfOEREQHTyyzyMv5O2gX4cE/YNZpzgSO/I6V
	 sD6mUcjNsPrftv1AsmOLumP3EWcew4ASnE9ddcPkbazJlVbXpQUoSJ7TUj8SsSO4qi
	 fYBDla9O5rfdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAF383BF63;
	Thu, 28 Aug 2025 12:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] Add Si3474 PSE controller driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175638541749.1442882.15142073077092795834.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 12:50:17 +0000
References: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
In-Reply-To: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Aug 2025 14:40:57 +0000 you wrote:
> From: Piotr Kubik <piotr.kubik@adtran.com>
> 
> These patch series provide support for Skyworks Si3474 I2C Power
> Sourcing Equipment controller.
> 
> Based on the TPS23881 driver code.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: net: pse-pd: Add bindings for Si3474 PSE controller
    https://git.kernel.org/netdev/net-next/c/7cb4d28e1195
  - [net-next,v7,2/2] net: pse-pd: Add Si3474 PSE controller driver
    https://git.kernel.org/netdev/net-next/c/a2317231df4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



