Return-Path: <netdev+bounces-195248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451AACF0AA
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C6188C41E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC123C506;
	Thu,  5 Jun 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqNAswPi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B922FDFF
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130138; cv=none; b=UxqEGb0CiJJNneE2YJ1pKxWOyEyK+/sGOGHOeHnPHMqEVOQr1KCGngTDP6katzeyTV3yd54eEr9Od/sHYhU1TRTGsdiMZ08/FtT6dLAIQZIk7fEX/HuEhTzDKHliFzbmlqg6uyQrOBCOIXf2MYppN8yfHkV1QZafYqaLDtlcNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130138; c=relaxed/simple;
	bh=l1N2Sjik91iiK8P8e6jyD8rYPVCYzWXF3jxdLrK+5/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN66BiVeg4poY/jeniyjmTSLyTO1rVxAosyvy9aTkt4DGTyzHaURo+9IpGtHmewdjCoUe6ir1/DZr+g13rwip/7SKfhLRtnyMLuYWcp0z7bh+SiTrWgiX/2YS6x70D7oMOyQFntKml12kyJyE/4EsbtT6upkFXoAxoI6gVPQOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqNAswPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29DFC4CEE7;
	Thu,  5 Jun 2025 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130137;
	bh=l1N2Sjik91iiK8P8e6jyD8rYPVCYzWXF3jxdLrK+5/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qqNAswPisoWJpjtsgKZVSOr10KQJdlHMxyjYJ3tegz4w0bMNDZEfyMOe8UDor5iuP
	 OSmtqmkUh+oKqc4FyjbeGqkCwWGGV83zWVBshrxo1rRBlGMjKiOnq2hgDa/LY2J1it
	 7lHrN8zpxAceqoZDSLAZpnM8LLk7PWKfOkZkagl7BYp+o8JSgNoImOEeigiDEuIAN8
	 bDsKL3fGWcdG40R5mk3KMlt6lWKIEapMRRf6TKtNzJNWInW0z47ePjEy4rnzw8E6Ld
	 1vddoQKnwnjyVPWlfeZX/5+TTg7eL5Y7/yXJcEchsgryv9FTU1jni7RxBe6W4NcGTg
	 aW8b8FcaAyFkg==
Date: Thu, 5 Jun 2025 06:28:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Message-ID: <20250605062855.019d4d2d@kernel.org>
In-Reply-To: <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
	<20250423104000.2513425-15-tianx@yunsilicon.com>
	<20250424184840.064657da@kernel.org>
	<3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:
> Regarding u64_stats_sync.h helpers:
> Since our driver =E2=80=8B=E2=80=8Bexclusively runs on 64-bit platforms=
=E2=80=8B=E2=80=8B (ARM64 or x86_64)
> where u64 accesses are atomic, is it still necessary to use these helpers?

alright.

