Return-Path: <netdev+bounces-111974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66E93453B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8FB21EBD
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D6639;
	Thu, 18 Jul 2024 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdTvG/eP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84717C;
	Thu, 18 Jul 2024 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260845; cv=none; b=r1+rONXildiysinXRDR5LoiE+sfvYtgAf6X4CZopJ2vrTZxPdQ8MBRhf81F+ilzH6JCvlRQxhTeZ/SHoPoOzMFnzmMv2/HZXvfX+PMdk9TCwmYGXKrS73BG5LyAUkC1AipneiXjUdy+TfudelKpBw4OkOIL7s8KKO1LLcy6yIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260845; c=relaxed/simple;
	bh=1K/eLbk0Vgwfxwjr5jlZ5haAjXZM1N9RcoofjyCY0+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+UYqzzpDVGWh4CIzr7IlQ+VH8i0ub/QpDwR2HPMLZ0QkPocjfTE9VhJtGRRizFbbvRy/YO+vYiYlt0vS0nIrAaxGbtTfbAi4W8Dp0y9JFAZ7Q1OX2xb2Kj9G9McYOiAjZs01rhcyL/3F7ObkZXmHohAliFjAXNUMp1VCsuUBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdTvG/eP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C07C2BD10;
	Thu, 18 Jul 2024 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721260844;
	bh=1K/eLbk0Vgwfxwjr5jlZ5haAjXZM1N9RcoofjyCY0+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BdTvG/ePDPre6eCjMNfPI/dCR4bigWGD4cdLBO9awDvnCYcLncXcpRtSwoSN41LYc
	 abkDmBU//5R1kkvn8npJPOL/076wAWalKVJUjiW11RQZuPywjaFGW4+CO77g9Tpr8Z
	 D346ol8uJtTldbnzuJumCuF9sqH3t55u3rzIaw5xVSf4S4WBuQxBsWyClPHHTgv7cy
	 DymypF1XWJFnoKCUJoTO+elnyUYrpUJd7+8N50axiSwIpTMUebAFeiDBLBTU43VIVq
	 o7bqZnJ0MNK9tSUpXlW/3onYXNlXDsBchRg/VErBRasxxhTTpIexYREPZ6GPXFSM7X
	 titfbTjRajjRg==
Date: Wed, 17 Jul 2024 17:00:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.simek@amd.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
Message-ID: <20240717170043.45aaf7e2@kernel.org>
In-Reply-To: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 00:24:43 +0530 Radhey Shyam Pandey wrote:
> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro".

FWIW the BIT() thing is a matter of preference, we don't enforce it
strictly in networking, it may not be worth patching. Up to you.

