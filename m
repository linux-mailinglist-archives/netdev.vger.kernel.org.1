Return-Path: <netdev+bounces-214966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E1B2C4C2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0C6242655
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1C2C11FE;
	Tue, 19 Aug 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBE1vgAE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55113224AF9;
	Tue, 19 Aug 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608622; cv=none; b=StUzwHOEutivBVL5oXpfmfOOS9iDP9onBD/zeFf9+Y3Arr0KPthtXzMQLn1rfx0cKd16ZcAMf82PneCyV4zYH4RxTIaK8KNhKQrWICousXSjfTBl+aDEwP8sM1tzDB2z1eaX1hi5GS4zUifURCap9LboFGqiaRcqv+ix927F5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608622; c=relaxed/simple;
	bh=hplkDh1/2FSuApngWSdqjeR/23Vt5OkOSLfobeSPdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfJv+kjdTdyNkbrdCFrqvW17brlFSyvETi48n8Xn3oLLvBgdyR2vnoQi/Hqh3ky3h2JpfZSjSzz/XGtnQTsvQeYMqH7wbdmeRKGSDU/HcgTRzgw/xb2Qo5lRJN/N4mVxQ2PVFZbBkoc0H1Hef1xeM4OhrMkeRJsbLF0hc70xzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBE1vgAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061E9C113CF;
	Tue, 19 Aug 2025 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755608621;
	bh=hplkDh1/2FSuApngWSdqjeR/23Vt5OkOSLfobeSPdFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBE1vgAEo4bbHJ7SIvzzOzhgWKHLFVlLWkSeakMoHYneWqwf/uNi1k+Ul9NbC+or8
	 yQWoPs7oGsU4gn8rZQUbQuu8A8W5g3TMe0Gkm/SJBo36lPPD/qXH16eCWfYIhC66Ok
	 BPzH0fwEtOVfDNHEfLk7MGBllFhYERHKc7cSX/wpWZHRLwrQrHNTIWIG4pVfXRVWXL
	 IqfszaZ/F3IZNT4TdSEVNYOLs9kOowZ3vp+6fSR3LginfDarVrmRC1ecQKxd2O06oe
	 Ak88WZKTrUfKPns6LH7nFHPK1mFyznjFabu3OIu60TvazW4YKEQaa0EjwvDDpHZUiZ
	 s1DXoUdsRDrpQ==
Date: Tue, 19 Aug 2025 06:03:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v2, net-next 9/9] bng_en: Configure default VNIC
Message-ID: <20250819060339.7b38ae1d@kernel.org>
In-Reply-To: <20250818194716.15229-10-bhargava.marreddy@broadcom.com>
References: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
	<20250818194716.15229-10-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 19:47:16 +0000 Bhargava Marreddy wrote:
> +struct bnge_l2_filter {
> +	/* base filter must be the first member */
> +	struct bnge_filter_base	base;
> +	struct bnge_l2_key	l2_key;
> +	atomic_t		refcnt;

please use refcount_t for refcounts.
-- 
pw-bot: cr

