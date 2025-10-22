Return-Path: <netdev+bounces-231473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F2BF96E3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD74E1486
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC1114F70;
	Wed, 22 Oct 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoKigjnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE1DF72
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091807; cv=none; b=AvnkMtPyB44sWmiY4IBtbvTYQNrmB840CFGd69HgB08RSQVyJet7Dr8X76GLYq0I3MsFekNc4h2XqHSY4YebI2dMOTDSAyM1W0/+LwSFoNkOUYt8eW1RyI4Ues8B7KJmQyN6e4ymTiw6S2Y64xDs7GYVpckGAB+CmH4jbdXgay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091807; c=relaxed/simple;
	bh=5+lsmVoiQGOGFVGmMtMyDKhRMEVJpi8PtM60HqBwSss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWt9z99BJ2bH91OS8NC9VXPZdrG0B44BVrxrNk3CU7A/0iKxeVwIPl6tvt6CEJXMbkRKmCD1ByiT6qJD1Suup9gNK/m0PGdNxaDI9bRoGKOKqJn/8V2pcMI5ksIZMbtg7iu08LZGFYTwvfGI/5RhPtHTKGR/xcxMGEnqEs6HKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoKigjnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050C3C4CEF1;
	Wed, 22 Oct 2025 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761091807;
	bh=5+lsmVoiQGOGFVGmMtMyDKhRMEVJpi8PtM60HqBwSss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoKigjnXY/V5CIurT93Dve7cfSva+eC/lzlwdbdSBTN1ig1qxSEry/AAn5FiB8v+t
	 fmt4PZhkIA66wRP7U9jtP7LvPDBLNfydwz6WdQ6PqwPPhfpZer/4+04+GTQXEGEsp9
	 JUo3qq8AYht5d7YBQUdtgN4FfoGUofumixT6AZNJvPPBeh5om5gi20TJX5Tn0u3rUF
	 Pfu6ewHlkF2HgWSM7GTZQf5SDGTcJ231KWOfMDvXHDefP7dVEoMSyIu/pazx6NVh6s
	 UwcZcocWfPmdxkzbFRXvWfeRUs5ZgY9S0JUx0z/JdOVoaBUGde+V9OBy7fTh2MxnZI
	 pQ9+oI9CnSxWA==
Date: Tue, 21 Oct 2025 17:10:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>, Jiri
 Pirko <jiri@mellanox.com>, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net-next] net: add the ifindex for
 trace_net_dev_xmit_timeout
Message-ID: <20251021171006.725400e3@kernel.org>
In-Reply-To: <20251021091900.62978-1-tonghao@bamaicloud.com>
References: <20251021091900.62978-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 17:19:00 +0800 Tonghao Zhang wrote:
> In a multi-network card or container environment, provide more accurate information.

Why do you think that ifindex is more accurate than the name?
Neither is unique with netns..
-- 
pw-bot: cr

