Return-Path: <netdev+bounces-184480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88648A95A8A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478977A9D05
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1213212A;
	Tue, 22 Apr 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYQau24O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E1134BD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285772; cv=none; b=qYRmV8nQ4R0xuG1rBtmvQgEoOCKvTN834gsRK2Pt4Vm8ldhscZABlO4yYOM3SigTpcjrsW+aFmVcu67/GWdHNrsIVe6wSA72YtihyRsNefO9q5Lf7d8izagQdsD2qumX1cOWMGqEux3361T4EjLdQ90kBMT2Kgo2xTW/ATm+ygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285772; c=relaxed/simple;
	bh=jaSaaz4fD7gmy5u/L+9Ywg1JbN6BK11zXKoZ4GqzkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLDwn/60B49nzL21pRpUCZFj3KX1kQxNXzAMhUGX4dyl60V+x6+Ayat+OA2skSkAjrwWrfIbQFCs/MBE4yvFSZf+hIWtfg/5f1gwv3IBZX42/49lVFFB8rRLPakNuuA8buVc9RY59zE0CNlf8d48q2NdWNP0vly4kiBfnmWgPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYQau24O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A678C4CEE4;
	Tue, 22 Apr 2025 01:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745285771;
	bh=jaSaaz4fD7gmy5u/L+9Ywg1JbN6BK11zXKoZ4GqzkRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYQau24O5eGvmuufDN0rW0XBs9GPjVVDtpPYw/mZeJsyIofS5cjPRsvIhuiwoO3R9
	 B3k6pTHPt0XMREAyEL1xd1ZuOLIObVNsgF9vgDzFu3VzvB3WZuY50qo9blGBwBM+8+
	 FQpN8Hy/a6+wIkf/xMN4YI0QNg/VQb12oOJLk8E/cAyhJpyqx0ZGJdGF7xJ5fgN5VS
	 zxwWDsX7xCRIKCJocSEOYiDXm16TunVszZc6rZE2VcPkkp84Nit+meTPkrajJ42XGd
	 j3EgOGeCn/Ufuwgq8uWWXckstGmlqVZZQQ9tmEm2n8gTuv1LAar7ei9DkWPSS4kDa/
	 v7ZVSYrH7o9hA==
Date: Mon, 21 Apr 2025 18:36:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net: airoha: Add missing filed to
 ppe_mbox_data struct
Message-ID: <20250421183610.7bad877c@kernel.org>
In-Reply-To: <20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org>
References: <20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 11:30:47 +0200 Lorenzo Bianconi wrote:
> The official Airoha EN7581 firmware requires adding max_packet filed in
> ppe_mbox_data struct while the unofficial one used to develop the Airoha
> EN7581 flowtable support does not require this field.
> This patch does not introduce any real backwards compatible issue since
> EN7581 fw is not publicly available in linux-firmware or other
> repositories (e.g. OpenWrt) yet and the official fw version will use this
> new layout. For this reason this change needs to be backported.
> 
> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")

I'm not sure I agree with this fixes tag. The fixes tag should point 
to the earliest commit where any problem may be visible. IIUC you're
targeting net-next because the structure is not used in net. So the
Fixes tag should also point to some commit in net-next...
If we leave it as is after the merge window stable bot will pull this
commit into 6.15 for no good reason.
-- 
pw-bot: cr

