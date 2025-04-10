Return-Path: <netdev+bounces-181436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C176A84FF9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4686A4E0E3F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70B20C002;
	Thu, 10 Apr 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcJ6rytk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5E1BC073
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326483; cv=none; b=YkDT1gIT9kjEmI9ZCltAAGsC2YTqyUdN/EwdDjY8/nczUklLzoJ/58oRduJid/CoWV79kIE0HpNkvxZV94L8HkLB8JMcyviuj6gLs96Gn9JMZe5kId9wFLZ+30fzF0bZMiPo3G0OdVmoN+u4DO59xy6lis6YZAqC+sOMYMFteDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326483; c=relaxed/simple;
	bh=ePzRJ7VvpzRkgr0f0Xaw0UWqS/IvWCFm5HOk8LJt70o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpG3OqhcMD3gzf9BEQV02clyJyme+Re6OywUoVszQUZt5ZTo1rgX4b/tWjGLxtR/C/S+dXcRhcRArXNkr1weNxVzjyaTZajEPEzusFVNk+w/WuF1wXaxQ9Irhfh4EOm0xZOeXjZlgzlGgXB+2PbCX9Zvx+CkOCfggwgm3cNxUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcJ6rytk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA7C4CEDD;
	Thu, 10 Apr 2025 23:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744326483;
	bh=ePzRJ7VvpzRkgr0f0Xaw0UWqS/IvWCFm5HOk8LJt70o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mcJ6rytkF37/A7bU67P2wZGJCeVW9iyC+u35X5HK5bzyigtVUhUBStTanLu7VUW5C
	 ACtva/HUONOryqELmgeQFoU3py91vTdpu/dhNexkP4G6lixiN2/TAjGxv4pd2CJfQ+
	 MxDqDz7N422+KlhuXN6uqY9pWXxryFn+m7uqgb6PsCRxl43Y7m9wR6Z0A2XPJw2RyB
	 UP0gGaGA7CYSGJLGWEpVnvoVZ8RDg4RZS6amtskhSlE98rLQP84Arv9CrgxGGgWDlk
	 3unPYdHlrGVi7qM96v9j3gavBoJZcW+IxmjerscEfg6MS67niirI6m7xF616V9ygPC
	 prrXax4ZqpQZQ==
Date: Thu, 10 Apr 2025 16:08:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v10 00/14] xsc: ADD Yunsilicon XSC Ethernet
 Driver
Message-ID: <20250410160801.029ca354@kernel.org>
In-Reply-To: <20250409095552.2027686-1-tianx@yunsilicon.com>
References: <20250409095552.2027686-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 17:56:39 +0800 Xin Tian wrote:
> The patch series adds the xsc driver, which will support the YunSilicon
> MS/MC/MV series of network cards. These network cards offer support for
> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.

Does not apply, unfortunately. Please rebase & repost.

Failed to apply patch:
Applying: xsc: Add xsc driver basic framework
Using index info to reconstruct a base tree...
M	MAINTAINERS
M	drivers/net/ethernet/Kconfig
M	drivers/net/ethernet/Makefile
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/Makefile
Auto-merging drivers/net/ethernet/Kconfig
Auto-merging MAINTAINERS
CONFLICT (content): Merge conflict in MAINTAINERS
Recorded preimage for 'MAINTAINERS'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 xsc: Add xsc driver basic framework
-- 
pw-bot: cr

