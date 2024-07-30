Return-Path: <netdev+bounces-114297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE0942113
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E82B242BD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84318C91F;
	Tue, 30 Jul 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b63rnBRW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77E13AD13;
	Tue, 30 Jul 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369074; cv=none; b=aouXYrE4Jl3Lig78WtrLlcNQ/GxI0PsSAhK1dmcrv9XU0yheANGxXCs5WwfcBbMwLu68Ftmf5T9bQ1q1croYbA1GdTq2rP/hShjz2467pxvF2juzv/jzPqp2wc4roSrDYcFdnyLROE5GKJzCagtI9xJ6eCVRIa2ZXSpUis/WqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369074; c=relaxed/simple;
	bh=fAa3YqztrXvUe4q2HK4TpXZwBl0ND7KIRKvnTFi0STE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEcGM1BzEJrpSaOkYnJpJQvTvpNY83jbEbdjXDi22UJ83jwVlre3b4mS1TBvrwkijeMrUj+i+4/VjWSKqhTfhHYugTMQU54fmqfwAPhKtPDKFXYpxpi8wjz74TzGUumBs2dXckxg643CIb2q0FUJqAq7sw7hu4XbGyjwlVsQQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b63rnBRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E60C32782;
	Tue, 30 Jul 2024 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722369073;
	bh=fAa3YqztrXvUe4q2HK4TpXZwBl0ND7KIRKvnTFi0STE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b63rnBRW/5AdgoMSrV3IA2ucuV/cEEWON1SXrgPwvsi3z7ROmihKK6Gp53tZj7mjK
	 2ZTCloU1xkg1LBUuH16GN3HLHQ9Ace8U+7JZ3xVLCsRM0pWEaYOeSxWV0qKPztBfPm
	 yLKqz3CEzNPc+Xc/olClbh/4edSkNiwq4O9eF5SV4Rnns8dDbIw4XUr0s3jr2K6+3I
	 /70t29QyLnjPRlcEGQNM2i6+VwQBgLxhKAOSiYXJzjurCX8inPJMSdedfvRa5idHEc
	 0wZjtpgKzOvSltr0uvlPfRVnS/JtUVZlxV7TuxrEgQ3xGJE0ISuERV/1sAtIzvF3Je
	 Oizhit8T4fQTQ==
Date: Tue, 30 Jul 2024 13:51:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] dt-bindings: net: dsa: vsc73xx: add
 {rx,tx}-internal-delay-ps
Message-ID: <172236907155.2041115.15896777059497841424.robh@kernel.org>
References: <20240729210200.279798-1-paweldembicki@gmail.com>
 <20240729210200.279798-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210200.279798-2-paweldembicki@gmail.com>


On Mon, 29 Jul 2024 23:02:01 +0200, Pawel Dembicki wrote:
> Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
> in the CPU port. Additionally, valid values for VSC73XX were defined,
> and a common definition for the RX and TX valid range was created.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ---
> v3:
>   - use 'default:' instead text in description
> v2:
>   - added info about default value when the rx/tx delay property
>     is missing
> ---
>  .../bindings/net/dsa/vitesse,vsc73xx.yaml     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


