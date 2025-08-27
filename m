Return-Path: <netdev+bounces-217110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240CB37631
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D87AB666
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743719A288;
	Wed, 27 Aug 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqII1PjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9C30CD93;
	Wed, 27 Aug 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255565; cv=none; b=GRun8sL8SCab8AgZKWR4X2wOCF953lv4ZRwgD9BIrMd2/IzRUH0vSA565r+icN+KcjYetiN5i2WIHyT2VGFPuvgj/xJL5c1SxgujF/q8OiF5/CPLb4VmNjBPyNcmGL0rYfaDVJmLh+GfOqFrUuYUx3WQaKuOmR+0F3WXH9ojAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255565; c=relaxed/simple;
	bh=gXzyGGMGuuqC8RiKBvHqCeM3fcJnAsqd+qzqkEmdzGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdsAVZhD7hnTC+c4Y7AyShl8dCrUIO0e3u51CoZm9u3ak1M2OafEPz6iYYLm8YM369U97f05kkuijeXKnXzbujXdMtry3NPV/Q8ChjU4Bmf++LZr/+n/IvY0iMS/eG0iqc7t4shQNF2P9dHa/9nE8XHWX989zqfhcsZXt0BQhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqII1PjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E958C4CEF1;
	Wed, 27 Aug 2025 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255565;
	bh=gXzyGGMGuuqC8RiKBvHqCeM3fcJnAsqd+qzqkEmdzGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qqII1PjP5mx56n8aF3z9wHiIq1WOjHErZkab7vXLzzu/lzc9HrtEvQ8wxOXNxzoof
	 xKRpXMII4p2VQfjv7U3p4ecU7Kf2imHWdmVdNiI1Eu/mT5pyJsqnxG3dYW+mkcylM8
	 FCO2kZScbC6pe2+NXt4kgx5yMmg5o3iCsRHHf0UJMkS8gubACKjs8XoQxcBNG78wSN
	 l9gJ2YctTirPbdzmRfunDA83b9azFQAr7jZf78pJb2TV4P6zyfX0upxKqdaNthNR1X
	 o+anfFGEoWmQ3y6+aVf9KtcD2yiR2ZPKo+OLciLAiczu+QnU5ZlO0prhOSVY4hSr1k
	 gY1qNT/78aT8Q==
Date: Tue, 26 Aug 2025 17:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <zhang.enpei@zte.com.cn>
Cc: <chessman@tux.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ethernet: tlan: Convert to use jiffies macro
Message-ID: <20250826174604.320a63bd@kernel.org>
In-Reply-To: <20250825184102534B6FAD5gv_p5nAHbiIyFqx@zte.com.cn>
References: <20250825184102534B6FAD5gv_p5nAHbiIyFqx@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 18:41:02 +0800 (CST) zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use time_after_eq macro instead of using jiffies directly to handle
> wraparound.

Patch does not apply, looks like your email client or sever converted
tabs to spaces.
-- 
pw-bot: cr

