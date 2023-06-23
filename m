Return-Path: <netdev+bounces-13234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9073AE81
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BCE1C20D23
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE8384;
	Fri, 23 Jun 2023 02:22:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DE363
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535E9C433C8;
	Fri, 23 Jun 2023 02:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687486919;
	bh=tnJ8MJYmGsXhm9WvK8f4ApXNR1tUYJh3XJM+dv+ULCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dmgg8BenMVw7uet0WiYa2h4+ev68iCiglfgP7dOFtQ3YgQYq6fNhdQal+0cMkFek0
	 2sMyvuFBa/HpuSyGqxPsxcPT3/ZM1n0SYuMTmQi572UjBSD6VsZu6BkD2ISzYslfoq
	 2iU/reKpIjJLMBlDtX63TxyofRNw1XCNdacb70xOtS7rlgWMM55PkXmtdkpj7YoI8m
	 iqJrmuSnZs8Ro6BnjBksTWSZ9V8rQtskiEqZKyTeXOKotugcqk5jdS0rVVyfm/zLLF
	 C2138oC4dlLQAH4VyOIKv3zlP6on1xHJn8VaN8MBqUHiL+7RS0g31oWzjpb5geA3Iz
	 TTkqxDyDX7CQg==
Date: Thu, 22 Jun 2023 19:21:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: txgbe: change hw reset mode
Message-ID: <20230622192158.50da604e@kernel.org>
In-Reply-To: <20230621090645.125466-1-jiawenwu@trustnetic.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 17:06:45 +0800 Jiawen Wu wrote:
> The old way to do hardware reset is sending reset command to firmware.
> In order to adapt to the new firmware, driver directly write register
> of LAN reset instead of the old way.

Which versions of the FW use one method vs the other? Why is it okay 
to change the driver for new FW, are there no devices running old FW
in the wild? Or the new method is safe for both?

We need more information, we had a number of reports recently about
drivers breaking backwards compatibility and causing regressions for
users.

> And remove the redundant functions
> wx_reset_hostif() and wx_calculate_checksum().

You don't have to say that, it's a natural part of the change.
-- 
pw-bot: cr

