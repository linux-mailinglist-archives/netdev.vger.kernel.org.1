Return-Path: <netdev+bounces-229832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E0BE1206
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50E664E045E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1D18A6C4;
	Thu, 16 Oct 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnblYC5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A017A2E8
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575257; cv=none; b=EMZjkEJHS9kg8dJA926mjd/L6Y1H5mM2kPSBcgDlVG2XUL1pynHxbY9Df4rj+Kz0s7a9/uS1o0V23xu9Et1B7SKW7RF0WB+bUTimSYHaG9Rw88NJElU1HK2CpwRXABG5LVIbPzxAws0RtKsNpmOuGB9rZtnPDxmn7bwI96T0OC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575257; c=relaxed/simple;
	bh=GtVw/9f2FJgKJtatJDYWSMPOOzVe4+O2VcRR1M5O1zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xk3be9UceoJSjAXDjbPM2kmXRbsTcJpsu9xauNdi6wvp92ADc/CW4PuNQRnEFJTghQLdUBu0sgUB1TwQ8HkWzjn78xArhFAR6EQ8yFjeduuGbsYvJtXRarDLQvtZbThlc9ziLR8F2smMIfI4JJdVZnV0I40+B/t+QX8B6+VbprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnblYC5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F48C4CEF8;
	Thu, 16 Oct 2025 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760575256;
	bh=GtVw/9f2FJgKJtatJDYWSMPOOzVe4+O2VcRR1M5O1zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YnblYC5BZ98AKtvg4hxJQ0qWYw10hPLVCv5vkZTdRXbPDqpSfvXYO7Byst3hRDA7G
	 Gc6gcPWbrlYJDTkvC3apXKpCBkjrUa1/OsZH4S+gBZ2245gMKUYcGmKY8Htdr8oDue
	 v6ACgjV0zceqSdecIK5Mlti7ELvUda7gyur2PTzPI5WL1ueY7sYHT/8U1mLlTimqao
	 tGti+z7VTEEdQxRPt4CSm4r97MSGRwliAuxNHnrVImoTwkVJs56AJQQ52lwDY7EBzO
	 xmMA4aQgM+bIj+t03HEx5zOYoIwdZZtS2Bbm8oJid1ozhD58s1JpJsU3Hs09QwhwzJ
	 pQYiWTTQG+iZw==
Date: Wed, 15 Oct 2025 17:40:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
 saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 4/5] bnxt_fwctl: Add bnxt fwctl device
Message-ID: <20251015174055.390d98e8@kernel.org>
In-Reply-To: <20251014081033.1175053-5-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
	<20251014081033.1175053-5-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 01:10:32 -0700 Pavan Chebbi wrote:
> +	case HWRM_VNIC_RSS_CFG:

Gotta be able to configure basic netdev functions for complex debug!
Or whatever the pretend reasons for fwctl were.

And AFAIK all Broadcom NIC tooling is aggressively closed source.

Frankly I have no idea what the rules are supposed to be for merging
code in this joke of a "subsystem". Please stop tagging this with
net-next, it's definitely no going via our tree.

