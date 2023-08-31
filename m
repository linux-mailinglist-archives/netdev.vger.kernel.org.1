Return-Path: <netdev+bounces-31477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CC78E455
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D7C1C209B7
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938FF10E1;
	Thu, 31 Aug 2023 01:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223C136C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00ADC433C8;
	Thu, 31 Aug 2023 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693445384;
	bh=cb760b00c88nI7p8jqVzDcqBTkiybLXeMCvY7zM8QYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPq+O/NUlMIiNjY2Pwuau57du84cZbJ0ezIl0aItG0HKN/VKxFvOPVw9DYGasnN6g
	 Fha02aIA0Ju/hoNWEf2WU8FFPgqWjucJMeiWLevJxvpaChAjCCJiSM9dcGB1fyu6q5
	 +bjKwinXwTIi8VOwCIVTFAks9Gv+jC651cX9ecv9uxuiEutm3IzdfAmFLwwVoUSxuV
	 91kEeXHCLK0YAC+PUaxDUkLIhRO3BWND3rP3QhLKaH3NnSOckka3Wo/75F3aVdT0vi
	 9UjUhEdh9QKYQIyGPG76u7CvzlsA5PW500nhQuj8ZQODI3RBVD6TNMM6b5nJZXF/hj
	 RS0cbLEbvkctQ==
Date: Wed, 30 Aug 2023 18:29:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH -next] ptp: ptp_ines: Use list_for_each_entry() helper
Message-ID: <20230830182943.6aa2e346@kernel.org>
In-Reply-To: <20230830090816.529438-1-ruanjinjie@huawei.com>
References: <20230830090816.529438-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Aug 2023 17:08:16 +0800 Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the this
> list_head pointer and list_entry() call are no longer needed, which
> can reduce a few lines of code. No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


