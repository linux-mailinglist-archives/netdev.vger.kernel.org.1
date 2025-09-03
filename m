Return-Path: <netdev+bounces-219395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3954B4119F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0745E6E64
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D21B043A;
	Wed,  3 Sep 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEbwCBSp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA93597B;
	Wed,  3 Sep 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861586; cv=none; b=TUBMY8VIUraRAyuiL8vg5WGffh+syI+bScx+hYbnwgxMubjX4Or/hlqC0Vr0JmnUEEAgXmU/IRF/5aJAp/8lKnr9UJJKdU8bNqfidU66Y2Bi11+/CFKwTtpWNyoWubNSWBW/9UCIs21YyUZgLS9Tgj8K/67WQS1p4PhOOf1UERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861586; c=relaxed/simple;
	bh=GR1To0WoOOdlYT1PhZY62bBLb1zMmRyOO0N/UeGsO6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6EaH2zpxZ08+3zMVVuCLWkjJt4MeXoYlS9NQ1Q150FKhW9tRex20VjadT/vEEBWkECLdgkdOSoXnkgFQqLf0OvHGhq2hCZrgh1xNpRceDQKM1Wu3MggzH2vHiaMBaFTTDLqwJjTOVt+l3yKGHF64NGHS09GRsqGk8gVJW1tYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEbwCBSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD99C4CEF5;
	Wed,  3 Sep 2025 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756861586;
	bh=GR1To0WoOOdlYT1PhZY62bBLb1zMmRyOO0N/UeGsO6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEbwCBSpQqGmw1E1JvTFRWfeZD1X+YfcFQlt5parKkhvCiaXRYs+cxxyBytft3F/H
	 PbS/B6kIGAVY5sFlVF8LvIfaYci1IH7wKnrU7aaDqjSbWl9B0uyh+VSQIaxunmW2nL
	 uk4RLyBqCAQbkKHY+shoWPIJ0IBfJWSZbg3aT5eOjFZMUNZwVhoOm2nTj6169TLJlq
	 wL3Sxns/P+G/65wIvXGnmtDIt2R9Bodulb9TFO/OKBQokce/8CVQ5BqKyYf6dp6gp4
	 LKc7UJREtp9lXgD7tIprXhKaqgVaT4r+/LHu5aWuOQcXYhaFK+j7nkz2+CH6SW5uOs
	 6+fniTxCcK/vw==
Date: Tue, 2 Sep 2025 18:06:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v03 02/14] hinic3: HW management interfaces
Message-ID: <20250902180624.4dd37159@kernel.org>
In-Reply-To: <07e099c1395b725d880900550eaceb44a189d901.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<07e099c1395b725d880900550eaceb44a189d901.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:41 +0800 Fan Gong wrote:
> +	actual_irq = pci_enable_msix_range(pdev, msix_entries, 2, nreq);

I believe that new code should use pci_alloc_irq_vectors()

