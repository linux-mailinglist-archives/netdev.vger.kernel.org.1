Return-Path: <netdev+bounces-68958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24957848F43
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3867B219E6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7022EF4;
	Sun,  4 Feb 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otVdjXrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DF22EEB
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064140; cv=none; b=s2GnxQy/bPYERciAdRMkwdFj45N308lONMJrFVcnX1qQVsF06HqNZ2/rwVenGwJgVtu0mfEylIQMwK6we/xdvcx7LYFXNgQsM9qrjtk7zx/rk3O0pa3/8grObqgCigUEwtCuku8JHd4Pe7wa1Y/q2v0ipNWgMz66aDOigQbe1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064140; c=relaxed/simple;
	bh=gfz8OeZCH9E5oJrPbcU2nbIx1MR2D1bjT/jjMfIsFhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLMFwaHuzdelLevcjm6oGU1dd4mE46UKjJxIF1rZsj5Pv93pyMnhU/cYxwpM/1k2d9dPXcysW3dwPtWrHSI4yr/ev2cibEW0mmRGlvU1iELxtisXGD6U+7h/RutdBGqyKQjefGFhqgEPSXxxIFv3SnZeitHcjsb13wQfrSfNmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otVdjXrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20622C433C7;
	Sun,  4 Feb 2024 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064139;
	bh=gfz8OeZCH9E5oJrPbcU2nbIx1MR2D1bjT/jjMfIsFhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otVdjXrfY1wWA3DH0ngbpWIh76N7zXZmE5R8pvPxOCnuwJKLJgIc6tXoFLFMBJhld
	 eIdtnJaqLeXeXlDtLS2YQhqunwGyp4BwO/2ka0UqZOgrt5w1Ez0oveBKxCdI/J+9nm
	 xHw0GnRg6X6cT3Uc4DJX67ArDCfwvKgLZGzAQ5bDmHsYrLXbATU0PJLwx8qcmGGCH6
	 jqPG+PtlsQMWPy42QGqEjabKyStBeJWsbXtlfeH7PxDzUo4a07vI/xV+IWxaW6a4ad
	 58FWUtIRoK3pquche/GbNq47RVbFvp6PLyiQ4AoaC+zK946igXo1SaDRaU274Ak4Wj
	 tH6+rSGmejZnA==
Date: Sun, 4 Feb 2024 08:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCHv4 net-next 4/4] selftests: bonding: use slowwait instead
 of hard code sleep
Message-ID: <20240204082858.2d823ef5@kernel.org>
In-Reply-To: <20240204085128.1512341-5-liuhangbin@gmail.com>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
	<20240204085128.1512341-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Feb 2024 16:51:28 +0800 Hangbin Liu wrote:
> Use slowwait instead of hard code sleep for bonding tests.
> 
> In function setup_prepare(), the client_create() will be called after
> server_create(). So I think there is no need to sleep in server_create()
> and remove it.
> 
> For lab_lib.sh, remove bonding module may affect other running bonding tests.
> And some test env may buildin bond which can't be removed. The bonding
> link should be removed by lag_reset_network() or netns delete.

Unfortunately still fails here 4/10 runs :(
Did you try to repro with virtme-ng, --disable-kvm and many CPUs?
-- 
pw-bot: cr

