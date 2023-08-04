Return-Path: <netdev+bounces-24555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262577098C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBEE1C20B13
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE01BF1B;
	Fri,  4 Aug 2023 20:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBF440E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3EC433C8;
	Fri,  4 Aug 2023 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691180236;
	bh=OcTcljePJX9c6fP6sanmFy/UWxdTl4nx+tja6jELDHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PTc67s1ra5Zycend0jOp1YfLC+z9Ig1JiLAq8NGhvkWzfreLfDzo2u05Mpxfx3PO6
	 4rGWjrGn86Jaa6SF/mi4YhhE+6f+Rkvz95RZ7Ta2aMyhCRvZTPGTDm4SLe98KEtM5l
	 wfKWpq/YCUH/ywXCMtakNxA+NeXKQTOGOrAqZHXPwaeyMLcVlFD9Ose4p0YtYg/frq
	 3d5pO3OCQMg7mZcL2NxjKhkKH+mEK0za/AMouMhnDznx6eithGPklJonb6Tqg1gUnl
	 bBqw7U0orI6i5Qu0nJEqpMTzRhd/LPpPmXOd1yo1Oc4s/aldFE/zF5wWcqXNCFfVPd
	 0kA7aaMp08kjA==
Date: Fri, 4 Aug 2023 13:17:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <tariqt@nvidia.com>, <s.shtylyov@omp.ru>,
 <aspriel@gmail.com>, <franky.lin@broadcom.com>,
 <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
 <richardcochran@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
 <u.kleine-koenig@pengutronix.de>, <mkl@pengutronix.de>, <lee@kernel.org>,
 <set_pte_at@outlook.com>, <linux-arm-kernel@lists.infradead.org>,
 <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>,
 <SHA-cyfmac-dev-list@infineon.com>
Subject: Re: [PATCH -next 0/6] net: Remove unnecessary ternary operators
Message-ID: <20230804131713.09383df4@kernel.org>
In-Reply-To: <20230804035346.2879318-1-ruanjinjie@huawei.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Aug 2023 11:53:40 +0800 Ruan Jinjie wrote:
> There are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.

Who cares. Please stop sending these trivial cleanups to networking
core and drivers.
-- 
pw-bot: reject

