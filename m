Return-Path: <netdev+bounces-172737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDAA55D51
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B21189528A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC315573A;
	Fri,  7 Mar 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwAs+mfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA9143748;
	Fri,  7 Mar 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312341; cv=none; b=Pzz5h75TEy1J6EzHv2vRR+LJkOi0AGi946dExHh8Xqxx7ztNh32xQq28vF3ZgfcmWYz+4al8zPBoO7fr8Q/Ru7lkJ4zMvNZ9loK8TF+gEJlr27cz8y24abVl6GLELHKWn8q5zsNlQ1/a/hkJz5ntBos5e0ROTKcf96gPpFiKEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312341; c=relaxed/simple;
	bh=xwNJxF1YyGce08oYy0Fe12Vy2Z2KPkn8AONDnD2E1JY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2VGUtehtPSZ4FbuuP7GABVLaBVAEPba/Mk3mZxObt2Ytrx8/EimY51KsVg/dyzMhyl9ABZ+2Qd2WWGLJNHT8YYf8RHKrcb/gEyaWJjVMgkovNSW2IL9ZcsAgpP4gWZFAaQwzI94/t32NpXhi95K2IuvJLoaizXnGVb5fmrqgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwAs+mfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1BC4CEE0;
	Fri,  7 Mar 2025 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741312340;
	bh=xwNJxF1YyGce08oYy0Fe12Vy2Z2KPkn8AONDnD2E1JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CwAs+mfKWvL9z58F7FJ5FdtMkL7EfeYt2+CkaLUaJDsjP+o26naI1OyHwHrQgxHiq
	 JuUNCUgfxSZXKfvzGxaWX9ZJWY1lS2nuzMebHqw+njI9sEtEh6z2B9qzfYPMrADE6K
	 MXeynKnC2rU7aPCD4UwrCMEqWM635Tf98YKr+cNFA9ajCiXXGBbTrvssLXJZ+thUb7
	 BMSP0TMUU3usi1NgrAjDktdC6gcMJVQx6lQ2Vh2+irlix5uDV/USkh0jNYkR3EaS0S
	 vIX1UwGLmPRfUH79W1xudnj9F0/A07nmawPcitDJtlUGC7univDGgw+80kFSB4FKKY
	 KCa635LSHeETg==
Date: Thu, 6 Mar 2025 17:52:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Lukasz Majewski <lukma@denx.de>, MD Danish Anwar
 <danishanwar@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next v4 2/2] net: hsr: Add KUnit test for PRP
Message-ID: <20250306175219.54874d3d@kernel.org>
In-Reply-To: <20250304104030.69395-2-jkarrenpalo@gmail.com>
References: <20250304104030.69395-1-jkarrenpalo@gmail.com>
	<20250304104030.69395-2-jkarrenpalo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 12:40:30 +0200 Jaakko Karrenpalo wrote:
> Add unit tests for the PRP duplicate detection

The patch appears unable to survive an allmodconfig build:
ERROR: modpost: "prp_register_frame_out" [net/hsr/prp_dup_discard_test.ko] undefined!

Guessing that it ends up built in and the function is in a module?
Maybe a depends on ?
-- 
pw-bot: cr

