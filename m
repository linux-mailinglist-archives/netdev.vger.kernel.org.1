Return-Path: <netdev+bounces-303861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id obDCMvuLRWo1BwsAu9opvQ
	(envelope-from <netdev+bounces-303861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AF6F1F67
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:51:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=ORq+0J6l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303861-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6D713007882
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E573A4F31;
	Wed,  1 Jul 2026 21:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86C431E7C;
	Wed,  1 Jul 2026 21:51:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942713; cv=none; b=oIK1wLH2wo+G+joUAwDFcCGAUWEA4P4iEaak4h/9AcCdFiauANS5DY3sbV51rOjMv6Gm3r9JXSA7WIrPOArjtEYJw8BLWnSntWbfVpx9KQFctdW2M2z/gCXWC715SWtKOFve9PiBzauF+lhOthGoJLa/0KOqE/VtkJblKzzYxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942713; c=relaxed/simple;
	bh=WO9Us4vfLgLqjM5YqNhNxrYNNGbGT3swRepzpHqECEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY6UqPF4Qpb0HDQknop5bbEp9wiDSTLTdcfEhKyuCM61OgkLFPQEDxeNWpfy/VPQQJu03vXHW1DxEd33cbVTBRsp5SD4o/5S0SFvNsbsqcCkz9QYzBRHA6EldgT/HnMeC1dno+vaHBRAc6U+bebl0m4pfRxCos9KUobVW7NOh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=ORq+0J6l; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1782942157; bh=WO9Us4vfLgLqjM5YqNhNxrYNNGbGT3swRepzpHqECEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORq+0J6lf5t5CVTPe3gm+qXbWbgqj/AHpe0LOR6ZTZbe9U/pZkMzerK7si/zYowcG
	 LRcnk2ByGGVV805HdVkburxhiPUIS5YUucZmbRFNbEkbzFNCTl7c+MFQWRkhlNEy/z
	 b6O4E7Ftr2eeLD346TdD6HR50itOb59XjIofDzyFJrsg6JYK8Vd/dNM/BGuQmOsPfO
	 l0mgU5RqOV515Wj6fwlYrZC9buiMBDQt9ZQT/qvZ+W7Aq4JRoL8piZPisoR6Uixxs4
	 O2TnPBWxtMrFxJmG5b3K8YT2S24vK/OqE7MdhOECYasDsreod+ZsapuVzpz+ousd8I
	 ak6pxvgOwj2Ww==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 5293712664F;
	Wed,  1 Jul 2026 23:42:37 +0200 (CEST)
Message-ID: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
Date: Wed, 1 Jul 2026 23:42:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-2-matthieu@buffet.re>
 <20260626.taijohThood1@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260626.taijohThood1@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:hexlabsecurity@proton.me,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[buffet.re:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B7AF6F1F67

Hi Mickaël,

On 6/26/2026 10:40 PM, Mickaël Salaün wrote:
> Thanks Matthieu, could you please rebase this serise on the master
> branch (especially on top of your UDP changes)?
Yes I hoped I could send it just in time before the UDP merge, but no 
luck. Here is the patch with your feedback, and rebased on next over UDP.

Have a nice day!

-- 
Matthieu

