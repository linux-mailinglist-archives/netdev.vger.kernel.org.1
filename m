Return-Path: <netdev+bounces-293003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6jQVIFg0GWqdswgAu9opvQ
	(envelope-from <netdev+bounces-293003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:38:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA85FE084
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C153E3045B10
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DC38D401;
	Fri, 29 May 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wxEtT06n"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AA35203F
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036692; cv=none; b=SPDO4lVTk9Tn+fbThoRIuhAGTVqp3FPjitgdCPFPZxgK/3F/q8qy713hQT5LGs2tl3G9XZlzW0PUoLxALt7x0NfXgL1/SReE4ZlD6ei2254CfDDCHyTRgvqT+zuWzhdz6pU3EGbxtMtSHWYdew2ByteWUxyOXezRtpYrHwzrKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036692; c=relaxed/simple;
	bh=FMYZmmy9pl+CSUYKIaShkCf9kGNJLBVF7/zOSqnKhgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks7ZCua2Eou0s13rGxcEnMwNfPJ0CSHHY70+KdRK7Xkr5s7hq3oPoEtqnVWdD7CFj+dPi4ZHEAUkPiIJ4SwVIeQUqQwepqL3XmEM2ek51scdL1xhWoE27C0tOWmOeWtbt3bRbkWWuyl9sX3u8XdDrRTfltv6GsFwfblw676oZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wxEtT06n; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <689d4e81-583e-446c-b18a-3aec328ac395@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780036688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoHjEWpkgdCVH/F4rqUpD7QCu1M+M6ibQLfZ6/htMgc=;
	b=wxEtT06nJKjYPeqjkaDjDoqV2FIXIOvdvGzlocmULWBLX1N0bxbf6Un7VMpw4x1YorZvA3
	j5vWfhiJ/cDmJwIPNSvfvf/GhbI1BUQkSJxmpYA5CRw3XD/BnLpG4dIVM8/+fMceU6iMZb
	/AHswFm+aT8RrdK7EsTSHSr9F7wxJSU=
Date: Fri, 29 May 2026 14:37:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Unidentified Fragnesia Variant with Public PoC
To: Wade Sparks <wsparks@vulncheck.com>, netdev@vger.kernel.org
Cc: Disclosures <disclosure@vulncheck.com>
References: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,ubuntu.com:url]
X-Rspamd-Queue-Id: 26AA85FE084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 11:12 PM, Wade Sparks wrote:
> Hello netdev team,
> (cc: security@kernel.org)
>
> The VulnCheck Research team recently discovered and successfully 
> reproduced a *public* proof of concept 
> <https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc> (PoC) 
> published by V12 Security that targets an unidentified variant of 
> CVE-2026-46300, referred to as Fragnesia.
>
> The original Fragnesia patch only addressed the coalesce path, leaving 
> the segmentation path independently exploitable. We confirmed the PoC 
> works on the latest Ubuntu kernel release 
> <https://ubuntu.com/about/release-cycle> as of 2026-05-27 (we are in 
> the process of re-testing against v7.0.10 of the kernel.org release 
> <https://kernel.org/>). The variant is distinct enough to warrant its 
> own patch, as it operates in a different function with a different 
> trigger path that survives the existing fix.
>
> If there is an existing patch that apparently has not made it's way to 
> Ubuntu distributions, we'd greatly appreciate if you could flag so 
> that we may initiate the CVE assignment process with kernel.org 
> <http://kernel.org> CNA.


Maybe this commit 48f6a5356a33 fixed the variant you mentioned above ?


