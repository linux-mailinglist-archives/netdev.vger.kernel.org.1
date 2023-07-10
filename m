Return-Path: <netdev+bounces-16536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE674DBA9
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0EA280F4A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB00134C9;
	Mon, 10 Jul 2023 16:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97941125CA;
	Mon, 10 Jul 2023 16:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EADC433C8;
	Mon, 10 Jul 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689008121;
	bh=92QedKxPnNh0nRPl+lEtvbAjvdZYrtCfYJAIUUcekKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h9XLo4wu7lBg0N5oGAc759RbT0fju5NSf+fRgRNGKv5KrBtoihuXqUzVUUs7BXkMw
	 ZTgs8YaMAjE28qU+zL1jrVmXhmRFPr41gUPd7zAtoFlb6E4x1xOYNCv9R4K9puEZDv
	 LyRhqxK7QNLgDUVVH3hO4494TbUbjgeLhgDu7ATjo6SP0SMnXbTTjGMmTkAIzkSHCf
	 xfx4unSSVitYNuZF3CC+e1Oqbqyry2HOEdBgxpcRF1BRiUje4z2s8/M+RgkICU4Al+
	 jjcovcDLDMrNRkfxxoce5M8+MCQFoTtism9s18iuPBMlfK5LQm0/nzMPovRKHYFPh9
	 eI9H1aqDZYMcA==
Date: Mon, 10 Jul 2023 09:55:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Andrew
 Lunn <andrew@lunn.ch>, Ross Maynard <bids.7405@bigpond.com>, Dave Jones
 <davej@codemonkey.org.uk>, Bagas Sanjaya <bagasdotme@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 Linux USB <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: 3 more broken Zaurii - SL-5600, A300, C700
Message-ID: <20230710095519.5056c98b@kernel.org>
In-Reply-To: <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
	<50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
	<e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
	<ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
	<62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
	<14fd48c8-3955-c933-ab6f-329e54da090f@bigpond.com>
	<05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
	<ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Jul 2023 06:36:32 +0200 Linux regression tracking (Thorsten
Leemhuis) wrote:
> To chime in here: I most agree, but FWIW, it broke more than a decade
> ago in v3.0, so maybe this is better suited for net-next. But of course
> that up to the -net maintainers.

I'm surprised to see you suggest -next for a fix to a user reported bug.
IMO it's very firmly net material.

