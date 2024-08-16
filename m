Return-Path: <netdev+bounces-119123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCE95426D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B912281EC2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518385270;
	Fri, 16 Aug 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TExMALuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110F7F460;
	Fri, 16 Aug 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792352; cv=none; b=JTT3d6ocedPAGhgTIDbkdgndUu/HzxSdz94FbJuJFgDfVUvuBOqYBABvzupR3/rO6On0msuUEX8oP3atNYXyWN6KOu7gGLQCDRdHL0/LPr976I9g5EL5mZSQRPYoRySXBJ4qWaHhq2a5O1F2Ooc6LVlwVWNjpqdnbNRsp0Sa2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792352; c=relaxed/simple;
	bh=0ulnKDYaVi07kwYpVeVtuyN055Jl2HkRB9mAgzF2VIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeWuVPUSZM04S3dc3cgZJwI9upvcsZmZFyQwQMLoWh8dJN5JCGC7lLcH16lKn2x4hX3PvaZP437llxmO/bueWRXzF1ogWKoXey1m2ybb4odqN3lqsEP/LV75xSBdLdGBdlVwWz7jCdcp30auBN4QOWibr59AT21QGmzDB36YQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TExMALuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA5C32782;
	Fri, 16 Aug 2024 07:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723792350;
	bh=0ulnKDYaVi07kwYpVeVtuyN055Jl2HkRB9mAgzF2VIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TExMALuyhTGZ9x5Oe6tpH06BElCI18k3d+kkWaW9JF+xkxYjsPvNjHN0nr97dUGRM
	 NIQNUMEMaVb/5wtn6F9734YKsO//p0wg5yrVQRtPVB4h1RQf32WJQgVY86Dwq/iOSW
	 Yflwf3pHonpcD8fuscFhCzdb97KaegEsTthoVptUQnmyABKoLiGQV7wPACVN1Ut9ma
	 0k+mMh89sGkuOxZtaPcjER3ju/EeRu8L9vgniDNsr92JLeDvUR+ZOmRsbIObE8KdeT
	 QI2eTx/MYAsv+fmXHMsEeuTj3LYbRBdYIi/I8isc26vBHmpwHmZTjLqEoI6g8xYV1U
	 w/WYx/c9Ofdbw==
Message-ID: <e3dff6ce-7fb2-47fa-9141-9281e5e9de5e@kernel.org>
Date: Fri, 16 Aug 2024 09:12:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: dsa: microchip: add KSZ8 change_tag_protocol support
To: vtpieter@gmail.com, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816065924.1094942-1-vtpieter@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240816065924.1094942-1-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 08:59, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add support for changing the KSZ8 switches tag protocol. In fact
> these devices can only enable or disable the tail tag, so there's
> really only three supported protocols:
> - DSA_TAG_PROTO_KSZ8795 for KSZ87xx
> - DSA_TAG_PROTO_KSZ9893 for KSZ88x3
> - DSA_TAG_PROTO_NONE
> 
> When disabled, this can be used as a workaround for the 'Common
> pitfalls using DSA setups' [1] to use the conduit network interface as
> a regular one, admittedly forgoing most DSA functionality and using
> the device as an unmanaged switch whilst allowing control
> operations (ethtool, PHY management, WoL). Implementing the new
> software-defined DSA tagging protocol tag_8021q [2] for these devices
> seems overkill for this use case at the time being.
> 
> Link: Documentation/networking/dsa/dsa.rst [1]
> Link: https://lpc.events/event/11/contributions/949/attachments/823/1555/paper.pdf [2]
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>  .../devicetree/bindings/net/dsa/dsa-port.yaml |  1 +
>  drivers/net/dsa/microchip/ksz8.h              |  2 ++
>  drivers/net/dsa/microchip/ksz8795.c           | 28 +++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.c        | 19 +++++++++++--
>  drivers/net/dsa/microchip/ksz_common.h        |  2 ++
>  5 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> index 480120469953..ded8019b6ba6 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> @@ -53,6 +53,7 @@ properties:
>      enum:
>        - dsa
>        - edsa
> +      - none
>        - ocelot
>        - ocelot-8021q
>        - rtl8_4

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Anyway, what does "none" mean in terms of protocol? Is there a "none"
protocol? Or you mean, disable tagging entirely?

Best regards,
Krzysztof


