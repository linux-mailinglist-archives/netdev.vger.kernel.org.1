Return-Path: <netdev+bounces-243553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D816CA37E9
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FE0D303D9F1
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16E3358C6;
	Thu,  4 Dec 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="yezYnQPh"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB1335070;
	Thu,  4 Dec 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849196; cv=none; b=toWfzZDtsFg9P2lwTKYpW28nnSCCELBH2EPXbHOt1Abftukjs22r8j7qqu5eTRMdZ4MmeYopUSHiSGQOU4EGk7JwSkY8lkqP4hQ8Zc21xxEzEYzw/zX+iFhjk1GrwaVzlkrOIEKcjoUeCVroDzWyfB9jMlv1vL3tOr7dQZt80rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849196; c=relaxed/simple;
	bh=Mfjbfpp/0gwfxAfbud+u2b4E/dP61WOnt2PhVBGLoGA=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=OFk5k6J1ybCE/fjNJrOXZI2zaJpg1eeQIa8RwI+d23olkq57Iw4nIpQaNMw+WUWhyb2M1qd+6J76UDF+SIL8FjyHJkKrckGIblaWxe+goAbVlWmYSHGI7EbKcYsqhg+bjwxUrlqpWeEQxVKbXyYwWdIMl8nvJvAAwp0XZ6DMLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=yezYnQPh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:To:Cc:From:References:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=iX3gKN6EvUH85dcLjdOxFvt2aveGDYYKGTRSu9FxyfA=; t=1764849194;
	x=1765281194; b=yezYnQPh29trVrSItYo7gZBKTZWOFho4bSHR1YGyCiwIdj+XxDVJUO7Jgaitu
	KAuXa16u4isNWm4FuQwDrxlq+ojgbSxwN1551WuTxKUP7qLRfdYdqs0KU2yUHdHDvxOUcBJiYdZLJ
	Rp9pU4I36/opkIQbyi55tT/HDJ9yPK+Kf+T3Togb9uDI1YG06e23zPI5lhd8wEdSJXMvL4nciwys0
	FElPn5ngQiKERJxrkHvWD+ksKEshGST2X6R5IWYivnJ8p3Sp0KBswg0Wl/31TzVVABZBY88dDhmQV
	WcoaQioGcj2GRrSLXms8QQOV/zUFMbQkPR1D+M/k2+drHru8ig==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vR7tS-008nsc-2j;
	Thu, 04 Dec 2025 12:53:06 +0100
Message-ID: <418484c3-e65b-414d-ad2c-71e832ae7af2@leemhuis.info>
Date: Thu, 4 Dec 2025 12:53:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: mlx5_core does not autoload in Linux 6.18
References: <a939e5fc-c5ea-4a9e-8566-54dfa54bb0da@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: regressions@lists.linux.dev, Demi Marie Obenour <demiobenour@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev <netdev@vger.kernel.org>
In-Reply-To: <a939e5fc-c5ea-4a9e-8566-54dfa54bb0da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1764849194;ad24a402;
X-HE-SMSGID: 1vR7tS-008nsc-2j

Lo! Thx for the report.

Let me CC the maintainers of said driver, maybe they have an idea or
even head about the problem already. If not, you might need to bisect this.

On 12/4/25 08:54, Demi Marie Obenour wrote:
> In Linux 6.18, mlx5_core does not load automatically.  This causes
> my server to not be accessible from the network.  Manually loading
> the module in the initramfs fixes the problem.  Everything worked
> with Linux 6.17.x.
> 
> I'm using the linuxPackages_latest package from Nixpkgs.

Mentioning it like that might scare kernel developers, as they have no
idea what this is and thus might suspect that it's a vendor kernel with
lots of patches applied. Is that the case? Or is that vanilla or at
least close to vanilla?

>  The server is a RISE-7 OVH dedicated server with an AMD Epyc 7402 CPU.

Ciao, Thorsten

#regzbot ^introduced: v6.17..v6.18
#regzbot title: net: mlx5_core: module does not autoload anymore Linux 6.18



