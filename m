Return-Path: <netdev+bounces-48970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9ED7F03B3
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC584B2096D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C661EB5D;
	Sat, 18 Nov 2023 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBUdeo1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638120315;
	Sat, 18 Nov 2023 23:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6081CC433C8;
	Sat, 18 Nov 2023 23:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700351979;
	bh=A5eYIpo9nw6P9JOIqKyEJq1aT2EBOd0qD0hr9BR4N8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oBUdeo1klbXcTrHTYDEVainAaFMfwsd/6QKTALINg5d7lfMpvydF/V3VfK+nIC/95
	 UiNMKmAY1IoTeL0g0I3IFBpvWBlrWFbCAyoB/0+3SEby7LoVnYQgL26moEI5oUrDzG
	 2PTr9uIePPbTgSwJr4OZEN1bmURc6IBEpOYmfVLI9Y8U/cMYDjApQ7NngEtmkCMCrl
	 L1J8ZU6a3Pihn6Fkj12mx/VsZW1a4YUM5v/OKJVUKn8KOGpSkDgfR5nu3Ngi2PkvFM
	 k9umNY4Q9dL4zJ9vCiehrqCxTIJsI102jxGJxpoy9NzfBUkQXmhSWbNfdcpYUn/ejQ
	 HGpzOsgXeRBDw==
Date: Sat, 18 Nov 2023 15:59:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] net: Add support for Power over Ethernet
 (PoE)
Message-ID: <20231118155937.4c297ddb@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 15:01:32 +0100 Kory Maincent wrote:
> This patch series aims at adding support for PoE (Power over Ethernet),
> based on the already existing support for PoDL (Power over Data Line)
> implementation. In addition, it adds support for one specific PoE
> controller, the Microchip PD692x0.
> 
> In detail:
> - Patch 1 to 6 prepare net to support PoE devices.
> - Patch 7 adds a new error code to firmware upload API.
> - Patch 8 and 9 add PD692x0 PoE PSE controller driver and its binding.

You haven't CCed Oleksij or am I blind?

