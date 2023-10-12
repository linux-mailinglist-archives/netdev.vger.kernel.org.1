Return-Path: <netdev+bounces-40548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864E7C7A5E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AF5282147
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6F2B5CB;
	Thu, 12 Oct 2023 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKTB+Cck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847D2B5C1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1C9C433C7;
	Thu, 12 Oct 2023 23:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697153161;
	bh=FxDU7fsWaLUrXPafq43dXGONyys3h5tlOTxIdNyvE9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKTB+CckA6PzylP9o8wEslGNh/PL2nvvlcuG2KM1UcDsF+u8N/LzKAbj+rDTzubhf
	 sw97587wtQ0NJuFfogMBQpivZxWs9DoVGcZvbnBmtazb9Iivt5+r3wM09c46ZQ9Cut
	 sqcOZRTept2jsYgju04bYJkZnXj1QFFSdPG9zBy1r8WAeUEfY7rtCVqSvhr7T9PGp8
	 H0QgpC4X694t2KERLDcuigFzuCtFyWsnl5QmU3E9FbH9YnCo37auYfFrecqhQDtkH/
	 8cD4WANl7ObjBqms9AKBfIosV+HxpZIS6BdtcA8iIkBgFvr/oZIvPMIgFEFqQ9TzzS
	 GQPL77tfzqAzg==
Date: Thu, 12 Oct 2023 16:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Message-ID: <20231012162600.0ba5adcf@kernel.org>
In-Reply-To: <8804726a-cc2d-fcac-093b-8cd34209d662@amd.com>
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
	<8804726a-cc2d-fcac-093b-8cd34209d662@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 22:59:57 +0530 Raju Rangoju wrote:
> Hi Jakub,
> 
> Can you please apply this patch? Let me know if it needs to be resent.

Yes, please resend. And please put in the commit message an explanation
more technically detailed than "The current approach is holding good
for amd-xgbe." :(

Reminder: please don't top post on the ML.

