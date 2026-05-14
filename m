Return-Path: <netdev+bounces-287979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G8POV3WBWrxbwIAu9opvQ
	(envelope-from <netdev+bounces-287979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:04:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD64542BA0
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B97303C61B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B403FA5F9;
	Thu, 14 May 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fC5C99+/"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABF3FADF9
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767404; cv=none; b=hVVfYzfx3WpglxsLt/SReYwluXHXM50W3irp+FiB7xth/cm3o8dfjdB0RPDwzzyMtdxj68Kb3BabvEm1RDq4jvB0zXt7LzVLChwz2tXDlmvm/LpbF7S7lvtNtI4E2NwwMoT9dMC9N/YdgGEK3ro912YqfLx1jj89BrJaJayq1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767404; c=relaxed/simple;
	bh=neIZnNUmn4ygpujeMBN0+qXsVjrMF/r/Yz7ENJiopCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcXWMsIzy9ZlW4hwhd4JNY9+t7GL2dmQF7A4cV0TKOUq8ENNt649LqPKq2NlF9Rr5dSuJfwCrCnuhU0XQfmuyArX46hjE2f2jaXbb/3TJvJwSifFuq5eJRENb/Szng10/ZlKG61b5CxfI1snZ55tqt5pvK9KcTd052cT1b1jHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fC5C99+/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65a3d091-0648-4c6c-8062-869d0fcec8dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778767398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IJ/JWVLzpiu9gzA7/jZVal2HN1ffjU/2BFPwULtf6Q=;
	b=fC5C99+/lEsjgdcYVU5Pj2kZ5xuSknR9Q9y32vdIMBdv2YMV0bRPmWOLbilGWkgUp2a5rU
	OkRVLMqsECZnFxvsc+BlUwoq4WZdysqNPVpz4N5CUfgOilZMD2BdFnQTzgVbrGJAfgEJnX
	N8/xz+/KPA0V1caqR3b6AKTwfOXwBxA=
Date: Thu, 14 May 2026 15:03:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] pps: make number of PPS devices configurable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
 <20260514065526.2ed937dc@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260514065526.2ed937dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2BD64542BA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-287979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 14/05/2026 14:55, Jakub Kicinski wrote:
> On Thu, 14 May 2026 11:26:14 +0000 Vadim Fedorenko wrote:
>> Modern systems may have more than 16 PPS sources and current hard-coded
>> limit breaks registration of some devices. Make the limit configurable
>> via Kconfig, keep default value of 16 devices. UAPI has to be changed to
>> support maximum possible number.
> 
> Hm, since this is effectively just sizing an IDR maybe we should just
> bump it to 64? It appears to cost nothing if not used.

Just bump to 64, but keep it constant? In this case maybe 256 just to
align with the max minor value for chardev (in compat mode)?

