Return-Path: <netdev+bounces-219095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260DB3FC93
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03067203631
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3892820B9;
	Tue,  2 Sep 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEhXgNd/"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492836FC5
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809248; cv=none; b=Ky3mBablpBSd/Ay5qMUM8x4BP14RfgXBpIV74yYauLPmnwIgSjYSFXCDjHwGpvwgU3d76Ca/ygf+hBA8dKGbFphGPIcyf3hpDyMZbGR1eAJg5dUBTJmRh0sIqBuQVmjx1WIlGoj+gwYBr1cpqlUQVhXkB7IHlBTHGor6KOMTFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809248; c=relaxed/simple;
	bh=RiIQMyTtZtlLSv652vXkmVhDFhCvj54CnNuvyOi4keU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlwvzNOd/3F55k6WeoyvcWBZospVpG8aZj+5psDEkO4NaaXpMntS59JT/PlyfxmZ7UV/y30LQdmyMXci/KINOjwREaRndxmznni4QIAGLk6yLhhEGfBg8Xa+taC0Mu9A/XjA3WgMvCho+sy8KMZBul07pIsuKiBrpaI+bL4Nnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEhXgNd/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7005c02-63dc-4316-905c-e02283e398c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756809243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5dadqOPXnawLXbOXYYjUzwsybHxfQkh6+VqxS9pnBQ=;
	b=TEhXgNd/20zf4/RnqZqmSxfPjz8bsRHnAEQXdruje2qZhpH25fL0rRpMc/fFHJYhqTyWIo
	9HJxvGQrJrOQxv+BkJlIUGpwCI09VVa5t/RgAIH1Uyon/zcxRe0zChuBIroTerhE6o2WZx
	OEB05JZua5lQdVYhOdImktPN5ljIBlU=
Date: Tue, 2 Sep 2025 11:34:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: intel: fm10k: Fix parameter idx set but not used
To: Brahmajit Das <listout@listout.xyz>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com
References: <e13abc99-fb35-4bc4-b110-9ddfa8cdb442@linux.dev>
 <20250902072422.603237-1-listout@listout.xyz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250902072422.603237-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2025 08:24, Brahmajit Das wrote:
> Variable idx is set in the loop, but is never used resulting in dead
> code. Building with GCC 16, which enables
> -Werror=unused-but-set-parameter= by default results in build error.
> This patch removes the idx parameter, since all the callers of the
> fm10k_unbind_hw_stats_q as 0 as idx anyways.
> 
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
> changes in v2:
> 	- Removed the idx parameter, since all callers of
> 	fm10k_unbind_hw_stats_q passes idx as 0 anyways.
Just a reminder that you shouldn't send another version of the patch
as a reply to the previous version. And you have to wait for at least
24h before sending next version to let other reviewers look at the code.
Current submission looks OK in patchwork, so no action is needed from
you right now.

Thanks,
Vadim

