Return-Path: <netdev+bounces-250437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC7D2B30B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B494300E3F2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7E2236E3;
	Fri, 16 Jan 2026 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqC5tH4v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360032E15B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536622; cv=none; b=shiDHv7QAsmc2/jYj6fYOzVRWq7hz9GGiROwv64V3EQgDWroUsrw23aq9fPETx89dlaFq1Q+2L22rTSn68UlDcC9NwuZSfNcsutidYKd+us2M7KZ+BGVOVNxBbeirQqftBkVATpvzpaml5jxO0+SObCHmzLWjqtkZbEClL8S8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536622; c=relaxed/simple;
	bh=a/NicxW3PdzYrPqo75Izw2awQl78BVWlLtSFavV/Wk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt8BN/RpofdLhd7AdOvKPjUy8v1svaY5xijNakH10n1SA+Fp38FMCIk1PZ6yZRsbEKhzBd/k5FWvLxr2f23oFoemKQg9puOuHTQJ4gAyOaUt+5TVLgWIMMk7qI7AI7GNZwOOsFsxE1xRlP97YTEFATTnU81k6s5wmsnnUUBWkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqC5tH4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFCEC116C6;
	Fri, 16 Jan 2026 04:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536622;
	bh=a/NicxW3PdzYrPqo75Izw2awQl78BVWlLtSFavV/Wk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XqC5tH4vdZafkDWDAn22RFdZVFY3LbLfBCVgKhHdJBMN8mrRUAkwmBt76QMcIm5jX
	 hDry07xPWxHCdL74pcrvq/OcwJo9WN0RBF/j1Getrp04wK3ARvwZL0M8/scttuOA6C
	 cbc9wrWAMxDlbHiIdsmac/mQJ8qr3i5mX8QRttMBqidSwE7MnPOI/wy2ODHRdFkPmq
	 qzgYjPfiQUgjjkRuEEEV1G9Z3LFtS8ZZpwz2t8qboJahN0WRlwbLqil7+LmBuoE4yY
	 kN2a7wqCuBdX1y1VLk4QAKP42y5F/HoAuFRA5EpHko7BRRuGj1Z7ZVYK49/cfPkuWV
	 uQrR4yavTl5iw==
Date: Thu, 15 Jan 2026 20:10:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: extend HW timestamp
 test with ioctl
Message-ID: <20260115201020.69f2a0b8@kernel.org>
In-Reply-To: <20260114224414.1225788-2-vadim.fedorenko@linux.dev>
References: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
	<20260114224414.1225788-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 22:44:14 +0000 Vadim Fedorenko wrote:
> Extend HW timestamp tests to check that ioctl interface is not broken
> and configuration setups and requests are equal to netlink interface.

Haven't looked closely but pylint is not happy (pylint --disable=R
$file):

tools/testing/selftests/drivers/net/hw/nic_timestamp.py:9:0: C0410: Multiple imports on one line (ctypes, fcntl, socket) (multiple-imports)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:16:0: C0115: Missing class docstring (missing-class-docstring)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:16:0: C0103: Class name "hwtstamp_config" doesn't conform to PascalCase naming style (invalid-name)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:86:4: W0201: Attribute 'rx_filter' defined outside __init__ (attribute-defined-outside-init)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:87:4: W0201: Attribute 'tx_type' defined outside __init__ (attribute-defined-outside-init)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:22:0: C0115: Missing class docstring (missing-class-docstring)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:22:0: C0103: Class name "ifreq" doesn't conform to PascalCase naming style (invalid-name)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:56:4: W0201: Attribute 'ifr_name' defined outside __init__ (attribute-defined-outside-init)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:89:4: W0201: Attribute 'ifr_name' defined outside __init__ (attribute-defined-outside-init)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:57:4: W0201: Attribute 'ifr_data' defined outside __init__ (attribute-defined-outside-init)
tools/testing/selftests/drivers/net/hw/nic_timestamp.py:90:4: W0201: Attribute 'ifr_data' defined outside __init__ (attribute-defined-outside-init)
-- 
pw-bot: cr

