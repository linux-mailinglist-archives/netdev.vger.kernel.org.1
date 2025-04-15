Return-Path: <netdev+bounces-182561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF108A8918F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD54217947D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D47433B1;
	Tue, 15 Apr 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO6fTxGI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83033997
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681512; cv=none; b=tENDdRvL/H2BuubGNBrvjJ3limCc7V7kFNK2e3keSOVhWmYZXATshczu5QDoBgUYQRKzKNzKrUJQzClL/L28GfwhMaWCsd1vAgC+lyCi7437uyoynX7R+udAGX5Pye7Fx13RTGJXOsZ02wGjpRMEc81eVCKuCQwzlPYIMKvHG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681512; c=relaxed/simple;
	bh=ztVLF68jYAyW1osbpDPoRpJ9kbMS8MJULa4t4fRsp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqo8HSvm3Vp2dGDyaQJDZLYloy0XheoI0gjgSWAA0b15Y7S7cE7fOnDMU8geHVYorQvpnGQQblk5xffDjkjHkENC8MqEwYNDaAdFqWKbUAaWUV66EB8zAh6VyemAXDM9RaodMEGO84vM1GAeN+AFvXmNGx+X3A7cYVOMQmAsRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO6fTxGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C65DC4CEE2;
	Tue, 15 Apr 2025 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744681512;
	bh=ztVLF68jYAyW1osbpDPoRpJ9kbMS8MJULa4t4fRsp2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dO6fTxGIdBsLRB+K6boDv8NUHpNNwaGu8DZ2lkoc0E2KELCjGm0/Q5M0NKyMrVnld
	 EOjkF4MnCg+SNyfnPzgB7paJYPd7D1nr8rs+Pg+wwhE63bkOsuLabqGfBvggTMsNPI
	 3teSaZAizZudKytVfcJ0iG52cFip0NMDUsZADrTRGcnhBMZ9/iB+MdL7ngyd75Yxo3
	 QkqbhEwm/BU8MkTC2cqaOkwpLc59Uhy46v3ow7lyiu4k0DYW+eORa+uL80yd3K4Lsb
	 KctKBCR/aId3g5Tskse6OCR0IRv5Zm4EwwR7il+gYnVEvwOHzT2yQMkATPSldBL5Du
	 2L3pNSQU8ohUw==
Date: Mon, 14 Apr 2025 18:45:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v10 10/14] xsc: Add eth needed qp and cq apis
Message-ID: <20250414184510.367bbcaf@kernel.org>
In-Reply-To: <20250411065316.2303550-11-tianx@yunsilicon.com>
References: <20250411065246.2303550-1-tianx@yunsilicon.com>
	<20250411065316.2303550-11-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 14:53:17 +0800 Xin Tian wrote:
> +	netdev = ((struct xsc_adapter *)xdev->eth_priv)->netdev;

This double cast is a bit ugly, and it repeats 7 times in the initial
submission. Please add a helper somewhere, along the lines of:

static inline xsc_dev_to_netdev(struct xsc_core_device *xdev)
{
	return ((struct xsc_adapter *)xdev->eth_priv)->netdev;
}

