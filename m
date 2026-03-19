Return-Path: <netdev+bounces-269593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHVxIhY7vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6802D0856
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B0330131E6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B05396B96;
	Thu, 19 Mar 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=i2labs.ca header.i=@i2labs.ca header.b="mHEZt6EG"
X-Original-To: netdev@vger.kernel.org
Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B639447C
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942904; cv=none; b=jPLhbuGqPh2XnxHkyByuCbACiMlhruAOetmGd/ZGMDm3lDm8rnZMJ1U/qX61SQsamUrCkNA4l38eT//9pjc/gAG+rbXgbkRvFbe6rnDzPGwEUiT+zkND2de3vVxPCQ0qNSCFrktersPILvf1y+Uxm97JX9lfK8w0Xv1bXQy45G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942904; c=relaxed/simple;
	bh=cfVoYIitZHte75pCalAJPyi3bNyNpJXZTP7NUsP18jI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IwS33jzxOCih+49CZlvT9reHSKT1dJ9TIbo2KF1vsx4rmn/vHazQGXy82Aozxqkn2UmowNPBVIoJstv3X1d6jrAlho8yV5El9nc+C1BzvWePpVrjaKGty3EL8Z664yBcL3D22/GiXrAlyryFUtfk0xi94gI/EjYBPEk4RYKG1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca; spf=pass smtp.mailfrom=i2labs.ca; dkim=pass (2048-bit key) header.d=i2labs.ca header.i=@i2labs.ca header.b=mHEZt6EG; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=i2labs.ca
Received: from [10.0.0.136] (unknown [14.179.148.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4fcCn85HVSz8sWQ
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=i2labs.ca;
	s=spacemail; t=1773942413;
	bh=CNne2cEWWRt2To1i/YA4zmoi4I8eb4+3j9s+sDdf0iM=;
	h=Date:To:From:Subject:From;
	b=mHEZt6EGMRHkFs4WO8nYQJIdpkTEN1FIkayxL77O7+G5Ieb3AOrbmYYhsQTUvUffI
	 JHr2wGnW2buolhibzYsdUsTgB/bPyI9Uh6YmfRBaCa5olWDdJTu5RZHfwaWCSppxUS
	 k/pBg6tIZimrg2UqxBNuLbMbd11eIvvuttrLU00E6Mk3IoDZIC9hFd2S/vzFpLbJYZ
	 Zcm18PdXEcfC31PQwdkqpgDULlDpxdL/Ze9NrP1gbQAsKE8YVQve7eECu+XHPdc6Tc
	 uTENP5BCLt3HvycXBg9LmijDTyo/SEgEqYuwDP9KOysi/OzQa5RpyoxW6+LDPypWq0
	 c5kHcU5+bdM0g==
Message-ID: <350cea13-9bf1-4605-82c9-b85114fc88fd@i2labs.ca>
Date: Fri, 20 Mar 2026 00:46:47 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Nolan Woods <nolan@i2labs.ca>
Subject: net: disable default loopback
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Envelope-From: nolan@i2labs.ca
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[i2labs.ca:s=spacemail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[i2labs.ca];
	DKIM_TRACE(0.00)[i2labs.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nolan@i2labs.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i2labs.ca:dkim,i2labs.ca:mid]
X-Rspamd-Queue-Id: AE6802D0856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,
I am building a highly constrained Linux environment where I want to 
remove any possibility of a process communicating with other local 
processes via the network stack. It appears that the kernel 
automatically creates the loopback device and I can't locate any 
configuration that might disable it. I need to be able to create 
loopbacks in namespaces, disabling the network stack entirely isn't an 
option. I also do not want to depend on NetFilter or any sort of packet 
rules. I can disable the link after it is created, but that approach 
still has the potential of the link being brought back up. SELinux might 
be an option but is just another form of filtering rules. Ideally the 
process wouldn't even have the option to bind to the interface.

I found this comment that implies that there might be some sort of 
unbreakable implicit network stack dependency on the loopback: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/core/dev.c#n13266

Can anyone elaborate on this?

I would greatly appreciate the input anyone could provide.

Thank you for your time,
Nolan Woods



