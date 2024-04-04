Return-Path: <netdev+bounces-84662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B2897CD5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6981C212CA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E69184;
	Thu,  4 Apr 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb1g994p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E2163
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189281; cv=none; b=gDguxkjqQyJb8PSsojtwWzJh35/cfHV16IGfYG4bBOhm/3Vl6w4xUaC+y72QpXbjc9cLnew8xhhyuWCFvrQEyHAjnyDiusinA+b11xTNiay/JatV4nIfpFrj9d66XXLu5kSVoT+1ms+y8GItva58Z5iVNTznJ7Fw0WLFUBpHxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189281; c=relaxed/simple;
	bh=zGmkVFGzEf9z5jmw5a9DigS7zLHUmBwYksMkce40kSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGc5UwTyxB8svfdpBGBAwDYbWk/xWgvfIw4wqlx6bwLgqe8yVrUQg1jS0zmWuKlVyPnUbkiYnKvQ0nI/zUVnqaRjuqjrqyCn6PSffNE00nZKPckSkiGpyq0jMMtDThTwyuRnBsFgzlX5mzyPxkh0Ui0chN/PaTMBggD+L7bkPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb1g994p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92615C433F1;
	Thu,  4 Apr 2024 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712189280;
	bh=zGmkVFGzEf9z5jmw5a9DigS7zLHUmBwYksMkce40kSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rb1g994pozVv8sTSvGeAQ0cUCtgaMvABKX1+NdcuZPyw67EHREEyVTE/RT0tJNl9v
	 vvTTdodIIdSbwhWBBDMLY3B7b5ISazUrZfPW5FBM0ldPcT8YgeKHuCEsOymuJMYeGV
	 FOG64rc+b6+of5UOcRSt9IzVeeQq/Y2g4KC4bHBp21i65pSqjsHHif+2lIPIf+coTY
	 Qsqr6wSjBvU0DDVPcRyz6YTPKPyEiMMjw5ExWK+2xBhQchDwLOSomKyb/sXum8OxGJ
	 sUiUtf5+ptVzIJ9uP1IhLCLNT9zEHzTjhc3IqAwHkOUJGAb7JDjyJL85EvZh6ATHXI
	 KtxanJsXwpJ5Q==
Date: Wed, 3 Apr 2024 17:07:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for
 indexed-array
Message-ID: <20240403170759.5310ca97@kernel.org>
In-Reply-To: <ZgzMmqWzRvdk4wzP@Laptop-X1>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
	<20240401035651.1251874-3-liuhangbin@gmail.com>
	<20240401214331.149e0437@kernel.org>
	<Zgy-0vYLeaY-lMnR@Laptop-X1>
	<20240402193551.38a5aead@kernel.org>
	<ZgzMmqWzRvdk4wzP@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 11:27:22 +0800 Hangbin Liu wrote:
> OK, I can separate the binary and u32 dealing. How about like
> 
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index e5ad415905c7..be42e4fc1037 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -640,6 +640,16 @@ class YnlFamily(SpecFamily):
>              if attr_spec["sub-type"] == 'nest':
>                  subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
>                  decoded.append({ item.type: subattrs })
> +            elif attr_spec["sub-type"] == 'binary':
> +                subattrs = item.as_bin()
> +                if attr_spec.display_hint:
> +                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
> +                decoded.append(subattrs)
> +            elif attr_spec["sub-type"] in NlAttr.type_formats:
> +                subattrs = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
> +                if attr_spec.display_hint:
> +                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
> +                decoded.append(subattrs)

Aha, this look right!

