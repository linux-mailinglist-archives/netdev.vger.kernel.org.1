Return-Path: <netdev+bounces-117364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337D94DAE2
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8711F223EC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80243ACB;
	Sat, 10 Aug 2024 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFesfs5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98416415
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267348; cv=none; b=tyT/oF2ASln7J8hAnULOa/rGgaHzTDBleSrXhn8JA55gmOzvVYXEFePGavep6wXUsYE4bmPivT0A5auxBXt1Z87joAXmrAYnVJlpAu5AAHQjRqu+U/M4KB/qzi8Aca/yyM0QvKKB8dTdduu4d0wSUqlHCRohUnsGDFj6TixCcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267348; c=relaxed/simple;
	bh=gVlFn/5Ur0tPWqoRpYcbHEVRxg48ToaQy1s45Bsthjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO73QRVqu16SAkAEIvT9LBdWJti/gs7nNJsX4Bn3P4JDHGsGaTc4eiTVQxUTNEyl75mzJuU4nL/OmSgYUniazgvR27+BRGlF7P1TNtCi/Os31B588yDby+v+YiyWGactmofRH2AKLz2iPTQLUlzGBs32l2forueUKYQD9IuOhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFesfs5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D16C32781;
	Sat, 10 Aug 2024 05:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267347;
	bh=gVlFn/5Ur0tPWqoRpYcbHEVRxg48ToaQy1s45Bsthjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFesfs5/sxqiuPY39ezgsvBCSpKRhm5eGQjaYA4PhWY3yQB3sSAQXWsz8EitxhYdN
	 wvkh0nJ6q943WY0D66nY/Q5I6t+bgJOleF0idwdG9AjNt4Hnhxy4Y14d9OcnONgwGd
	 VuFASL81XVKbMSsUVh0Mb04QU1eSYeTp4IP5rGVHdcgvwE0H+gEUvsDitQzaVekC4+
	 zxF2Tj1p8fKiF1J4AS3OAehYPq11HQA06dOf0Njz0Hfetho/QB9hnZZcoEupo+pffi
	 v0rNtxEj2IuLSIe5U6EJhyNKhUp8hJlc0rHHUp9BI4kpSIyoIGngeXLbIpkNsTzeZg
	 bUPlYH8y1JBpA==
Date: Fri, 9 Aug 2024 22:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, jfraker@google.com, Ziwei Xiao
 <ziweixiao@google.com>
Subject: Re: [PATCH net-next v2 0/2] gve: Add RSS config support
Message-ID: <20240809222226.42673806@kernel.org>
In-Reply-To: <20240808205530.726871-1-pkaligineedi@google.com>
References: <20240808205530.726871-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 13:55:28 -0700 Praveen Kaligineedi wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> These two patches are used to add RSS config support in GVE driver
> between the device and ethtool.

Code looks good, thanks!

Unfortunately the series didn't get into patchwork.
Could you repost?

