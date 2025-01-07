Return-Path: <netdev+bounces-155846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF3A040BB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D21886989
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEF1E9B06;
	Tue,  7 Jan 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYbWYYvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B91EBA04;
	Tue,  7 Jan 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256068; cv=none; b=WFGLNSZD2GEX0+c//m2PPgJ14HhuMwo3R8PZJn7tupptkwI4s9G+ruP/PpokEXrAc2SdtVYGNKu75ri3jh8vU+egxlX4vU83gTkKQz8q/BWFmmli70eGQvheCzr34/US5oUnM7ASlsJ1EMZkbq3cd027P6DTi03bnxiKe4HHOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256068; c=relaxed/simple;
	bh=9NTgYqTrn5wL8NaJXAT7TIA0G7ygQMIXiRiad9OKEJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=je4cJ/4UeWxRDFJ7e4DRW0ew9eGP5vuIp2lVV9EzwPbUE6JJCT6gG3EqJw01qVPP7YXhEizjiI3oDLuC6vsHwZ8qExnUQ9WmUl2pjclHf2YCWpnSesF0U4sxmv+ALz+pXpXZFtOCVPyGz1WJSIDqMU4j/rQb06gkM+9N1NdMJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYbWYYvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F324BC4CED6;
	Tue,  7 Jan 2025 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736256068;
	bh=9NTgYqTrn5wL8NaJXAT7TIA0G7ygQMIXiRiad9OKEJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DYbWYYvzpEroP27+bQ/D3FsjsX5+Y/QakfQ9cvd26kQFmdHmXDqFP0G3pTs4zKhA0
	 JyPYh4El071HKAsZgYIGzwI+NWWfbcEzQhjrcRv3kB8VrF0mhJK8pRT+5tMwVbZxQ0
	 dJ095+r4ffi5Kr3d2rXJbJF42Ftrg7bixFgQbUUieML+HzkvIDZqhDRXzgq0UBGOMo
	 0zJi/azt9cmUIGxT9gBkElUnJ6G9NyG2MgOqNcMQz7Dpb0D/giJtEvht/ubCbWltYD
	 vri6npuG2Hd5HK6kK8/FiG2Nsl1GHdJYye3uWzFY6e6jj5y+6eBdXKEqCiEspl1Rkz
	 bT8WDuwR0cxrg==
Message-ID: <d425172a-4f98-44fd-875f-dbbe6497d1ce@kernel.org>
Date: Tue, 7 Jan 2025 15:21:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssg-prueth: Add VLAN support
 in EMAC mode
To: MD Danish Anwar <danishanwar@ti.com>, Jeongjun Park
 <aha310510@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lukasz Majewski <lukma@denx.de>, Meghana Malladi <m-malladi@ti.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250103092033.1533374-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/01/2025 11:20, MD Danish Anwar wrote:
> Add support for vlan filtering in dual EMAC mode.

vlan/VLAN

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


