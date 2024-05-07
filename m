Return-Path: <netdev+bounces-93954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1518BDB7E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CE1B21F00
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91802EB08;
	Tue,  7 May 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="spq6YbMk"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D088830
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063503; cv=none; b=g/HZNAU4U/fQ/q68yamn/MZY1XYW8fhIOc5UJpkUp/01Y+MzVFs8f1qd43Up2oLiaAufC9XWHwWmuEGJcPfui4DvffDZj4p8jJLyFtq9joQXvFlizAEK0o3uq93ztD+1OOz9iUYPVhqFyPNBGTW3T0ByPICUq5hA1JSVq/HnfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063503; c=relaxed/simple;
	bh=sjkkmkkTcDnmKTw0Xiorjtb5+WjFwT0t/cK486d6h00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb+0jeOFKOvD6BtxoQaXuytjCzrksgAi07RvAG1AcXjkRSs+fHhI2lCDvBm0w1AUAqZl66b/2hFLj6h6iLiUknCXPjJATKpE1xUv0XW67tnYlcyf0aALOiMG619tO32WsRnlFjoZD4DyKoXvmUvvk64tEfgTtm+9Z4OTPcxzBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=spq6YbMk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ayw4KnU1RnMVA8OqMIL8IKsVc4a0EF01H4cTWTYWOPg=;
	t=1715063500; x=1715495500; b=spq6YbMkwuMbcH/4fUut9rGuMmIaSqqtF2BkDbvXpAWLnZY
	TOT4lmi0ktWEO3o0CjPiW1FLri4AllzC8ER8mjwfQSLZRIf77yoSAD0Uu6+bVTx5Q4yXzpn0QPONZ
	w0+uuKGzaAtsUCUKdYLq0w1MU0gxF188VnZA6sieGnv7FQSOVCy4qQztsv+Er5TExISGc9wHmBv8v
	iFrqc/i7R+xd/DXf3SH5HPQC5s8EQKnm/wmqfUhAc5SrV7VV1KE0+iVJTbeOOgGRKW/DxLzP9Lsxr
	BnTQeW5ZaBUE86n+WVOtI1SYO2ocWRiaRNprNB8PGnzq7VYb9ztokvge9mmyNKjg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4EMR-00019z-6F; Tue, 07 May 2024 08:31:35 +0200
Message-ID: <bc14863a-41f0-47d2-ab95-ed82eff5f5d7@leemhuis.info>
Date: Tue, 7 May 2024 08:31:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] Non-functional ixgbe driver between Intel X553
 chipset and Cisco switch via kernel >=6.1 under Debian
To: Jacob Keller <jacob.e.keller@intel.com>, kernel.org-fo5k2w@ycharbi.fr,
 Jeff Daly <jeffd@silicom-usa.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <cbe874db-9ac9-42b8-afa0-88ea910e1e99@intel.com>
 <e16d08bf-49f6-4c51-85fa-7c368d1887b4@ycharbi.fr>
 <4a0bf7cf-d108-49ac-ac7c-6136a070c44b@intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4a0bf7cf-d108-49ac-ac7c-6136a070c44b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715063500;3d487244;
X-HE-SMSGID: 1s4EMR-00019z-6F

On 06.05.24 23:18, Jacob Keller wrote:
> On 5/4/2024 6:29 AM, kernel.org-fo5k2w@ycharbi.fr wrote:
>>  > Ideally, if you could use git bisect on the setup that could
>>  > efficiently locate what regressed the behavior.
>> I really want to, but I have no idea how to go about it. Can you write 
>> me the command lines to satisfy your request?
> The steps would require that you build the kernel manually. I can
> outline the steps i would take here

TWIMC, there is a document on bisection in the kernel now, see
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst or
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Ciao, Thorsten

