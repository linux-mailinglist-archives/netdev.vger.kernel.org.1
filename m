Return-Path: <netdev+bounces-151798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6394C9F0EC4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2916603B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E21E0DDC;
	Fri, 13 Dec 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlpR6XB/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B51E04B3;
	Fri, 13 Dec 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099022; cv=none; b=s9zEZSRryHzVnzHZX2SxxfhpXwCoqyqj7iK6yQg4uHbbTQMHJ6KPqI6C0AMStxUo2JHp3JHhyfda12WvtA4DabGdAEHPZoAmqSCaGgqZbuGVVrXsl4BIfdfPa4IpbAoTCidkhVh6f9GyrnUixWq7Tzcm2Dr9YSCA1tz7HahB3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099022; c=relaxed/simple;
	bh=X1G8jyNdOTQp6RmoXhjSlh2R/WEz9Ja/0XTEzP+fWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr0ZjXLS4Rp5PDb9n+Gz73LB+AY8n/aNRddinJf9OVAldkUv0AW5Cfqzpv/kN2Tnt14fCqM477znjcvTr58wlUp8tZ22MH1ZpabgjBg1FNfNg625+Gmr4KPyWdZnrhs9GKLedxcCgmxFZ639Kxqijy/3WAWHqq4GUxq4i36PzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlpR6XB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07ABC4CED0;
	Fri, 13 Dec 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734099022;
	bh=X1G8jyNdOTQp6RmoXhjSlh2R/WEz9Ja/0XTEzP+fWwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlpR6XB/qnXaJXi1l7tthmJU7zeaD0PQbiidaPJYzkhQgxbbSCTCLI24pcF99v+3o
	 3hT0WcWHIMo8z1aqmXnTvZpLt4UzWmlCENtPywXq6Xs7X7NyI96r5L90SEiBRHYjC0
	 sLICrCYgymj7LC7ypOaw0/3nH7D6XXLE9GptEgIXExrMEB3V1+FUkqmOeVsP5TXC/l
	 q6Et+sQ8npLd4ZRslCFpa8FlspuHWoMYcqroh2iYvD8ndfoNRH4nDD0H8w12DKxWP9
	 6hsjyv4TorkWUUpLvZ6/tCPIna5n+ndCSecJB/+gz7/dA2arp2KA4dWqXROTk30YFK
	 xk1VJGwatg4RQ==
Date: Fri, 13 Dec 2024 06:10:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
 <wangpeiyang1@huawei.com>, <chenhao418@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
Message-ID: <20241213061020.017b6f95@kernel.org>
In-Reply-To: <1448b4a1-235c-4abe-9f95-fbf6e7f9d640@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
	<20241107133023.3813095-4-shaojijie@huawei.com>
	<20241111172511.773c71df@kernel.org>
	<e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
	<20241113163145.04c92662@kernel.org>
	<058dff3c-126a-423a-8608-aa2cebfc13eb@huawei.com>
	<20241209131315.2b0e15bc@kernel.org>
	<1448b4a1-235c-4abe-9f95-fbf6e7f9d640@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Dec 2024 21:11:49 +0800 Jijie Shao wrote:
> If the framework does not call .release() for some reason, the buffer
> cannot be freed, causing memory leakage. Maybe it's acceptable=EF=BC=9F

Are you sure? How did you test?
Looking at the code debugfs itself uses release in a similar way
(u32_array_fops, for example), so I think it should work.

