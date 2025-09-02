Return-Path: <netdev+bounces-219028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF568B3F6CF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6411A83CB7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9ED2E613C;
	Tue,  2 Sep 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3UoKuHI"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64A2E2F05
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798902; cv=none; b=TZCNO4RDglvWob2iAvsakQ1sSkN5TtETRldfNYeItEdLyEF5/CVt9LhZYpCs8BbiugOx9wdqTiMMPyLTuQrRZBSDoOeUAk+bjzA4EGDeZFoR//zkWgHH63dhmKWLOTYK5t67GBUOCQNw4RrC0t1nnoNI+rVbynQch/tImUSxNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798902; c=relaxed/simple;
	bh=QIK209W21FlyFntgm+zs6uQT9kcebOLcZlrG1QTxl1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrX/skfSsyvvedX49J7tsPbiGb6rh7V+0eQwZ9uN2OSYTbkeKHC9eK6KXB9VNcFIc31Ch1yIBq1omHeTFc6aSbSPktS4rF3VHC8wYlGniI1wqzCKfmH3e8VuIiBEEoreYzsSnhxp2+8qoXi36QK25lYPyjj4voU5P8t25GOvfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3UoKuHI; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <195a39b6-e4e6-48b0-bb47-3c86d8be20fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756798897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeU3paiQ9HhrqVYRKq8jOEDqZ9NfHngwUbp9m30YdWo=;
	b=q3UoKuHI6ukCKweGSo4WX/fL2NwxsGF2knvkeWskJUIHacuCDJL7uQQJOXeRMc4BHADlMz
	tSTTwdJ3r0MkXZSzgcpihM1CVtctB4FKpu83Jxg0yqxZ76owrtESOeeGdeB4sbeXMeRkCp
	99jB3zagFkLf9Gl+8CevvDdXfA724iU=
Date: Tue, 2 Sep 2025 08:41:23 +0100
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

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

