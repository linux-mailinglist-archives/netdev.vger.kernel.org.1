Return-Path: <netdev+bounces-67676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036A84488B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE832863C3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C43F8F9;
	Wed, 31 Jan 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="h24/bpPo"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E583FE42
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732088; cv=none; b=uJEd3kGjnDK0XMWDloCk8gP0N8Kn8NGk3g7bv7eu5sTj8SRNe7FvPhU5RGJfhUsmSOuWUs4inWWssgB3mpc6/J59oRgDzHDzcUeBGWyHcT55DmnElsyUx/Qxj2+/EAyErlyQjBslRnG7EKDfqPoHFnlGYBYj0k+Lj5SCWZO51Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732088; c=relaxed/simple;
	bh=7jweyZLOFtDNaOEFbSJj0RmPqBh6QAZpJTvRl/xgquA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hixi7URSaJn9NyFybLjpXcMTWVyWHBzN2X1LhFq4Aslvc1sgG3HJqyW2T2/oU0pyp4aEfIFo4ZwleP6Vlp8emj1rM4D4elRwt6KHL//ajxoOy3jyJloKoqa3LuiAf9PekBO6jRs0h9BDbTBVrrdQcEVEvU6VrDJDnnnkamNc2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=h24/bpPo; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dwDz4HR0XwvcxaOVLvd19SVlw6LzAoobZQGHX8bezEM=; b=h24/bpPod0+W+OTi6mJjJY3g68
	MGIxMTd+IVV05h1V0yLrRbDw4lPYIId5FQZ+6RWncUuAupldUo1iBXqn10HXUuzpQZTVgn06kyl7L
	3CiYkNtIbxoq2re7RxfK2mpP0gnjo+JC1Pjqnnid0y8/vq0Hx1y1FsAoK2MZFvrHolk8=;
Received: from [88.117.59.234] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rVG3J-0001Gh-1u;
	Wed, 31 Jan 2024 20:15:17 +0100
Message-ID: <b113bbb6-6e17-4aa8-b922-aaf6056d142a@engleder-embedded.com>
Date: Wed, 31 Jan 2024 20:15:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Report on abnormal behavior of "page_pool" API
To: Justin Lai <justinlai0215@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 31.01.24 08:31, Justin Lai wrote:
> To whom it may concern,
> 
> I hope this email finds you well. I am writing to report a behavior
> which seems to be abnormal.
> 
> When I remove the module, I call page_pool_destroy() to release the
> page_pool, but this message appears, page_pool_release_retry() stalled
> pool shutdown 1024 inflight 120 sec.

I had a problem with the same message:
https://lore.kernel.org/netdev/20230311213709.42625-1-gerhard@engleder-embedded.com/

Could it be the same problem?

Gerhard

