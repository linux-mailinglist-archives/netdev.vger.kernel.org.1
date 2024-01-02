Return-Path: <netdev+bounces-60965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509D8220BF
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A51C225C7
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F5156C3;
	Tue,  2 Jan 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDaKD37X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23615AC5
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 18:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C114AC433C8;
	Tue,  2 Jan 2024 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704218889;
	bh=nS++WJl+CiR0IavHKbU7Kf9jCOZd1j3uWXblBRMheFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDaKD37XSnzq2aXehIFEuJweA4jYIX3GLgH+VTOzJ6I7vcX/23ybOO/KDXCYFJq0d
	 WSfSaUPSPH7s4vpKrMlgiAX6zf/VZdZND2h1VnDO4F3Vh4PZFIzk+eA6Xdsy9Gzm0S
	 V/y8DPtBn3U3HMqWfaX0ROBpEsOAkakyNpZStZmXidCmyrZQAbvRPPmqVmsGA4Wlux
	 B4D93cTJXNK+m0s7VzarUtH8VOxBT2mj+v9r1EOPRP2j2GipI/9qDCur6WWgUi2LEl
	 AsCqgSD2EaSUzt+v+vVFwXmkYnPq0N9y3nceCwdAlN7vuclZgrVw48G3MUwqrzOvMi
	 tWBjV777pjJAQ==
Date: Tue, 2 Jan 2024 10:08:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v2 net-next 00/11] ENA driver XDP changes
Message-ID: <20240102100807.63f24fa3@kernel.org>
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jan 2024 19:08:44 +0000 darinzon@amazon.com wrote:
> Changes in v2:
> - Moved changes to right commits in order to avoid compilation errors

Please read:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h

