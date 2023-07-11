Return-Path: <netdev+bounces-16687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0C74E5BC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8FF1C20D34
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9F4423;
	Tue, 11 Jul 2023 04:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39803D7B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518CAC433C8;
	Tue, 11 Jul 2023 04:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689048877;
	bh=/NT8j5dTImyDDiBcLBerEKRFvktbfWBQTuwILJurgBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0xb7wdHITbH1KagxXY1mBrMYPgJq56cnkg4HXbW0CUrZHkV5XYIv3hUqnD0YBEyz
	 aKCRNr8QUZGt5oJxktjEmbt7E+5oitUhUgBlYPgV9l4GtsXLcG4zLtOAtdq6fnCZBl
	 0ECV5QSqWAY6ZYuU3zuOiztQ0BbX7x8xagbdtqzHbei8JOh/orw9z6aXyGAg2+ywrb
	 bfhq1lDYMHzpTObWkGwvewiElTMpF4KPWcitBtwgizYcG8Y/KiOe1cMsdLr/QNCLNT
	 4TksycOHPTSJ5ghE16r6tvjJeEoTslpekyNRyfldKWHtcLDkL6lI0JI1FD01mmaclR
	 fu8yC0RtYuvxA==
Date: Tue, 11 Jul 2023 09:44:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
	andersson@kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: Add another mailing list for
 QUALCOMM ETHQOS ETHERNET DRIVER
Message-ID: <ZKzXKCpoN0Zz4cCs@matsya>
References: <20230710195240.197047-1-ahalaney@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710195240.197047-1-ahalaney@redhat.com>

On 10-07-23, 14:50, Andrew Halaney wrote:
> linux-arm-msm is the list most people subscribe to in order to receive
> updates about Qualcomm related drivers. Make sure changes for the
> Qualcomm ethernet driver make it there.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

