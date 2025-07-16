Return-Path: <netdev+bounces-207336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A216EB06AEC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8C1A64202
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3B219300;
	Wed, 16 Jul 2025 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1T5Y14g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3D12C544;
	Wed, 16 Jul 2025 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627210; cv=none; b=uEcomVyKk2jMrRnB8+KQp7SUH3WJjqvwG44HLYzFoyEoGHhD8BH1S87JJU8u5/6yNBVrj9dlfLWWL1dzkzxBJ7bIxPlYR/rqvspPzp91MnOzljN1l/398A67U3socKIPwyf+sHfGjtkggB0kSCkQKvfzNffkAO9MbvSeoKxP474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627210; c=relaxed/simple;
	bh=6xOuTn8B1PCo4diLCbYgO27Euv615aCvJ7kW+gkRqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7aY7NjxNjfTMCUXPYipf7uF5Idv7CH8XRKwL7sgcMfwADG5SqVZBxe1xM9ErGza5F77OjtIjgF2XZFZLYauAPwevkcxtu15qK1oFwx+HY4dLDPdduywhZ9K/o+EnyYvW1fLFIphpQHYX+ZUh16X1l0pf1vDxbheX2GsGJalM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1T5Y14g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E132C4CEE3;
	Wed, 16 Jul 2025 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752627210;
	bh=6xOuTn8B1PCo4diLCbYgO27Euv615aCvJ7kW+gkRqVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1T5Y14gRxoXIZktODujBUk0Y0YudkPhaQqs0Rfp6RBPWuii0RvuH4r5kzZXKQbwz
	 cJYv8UqsWSppo/xfRQQKmUZfCmr26Kx+i152/7Ka0aa9YVRJQhBDvvJEe/ZI/aSaJY
	 W8r1crMtt1SOHtXJbRL/F8w/NBPHprk/7joApex14oifc32M6vHqWqLe6nQiF9nqzl
	 SXQa8cWwzh9/QKHUkV/7kzcR608+DFPnl5E9NpUnK4MMsTXWtorOMA2UIPSPMKp8vD
	 UohTcmhjVho2uIOfjl0i3SARVT6GZ/SIJ5m0UhjkYSDAFeDROHIE48zsOFS3C8I98R
	 JV53a/jUR+4sw==
Date: Tue, 15 Jul 2025 17:53:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250715175328.43513c21@kernel.org>
In-Reply-To: <b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
	<b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:25:02 +0000 Piotr Kubik wrote:
> From: Piotr Kubik <piotr.kubik@adtran.com>
> 
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
> 
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
> 
> Only 4p configurations are supported at this moment.

Hi Kory, it'd be good to have your review tag on this.

