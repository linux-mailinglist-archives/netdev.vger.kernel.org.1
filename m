Return-Path: <netdev+bounces-146048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D49D1D6D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6634FB22A38
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A285947;
	Tue, 19 Nov 2024 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEZ8XHzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF82745C;
	Tue, 19 Nov 2024 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980330; cv=none; b=Oek47LN9GKS559m5SW8Xftc2ea9Li8z2y8tV+haL8BsXAurW8AA8enLLFQFpCB6UnTZwdki6xqanN0NyqECcKEiCMQkEJ+X6G6v2D0PB/5DEs/A34UTNsy4dzF9p9fDX1IXyR3ceNZr0oLhQRA5c/LeRGR6cU01kmWP7cfDqHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980330; c=relaxed/simple;
	bh=GORz5YKwiSBTiFoLEvoIvB+NpY5LmzM+bGWL39W/r/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfetAGPbOO4iLwj2rjNiZPhQk5ZDHyt3be4XMhg5e8HsVCJxgQ7WGge74D0ORs7FJc/aOTYboaxCsXHk7aGTG/t1POOWOkitn6Y6ycnb1lZuZPIOWpxpzgPu5lHaFv04NvZ0Pdye7qLhUhMyZf4LyNBz5Su6hW4ZxNArN9awIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEZ8XHzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C46DC4CECC;
	Tue, 19 Nov 2024 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731980330;
	bh=GORz5YKwiSBTiFoLEvoIvB+NpY5LmzM+bGWL39W/r/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jEZ8XHzVxQ+DD4luZUaanbz7eEYgX4Ip2dz5VD8ml93tfbhcZrPp5hBThNXbuzlfe
	 o/veEtxKfEX9GKop3Jg7QOUBvMVAeAbAo08lpIgo8niUpWdUVuNXK9VxZnltP2eL34
	 2/nxz39j3ooZVRlCXoEF5z15u/g7ObyLwwT5qabaIB60pOz+jaJIpQ5SLP1OEwkJ5N
	 wt1w8qSwXfZI12O66VKxxkSeI71CILUWLs62aPlWcdiGxGQlirXMLa4638n5qX8cgV
	 Q1661KUcOWSMGGb1Bxn+JiM+uue6l7bbR1Al7wr1MTgjXulAy06iGXE1Ty/adwV10F
	 8ZeOt4ch5qAvA==
Date: Mon, 18 Nov 2024 17:38:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v4 0/6] CN20K silicon with mbox support
Message-ID: <20241118173848.41a8060b@kernel.org>
In-Reply-To: <20241118150124.984323-1-saikrishnag@marvell.com>
References: <20241118150124.984323-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 20:31:18 +0530 Sai Krishna wrote:
> CN20K is the next generation silicon in the Octeon series with various
> improvements and new features.

The merge window has started and therefore net-next is closed,
please repost in 2 weeks.
-- 
pw-bot: defer

