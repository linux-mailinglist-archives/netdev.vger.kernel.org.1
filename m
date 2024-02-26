Return-Path: <netdev+bounces-75041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54C867E50
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9996B27BBC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFB12EBED;
	Mon, 26 Feb 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9g/wYnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F060DC5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967749; cv=none; b=fCVXpce48Tzn32khPkIAa0rrhxD+xu746WUAH2TQuoZWv9cDrnRhdYC3a1eWHAPgZqapggErOdwtcZ9VSB9FV6Ce9jU91bh8t4cG3WwF4SNXU11dm0VCUvD4ttEp6sBhxwFSLC0J90U94LBJp2USmjbYPVj9Vj12/HNfTgMLRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967749; c=relaxed/simple;
	bh=RmVB/Zlb5l33c9Qk6cVqya9DXZ9ZWVNDDj+FxnzoIHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRm5ySfc+d0BTlQB5yebQDRclPVKsQhv127LJvsUYTXuGvoJrblr6JZyqaejenfYYCLY5OWF2ZNRKJR32Gn8y0Xz811vLUbg8OvOwxbAHYQEhrxlhbV6jO7807EwAaxDQ3B2htfsaH/4rmaMzka1q+Ibo3ar0GeL7AC8dJYP5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9g/wYnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6214C433C7;
	Mon, 26 Feb 2024 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708967749;
	bh=RmVB/Zlb5l33c9Qk6cVqya9DXZ9ZWVNDDj+FxnzoIHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t9g/wYnuUYtWISlNxMPzVFhWMVqIfJgjLeiBTuDM8F/L02CLkyTMw7IolJEKTG1qd
	 paA1KRQRiG1d0Rc4sTiq3n3cpbUCr0wGhalysJwqcwq26IDKvzU12ero9FDNZd7PQd
	 2XgRIBgO9OR1wGqMXTPOMd+qSoVZS9RN358rBqfpXNmCnbg5mWNbI9QwKBcqWRsM/L
	 VoMm4BsfnVfe0/M6aKsrDL4ZflFzN3w0JqgHe+xM2MWyynx4Dq/wewntv/Vn/EKvV5
	 MgT/dCLjGm/OmEpSqEWvLUhh+O1YIuUpymAAOjdaFCS7m8ghXEcp0xo9yCfB8QaijE
	 KaJqucDwZ45zg==
Message-ID: <a31243e0-d6bf-4a3f-892b-c55d1fd84e65@kernel.org>
Date: Mon, 26 Feb 2024 19:15:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/10] net: ti: icssg-prueth: Add
 SR1.0-specific description bits
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-6-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-6-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/02/2024 17:24, Diogo Ivo wrote:
> Add a field to distinguish between SR1.0 and SR2.0 in the driver
> as well as the necessary structures to program SR1.0.
> 
> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

