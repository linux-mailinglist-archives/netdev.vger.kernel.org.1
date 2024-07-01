Return-Path: <netdev+bounces-108277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD091E990
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD98F1F21D6F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46516171066;
	Mon,  1 Jul 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE/Tyjt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1662AD0C;
	Mon,  1 Jul 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865649; cv=none; b=O499qMmwPCqrcRz39HhM8HeF2a7BRPydgGDR6j4gNE35jDHw1iljey2Um5ZydUmwu/EcZbL3FRexhR997hdKOXv4c+tUDoQgbKUYxX7RC5klUPX2GZruqK9tEildbLe1Olu8BA7AExTtRtKVREWsYyd96Sg2+yTOcpMvd1OoC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865649; c=relaxed/simple;
	bh=0cnNYPaJOc3XajJvl1vFQngJ3JahUk39aC7HmDUXHOw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ISOjRJSs1ej//DSncxYopbUTAVcJw3jxWJjImwuPycCtpaBpL6Ud7Pf8isfmlMl+Jh1So37rpDc8c2m2IrFMmkJYbjOO8L2a0VOCCSUgpc//L6CiD537XWsHHqLZygs0TYgELU66LBCnDxlTyVp3I9V5itCMHgPzyvbxhZ3h4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE/Tyjt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A9C116B1;
	Mon,  1 Jul 2024 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719865648;
	bh=0cnNYPaJOc3XajJvl1vFQngJ3JahUk39aC7HmDUXHOw=;
	h=Date:From:To:Subject:From;
	b=GE/Tyjt2bzk05yg4s5Mpl6Ie9o3JDoEEXCy14zCn7l21aLUP9SHuR7fB9rpCbNGNe
	 99G0w3rn5FopG6BvKAfjLNqkmq0pP0o3O9C0rx3Ytss7K59S9DNVEj9OooVJhSReLE
	 /4t/kH/b+RzGRKtEHSgW13a6YLDdz+ev6FZ1yrl6Uaql0yURwnKvmsydmxeFLgg0V5
	 oHcV5K2EFPvBYsM2TpwUkmQZCS0/AYd1dks7bvE6Q4Ggv04xcZHU43M6ouRmWswE+b
	 dD+S7D4rhuvy8BOipse1UBunvlEwX7+hfgvIx+QrOtpbF7yLJaet+VRncvcYEISIMg
	 Qsk1XE7QoeYoQ==
Date: Mon, 1 Jul 2024 13:27:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jul 2nd
Message-ID: <20240701132727.4e023a1e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/b/jak-wkr-seg-hjn

No agenda, yet.

A reminder - both LPC and netconf are open for submissions.
netconf especially is an amazing opportunity to discuss problems 
and solutions with some of the best minds, so please take 
an advantage of it!

And an early notice - next call (Jul 16th) will most likely be 
canceled since it will overlap with netdev conference in Santa Clara.

In terms of review rotation - it's an Intel week.

