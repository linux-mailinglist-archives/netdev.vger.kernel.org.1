Return-Path: <netdev+bounces-189718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8FAB3563
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E917A1782
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C61267B7F;
	Mon, 12 May 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+lup5eM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168F257421
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047515; cv=none; b=T5Hu1VDjXQ856siH3lgwmZk23DvcjBQhUVd44H418mC+asuzZLO8E7qIC4nqep8GkxcM+7VVsM6mPui3TN9c5vZLk4ezUFma2kmKFErWqC7YR3eB+JBCdXIRwif3kZxu+BKkqS5+M2Nnpz2bpbqhENJJJGGvlxH45DGcDzSdft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047515; c=relaxed/simple;
	bh=m9qinAORR9WmQztOPm8KiAzUOda03mE9im8U1E5KFPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqqnD9lMTOGn/b9oBXNcPO44g19udw+r32PzbEL/yKy9pjDw/1tBR3T+pr1pkNbGhmMQMuymfPXe3OD31afvZm7/jAXe7A8eTYaGNkqEEbyHFVCNeY0tpGe7sUb4x6IhMdpW5qsCxOeQ76e7tzg5T38EbG3mrVJ3e6jq4fEn69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+lup5eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24258C4CEE9;
	Mon, 12 May 2025 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047514;
	bh=m9qinAORR9WmQztOPm8KiAzUOda03mE9im8U1E5KFPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+lup5eMTgoXtcQLXajNUaqYy+UJeQQaCJheN/6n/PIl3/u7HdTEjaHVer7BGGWPk
	 DZLoiCk3xVZyaiBkPuCsUE/ImPvr3t+JicrXcp2gtt7PrY+1IEdiBwPPr/5YSpvKGd
	 bMq197bbr5iQosA4eUyM5CZ7+PKZyVpFlzEO73xmfgqtjQaFMBn85zwENKjuJ1FAHB
	 i08q6/SToSpX8jlzhATOPzxIScus+XD1wy9bE16jS+LE+hOeWET5PU+w30HwtdY0zG
	 ipxw83HE0105s5DLxwN3rEFYStBQZn33F78k215+b/GrD/FAdQl8afrZH80sHt7kdt
	 wWgnqzvj2rjAg==
Date: Mon, 12 May 2025 11:58:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next] net: wangxun: Correct clerical errors in
 comments
Message-ID: <20250512105831.GY3339421@horms.kernel.org>
References: <06CD515316BD5489+20250512020333.43433-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06CD515316BD5489+20250512020333.43433-1-jiawenwu@trustnetic.com>

On Mon, May 12, 2025 at 10:03:33AM +0800, Jiawen Wu wrote:
> There are wrong "#endif" comments in .h files need to be corrected.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks for the clean-up.

Reviewed-by: Simon Horman <horms@kernel.org>

...

