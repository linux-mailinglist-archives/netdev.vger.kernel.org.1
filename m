Return-Path: <netdev+bounces-17322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CC7513D2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CF31C2109B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9A1D2EB;
	Wed, 12 Jul 2023 22:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2775384
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B49C433C9;
	Wed, 12 Jul 2023 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689202647;
	bh=HSHBBypXtaTIjcHaGesJpojtcJMqQc5D1D6QLyryiZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHq4n0tRGV7Su3cnnmyi9Xqcwa9i/vbp+LaZKzFtZf20IKBNf9XVDU1fkIximCIGs
	 81i6bxEFGNcoiz44YyomQx8tLA0hWWSWZJFgRC4WEDJHRL6Ihzu53GCsYcFqi3ERxc
	 5amgPEPYsYkgLB4ePlGr9I+Dywxotml71fT8kemPuueK4/B3TV2+0WrNqN+0Dql+E3
	 6a2NjDxXbuIMrKVW11Fblb9GlCJmuj1W7Bw5AAm6Y2b7FgMBkdqlDz7p+Wy9xTYV+q
	 2hahprfOX1Mjppqh1UxUTYXcd0/tDUYiAaTmaG9KaptMLsFdnfJmOhfwpy67O/Oc9t
	 RhcAB92zTTCcQ==
Date: Wed, 12 Jul 2023 15:57:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net] net: dsa: microchip: correct KSZ8795 static MAC
 table access
Message-ID: <20230712155725.33677f46@kernel.org>
In-Reply-To: <20230711063020.kmipc2wxsfuwpypz@soft-dev3-1>
References: <1689034207-2882-1-git-send-email-Tristram.Ha@microchip.com>
	<20230711063020.kmipc2wxsfuwpypz@soft-dev3-1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 08:30:20 +0200 Horatiu Vultur wrote:
> The 07/10/2023 17:10, Tristram.Ha@microchip.com wrote:
> > From: Tristram Ha <Tristram.Ha@microchip.com>  
> >
> It looks like you forgot again to add all the maintainers to the email
> thread. Was it something wrong with the command
> ./scripts/get_maintainer.pl?

To be clear - you need to repost with the right CCs included.
CCing authors of the original patch (Oleksji, Michael in this case)
is an absolute must.

Please add Horatiu's review tag.

