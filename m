Return-Path: <netdev+bounces-81690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0188AF58
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C682C22EF3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323363DAC17;
	Mon, 25 Mar 2024 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtZn5Tn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827710A39;
	Mon, 25 Mar 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387069; cv=none; b=LG9HYkCXCeNrzHvD2JHSz+Rimru6TgBNZYjffF/kEwJJjynFYHGBlE5wh8+Lopj5IRGwZwR4r0HwqqHpQcumG+sWD1zr2DrOS1THS+sPEhfHioH2i/NOZGQADEA4mZ4dQbmc5gXJgkJa3EEDHYFLFw4fL5RSHDP7r/T0sRkPEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387069; c=relaxed/simple;
	bh=x5oXqKz2NPy6mgP40CYo80+uijWsWITx8rWbvyYijMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7sJicEbDlP5TKbQnbEZUaL+MFRnDM4dXRZVqhhqhvdCQpReQjRSCHdmswJPEuuABBVqaI6HouAUBGgayy0wUUoCaNriXH8TWZBjt+s8D0/Gf3Za2r7TAOJ53AjRghjp5YGagzjbZc3qnAwBfGrPR5KJXgan8BefMV56qNEjfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtZn5Tn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A26C433F1;
	Mon, 25 Mar 2024 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711387068;
	bh=x5oXqKz2NPy6mgP40CYo80+uijWsWITx8rWbvyYijMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtZn5Tn8y90ARnIU+FwgmFCDM4tBD2tMGsxU7wxaunetZoSYEiuRQtz6Q2Z2BD0OC
	 ZWwiLCDT453S9M/MTNYaFab+BCmoLyrXz+bTZKbDdePR0PLAzOTzIqSQD4KnOkbPVh
	 c6SLhRPY9Xd6cJZ/Afrfq9M83ODm+2roM8mn+CMe0UOj/xsjFNxpLh3RjNtsst3WqL
	 OAN5MeEBjbg3kiDE1q5IkooKzzviAWwkh3mpyb0biOT9N6np0myxbtgXOBg5CRdZL1
	 nPIOjv0yy+OzO72a7MhSb8vQzzO8df9eOog0DUmEgu8sWhs//d6W88lQh2+kra4JWS
	 frqHaHZiOBdEQ==
Date: Mon, 25 Mar 2024 17:17:43 +0000
From: Simon Horman <horms@kernel.org>
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
	kuba@kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	corbet@lwn.net, pabeni@redhat.com,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH v2] dns_resolver: correct module name in dns resolver
 documentation
Message-ID: <20240325171743.GD403975@kernel.org>
References: <20240323081140.41558-1-bharathsm@microsoft.com>
 <20240324104338.44083-1-bharathsm@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324104338.44083-1-bharathsm@microsoft.com>

On Sun, Mar 24, 2024 at 04:13:38PM +0530, Bharath SM wrote:
> Fix an incorrect module name and sysfs path in dns resolver
> documentation.
> 
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


