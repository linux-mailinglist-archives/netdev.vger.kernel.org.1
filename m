Return-Path: <netdev+bounces-111488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9E93158C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390F7B228A0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E418D4B7;
	Mon, 15 Jul 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFpFaPJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF18C334;
	Mon, 15 Jul 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049608; cv=none; b=WNlXJ0KoEBWmiER1NWVw4ZpjdTyZYwHDO/RZ6cyHSJ4xgMsy3wui35Q1DcFCbCMMJLDQMnpXUNHeX7CwR7FlPRUbBzpyEiLRwIQxBrmFoDwHZ35s3BCw39wrDHCWc8M+D0xBseZXZg/S6zkKn5XxeAo2gJJtnZd/i9wHUzJoaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049608; c=relaxed/simple;
	bh=G1jGdZupHLLetdZyfII7nMBo755+GlZVnuWqo/SOdBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSAKr8TyHtJ5SZvHvywRG5kuEAH5HK+X6s8fBt3qotRwyNFYQtKoJZqsQpHeJAyIfJ2mfRX9EwJOYBi8yYA2uoIdWPQgszT7slvSLCLHXz0ALg6SvoSL2LhrW8D9MQjCJdPG39EUOyfVd06FLRpFPGq2VVLEZcKvCjx3JQVLs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFpFaPJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F9FC4AF0C;
	Mon, 15 Jul 2024 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049608;
	bh=G1jGdZupHLLetdZyfII7nMBo755+GlZVnuWqo/SOdBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VFpFaPJ8ibEedxLIQwfs/QqVZWPwqKWgEBlsn8SIQqx8PYF0AlM2h+msaJB5rbs/m
	 riu56HALb6fAKgItYDAcmK8GBPVGxeXc6gPe5f62LCaaJPSsoB3lWDBGOCJluWabvd
	 CrbKfdIpCyRiKKlUUV0/KRC5Ur5oxodC5mMFWoUoA7TKQa9FxI+MUW7qtc2zgoneav
	 L3a7GdeVYxJL30+1dpoY/UApBFi0O/i/5x2I6c98n600CVIUCBi/jY5NGC2UHTOGrV
	 SEpdmnDK+G6hEeoLekeSRbeuMatCO9ilR2eq9iwvxvc1XmYuoabTNwwQxtQvtiJ6TO
	 Zw++4Hj7242zQ==
Date: Mon, 15 Jul 2024 06:20:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v24 00/13] Add Realtek automotive PCIe driver
Message-ID: <20240715062006.7d640a30@kernel.org>
In-Reply-To: <20240715071158.110384-1-justinlai0215@realtek.com>
References: <20240715071158.110384-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 15:11:45 +0800 Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of
> Realtek Automotive Ethernet Switch,applicable to
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

Sorry, net-next is closed already for v6.11:

https://lore.kernel.org/all/20240714204612.738afb58@kernel.org/

