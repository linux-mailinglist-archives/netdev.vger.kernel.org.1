Return-Path: <netdev+bounces-152028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31D9F2655
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26E4165335
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048EE1B87FF;
	Sun, 15 Dec 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIdZuyBw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB66653;
	Sun, 15 Dec 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299085; cv=none; b=LF9NtHxKEmrdLazd1/yBkW/4hVsgZV4ga/CdzNpE4YCye9hC1ryEqY3H5xGH+jl1abKCJldzGixmnLe+bJG5FAe94vbTIP8VtpABcURoAZDPggrTGs38ZvedU2uV6j0qY68GkFwHkEyzwTfpAA/XrBY4pQLtFt2KNnc+0yqRKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299085; c=relaxed/simple;
	bh=1CPpcw0Otx08FEarz0dPgCUUa9KnxhNco6gxmihwvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIlvv5cpcVZrql4gWKMeFkkgK3XZLG/qkrEcUrOclaqMXcRw/Hglb/pOAmCljqAi+k+yp3KA+ipESH8M1ataQnolL4CVRn+dUGmcfKSr7ECYtsMlkYsXJsIf3TeU+MCpHI4TV5VCW7UIbj7IYywuS4ddHtF01obVgj8AJSdPUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIdZuyBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC097C4CECE;
	Sun, 15 Dec 2024 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734299085;
	bh=1CPpcw0Otx08FEarz0dPgCUUa9KnxhNco6gxmihwvQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIdZuyBwf8wJcINmix6Dca3qoDtjImgICN+qSAYQ/dM13/dXlt3mzFIkR6y7+Iaoa
	 A0mzexMb6I4fbgN80+SOPX9yAinCgNWQIo11aMiOlzDg6h5Vph4o/wS7b5NURPoM57
	 QwG/9UuY1RolXeGMXovDwa2x1Fb8eCux/NAbtxyxAmHvEulsTkrzp8KOe2VrqKFNPw
	 tbagkv+3aU2XZlXBYQqhyIGd0F6y/CiSKAkzBJtBCZ+t5P/E9qQzMAgKrh2y/oKkwF
	 wsfYvATacu1Np4V3w49o0XrCjrw0ZzTZa28Bs3Vr1aTFgjC4cgwDy0vdXdj4hFDPSz
	 VY3syBuIBXQuQ==
Date: Sun, 15 Dec 2024 13:44:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <gregkh@linuxfoundation.org>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V7 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
Message-ID: <20241215134443.28770bbe@kernel.org>
In-Reply-To: <20241212142334.1024136-2-shaojijie@huawei.com>
References: <20241212142334.1024136-1-shaojijie@huawei.com>
	<20241212142334.1024136-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 22:23:28 +0800 Jijie Shao wrote:
> +#define str_true_false(state) ((state) ? "true" : "false")

Didn't notice until I started applying this..
str_true_false() is an existing helper:
https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/string_choices.h#L68
-- 
pw-bot: cr

