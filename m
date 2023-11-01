Return-Path: <netdev+bounces-45545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907657DE112
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28530B20D93
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FEC11C9B;
	Wed,  1 Nov 2023 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yg8omY7O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845221FC4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:42:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964DB7;
	Wed,  1 Nov 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/rSzh2CBUdRpxCG4aPjW7h8lo8I4+wNi85x2FnwfJu0=; b=Yg8omY7OdOxly0zWXtqXNofPfu
	gSvV6lsiWyVKDGi23r6OPqadcW1KKOWDZGJH56gepezgQMGkPJqR8IYqhnyw/sfRXye5DuFkxKv2/
	hWHS6Eri/xBYRff3IdgQ9M8AguvvdPjaQspwk0+283Hw5IT/SlqeN9rZBKLVfRSn/uL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyAYC-000gX1-ME; Wed, 01 Nov 2023 13:42:24 +0100
Date: Wed, 1 Nov 2023 13:42:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [net PATCH] octeontx2: Fix klockwork and coverity issues
Message-ID: <335216cc-3412-4898-8b88-10405ff7c316@lunn.ch>
References: <20231101074919.2614608-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101074919.2614608-1-sumang@marvell.com>

On Wed, Nov 01, 2023 at 01:19:19PM +0530, Suman Ghosh wrote:
> Fix all klockwork and coverity issues reported on AF and PF/VF driver.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

The subject line is:
[net PATCH] octeontx2: Fix klockwork and coverity issues

So you want these fixes backported to net? If so, you need to provide
Fixes: tags.

This patch is way too big. A fix patch generally fixes one thing, and
it documents what it fixes. Or it could be one class of problems, like
uninitialised variables etc. Its good to include the message from the
static analyser in the commit message.

    Andrew

---
pw-bot: cr

