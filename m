Return-Path: <netdev+bounces-46036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F407E0FD3
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A100B2111D
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8EF1A58B;
	Sat,  4 Nov 2023 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7kNPVoM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B211C9C
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784BBC433C7;
	Sat,  4 Nov 2023 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699107054;
	bh=QcrpWMqDIyHMzeyBl7hc5a/1oRjJDGQtzMIi4g/TNE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7kNPVoMpHSsV2EIUVa/D6X6kO71kPVD20JIvUPtwnhcyjmCFUDR6cMwA9aUG3JhD
	 2P5vMzwHudkFqBLeLEHe5MEyEJrvtxhTkGXpydnfB/2duGsVVETisorc7uAM99STci
	 dQh3J5+uBZ5X9g7HJYmTw/j+A0Xe1I3cdivR6ulpJdHxu2RVWfEketvtg9A+88MVyz
	 5XSvvmlq4g/9ZJk6ykaA0vAEXlt358HldwwoauvZQu59F2bNbsxskQk7cZFd7W5ZiH
	 NgfINZxF9k6gjQrVXMO+Wo6zsEmkPd70o6m3jPqfBTRMx3DfegTrPMm4us8eEFa1zZ
	 D4pynNKAlWf1w==
Date: Sat, 4 Nov 2023 10:10:31 -0400
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231104141031.GF891380@kernel.org>
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>

On Wed, Nov 01, 2023 at 09:18:47PM +0100, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 11:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > It was reported that the "LuCI" web UI was not working properly
> > with a device using the RTL8366RB switch. Disabling the egress
> > port tagging code made the switch work again, but this is not
> > a good solution as we want to be able to direct traffic to a
> > certain port.
> 
> Luiz is not seeing this on his ethernet controller so:
> 
> pw-bot: cr
> 
> (I've seen Vladmir do this, I don't know what it means, but seems
> to be how to hold back patches.)

Hi Linus,

In this case it may not have activated the automation, but
I do see that the patch is now marked as "Changes Requested"
in patchwork, so all is well.

  https://patchwork.kernel.org/project/netdevbpf/list/?series=798030&state=%2A

FWIIW, pw-bot is (slightly) documented here:

  https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-status



