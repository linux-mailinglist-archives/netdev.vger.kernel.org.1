Return-Path: <netdev+bounces-88087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD778A59DD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7121F2172A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF813A87E;
	Mon, 15 Apr 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc9H7mdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A976033
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205630; cv=none; b=nSJwiwnjFiYPKd3Y9u0HFlDStYgA22foAY7QefYM+uQIH+J1qtVn+zaj6cKCE6FUtdyoZWfbXXa9xkptwI9n6oHtUIiF/QVK8caA2h7ae69RdtO+qeB6ggMJ5Axgep6p3A7JImwmds2Bd0Xp+MT5s8XBer0qZPwaL2BFOhAk7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205630; c=relaxed/simple;
	bh=YEmFcXqDaNOD/wJqMzGpL89WTGuVMvUPYomOi8FEFWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKgFxt7V+OUz2J0YfRy1aF8731H8xrFNuO9Nw1ss5a/Jpo2IMV0ZwiGRTa5Tfef0ZVtVxGVMiqYjYveU1hJ5xfhN5EnvlHn5D3mIwQFXdcubappss238Dxc8QxBl0s/QM+jVMylB4x+hauYHUP2iShWX6peGdNYlyBvXTkrHRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc9H7mdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E50C113CC;
	Mon, 15 Apr 2024 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713205629;
	bh=YEmFcXqDaNOD/wJqMzGpL89WTGuVMvUPYomOi8FEFWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lc9H7mdI/JPuuSgAl4EoNghANiTwtrgKzBe3KbsDc0JZJS8E6HbvRgOWPzLfqZWIj
	 su7X5fPZtnNomZEmtgbu4kgSVGjfs+wAgGyQfwbGpYMoaxn8Lo8wQSfxe267TDrNVH
	 BGE+Hz2H+rijhbYqqTc2j4NCFMXCLSm2LDbIaxkFRSUZOaPwqTlp7o84OznUc3FZ81
	 2yM0i5ctgrwR4IZE2pxbuCrfbatYYX0KlQID9dXRT1XN0el+MNFQ1i2IMNydT4ee98
	 g9juc/UeN4TC/oXJaeTnXOD/Tzj6M9ZtiCrumPZ51IvNBmllwp57NJ2XKg7oE2Drko
	 jilaE080gTw0A==
Date: Mon, 15 Apr 2024 11:27:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
Message-ID: <20240415112708.6105e143@kernel.org>
In-Reply-To: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
References: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 18:54:27 +0800 Mengyuan Lou wrote:
> Do not accept any new implementations of the old SR-IOV API.
> So remove ndo_vf_xxx in these patches.

But you're not adding support for switchdev mode either, 
so how are you going to configure them?

