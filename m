Return-Path: <netdev+bounces-165301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A295AA31861
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E9D1887387
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5F2641DF;
	Tue, 11 Feb 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlAglzcG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE606267735
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311613; cv=none; b=nE+deg++OIsJ/UBZ/rFw4wJMJeDW+6VkV+WNdRIVIL0PKjgOq/Qj28b0Rl3m2rsR4OtZIo9yWurNGOHUjV/lrnfAWuNsNQb9xyidC2Z5HFb6jLp1oO8kREWw+2c2y49fheT9ZMgnEyb235ObzslhrsiFQd+Zx4ui38ra2SRort4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311613; c=relaxed/simple;
	bh=QUdutst0O8bfQjnJbHBA3fQDZIWIm2amVA+GBLRrFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNCsqwW3zsbpjszWf3Yzojl3I4viPkRH9ZYJvSvUlK441nGEdY84BX04gCDOVOxxq/AteSYHIirmQDCOKmyypvo3YrfEpa6q6OkprazfnQpT7SlsdMBYveTXZvrQUDlrEkIYM+ltbQO/oTB5SpuCAXuUmqQCEwJ1F9/OYKHN9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlAglzcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF8FC4CEDD;
	Tue, 11 Feb 2025 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739311613;
	bh=QUdutst0O8bfQjnJbHBA3fQDZIWIm2amVA+GBLRrFRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlAglzcGixWn6wlYlzxpiaRfl1wBxxs4V98sCQTNwp4bdDyiSR/4nPcYXtCLapfKE
	 Q/t8ocQ2+kbq8RS7fw90xg+PuAnNWMfqKmyJeChKuGeAwxhwANYZGchzkGjLLdesAJ
	 /+M3VIKurnnsesSzzT8ft8WrIewa6mTCwa3Lcio5T+y4Rp4LJCmN6UXKEQeNXUut2Q
	 8K6nf8CtXwXLk3t85SkxVBtYhCQe69/caSxT1KPk/Hot7aqsqeQwzWXXYxkN2tDGu/
	 99cK9Eo7GEKQIa80vOTAXrz6lxoULzqGNrscejQQCK5NdgLQLphfhHMJDfP6Ey5CCJ
	 msoKP/F63F3Ow==
Date: Tue, 11 Feb 2025 14:06:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 5/6] net: ngbe: add sriov function support
Message-ID: <20250211140652.6f1a2aa9@kernel.org>
In-Reply-To: <09EC9A07-7DA7-4D3E-85EE-F56963B54A66@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-6-mengyuanlou@net-swift.com>
	<20250207171940.34824424@kernel.org>
	<09EC9A07-7DA7-4D3E-85EE-F56963B54A66@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 19:14:54 +0800 mengyuanlou@net-swift.com wrote:
> Due to hardware design, when 6 vfs are assigned. 
> +------------------------------------------------------------+
> |        | pf | pf  | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
> |--------|----|-----|-----|-----|-----|-----|-----|-----|----|
> | vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
> +------------------------------------------------------------+
> 
> When 7 vfs are assigned. 
> +------------------------------------------------------------+
> |        | pf | vf6 | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
> |--------|----|-----|-----|-----|-----|-----|-----|-----|----|
> | vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
> +------------------------------------------------------------+
> 
> When num_vfs < 7, pf can use 0 for misc and 1 for queue.
> But when num_vfs == 7, vector 1 is assigned to vf6.
> 1. Alloc 9 irq vectors, but only request_irq for 0 and 8. 
> 2. Reuse interrupt vector 0.

Do you have proper synchronization in place to make sure IRQs
don't get mis-routed when SR-IOV is enabled?
The goal should be to make sure the right handler is register
for the IRQ, or at least do the muxing earlier in a safe fashion.
Not decide that it was a packet IRQ half way thru a function called
ngbe_msix_other

