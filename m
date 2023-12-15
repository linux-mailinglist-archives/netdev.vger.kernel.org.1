Return-Path: <netdev+bounces-57904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49756814774
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA801C225EF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA925112;
	Fri, 15 Dec 2023 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFbb4kWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F622D607
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5E4C433C8;
	Fri, 15 Dec 2023 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641464;
	bh=AVfs5nMY6oNJ3TJTk3LR1t4Qr8LlVfRdwEmPahoohQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFbb4kWJheJk1wlDHNFVjaMDFb59FIXcdEnkd5kjf3csOzK5AJVjbFloiAS4fgJj3
	 a+eSEvYmVlfHVXs4PLQXhLvBY/M8ZUptlTGhTY3+1MwvSbRQ0MXjeT9yoNqANrwd4l
	 vXZH9oTOnmYVPBrHeOxPU/PSBHR+Axiqy6KUgu9QUYpHUxrqrSkX6EsseuMrXz2nXu
	 XtjWUKgK1yo94lxOWzGCPSA2ersBAkKMJegan5ggVFbNO1BYqKIBPAAeYQoSHDoKBy
	 mkBoeRhmBw6hX2QpqWilv9rF49lYHKvzSxkjRzbOlbLsPJRrLe5K/SzqatKYy4vomW
	 V8erk29KmJrhw==
Date: Fri, 15 Dec 2023 11:57:40 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/8] dpaa2-switch: set interface MAC address
 only on endpoint change
Message-ID: <20231215115740.GD6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-2-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-2-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:04PM +0200, Ioana Ciornei wrote:
> There is no point in updating the MAC address of a switch interface each
> time the link state changes, this only needs to happen in case the
> endpoint changes (the switch interface is [dis]connected from/to a MAC).
> 
> Just move the call to dpaa2_switch_port_set_mac_addr() under
> DPSW_IRQ_EVENT_ENDPOINT_CHANGED.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


