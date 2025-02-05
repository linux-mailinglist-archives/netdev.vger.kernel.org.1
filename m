Return-Path: <netdev+bounces-162939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E7A288AA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557B6188245D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F761519B3;
	Wed,  5 Feb 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9Ve/1LX"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F041519B0
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752493; cv=none; b=qjs8xqHRItDBavMM3YV49T5M9+b1/rpHjx8wiZ3NMVXSyWyV4oR9zMOntpon2lqQEZDUH766eYbC3qQ7wgOPc+pekRUbqf58GEhKYDzbzav7KTPfONROACrjQHGxUPUikzXpHuIqQhuLyW32ZSkPaCIMJRl+wM1z67itJ9fiU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752493; c=relaxed/simple;
	bh=8jwkEvDuMrp66gminBuoovOR8JxBAtbu3NSr1JnESD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5hB5qbsP6i4GzZ048We6EDFptQPqVxQYGEYXrSmYg5w0q708xbgHi+GkQE1/oi+Umz/PTHriPLVcCLhRm6MKJNPJyWSZ7werTGBxt5WvBUgtB619f9bcoq1kZjt3VdgdFVU9T6whnLP9z25Y83hdfiW3QYu80htgqV8+ZZOkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9Ve/1LX; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ca4e13a-c260-40dc-b403-5cc73e664e02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738752484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2S2f2xfhfxaFlxlemPFesq4hdYTFlW2kbj1NfekJK0=;
	b=I9Ve/1LX2m7T7qcvqQ0GQKrJOEmyRS8RIqyUvlTo8MKiIuoO344jAiv0VsfBKRl2V5NfcG
	HiADi7DdsQzT6yuaEUDQWWDEifB++lhGOcmN98jJf2sRkkmhlOlQQHCT6QEk/VBIefM0An
	+baxhYh/nlZc9DqZEeUDzZWHmoGEGM0=
Date: Wed, 5 Feb 2025 10:48:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
To: Jakub Kicinski <kuba@kernel.org>, Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, matt@traverse.com.au,
 daniel.zahka@gmail.com, amcohen@nvidia.com, nbu-mlxsw@exchange.nvidia.com
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183427.1b261882@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250204183427.1b261882@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/02/2025 02:34, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 15:39:51 +0200 Danielle Ratson wrote:
>> +#define YESNO(x) (((x) != 0) ? "Yes" : "No")
>> +#define ONOFF(x) (((x) != 0) ? "On" : "Off")
> 
> Are these needed ? It appears we have them defined twice after this
> series:
> 
> $ git grep 'define YES'
> cmis.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")
> module-common.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")

Are we strict on capital first letter here? If not then maybe
try to use str_yes_no() and remove this definition completely?

