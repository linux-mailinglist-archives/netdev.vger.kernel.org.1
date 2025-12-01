Return-Path: <netdev+bounces-243085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82528C995F1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183AF3A1803
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220AF285045;
	Mon,  1 Dec 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M215DCpK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF825F988;
	Mon,  1 Dec 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627541; cv=none; b=RBtBSrPRsR8p1TlJBjbFmpbKYTjIJQ+8de0YUmOICLAThyPBw4yYHrsC/iuOoYG2O+7Gw18apYWM0zRaZq7DLQ+0A7mLgwRrLBh/M2Vk8N8xvJqN6UZCbX8XUiPALxG6gpX5wYAtVtHxoRpnzV0vBBN+UUK1cxp1hMqF8HRkTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627541; c=relaxed/simple;
	bh=PgXcgcE2lF6g6YJrSfSVJEMuvaWiG9HS0TNC17TC0zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOkNeEm8hufMdP6X2am88dCLqNOpVbGXGqKSFrnRPM17+R+7EC2jI/WYj7AJdECGB9QMFIr1iMeCUwpHWi1UQIWey/mA4xurM8BJXHhGCkAQpvovfd3FeFifojHzU61n2UoLMMsqHOJk4DpwhQZfafeyep3XIqorIenMRhE55BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M215DCpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF9C4CEF1;
	Mon,  1 Dec 2025 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627540;
	bh=PgXcgcE2lF6g6YJrSfSVJEMuvaWiG9HS0TNC17TC0zA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M215DCpKNJCmIezV6ltkdyFYb0o9BQz6c4JhASXZpEcI7Ck2yqRsQ4J30PbZ74FJg
	 wAOev55ptHtk7z1uJTB/AxIu68T5wogp4DALebiyeAUGxUOXY/4ugmnWOjXMvh9t+m
	 owQfAO0RtKO87c/ZRCluzgTSgqvUAHlwsdrVsottFtqZeV3kkVczX7W5IxZn2soCHT
	 DcayC0zhPJsWDAYHJis/m/sOmgI/zJLdJ63nxR0KKHhRaRjv2tgNos15z80NNIE2yd
	 WaJBU8ocVZi4/3ZT2QHc6xvjr8qy6FPqiO6IQs384eCGXNKuhB8cLKuAJ4RBfxDzre
	 zQYPJgW7Zk45A==
Date: Mon, 1 Dec 2025 14:18:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, basharath@couthit.com, afd@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
Subject: Re: [PATCH net-next v8 1/3] net: ti: icssm-prueth: Add helper
 functions to configure and maintain FDB
Message-ID: <20251201141858.399fff62@kernel.org>
In-Reply-To: <20251126163056.2697668-2-parvathi@couthit.com>
References: <20251126163056.2697668-1-parvathi@couthit.com>
	<20251126163056.2697668-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 21:57:12 +0530 Parvathi Pudi wrote:
> +	u8 hash_val, mac_tbl_idx;

Using narrow types is generally quite counter productive.
It can easily mask out-of-range accesses and subtle errors,
given that max is outside of the range of the u8 type:

+#define FDB_INDEX_TBL_MAX_ENTRIES     256
+#define FDB_MAC_TBL_MAX_ENTRIES       256

You should consider changing all the local variables to unsigned int.

