Return-Path: <netdev+bounces-207284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF5B06945
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA531781AC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C102C1780;
	Tue, 15 Jul 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAtJquZZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FD27991C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618525; cv=none; b=rihzndYVXhmCTXY7MqWq3MR3anNG9fZuXb06myAYX2nGGFyvTZrmuUiBHP6zyIIQRu7LZE8BTbCxnjN+8txAE43giIZWn3XKENnI6g8zuYUv8tULbhYHxrF6kzc6BlQhSE/OXY6SBx4ok9ydBEptRFyyonGtnJTQ/F8Uu1k1M8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618525; c=relaxed/simple;
	bh=4ut389ZOxiX2HxYyVoWEiSfFyFoFm3DzYvNjUp3LuMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2rQ4XW0RgtMpAz27tsd5dpIFxhEYLfBskYAI+GP8f90oGRoALQ07aKS0axgfZN2hI75Ur0qtjrRgaxLqGHJXP3nsQwsSnS4R4MZB4ShSAa/lZe0YmKN3/u60cwN2VkNPSiuDbtyodmBlLF/WihaP1NzQWgHxJ7NLbdVrmEDNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAtJquZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD64C4CEE3;
	Tue, 15 Jul 2025 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752618524;
	bh=4ut389ZOxiX2HxYyVoWEiSfFyFoFm3DzYvNjUp3LuMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAtJquZZl3Y9oj6CDXvPhooIeC5U7GzuT4vy4S6EhyH4H+wEUquADDhzaWGbN1fBs
	 u5q+/+nMFg73uEvfSggmEpz6lPkIi5igeagXdkHaHlHhC1X6q9RZOLm+dSTCWTpOpy
	 NEOu06BKxNLDcbUUtW41FdpQDgap52SaqClIsBWs7bteUe0wekAayjpsqD0IxNrVN4
	 zGPpSLRJICMnhl6GtjnnA/tuga5dwg2yHMHk2TzEbIijQclBL5yNYxdus6175202q9
	 0KtRVR6x/jvS7QT1edYRiKERSqgqIJTup/4+I00llamAk/ImKFHbSWJhq974Oe1LHu
	 z/mBdcrxApGNA==
Date: Tue, 15 Jul 2025 15:28:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Cui <1997cui@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/drivers/net: Support ipv6 for
 napi_id test
Message-ID: <20250715152843.1a1e8ff2@kernel.org>
In-Reply-To: <20250715212349.2308385-1-1997cui@gmail.com>
References: <20250715212349.2308385-1-1997cui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 14:23:05 -0700 Tianyi Cui wrote:
> -    listen_cmd =3D f"{cfg.test_dir}/napi_id_helper {cfg.addr_v['4']} {po=
rt}"
> +    listen_addr =3D cfg.addr_v['6'] if cfg.addr_v["6"] else cfg.addr_v["=
4"]

Would cfg.addr not work directly, in place of listen_addr?

=46rom NetDrvEpEnv::__init__():

	self.addr_ipver =3D "6" if self.addr_v["6"] else "4"
        self.addr =3D self.addr_v[self.addr_ipver]
--=20
pw-bot: cr

