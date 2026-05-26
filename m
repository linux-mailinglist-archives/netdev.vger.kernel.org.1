Return-Path: <netdev+bounces-291742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNidB5+6FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C95D898C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B68B3058602
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406653D47D9;
	Tue, 26 May 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="TtRBRQcU"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429703D5648
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808283; cv=pass; b=Tt9Lxwn+bCIq35iahXPoWcF7Rj9Fr/GkGCllCbm8Es+Sx6hq+Ffyn4dePXr70et6o1CHz+xgKyF/CZeRaQXaocP2dKPc1c2LYCVOx4EnFFvP0DAo5RVpkSlFIE50rm/MYvX9kvZO/citFp0v0rDHkHAnXG6eRT8ovDo/d6iQZ5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808283; c=relaxed/simple;
	bh=q/VHA5/fdZi697G+Urin9dLHPxDsge5MpL7r4ecRFys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMBY6fBtWbn5rJt853INz5EpFIZXNK/1aUqM3sgJoJZPR+BwI3eVZqNZwisUVYub0A7iAy8TgSkJalruD9d5AOcg03T+YLys4zJjgq6lvESIpR9NV9dN/nCSH/j07qD0ylv5fQiG6yWOYQHNuO4n37qWZqDUQgdutuOaXiUgx6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=TtRBRQcU; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1779808252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VvMDnOOiYdd/IVgTbtVagICUbp1Ku7qPSJ6ubCXYaIgSfeN3ZO393xLXcuRH6XYd8XvTSQGhzeU8kROAs67r8BsysvBbn1VO6xB+rBYFTlrppuv8FIT2adtoFZCL535JKbWrFAqwfpUd+luhtnIKIjJ5BWoU3kwhYBcOeWa/0e8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779808252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+fN2v6ZfchSscSivSA193Z9bDzJGNmbDbzeEpNLov10=; 
	b=FzZKzlYw0oAWOcuPMKl/IsVQ/BFC9cNBz124HRuk8VtdoA58cOeIzNT9J852q2xDffeLE5nKeLAg7QJNx8i1BQJpxAlQNd0QN7Pbu6QVR5J8oJTM2FHLMDCstsU/mfLE6xnvTqZyTRV8HzceUY/35tTIMaYuLRo29tFvLAnx9Dk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779808252;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+fN2v6ZfchSscSivSA193Z9bDzJGNmbDbzeEpNLov10=;
	b=TtRBRQcU7NO0cM3R/Cbv+D0YFPR7job5OndtFLRRbbF8WNbK82Urd4HHfathrDzA
	zTRC/1hU+BN8UR9CizO+oEtxjp8twmuAxyKHR85fuo9I2oFdhAEc6CDI2NBYtv75rLq
	qCKzF338Dhq3iwVnLP4nsGjtc0PiB/Khj1T3tNf7zSQglezNqn6qyS2BOb8Q68K5oGI
	n7NXlbAG8WJqruKy74VL+pAM5LBv5RRqZzsGiyyvVZReaqwNN9O137nJnElyxaZEAto
	FUGq05wX+meW0yCpyXcdsSNJ/9cFADEQ9N1hoUhnycPOHnaq7GHj2Dp92t58UNynEaV
	2Xa9CEx02g==
Received: by mx.zohomail.com with SMTPS id 1779808249143981.3810602780743;
	Tue, 26 May 2026 08:10:49 -0700 (PDT)
Message-ID: <f10b3ddd-d403-48d3-ad0c-25b0e2d9d64d@machnikowski.net>
Date: Tue, 26 May 2026 17:10:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260513094520.325693-1-maciek@machnikowski.net>
 <20260513094520.325693-4-maciek@machnikowski.net>
 <20260518174209.41e2e039@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260518174209.41e2e039@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291742-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,machnikowski.net:email,machnikowski.net:mid,machnikowski.net:dkim]
X-Rspamd-Queue-Id: 621C95D898C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19/05/2026 02:42, Jakub Kicinski wrote:
> On Wed, 13 May 2026 11:45:20 +0200 Maciek Machnikowski wrote:
>> diff --git a/tools/testing/selftests/net/ptp.py b/tools/testing/selftests/net/ptp.py
>> new file mode 100755
>> index 000000000000..dd6f12cf3d91
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/ptp.py
>> @@ -0,0 +1,184 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026,
>> +#
>> +# Self-tests for HW timestamping and 1588 synchronization
>> +#
>> +# This test runs a ptp4l leader/follower pair and waits for follower sync
>> +# state (s2), using one common execution path.
>> +#
>> +# By default, it:
>> +# - Creates two netdevsim instances in separate namespaces
>> +# - Assigns IPv4 addresses and links them together
>> +# - Uses those interfaces as leader/follower endpoints for ptp4l
>> +# Optional: --leader and --follower override endpoints with existing
>> +# interfaces. Each argument can be either "ifname" (initial netns) or
>> +# "netns:ifname". Both options must be provided together.
> 
> Please use the existing DrvEpEnv infra!?

It exists in the tools/testing/selftest/drivers/net and this script is
in tools/testing/selftest/net. I can either keep  the self-contained
test only, or move the script to the drivers/net - which one is preferred?

