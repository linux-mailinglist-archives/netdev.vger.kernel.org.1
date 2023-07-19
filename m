Return-Path: <netdev+bounces-18801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0414758B12
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E41A1C20EB3
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EEE17D0;
	Wed, 19 Jul 2023 01:58:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65617C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC42C433CA;
	Wed, 19 Jul 2023 01:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689731879;
	bh=xV4j/eBSUiPaOF7DNsEID37wgewGDwpgj3ghPv/Zm/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0VPnIN4OQMOP/yQfplfNBA0rJg6b8htqfMDtdUBF09MYsRYcPn04mN6eXxVjuNXO
	 VBHpAi48n/HmTodyw/klN1lxdXcwZDF1IWiPVDbLj0SU4jClz3oSeVpS8ayhPLUljz
	 PoVkRACbH2xPYyaaCKlY8OzIrS8ptIoypne1yrAV/Shh5OfFGisblITgSY3n5lwuqE
	 4zRT0LOzXjzSXMrxV+d9uNX/8MBlTTjo9fPwdrzhPnFPZcE5qbO3DWOEZM7k9+3BDo
	 BT5yBHPHJOfKKwGlOJO0F6nudsW2OBjnGY/TQxPKRQk4XYWufsV9pGvLAoRhNZgUgG
	 U6ctsq6HATZjA==
Date: Tue, 18 Jul 2023 18:57:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] i3c: Add support for bus enumeration &
 notification
Message-ID: <20230718185757.54ae1e2e@kernel.org>
In-Reply-To: <20230717040638.1292536-3-matt@codeconstruct.com.au>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
	<20230717040638.1292536-3-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 12:06:37 +0800 Matt Johnston wrote:
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> This allows other drivers to be notified when new i3c busses are
> attached, referring to a whole i3c bus as opposed to individual
> devices.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

We need one of:
 - sign-off from Alexandre that he's okay with this code going via
   netdev; or
 - stable branch from Alexandre based on an upstream -rc tag which 
   we can pull into net-next; or
 - wait until 6.6 merge window for the change to propagate.
Until then we can't do much on our end, so I'll mark the patches as
deferred from netdev perspective.
-- 
pw-bot: defer

