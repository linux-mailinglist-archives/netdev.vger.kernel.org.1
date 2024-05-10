Return-Path: <netdev+bounces-95284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46308C1D05
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A471F21E54
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAED1494A0;
	Fri, 10 May 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv2zGA0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D213B7AE;
	Fri, 10 May 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311971; cv=none; b=aXj5SxJUIIlaC8PaycZinyWRp8KUa2G0MgLQgHpBHVZMjvupLwUq2O6v5nkfkPIPCpH57fEQnarnEp5o1PsyJEShyRZv6qvQhmF4Bxo85g8i1trdYkQKt1cW5+At1nB4ZQ9Rf+LCEqTjMXcZ4JPGnE3IOi8vzF6/1moGxDhEQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311971; c=relaxed/simple;
	bh=ifTPqdXQ7MTBTtvmPsGBtgmfq34K+ZFAElbosK+LOKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BL1YmAAXkJgCIn7yhhrPYOmjQDQ+jyMr9fMPcwK4scpgZ4tYusAwPyBra2YJijbnOad/2BS8O5NkYLUvaAsK93kjL/s/E3y9tuEd80Hv72f/D1p3PlswzAIzyg6l0gZRzDocjCRjp97gWDq45/nut0ZQECIvnpO6S+Z9R5Oede8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv2zGA0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE1AC116B1;
	Fri, 10 May 2024 03:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715311971;
	bh=ifTPqdXQ7MTBTtvmPsGBtgmfq34K+ZFAElbosK+LOKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pv2zGA0BfVxiT253GqvnsVrWoTD52EVpRuIeiO3plXlVmCsAC/XEeQ1pohUOzX5Z1
	 fyV7T6Ysk3CQ4A57b8onSUalLLRiyJYWxC8DrbTSlWdXUAAeXtlI6cOIAJeB0GQoYu
	 rSlbWyrWvJEpL5Eit+zBZHNdYTi7Jo5YP1U2EB0FLxlsSkFhEm/3tgcF+eq2Q1QEnu
	 D04AojoF1WyTYFhjBhKNXdoBbwOOPToDWcwYqvazp1t5+f5K/I8yyQHjlomDI7ri4e
	 aJfWh7J19Se5kxUDrPxXFnfojd4mSD8jaOUDEvU83gFCHedI/3ZjEEp8ryJELKsHui
	 yUG/AWPc28tPQ==
Date: Thu, 9 May 2024 20:32:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 09/10] octeontx2-pf: Add representors for
 sdp MAC
Message-ID: <20240509203249.09a5630f@kernel.org>
In-Reply-To: <20240507163921.29683-10-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-10-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 22:09:20 +0530 Geetha sowjanya wrote:
> RPM and SDP MACs support
> ingress/egress pkt IO on interfaces with different set of capabilities
> like interface modes.

This doesn't explain much, what's "interface modes"?

