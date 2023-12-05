Return-Path: <netdev+bounces-54010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044C805979
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385D71C21024
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D24963DC7;
	Tue,  5 Dec 2023 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMOh+HwG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015CB63DC5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1663C433C7;
	Tue,  5 Dec 2023 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701792350;
	bh=+Bt5QHGEn+NcmUs3Y/cRZWLtedKhM+nUoyWs0FuXtsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nMOh+HwGmpWhom8QIOLR3L45FaRfEUBrv7R6zP7pvTSwBAmBjQxiK6wiA3fWoNUfM
	 Arekj+Y902uHdPXEEy29YayaljcaXU5YluEvkblu9YiLhZ/EauJ/GZi4+THQZPGNXC
	 v2XqVpahFZ6NGuZbNIu92dMyH5gWIoV9+DByYzHUX7RM5/zFNoJlw1lzeXcdv5RuTR
	 XawP5tafKhuBkjgZ6gR+zKMidbQuu3c2IqboM60xF26rL3jhfckuET7QgwUr2WQhEY
	 jNWoFgeUUCvGKHjrh3vjcSEmTlCwHhS9AyMoNcDfvqB5JVlTA2wdybYnTDV2lJFJ8u
	 gkxTX5zV0OTNQ==
Message-ID: <074c0c5c-3336-416e-aad4-dc1b4a442edd@kernel.org>
Date: Tue, 5 Dec 2023 09:05:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 1/2] net-device: reorganize net_device fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231204201232.520025-1-lixiaoyan@google.com>
 <20231204201232.520025-2-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231204201232.520025-2-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/23 1:12 PM, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> ---
>  include/linux/netdevice.h | 117 +++++++++++++++++++++-----------------
>  net/core/dev.c            |  56 ++++++++++++++++++
>  2 files changed, 120 insertions(+), 53 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


