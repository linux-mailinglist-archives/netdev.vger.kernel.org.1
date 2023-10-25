Return-Path: <netdev+bounces-44055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A77D5F48
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53E1B210B6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C631369;
	Wed, 25 Oct 2023 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISkHD1to"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEC17C5;
	Wed, 25 Oct 2023 00:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE064C433C8;
	Wed, 25 Oct 2023 00:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698195296;
	bh=gyWNIVwIaH6wCQaWAE7rM3Lgkj2v5EQMeUHnQd4CqK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ISkHD1to/eJaX0HXGarugvgAkWWpk6jyNjxcai5CHykKR5vI5SOxg7m0TSp/NYkSd
	 kdzBwGfjBf134yXDxjPZ9xcOxE7l+ug9vswSlIlwDV4oW0xAr0LpUHh/vnDEFy5zos
	 ysS6bBQ/DlYvSL6icfVBUIBexo5S2eV+Tm59QdYozhPFTjn+y56Zaorz4XoIu6dWAZ
	 cnppntX93KZGYYP9NuC+HWqmRSZvAk3g0eijlFajjMPp3Lr3g6Fhh3ASY9uKcRcRgr
	 0tydkD8drFfpw+apw46M2BYZf8CI9cbP2X+t4WYYof+9qMOHDwVZahnP2E8CPQiHk8
	 4dsP+HTRtNSGQ==
Date: Tue, 24 Oct 2023 17:54:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 1/9] mptcp: add a new sysctl for make after
 break timeout
Message-ID: <20231024175454.11b3305b@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-1-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
	<20231023-send-net-next-20231023-2-v1-1-9dc60939d371@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 13:44:34 -0700 Mat Martineau wrote:
> +		.procname = "close_timeout",
> +		.maxlen = sizeof(unsigned int),
> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_jiffies,

Silly question - proc_dointvec_jiffies() works fine for unsigned types?

