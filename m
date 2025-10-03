Return-Path: <netdev+bounces-227814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEBFBB7D80
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3825A4EECB0
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADC2DE709;
	Fri,  3 Oct 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHiwnXTI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E582DE6F8
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514737; cv=none; b=YXcXKU7VfOeX3k/Vz/chbFDcwMMub57zlWu0gzp3uxfT0JhWWz7Jg/iKFosnvRfDoy8ujpO5VO6L7aIU3V8XNxafHQYKVl3WZKzkBkmQergZWNDf/RV0Uq2fM7tUfTre5R7LlXS6GvLN776dNe/fovJojj+VH9MAI2znndniPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514737; c=relaxed/simple;
	bh=6L7RZAh2Bya8EY2kgBTE/qiJkE645lMzjMuULXh5YP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fzklyj+ob6yrHw8fFzF4LmfhISSKJxtgn95DUOfuIEpwdLg9xfIgEC5ZeuAlTcwTDCgTOClXJQ/TdHFvUukxalvTX3mXZiu9lWEQeyH5/GEB3/RxFGgB/84YYXfKGeihnzIEN0xg3pjAILhH1EeykoRZhJbOVUnM0TQYLltczaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHiwnXTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B6C4CEF5;
	Fri,  3 Oct 2025 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514736;
	bh=6L7RZAh2Bya8EY2kgBTE/qiJkE645lMzjMuULXh5YP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHiwnXTISIDNEFZ1l0FKAt8xMoL1yRj+BUYpdgcEowOsw7wKYhaxMWLYwoviVbeCe
	 W0yfio31oDZV4CHbdmMkqKwyE/apzCjtOheu8X+GnQ6I73b8K7hWqexJCP5JBOzm/H
	 7TXt8/wkGIb1wxiWDHT468PRpVFu3695oULfeP189WGD7NjeDAOpRvDEOpAjMqklYX
	 oEsS32juDu6G9TLEpCK8uY7jA2oV44QFcrePid8Ylm5xQBGO1uKVp8bACeyriqhmHO
	 8L1dw+VvYhcbjMP7XsiGkaERWgxkh0AAbmPhIxeikbOrpyS1CPYIXiV6vMUc4ElD5W
	 hR4nXPbtXoBiw==
Date: Fri, 3 Oct 2025 11:05:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] doc/netlink: Expand nftables specification
Message-ID: <20251003110535.350f2597@kernel.org>
In-Reply-To: <JUuZco3v6YeIraurnU7qR-yqiNiPq8B5F6MJDG_2_tIrtMvkLEFhhPnns2BV7YCvAYkBLlhkadllZyRgQ7LmNWyWihwYr1dU9526sV63Ew4=@protonmail.com>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com>
	<20251002151133.6a8db5ea@kernel.org>
	<JUuZco3v6YeIraurnU7qR-yqiNiPq8B5F6MJDG_2_tIrtMvkLEFhhPnns2BV7YCvAYkBLlhkadllZyRgQ7LmNWyWihwYr1dU9526sV63Ew4=@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Oct 2025 17:51:54 +0000 Remy D. Farley wrote:
> Also, it caught another issue. Python yaml doesn't distinguish an empty
> attrset/list and a null-value:
> 
> ```yaml
>   dump: # attrset
>     reply: # null (but attrset expected in code)
>       # no attribute here => dump["reply"] is None
> ```
> 
> I think it's useful to have a machine readable mark to signal that the
> operation supports dump flag, even though there're no attributes outlined yet.
> I fixed it by simply checking for null in ynl_gen_rst.py .

Hm, hm, hm. So for "do" we use empty replies to mean that the reply
_will actually arrive_ but it will have no attributes. Whether an
operation returns a reply or not cannot be changed once operation
was added without breaking uAPI. So the empty reply is a way for us
to "reserve" the reply because we think we may need it in the future.

Or at least that's what my faulty memory of the situation is.

What an empty dump reply is I do not know. How we could have a dump
enumerating objects without producing replies!? :$

