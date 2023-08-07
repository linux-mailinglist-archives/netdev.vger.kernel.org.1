Return-Path: <netdev+bounces-25014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C8772900
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A1D1C203DE
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE810975;
	Mon,  7 Aug 2023 15:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325810957
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455CEC433C8;
	Mon,  7 Aug 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691421711;
	bh=eKeOwnUilQvBQlfyJP6vAB2J5JPookLqOqnK6bxP1ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnWM64mAcr3BbMWMRRT+DrK7ilmVcRbK8xjvF66wlMS54tv5rEuG7/lQrIieChzR3
	 JqJAFTLcEBTcNZ2ulxtBMyr+qX8opnPheb46zFH5YtLoPkSPUQV0auZiNaNEcUKYv7
	 v4uM3izi3sbc6xwcDLodd8ecfYkZm1dGAwyHJu0QkpVzlWKStbdH8WSENckquJ8dbg
	 8k/6pk7JkLRlU4kG+jcCNrIQW5EewFhtRgjPr/mC+UgU/oM3CfQwOls8693bbd7W2W
	 uOAs5kdW+SvcTjVyPyfyJXbEU3GCvlaXCUUWZ5fuFRLyCyCmkxGWEuOYL5al1CMwEX
	 iltcix4f6mJ/Q==
Date: Mon, 7 Aug 2023 17:21:46 +0200
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
Message-ID: <ZNEMCub3K+WSuEQu@vergenet.net>
References: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>

On Sat, Aug 05, 2023 at 03:45:36PM +0100, Daniel Golle wrote:
> Different MT7530 variants require different PHY drivers.
> Use 'imply' instead of 'select' to relax the dependency on the PHY
> driver, and choose the appropriate driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>


