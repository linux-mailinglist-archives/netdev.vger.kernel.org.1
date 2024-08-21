Return-Path: <netdev+bounces-120404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C0959285
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE3287172
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E62763F8;
	Wed, 21 Aug 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZunOn3Fc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D516D4CC;
	Wed, 21 Aug 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205284; cv=none; b=PA8U0VhqmchhnxkikedkdeB9buMHg0PgGKVbne5DKqNhHMmyvigzMlAsjvRPxdNNI/KmcMiE51+vMAid6tMs+/snrqgCYIiwyAhwB+IoQ21C/mZHW+EGPcFp9ipF0ps/C/vm3rMTG+DsqIALVEPigzaTDM1Oy34n5Xfq+KTDikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205284; c=relaxed/simple;
	bh=mNXBziqddIrIRwdBF8oYGU7b9vnXEjSUl1hVOg5s2c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+Fj2Artf7ePeKCOkPwL+OcFKiyVthmH4Q91lSn2hNJSt8tycexFtyWeFx+r2SSsr06Jc31ouMSbmm0nGoBkpFiLeBDxIHZcgpQm3Kv5craZgkezgn/yKEdq4Ans5o6b6veHPMWqBzhj/DnM3hw+3Av2XwPfufzQ74fUDNDCE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZunOn3Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40791C4AF09;
	Wed, 21 Aug 2024 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724205284;
	bh=mNXBziqddIrIRwdBF8oYGU7b9vnXEjSUl1hVOg5s2c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZunOn3FcO5tOl/aWyxqT8VvRVxbV2hNTOiJoZK1ZQivNHBp5z0EwJQnnj3SYd+DJ+
	 yPMNvwy2YRa7GXQpGCKg6fvP+XRyBiDluaGHrEwCj+SM5vlaWegJgvKyPtSnoM+SCG
	 fDHsazCE+4/DDNKfaMCnIMEQF1XV7l3s4Wl5+UmieXsmVsFfcoXi0TTDIjCI32WOUD
	 MNZRp7mXcAQcPrYQtdDljysOO0JP7BI2ihV6uSKn3I6S3U1bJFn79TZnP+vA68//XS
	 LKVZ8VyVtPuUBexymJi/isZF3BfBUfvNa3uT2KD19xaCW/nN4UpS1RIKabCkLHaekE
	 wNrmXkqmfPgsQ==
Date: Tue, 20 Aug 2024 18:54:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <sudongming1@huawei.com>,
 <xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 09/11] net: hibmcge: Add a Makefile and
 update Kconfig for hibmcge
Message-ID: <20240820185442.117d75f1@kernel.org>
In-Reply-To: <20240820140154.137876-10-shaojijie@huawei.com>
References: <20240820140154.137876-1-shaojijie@huawei.com>
	<20240820140154.137876-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 22:01:52 +0800 Jijie Shao wrote:
> +config HIBMCGE
> +	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
> +	default m

Remove the default please drivers should default to n

