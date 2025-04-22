Return-Path: <netdev+bounces-184702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502ABA96F64
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1713BA2BC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BFD28F946;
	Tue, 22 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJVd5Ig3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87828F93E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333726; cv=none; b=WbyZAl/iVee2rtYr/k3twSKXCsouN7SyORiMJ/E+8MTB2V1p3Tnp+ZtbJ7jBCPEYg657ig95hoK3e1n/aIb9r0Vf9nGQ2sAt8KixwwXIST3rHya0DdYUiOrAvcKTEHwYVeLdEfEjfy/ATNtwdc3BNO6VU4l1w8G9s8qwRtIlYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333726; c=relaxed/simple;
	bh=rX2SdauNBvl0FQUkJjSTWWycVMXLHKoraAk5Iw/r99o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7FRmGfUmuxBB0qVCJWXrjckJWKVZPLrcMfEvbh8iqimuH4Tx6oj6WTCuUkRUfpLBO3FyykG5tzqIjGCEFwK7PTig1Hi/MG8RiDwSmO5YdSUHDTUkJbNEco9/CG6j//UNwQdBFFXGHV1KkfqIe8Shk9iEa7fGhGE9iIB4LcDrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJVd5Ig3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861FBC4CEEC;
	Tue, 22 Apr 2025 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745333726;
	bh=rX2SdauNBvl0FQUkJjSTWWycVMXLHKoraAk5Iw/r99o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bJVd5Ig3yF4Pl7j5nmLWf94wMtQN2h65k5FlgTRRE/vxnM13t9eA5UtO/iInfBoGI
	 XysrAGSXCvOuFlyRd8hRtpNT0M6dNuJFYmlzJyBQhKyk2dbFN4kJwjkzl7MqTrSCVs
	 9ADaj2HWuHtt0vU5hnCU1QQGulSoaHgHVv3kVoXZjAaLlfgEcONtV/+gkm8mF5GXbu
	 +Qcmu4CDdqNHB7YXJ8vKX8C/d27X+D6l0ROXZScqU8s40n+wgSeewwTg7UbKlq8hPe
	 qOP5KIzbBWWr8XyprrjIee4FlioYMCUyPAzXy6LJHL2CyudfsLUTkWBFIkvMbngxL3
	 3dVsARgD0DulQ==
Date: Tue, 22 Apr 2025 07:55:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250422075524.3bef2b46@kernel.org>
In-Reply-To: <v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
References: <20250414195959.1375031-1-saeed@kernel.org>
	<20250414195959.1375031-2-saeed@kernel.org>
	<20250416180826.6d536702@kernel.org>
	<bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
	<20250418170803.5afa2ddf@kernel.org>
	<v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 11:14:36 +0200 Jiri Pirko wrote:
> >Ugh, I thought enum netlink_attribute_type matches the values :|
> >And user space uses MNL_ types.
> >
> >Please don't invent _DYN_ATTR at least. Why not PARAM_TYPE ?  
> 
> Because it is used for both params and health reporters (fmsg).

I see. Still, a better name is needed. "Dynamic" sounds too positive,
and the construct is a dead end and a misunderstanding of netlink.

Coincidentally - you added it to the YNL spec but didn't set it for 
the attrs that carry the values of the enum.

