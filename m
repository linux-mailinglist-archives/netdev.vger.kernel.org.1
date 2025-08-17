Return-Path: <netdev+bounces-214358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B8B29140
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 05:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F328D448227
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 03:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255F52F66;
	Sun, 17 Aug 2025 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mKfCEviY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A318B0F;
	Sun, 17 Aug 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755399696; cv=none; b=G04E+XaucWUgBxBIq9qzbeTNgpVV8MwOrF5LlOSylzsWtIDvlJ6QJCFtVLNriqXqrmkhG84lS9p9wHkE1pLse0y4K+523BUa7hjhIJqTit6kejK53y/wbaU29GKZukiQwqY7F6kk+5fw9i6mY2lIZGHF9I5Owl22Y3NWfV6MiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755399696; c=relaxed/simple;
	bh=HLxTinvOttSX8q8/xS2LuyPknhMr3xKhzJ6UufZR13g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZzHqKjMBQNNc7T0XpXKFMVu9uY3ZJ6Yprrnwzj3mlhOe0Z9CEUteqJC72+pZ5ILTG03GfK51+ChaMwW8DCYEWVKxEID+LNUHHyrukHN3losBkM6Vz83YPHRj6Tr0qJoPw3A6wrf8fcx4ziRBA8hlZYHl4+ShfoRZ+JMbDVDCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mKfCEviY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755399685; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4DlzfdPIMfL8ANWi7xfS6B1tMyCjDhGKokaaSdw7+zY=;
	b=mKfCEviYnXZ2SlO/UpXRfAsWcHeE2NWe7hM6HZaFDQjfERoiB8nFG4U2BHRZ8GEc0mW+XU/QmXySP0/3NJqHaBYGvjOBRXBim1rQwgbyn4OaR6KX2r2o200E9/ube1FrbSpssLRgikOiUwKybjKk1RRrxawcZEyi5Y9tNB84pfA=
Received: from 30.221.32.93(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WlskZH0_1755399683 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Aug 2025 11:01:24 +0800
Message-ID: <6a467d85-b524-4962-a3f4-bb2dab157ed7@linux.alibaba.com>
Date: Sun, 17 Aug 2025 11:01:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
 <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
 <729dee1e-3c8c-40c5-b705-01691e3d85d7@lunn.ch>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <729dee1e-3c8c-40c5-b705-01691e3d85d7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/16 23:37, Andrew Lunn wrote:
>> These sysfs are intended to provide diagnostics and informations.
> 
> Maybe they should be in debugfs if they are just diagnostics? You then
> don't need to document them, because they are not ABI.
> 
> 	Andrew

Hi Andrew,

Thank you for the suggestion.

But these sysfs aren't only for developer debugging, some cloud components
rely on the statistics to assess the health of PTP clocks or to perform
corresponding actions based on the reg values. So I prefer to use the stable
sysfs.

Thanks!

