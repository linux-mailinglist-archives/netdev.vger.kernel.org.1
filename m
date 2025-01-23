Return-Path: <netdev+bounces-160603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB2CA1A7C5
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9461637B6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515020F973;
	Thu, 23 Jan 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMldHYof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C91C5D4D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649358; cv=none; b=aJBjeNiGpBHa06EzW8VVZ0wqNKnJ/RBnSWaKGg/B39Jy03s4+uapMDbKQ5C65UzDCr40qFG8868d/hcH7BXiaGd93DrWaOOQQ2AxRCMLf1cnHeTw4vxeJ2ImMO91yvpglnfZZhQtRcGdSqxCglZ983Hnngy2RzkvsNtTo6sP2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649358; c=relaxed/simple;
	bh=/glhc3ybED5ZMc803T1L/QTRYPesfVx533/bDfzoC0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTJwjfxYFjLbKtyqHvsdZaUEvrOv3UtWgl4gDJb53dYt4qa+nTxHZ1LaSt/FayJvSyRoe8A826jradECrC8h8PwgsQYWaYmPqrJLyJtpDo52rIwWNXAAABazbc3bVjaVEdMBet/x/4pjeLgSkynbTfmSVuYilpU0fT1+eV2k9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMldHYof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B66C4CED3;
	Thu, 23 Jan 2025 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737649358;
	bh=/glhc3ybED5ZMc803T1L/QTRYPesfVx533/bDfzoC0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMldHYofCbW38BNX1YUfvecOicVyPgFiXJg2jcNkdpayBvmo8WRtNJpZqmru/6uzh
	 iTiMpvefQNCcqO8DzrD3OhXLSSBp5iOCpt1deU9QqaKIgia7wB1Emu4u5UGL8BDKjd
	 ROiUgfd3yg1z5Z+YOtnJYTua02Gz6xehSEa56xl6v0Mj7NY7gYdzjoYEuM9Dkz7JeG
	 fMIsstXqs7nKjMvM+sgiKAPnSO6Ec08MrMNVvioXJElM/xdQBh8IoAwv8fMLIqPgXL
	 e4lJ6fHvIMffdJfeH/7hkwnzqvedsPMFTZ69CNyKFtYns6HtYBC354n0g2Z8DmLYly
	 rrWvT5lzwkxlg==
Date: Thu, 23 Jan 2025 08:22:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net-next v2 5/7] net: ethtool: populate the default HDS
 params in the core
Message-ID: <20250123082237.27c5fc40@kernel.org>
In-Reply-To: <CANn89i+a_DfERsqHbi6Uu9uzCsN+wKh7WXr6Xh957Cs86ThS9A@mail.gmail.com>
References: <20250119020518.1962249-1-kuba@kernel.org>
	<20250119020518.1962249-6-kuba@kernel.org>
	<CANn89i+a_DfERsqHbi6Uu9uzCsN+wKh7WXr6Xh957Cs86ThS9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 17:15:55 +0100 Eric Dumazet wrote:
> I am unsure how to fix this, should all callers to
> dev->ethtool_ops->get_ringparam()
> have to populate  tcp_data_split and hds_thresh from dev->cfg,
> or would the following fix be enough ?

I think the comparison in nsim_get_ringparam() should look at dev->cfg.
If the used configuration (dev->cfg) is not set (UNKNOWN), our default
is ENABLED.

