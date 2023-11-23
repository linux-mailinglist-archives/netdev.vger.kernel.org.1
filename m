Return-Path: <netdev+bounces-50366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42D7F5755
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5A51C20BE7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F677B660;
	Thu, 23 Nov 2023 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob/WMaSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266BB658
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50803C433C7;
	Thu, 23 Nov 2023 04:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700712659;
	bh=vEGs5HAbjF1IAM1gT6KyCx139kNtp9F8hRI7yxkVjjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ob/WMaSz5Puzesg6kIs0WCLO0Ey5+KAdsoLiBDcp/oMg2ahAG2r/ibJLtOD+W6iJn
	 n279jAkbaKCxO5BeXXxQQoabBZg652kQ0j4V73Oouz36u2S9z95o5EpwRHKuh22gOQ
	 F5ItVw5kQEhfxeDVdsI1aDUsSp4x1kurKleSiJt1vKL0gcK1tjyBm/KzEwX4/SlxQQ
	 NU0aKWXCX0iZj04V+SLPfREzoJj5FEs7Nb4fQo8mJK9+NUq7hevNJBNpwvdJhZ2bfF
	 hPPBHqNAA84FNqbubT3znkYm6kD5VpoYgU0vToxP11vB05s80+kJ71L5WvpGJNdkXu
	 /HvGmk+0tNhUw==
Date: Wed, 22 Nov 2023 20:10:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, reibax@gmail.com, davem@davemloft.net,
 rrameshbabu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maheshb@google.com
Subject: Re: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Message-ID: <20231122201058.0bfb07a9@kernel.org>
In-Reply-To: <20231122074352.473943-1-maimon.sagi@gmail.com>
References: <20231122074352.473943-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 09:43:52 +0200 Sagi Maimon wrote:
>         Some user space applications need to read some clocks.
>         Each read requires moving from user space to kernel space.
>         This asymmetry causes the measured offset to have a significant error.

Please CC maheshb@google.com on v2, he was doing something similar
recently.

