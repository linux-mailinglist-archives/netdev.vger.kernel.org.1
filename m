Return-Path: <netdev+bounces-76867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20886F397
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 05:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CA6B2245F
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F45CB5;
	Sun,  3 Mar 2024 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV5j7oEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63F7F
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438737; cv=none; b=mwrXfJDjgYJsfX1yjQ47IMO3g9uNbLfzymL/zu5hK88OtlWaYPwd5PSEu2xZB12GYMUu215k7LFBNdwEffXr71Wu4prpUlsGl4emhOI/PpwCLA5xoxwEg3JztQ4EdBR5+xPViqjP94P84N+AAO/kBtcWsVmOcGPkk3UoDrU9ORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438737; c=relaxed/simple;
	bh=u/saMj8GznZwiXUgGDU83DQkfqLGJRKcTVxQ6qbwnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGagd24W1SriYDU3ysos2fjw5YELGqPFxD28XHO2f9N/DOUjtNT9oTVXEEZh2/6P5xITuP1s5ZvxBc2TuD6xbJDy6wRQ/jOHbj4dDzui8zOvFYHZBDKKvNWzpe2kDjiCeAkmCfc94C8QaCEJ0/sWSMVsFCEWepgkgKTknUA+JqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV5j7oEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8D0C433F1;
	Sun,  3 Mar 2024 04:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709438737;
	bh=u/saMj8GznZwiXUgGDU83DQkfqLGJRKcTVxQ6qbwnZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iV5j7oEilJ0T9xfr3n7ZNEMwJj55Qz6L7jysMGm0RbUB1AQ6X4K1qo4pI+mifXz5m
	 JfaW+KOEao2OGt2LOWYJYn6m0CiffjcHPK3vOs02MyM7t9gB8Oet0QVIHiKw6KzUud
	 +1wjX6ayjOUHx/P8s4t1hVd0fcsMq6/6kPyzoO1qm/FLE8/O7Qjyh+Hvb0xiWOSKDQ
	 +/OE72ECKCdM1HoVoXi4rDkzPeC5PDKN4Qw/wMv/tBt1p9WDFnrzvv4u9z1yz5YK3v
	 T1kQRc0apYEICf/MDF1IbnJ3rkWE8l97PQQoOL7PDeKmWbm0jEejHDwPNah2Ofouzi
	 bYevDHFRLD8dg==
Date: Sat, 2 Mar 2024 20:05:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for
 multi level nesting
Message-ID: <20240302200536.511a5078@kernel.org>
In-Reply-To: <20240301171431.65892-4-donald.hunter@gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
	<20240301171431.65892-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Mar 2024 17:14:30 +0000 Donald Hunter wrote:
> The nlctrl family uses 2 levels of array nesting for policy attributes.
> Add a 'nest-depth' property to genetlink-legacy and extend ynl to use
> it.

Hm, I'm 90% sure we don't need this... because nlctrl is basically what
the legacy level was written for, initially. The spec itself wasn't
sent, because the C codegen for it was quite painful. And the Python
CLI was an afterthought.

Could you describe what nesting you're trying to cover here?
Isn't it a type-value?

BTW we'll also need to deal with the C codegen situation somehow.
Try making it work, if it's not a simple matter of fixing up the 
names to match the header - we can grep nlctrl out in the Makefile.

