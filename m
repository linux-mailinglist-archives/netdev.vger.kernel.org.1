Return-Path: <netdev+bounces-150378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AE9EA0DE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A7A28187E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6419CC2A;
	Mon,  9 Dec 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvYRDONV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EA17836B;
	Mon,  9 Dec 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778797; cv=none; b=eD8AVpEbUC2f8DmO4116gr6ANP/qrGQ5WhMP6ibQTTDg41QuGkIFHK2i9W7DvU/DrOmkizVU6rTzMGEpnCakcROUCcx/sWsVSS8FbZU+I38w70fBJLsF6uZo7BX+OLzQ+AkVSCQAh2sNz/oBSgEgFAuigktiZSrfd/KLK/hLHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778797; c=relaxed/simple;
	bh=faJC0l37JVGvOxS+yPSk+/IsTgWitl8RFB9NhyInlMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rH/Dr+5CvgxchrpoUAdCZXehmttfczc8ckUVIDj2T6n37uHO+RisuY5OpLCZRcdMSveYAApRNweEPDwy8a46opQa2daEP2/+FjTgmT/npDyp7JKgD8OKK+Da1r6ip6oCOGp+Ja8IRIn3oAjlsVgXzrgktk6CA7fH6WXbmaChyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvYRDONV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8F1C4CED1;
	Mon,  9 Dec 2024 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778796;
	bh=faJC0l37JVGvOxS+yPSk+/IsTgWitl8RFB9NhyInlMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mvYRDONVxmSoH6XyS5RTdlILgCkErhKycyp734imk2J34nTBo2iHru/UxiqZqonpZ
	 1hOJE5lM+t/uVpwf7ggeB6/HS0sBupKmldszszsHdXA1x9ytIwpJWK7pz320CKbrja
	 Da4LcXD/BLLeERJL0LMMaFE3D1YgvdALFE83DBVZyo/uFJdkxcD1DFZRq9puxh6jEp
	 n2nbFtSdCgszs31e3txrMKY8SfQPvRtG/j/6wTR96n+byyuU6zsaDe2gEMyEm64XxC
	 bqHfPzJ/C85dTAdiJPlTSFt02/aPi4xdTGYTExyDwqcZfERXCbrdDtbIO8bg411jLy
	 G5LpFjzeGB6VQ==
Date: Mon, 9 Dec 2024 13:13:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
 <wangpeiyang1@huawei.com>, <chenhao418@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
Message-ID: <20241209131315.2b0e15bc@kernel.org>
In-Reply-To: <058dff3c-126a-423a-8608-aa2cebfc13eb@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
	<20241107133023.3813095-4-shaojijie@huawei.com>
	<20241111172511.773c71df@kernel.org>
	<e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
	<20241113163145.04c92662@kernel.org>
	<058dff3c-126a-423a-8608-aa2cebfc13eb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 22:14:37 +0800 Jijie Shao wrote:
> Another way is seq_file, which may be a solution,
> as far as I know, each seq_file has a separate buffer and can be expanded automatically.
> So it might be possible to solve the problem
> But even if the solution is feasible, this will require a major refactoring of hns3 debugfs

seq_file is generally used for text output

can you not hook in the allocation and execution of the cmd into the
.open handler and freeing in to the .close handler? You already use
explicit file_ops for this file.

