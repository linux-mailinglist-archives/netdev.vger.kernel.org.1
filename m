Return-Path: <netdev+bounces-141335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A259C9BA7C3
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F51F214EE
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA252189F3E;
	Sun,  3 Nov 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaBKBSiK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67B17DFF5;
	Sun,  3 Nov 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663750; cv=none; b=sZmX0tvTsYmqykq1wm5SNG/CHHTZj6spSnmTl8gkGs8qwQ6TmRyKGkyHrb3h2QKueG+yvd6k3XT5i/2naUfSlu3YyF7AY663C3S0GVEvg/czhgltaa1sXGG+tWfpc5hGPvnai7sbfLYrMR4GayPX3lTjZIF6HrAupVYoe8AxVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663750; c=relaxed/simple;
	bh=CkuDlYfKZOxDpFjnDLG0+0sTCT27qXAWrvfalxB7i1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0Us+6CllReudhs9/Q51ZbQ4iEOj9cwitPH8f3FG9bfOZYLU2eU3dvUSBSb0gNupF+n5J7NVtKBTRjQDQfN8/YJ3aQCAVCEKWB0l7TE1+3uE3/kcQYPsAn/FogJGi6+iKuROJvtdx2JkbyFjVzSACafqzv+c2gbdCScZ9ZnxsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaBKBSiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43BFC4CECD;
	Sun,  3 Nov 2024 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663750;
	bh=CkuDlYfKZOxDpFjnDLG0+0sTCT27qXAWrvfalxB7i1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KaBKBSiKoHtHLChxibTwcWccAJHnIEMljcbjsJ7EDA+FY/K2Kr6PJNQAeZte7CuIu
	 xvZgDLVg12KH2yp0tkwfjZRyTDnn9KBNOqgnkHqnbmUihMCjLUq7D2lYjW+7iBNmN2
	 JScF8bWY5RX/Ou2NFGg+3iGHW7iZjYTmwzTqfcfRgBFa3LS09gvCEMcnnFcPvBMCF/
	 sxSkOFBCe6TNN5wtLyxrB3TUge2+WTngtBua8AvKOzu2lLo/UmxqGqxNeHdR8s4wju
	 MalhcsPrwJV8HulQ2jFgrknXMD1Oau9VhCHq+Dfyi7BjQkltoxXil1NGV58I0/l9+P
	 obhZj9NPl7odQ==
Date: Sun, 3 Nov 2024 11:55:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>, <jerinj@marvell.com>, <edumazet@google.com>,
 <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 3/3] devlink: Add documenation for OcteonTx2
 AF
Message-ID: <20241103115548.35d0cbdf@kernel.org>
In-Reply-To: <20241029035739.1981839-4-lcherian@marvell.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
	<20241029035739.1981839-4-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 09:27:39 +0530 Linu Cherian wrote:
> +   * - ``npc_def_rule_cntr``
> +     - bool
> +     - runtime
> +     - Use to enable or disable hit counters for the default rules in NPC MCAM.

How are those counters accessible? ethtool -S? debugfs ? it should be
documented here. Plus please add examples of what such rules cover.
"default rules in NPC MCAM" requires too much familiarity with the
device.

