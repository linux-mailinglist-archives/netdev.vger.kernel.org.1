Return-Path: <netdev+bounces-208720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825ECB0CE62
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39E26C1556
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516C22AE75;
	Mon, 21 Jul 2025 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCAsT8mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143819D082
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141738; cv=none; b=uT6wEZXBjP7SEmTCdZ1bUmrmV0DtaJk5pKlSpaLdvfUxYpTykuoMG81amsR0rW2GdcVs8hFhsGEdxuOuL75lPt7hYYwvbPswT6Jj0umrJO+zq74v+S/cW2cLSKeNax27VSv+Rj1o5IxhwpUPImL7jwjr67e83VrnAGyEm5ZLQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141738; c=relaxed/simple;
	bh=3UtdaK5xwfROdCd6/oCb/jPYM1Sd1AieXmtkzNizZHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSzW5N0DJ9HxG0gz8nkKGswxtdtzMsxRyccpqjHZOgtPOOO1pCqy1nFbbILueLoclvO85lmZvYUp1tknJvrRkMMQOsP71vFIpgiGQm1QOKnn2FLVMn57VOyPWAnA4LzGG21Pv+0Uu7PfaES1X7GqwIkPtBStFEKInN39hTXWfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCAsT8mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F731C4CEED;
	Mon, 21 Jul 2025 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753141737;
	bh=3UtdaK5xwfROdCd6/oCb/jPYM1Sd1AieXmtkzNizZHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCAsT8mtf4tHuW58+KPuYEcPzz81hk+GKISLbcqV5o7LewTSQdqzUcHiK8GdX4mCf
	 B/3ixA3cwtM+AXoA0CMML5WGK6NGLsiex43YffofKT5bMhVNptRe/Jcyi+n2MFbP28
	 3QkOaTuwf0KP8fWH4ElqSPDDk47yZEMHR1FTAs5/t3WhqitsJKw9TkcAEgK04lVQbd
	 9vnzPSn6aJw/pVlDzn24aN99siDQB6yCCP+ehxkIJtQrddqNlUtHSgPHSOKzMl7m6p
	 vADfJTl0pYO89S6pUOyIvHaiYc6WuwSRqO9deXRydy2fSxejM02+BygYGaP2JPjDoT
	 NjQc5/zzU32sQ==
Date: Mon, 21 Jul 2025 16:48:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/5] net: define an enum for the napi
 threaded state
Message-ID: <20250721164856.1d2208e4@kernel.org>
In-Reply-To: <20250718232052.1266188-4-skhawaja@google.com>
References: <20250718232052.1266188-1-skhawaja@google.com>
	<20250718232052.1266188-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 23:20:49 +0000 Samiullah Khawaja wrote:
>  Documentation/netlink/specs/netdev.yaml       | 13 ++++---

yamllint  says:

  91:15     error    too many spaces inside brackets  (brackets)
  91:33     error    too many spaces inside brackets  (brackets)

Please fix, rebase (the series does not apply any more), and repost 
the first 3 patches ASAP. We really need to merge the decoding of
threaded as enum before the merge window. We don't want it to be
a bare int in 6.17 and enum in 6.18. I may break some Python scripts.
-- 
pw-bot: cr

