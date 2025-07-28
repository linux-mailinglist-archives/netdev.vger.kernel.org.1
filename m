Return-Path: <netdev+bounces-210573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F318B13F51
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195E07A68D2
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7E2737F9;
	Mon, 28 Jul 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsFU/0l0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EC2727EB;
	Mon, 28 Jul 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718300; cv=none; b=pcSLvc7mG1vJXD3ztIYj6o+Z0D5IHWmjWhfCssFR0JdzVJPXmSDnfAJ7ocHPOkr5nyIdAJ1UoR4zqlScm7+wK1YeYaTrcF32mzYd+HiVk8vFfBYsoRTEa55eAgN4nMKcsvTGIAHGZGXGiqzY4wpw+RMzkevozCnq2KVvDl0SPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718300; c=relaxed/simple;
	bh=V+d2rcREysRXtKARHFsAr2HZDjswTxp4mAu7WVwQcLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pw9nykQ/kq5cKcza+B1Imww5ktg14gDu/ZSuHBKWvy4+Z4s9kOosnWJIpzMhu6A+czTHaWDSWfFxtiPlepDBCqLrOuGYKBgVLJu/TGbmTHOxeYRWps70hCIjAK80OPhj7FHdkyfQLQw2vzcnqfkUzdC5zo1Xx3cZhB0CnjkihjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsFU/0l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4379EC4CEE7;
	Mon, 28 Jul 2025 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718299;
	bh=V+d2rcREysRXtKARHFsAr2HZDjswTxp4mAu7WVwQcLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FsFU/0l0JhHv3KnAnvGh9cpDYQdde/ZjdI3aAicUrmd3JLMO9kvxN2dnUFGVg0nb6
	 hwT1GRV+wSWcnTNqtXJT6NqIcKUVqyD09yR6V7inanEVa5Tyl9FVxqlTZyb0sRB8Iw
	 0LkJepsCP/izOEN+2HGU/elG6XQ7moL86xFYwSbRxQmYZswsXEK2zrsVcKhMvPmt2X
	 SXgDWQzWx/r010pE96+/oMBHaXLVkhE3D4N2grCCJ3At2BOdRwbn1O+WvkO6XNmAqg
	 MEJbJDImzWSQzN3NeoodWSvXhEn/8yn/3zB6u9cx8s36tkXFHMBRmYird8o5GOgq+A
	 jNm9g6/zcDC5Q==
Date: Mon, 28 Jul 2025 08:58:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] net: stmmac: allow generation of flexible
 PPS relative to MAC time
Message-ID: <20250728085818.5c7a1e45@kernel.org>
In-Reply-To: <424f8bbd-10b2-468c-aac8-edc71296dabb@foss.st.com>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
	<20250725172547.13d550a4@kernel.org>
	<424f8bbd-10b2-468c-aac8-edc71296dabb@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 10:15:07 +0200 Gatien CHEVALLIER wrote:
> Maybe we could compare the time to the current MAC system
> time and, if the start time is in the past, consider the
> value to be an offset. Therefore, any value set in the past
> would be considered as an offset. I see some implementations
> doing either that or replacing any value set in the past to
> a safe start + a fixed offset.

Let's try this.

