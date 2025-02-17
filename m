Return-Path: <netdev+bounces-167115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA5A38F77
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E6316F2EE
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F681A5B98;
	Mon, 17 Feb 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwiR9ptM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488F14F9E2
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739833469; cv=none; b=Z5GhmYRik5SRpE/ng0wMDJ90AiSP492kWh8l7fmKC31myp/VjH3mhZDUpqcx/Z+f83SxMqZ0aj0x1tcwQXEK7h/lnmrbyfcEYyR3Azl+mF72hDo/rse6OM4j4bmDY+1KmPzFoV6IQND9JWxnX/onMhwYswWLCvo1aAvVUxEIlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739833469; c=relaxed/simple;
	bh=xe6tDhiUjSdboNEzq48XtMZ0sysF/UboNoNlyjGqnx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcKHBOMv2+3SuRqw1a6AZhGWPmyuUvd5ndlVZGXAIpcNF3K3R4cY/CW5N7qH981p3BZIXJTZ4WE8Kk/bbAbQBg+4kx1naMnSHuDRLqhcQAfgCvz00vSCuSThxPf/6rxAWGEAfRAO5is1LHvkxLWsYT39g02FT4Tq0hTNg9iESuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwiR9ptM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D5C4CED1;
	Mon, 17 Feb 2025 23:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739833469;
	bh=xe6tDhiUjSdboNEzq48XtMZ0sysF/UboNoNlyjGqnx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SwiR9ptMtHWwORs/KZb4veLd/0ctTtTR8aGYre/2JcR4lprbpDHAHkIIfl0S5LBRc
	 0hlgWUgObf9g5+NvoIcSDBxSjAk9pXHaE0PnUBUSnGVloRMTmwnkJeyfdvxpsNiAZA
	 aIhQ8scrHygUVQp28Dj+ZkeY58AqUfJxflxY9EnagWVoC/o1VooqfUobDh/O10QoJc
	 xK4wEhIEQPPTYA+djbFk4A0XZSl4E0/xRp7oEQBTuJUZwEbr6YFGszEYHdhOZUCLOm
	 L0i02cQT9VlFqJfY6vcWE4ig2WZGdLYf4wdV19rGl0AMTXDIX9W5OXhyvxdPawKxO9
	 HkAJib2nADaiA==
Date: Mon, 17 Feb 2025 15:04:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: make ipv6 testing optional
Message-ID: <20250217150427.5ab88c70@kernel.org>
In-Reply-To: <20250217174908.1157168-1-pablmart@redhat.com>
References: <20250217174908.1157168-1-pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 18:49:08 +0100 Pablo Martin Medrano wrote:
> Allow to run this test where IPV6 has not been configured.

nit: You're missing a Signed-off-by tag.

I think this test was added prior to driver selftests.
A better move would be to migrate it to the Python wrappers,
see tools/testing/selftests/drivers/net/*.py

That way it's easier to run it against real HW automatically,
an in SW CI it will be run against netdevsim.
-- 
pw-bot: cr

