Return-Path: <netdev+bounces-74244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A9860961
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDE2B20CB5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B8CA73;
	Fri, 23 Feb 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/z0IQGU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863EC2C6
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658874; cv=none; b=iT/+qRbcHNpA95U5aaSckv/EtNsi/ROUAZfn//8gx3UDzOoSoLu2dwFXpYlBHcAAP1sxtin1JwIW9yj0MekQnGBq7F3ALP8SOZfzjPJU21ETQUIl5BxkB7gcWovc8cZ/R84iYEm6d2fu+9AYsilzQ0FDEvtk//esu0cSl8D1taQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658874; c=relaxed/simple;
	bh=1fDIClmWv1rWRhAiMz2t1EocNFTJxhHQxa/bUGOIXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/qcJus0tpMx5VU4qilKeFXWcA6QA2Q5VLgionFyD6pmz9/PbXATxgNjOJTn3ijJQeJQGIsEwHjW8JSb5yI1QGdXs0OjEO9xqr4LwDt8LmPD4b5liuo1oJGSIFWFrfN0f41ZQIDvHQukf8dX+CLC5SjUcjx3F8sxrtsOVVrMMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/z0IQGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C55CC433C7;
	Fri, 23 Feb 2024 03:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708658873;
	bh=1fDIClmWv1rWRhAiMz2t1EocNFTJxhHQxa/bUGOIXDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/z0IQGUM+PfYdtb0b8dv2BpZSeL4mhH+4Tth1T0rGLiFDJIHZLPqqxDediGYpehX
	 u1TO1iYhPHudxRbDqesHHECHEhms2HV1KzBvha/1RWvyGS2xPK3lGavMJnYTlrynj9
	 h08X7PAP+9BuGoopFC4PjwN4LjtHE4aa5v1E3WVt0VHWuaZ4kHV0idO0mJT/Rd5kSL
	 VRQQ/X1dspeTaTDUFS0UEpnJs1ZLoSEI+yKFuAKkoIXXfRY12GZ7xHT0MeJh933+bN
	 3IqVJsp9rdSqaeoFgW0npjSCTNAnwa/MSxHaVMUFJ5dVZ8AMa+I8GQB18O94CzfT8U
	 QNwR952hQI9Hg==
Date: Thu, 22 Feb 2024 19:27:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jones Syue =?UTF-8?B?6Jab5oe35a6X?= <jonessyue@qnap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with  __agg_has_partner
Message-ID: <20240222192752.32bb4bf3@kernel.org>
In-Reply-To: <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
References: <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 09:04:36 +0000 Jones Syue =E8=96=9B=E6=87=B7=E5=AE=97 w=
rote:
> To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>

You need to CC the maintainers. Please use ./script/get_maintainer.pl
to identify the right recipients and resend the patch.
--=20
pw-bot: cr

