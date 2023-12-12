Return-Path: <netdev+bounces-56569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A9A80F68B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243751C20DD2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25E81E47;
	Tue, 12 Dec 2023 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geZ412zg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65581E43
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B20C433C8;
	Tue, 12 Dec 2023 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408980;
	bh=h0vdMWDI9l3i/aCuABJALbqVOeIG/b5avLtu1EGcQGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=geZ412zgATKQGgmDbqAHiOBD4pvlrFl6nusNREosZOaj6307z4fTb3QkXB8e3sudE
	 p+hBXdmN3BwxqMPzrT0/VhUrr8AWvRGb4FN6NSZ4AFXN2wR717xJRkAo6Zef5Pz5Hr
	 cZg2O3ev1lPyIuHoLwfasv5g11XtCtQiSt658sM3U1FvJPoGcfwT7Dq/P4tFymrszw
	 OawWE6Dfh6M8UH1MYtHM+PhqmTNXUTjZ6AjTPFgeqXLQr4qdI/U41R9bhvKOddxPK4
	 ZIGBXlEI766hkyBOG1ilGYyLC6nnfUdciT6SP4TAHUBeiYbMNz+KeIX64nEv0YQmzZ
	 nVjTqxWneaV9w==
Date: Tue, 12 Dec 2023 11:22:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <20231212112259.658d3a79@kernel.org>
In-Reply-To: <20231208094733.1671296-14-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-14-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 17:47:33 +0800 Justin Lai wrote:
> Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Sorry if I already said this but please familiarize yourself with the
responsibilities per:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

