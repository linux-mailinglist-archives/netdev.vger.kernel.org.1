Return-Path: <netdev+bounces-52224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC57FDEE0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1062826D0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD048CCA;
	Wed, 29 Nov 2023 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6KR6NWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134D1B296
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 17:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45D4C433C7;
	Wed, 29 Nov 2023 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701280370;
	bh=TeE0Isi9YwAMtl8bMXbwMjaH/0PAcKg5AcG0AGcQ/Cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N6KR6NWdBUe9tFdkDnztYFJVQdBZoJJa6mOyRiTbpm75dRLI9Uk5z6eNybJC7AbhB
	 I5Zj+goISMxczvQrXgusYiBAoqocLGMKcrn4iXReG6CD9y46AvCfWdkADF4wV10Yc8
	 ZulJSUFPkpmXCw2hlEfL+8N4TjPmygDBBvncdyQ4eyrvEMyw0L4Iz6HyO38uQY6OEV
	 qQ14V87JJrcSD1aOvDlguDGvKq5DuA5SjPS7+Tdqjv9/18T4b1CnpIi51giOcRaboi
	 VAOWvNGh5Xq8bXDopmM2n1i97ykPx7ll6tAyknluxiKV5dETsCec6j3rRU/XuZiId0
	 48ie20a2MtSpg==
Date: Wed, 29 Nov 2023 09:52:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "lee@kernel.org" <lee@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Message-ID: <20231129095248.557d37ca@kernel.org>
In-Reply-To: <OS3PR01MB65932F46E55E38E3DDB938C9BA83A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
	<20231128195811.06bd301d@kernel.org>
	<OS3PR01MB65932F46E55E38E3DDB938C9BA83A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 16:59:38 +0000 Min Li wrote:
> But the driver that I submitted is a brand new PHC driver. So I don't
> know if it is appropriate to separate them to net and net-next?
> Because the driver change depends on the this patch.

What's in your tree? What I'm saying is that the diff context does not
match net-next:

$ git checkout net-next/main
$ git pw series apply 804642
Applying: ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Using index info to reconstruct a base tree...
M	drivers/ptp/ptp_clock.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/ptp/ptp_clock.c
Applying: ptp: add FemtoClock3 Wireless as ptp hardware clock


Do you have any intermediate commits in your local branch? 
Or perhaps the patches are based on some other tree, not net-next?

