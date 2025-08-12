Return-Path: <netdev+bounces-212912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA5B227E9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47A51BC4F64
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046326FDB3;
	Tue, 12 Aug 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZsCW8XIR"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AA26D4EB
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003599; cv=none; b=aZNfFMT5onpWRWVa97WSgG6J0y8WLACFRk2xrhvgvYASZ+02mBRhmvjk6OjBnNH2flac5IztmgiXnE99DJtSV441SdvGBGdhQWKU+VZ+DFxWdF3N6nS2BImLVREe1eXwgoGhBc+3ItvGJ7L5BbJLRULilHv7v9Iz5dbA0ZXUJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003599; c=relaxed/simple;
	bh=mCgHARsbpZ7EY554DIC9n1x9vqvKr/9JFz03m7Kkabo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUQ5CF531/4vKBFpd+0+vbIiQC8k/Icl2dZN2+wqQ4p+7VX7WdSN3ONUkJ3L/Ox+NP/I5JbQp3l/Z9MDA9HgXcYjPmHG2JlX/RZXF/CHLm5+IV8hPBFKIs4l6NSgSXHuSHlQSKb7/t+RfQhGfXeeRvovgJt6hTcdEWjirq18fBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZsCW8XIR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3f91ab5-d9da-4ef8-aecc-8d1264b8bf6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755003595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCgHARsbpZ7EY554DIC9n1x9vqvKr/9JFz03m7Kkabo=;
	b=ZsCW8XIRBW7teClXRZ+8EbhGeu4OblIhYW5uHjpFG0sbzgzj2LBa8mlJqqzfsF/4MBtQE5
	N42DaeXIjcneIl/L4AHwKUSbEPYdkagOANGspRGyHBcKR8eqKuibO/VmcenC4T+Dgo0Y4C
	4DszPisWbfot1vHk734PjmS5PQeGvaU=
Date: Tue, 12 Aug 2025 13:59:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] devlink/port: Simplify return checks
To: Parav Pandit <parav@nvidia.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Cc: jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
References: <20250812035106.134529-1-parav@nvidia.com>
 <20250812035106.134529-3-parav@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812035106.134529-3-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/08/2025 04:51, Parav Pandit wrote:
> Drop always returning 0 from the helper routine and simplify
> its callers.


Oh, I see, you split it into 2 patches, but I'm not sure it's actually
needed, because the first patch doesn't look logical on its own...

