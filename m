Return-Path: <netdev+bounces-17002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1C74FC72
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A92817B7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC13376;
	Wed, 12 Jul 2023 00:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB95362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE43C433C7;
	Wed, 12 Jul 2023 00:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689123506;
	bh=NvfxK9pKA8gAy7u7ITQ3h/x37zP/0gL7nCQsnj/ce/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRJf1kDbCA1KriaNRx3umVmdJXhvrk5vO1AOHWWn4NxnaiHMMqNiTTJm7svRf5BBf
	 8gyU1LDrXf2OVKunYEIffoDq2IWyYdgBQhFDNySqneOraxIot4CYhbmGDZxCAiYNlu
	 tRr+2dgwH7Xze+IfbOk2KuTXTfW2QLdfKSCEaGLUgH8rA0Yx3zKsnAd3iy5t/zyEoR
	 P/20Ttgi42beVE3EunFs3Pm1YXcESJZNi6XGTW521BtCj/vBOvNaDa4FDYkvn8pJBw
	 tVPMiICDZv2MEgRgQ9IbFaZGnUED8czK9ND1Y27dI0tXd61Lz3AxTCW88tIEBaSBxk
	 CQ4nUEcjyoz4Q==
Date: Tue, 11 Jul 2023 17:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Leon Romanovsky <leon@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kurt@linutronix.de,
 vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
 tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
Message-ID: <20230711175825.0b6dbbcd@kernel.org>
In-Reply-To: <275f1916-3f23-45e5-ae4d-a5d47e75e452@linutronix.de>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
	<20230710163503.2821068-2-anthony.l.nguyen@intel.com>
	<20230711070130.GC41919@unreal>
	<51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
	<20230711073201.GJ41919@unreal>
	<275f1916-3f23-45e5-ae4d-a5d47e75e452@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 09:51:34 +0200 Florian Kauer wrote:
> > I understand the intention, but your second patch showed that rename was
> > premature.

I think it's fine. It's a rename, it can't regress anything.
And the separate commit message clearly describing reasoning
is good to have.

> The second patch does not touch the rename in igc.h and igc_tsn.c...
> (and the latter is from the context probably the most relevant one)
> But I see what you mean. I am fine with both squashing and keeping it separate,
> but I have no idea how the preferred process is since this
> is already so far through the pipeline...

"This is so far through the pipeline" is an argument which may elicit 
a very negative reaction upstream :)

