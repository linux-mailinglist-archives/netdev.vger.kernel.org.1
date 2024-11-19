Return-Path: <netdev+bounces-146330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DF9D2DD2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796E528382C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922761D1F44;
	Tue, 19 Nov 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klRdFrLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609081D097F;
	Tue, 19 Nov 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040578; cv=none; b=m1g8FU/ieTmx/kFCPRx9/U2aqH12zwF5zw6XLjjxdbeagDQ+FdFNuDZshgcx5aH5aWhe3Yhw+G3mxpTTbjjHeiKeAV8VRrR1G6IU3IkiD8A5VuU6M4vxnOGaC5DA56P8yJhjNKGTZpUkk1fCbq4m/4jw78d83O3s2CXZWHHx0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040578; c=relaxed/simple;
	bh=H+g7KtGZVKeFClzWJ6E9sLHyjgEpc8Kl/xs6k2Oomfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHyXM3GHgA4kLy4CMycsQncfb6FJQQ4/qPx8xjdxiyVTcOYUw8AleQ92bjb4syS8WJQRHzty605qkEpo65riXZZI4dFlhrv9gl+cIv8dU8Fg1UZ3/2LUlLNOsDJkx9p9vp3P/q6WsR/pMWXGpe1iATTpTgVWKdwZSuZUBIyI6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klRdFrLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3913C4CECF;
	Tue, 19 Nov 2024 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040577;
	bh=H+g7KtGZVKeFClzWJ6E9sLHyjgEpc8Kl/xs6k2Oomfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klRdFrLUo7vC2s64ErxhsqLMBiAAqDKLzqloFX+Z82AgvFl8Uzxha69clYR4sSuZ1
	 t/LzpL3zrD/m/aYdQTCNiez/T64V2rlZBgpxpYudrtDDgm2Eb409gWOaSeF7FJKr48
	 zqw6wTSko2rKTg/D9H/3aeKPT7xAuWDbXMifiwXY3i+xyIrrtrd8BDtPL0xfDPvXqA
	 RcerYNuVRXMRo88IjKv4sCFdiFDCL6ZLmgkZxK/Qb1ZJCqssKSYapKSv3inaBhjTpR
	 UFsyDpQfyRFni+XE7/X8/0ovla3H+pwjyXwvcwxYRIiZnPIUEpn72ICbBOu9qWzdjS
	 +EZTZtx6FvY2w==
Date: Tue, 19 Nov 2024 12:22:55 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 8/8] dt-bindings: net: sparx5: document RGMII
 delays
Message-ID: <20241119182255.GA1967508-robh@kernel.org>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
 <20241118-sparx5-lan969x-switch-driver-4-v3-8-3cefee5e7e3a@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-sparx5-lan969x-switch-driver-4-v3-8-3cefee5e7e3a@microchip.com>

On Mon, Nov 18, 2024 at 02:00:54PM +0100, Daniel Machon wrote:
> The lan969x switch device supports two RGMII port interfaces that can be
> configured for MAC level rx and tx delays.
> 
> Document two new properties {rx,tx}-internal-delay-ps. Make them
> required properties, if the phy-mode is one of: rgmii, rgmii_id,
> rgmii-rxid or rgmii-txid. Also specify accepted values.

Doesn't look like they are required to me.

> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> index dedfad526666..2e9ef0f7bb4b 100644
> --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> @@ -129,6 +129,24 @@ properties:
>              minimum: 0
>              maximum: 383
>  
> +          rx-internal-delay-ps:
> +            description: |

Don't need '|' if there is not formatting to preserve.

> +              RGMII Receive Clock Delay defined in pico seconds, used to select
> +              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
> +              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
> +              any delay. The Default is no delay.
> +            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> +            default: 0
> +
> +          tx-internal-delay-ps:
> +            description: |
> +              RGMII Transmit Clock Delay defined in pico seconds, used to select
> +              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
> +              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
> +              any delay. The Default is no delay.
> +            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> +            default: 0
> +
>          required:
>            - reg
>            - phys
> 
> -- 
> 2.34.1
> 

