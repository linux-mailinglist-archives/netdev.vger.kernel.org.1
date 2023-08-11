Return-Path: <netdev+bounces-26713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7371778A53
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020A6281123
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9063AA;
	Fri, 11 Aug 2023 09:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB143FE1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52550C433C8;
	Fri, 11 Aug 2023 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691747376;
	bh=3Xc9b9hpSyJwEiUKOyQH74evABAG1Ic6UHFzpRwxovU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMKmAUimk6KBhi5Fn3IPqNHbbLbyVegXcKtPOkA/B5xi7eKjXfY4VzTIKdvjvZ3Mg
	 Ul2z9s2muCahBOZUQnDXnxU1fXrwCrNvAc0v1nyt/loclLNZs1SlLxj9asDt530Pan
	 srVUSi31gKMcvFwEzStFvqaSFUFnczXcC0cuvs9ZIm1e81S2tgGzOS3PdD+SlDMSF8
	 oBkRDfASkuYu5Pr/jW7oJXcksb/rqmUTCA2tcVNg2khYuvuZ0OJDQlpiPr3nUCIRdJ
	 dkx8zG67/NWBM8AJPtegc6ujXALIhOdjkKOMsQTZPoPWLzcg89upNJjCrucZfWL3p6
	 JdeNBbWcHwxiQ==
Date: Fri, 11 Aug 2023 11:49:30 +0200
From: Simon Horman <horms@kernel.org>
To: alexis.lothore@bootlin.com
Cc: =?utf-8?Q?Cl=C3=A9ment?= Leger <clement@clement-leger.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Milan Stevanovic <milan.stevanovic@se.com>,
	Jimmy Lalande <jimmy.lalande@se.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 0/3] net: dsa: rzn1-a5psw: add support for
 vlan and .port_bridge_flags
Message-ID: <ZNYEKrQZz/4NY4mW@vergenet.net>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810093651.102509-1-alexis.lothore@bootlin.com>

On Thu, Aug 10, 2023 at 11:36:48AM +0200, alexis.lothore@bootlin.com wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Hello,
> this series enables vlan support in Renesas RZN1 internal ethernet switch,
> and is a follow up to the work initiated by Clement Leger a few months ago,
> who handed me over the topic.
> This new revision aims to iron the last few points raised by Vladimir to
> ensure that the driver is in line with switch drivers expectations, and is
> based on the lengthy discussion in [1] (thanks Vladimir for the valuable
> explanations)
> 
> [1] https://lore.kernel.org/netdev/20230314163651.242259-1-clement.leger@bootlin.com/
> 

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


