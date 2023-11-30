Return-Path: <netdev+bounces-52615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BA7FF7AA
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FA11C20A1A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44BC55788;
	Thu, 30 Nov 2023 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtRZO8Yo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D633C694
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 17:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF85C433C8;
	Thu, 30 Nov 2023 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363723;
	bh=2EOAFj431vuilKjNH0jbQvDsK6KaxA6L8udeQ6gikuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtRZO8YoJ0o97J3I8S6qPZPaSubf6AGuOlTq98Mce2VnLZ7bE4gT6joBZX3oavQZ7
	 u7sNGONXuK6x2M0mz+BNEi7KllXEPp9S2WSLiqhfIXRuje1BU4t4SChlNdsn3Ztewd
	 739DbxXU6YlIV5MXNj7i7ruEwRUaDHL6Xm2ULI2MtgmZAQjR2uAzSIYMJ6kfoqnhS0
	 6jwqVcpP/xj3iDJ5FCrlvRc4te5LsfDlTgXO63346wwmFJ64kamZNCiqjWfx9GdTSX
	 W5wFQj6Q0DduHfMCi9CjHA9uW1Dx2IDj4s7c2LR6WKWVDbWUMTXFD6XdMLbj41c3yW
	 mPwHNnGiMpdVw==
Date: Thu, 30 Nov 2023 09:02:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sven Auhagen
 <sven.auhagen@voleatech.de>, thomas.petazzoni@bootlin.com, netdev
 <netdev@vger.kernel.org>
Subject: Re: mvneta crash in page pool code
Message-ID: <20231130090201.326c479e@kernel.org>
In-Reply-To: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
References: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 17:53:39 +0100 Andrew Lunn wrote:
> Hi Folks
> 
> I just booted net-next/main on a Marvell RDK with an mvneta. It throws
> an Opps and dies.

Sorry about that, you need this:

https://patchwork.kernel.org/project/netdevbpf/patch/20231130092259.3797753-1-edumazet@google.com/

I'll apply it and push it out in a sec, seems like multiple people 
are hitting the problem.

