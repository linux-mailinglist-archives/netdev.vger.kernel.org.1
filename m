Return-Path: <netdev+bounces-206871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F34B04A85
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754AF7B4299
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5436277CA3;
	Mon, 14 Jul 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqNh1ypl"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA61DF985
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531746; cv=none; b=O56SJ5lwr+qWihnw3sGkS4UVe6B5u3gH4e/1wG0rFgVPwRVksOzdK5KEqLp/J1/pio1I147GOug/Gh+bItq/8Qn8bckfCbYVJGxPOzFDURoXWjPGTXsXgOt2JR24x9q//yF0DaJrOMljKWa3hbtB0EtUW3nYmxnoyNQwkpO6/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531746; c=relaxed/simple;
	bh=J+3MplNBNA+2GkhjKcOb6MG/4EgCaMYmsk0PSBQ/bUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Clcbji1poAxdbJzhq8aZ+L7PZpT67Kyepq5Ox1tWgwemkJKNN1dhoy7SsYOo96NzkA/nT2XR3C5WfOIp3ThiNvkkYbWb8FZFJ3Vg7P87J/I/xwomjBJEhvmXc5QvRRHs3sSTOZFDRyHfMq7cTqXVqzQBpJh1BywEz+O4ZR3+MVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqNh1ypl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47134f9d-c152-45eb-999d-b36ce64a4015@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752531742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQaPc8u550r+YBp3rJQU0hamMDKkPkiTPc/f80CY6Ic=;
	b=UqNh1ypl/BdBcl+mhA9wVKoDt/PLCle2Dp13RkZKOw8jA++/SXUo6IYXs2KCw7npKywBAq
	BPHS6gfh1RSmRKG0Kb8Xk6euIY4iJ/L5b/a6cv8Z4BK0Mz1ZwQtlenSOOncROtXYnqCUWR
	76LaLG2ezEhOgl+2v45B9E+ROc8Incw=
Date: Mon, 14 Jul 2025 23:22:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt: move bnxt_hsi.h to
 include/linux/bnxt/hsi.h
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>, netdev@vger.kernel.org
Cc: vikas.gupta@broadcom.com, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>
References: <20250714170202.39688-1-gospo@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250714170202.39688-1-gospo@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14.07.2025 18:02, Andy Gospodarek wrote:
> This moves bnxt_hsi.h contents to a common location so it can be
> properly referenced by bnxt_en, bnxt_re, and bnge.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---

LGTM, I was actually asking about it in the review for bnge.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



