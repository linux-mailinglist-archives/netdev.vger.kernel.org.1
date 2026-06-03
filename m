Return-Path: <netdev+bounces-294824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QcRmKyhYIGp/1gAAu9opvQ
	(envelope-from <netdev+bounces-294824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD759639D0B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=earthlink.net header.s=dk12062016 header.b=YICi2Gl5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294824-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294824-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=onemain.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A92B31AA4C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A53D6CC6;
	Wed,  3 Jun 2026 15:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEE366DB9;
	Wed,  3 Jun 2026 15:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502030; cv=none; b=YbgXcIur2E+Hra4Ih/oFs2Y72d4IYQI5I7fCC3cEnvkaIqEpr3tmQd9QoegO+LXTJS6p6p6Z+cxf4SCNKRtjLSmROG3f4LvipoG0TUKEy8MkBiMmujNzwTwvnnTOLBgpkCBtDqhT/ioFsdaCATvxLccGUHg9anTLFtcBiMX3rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502030; c=relaxed/simple;
	bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH3JzpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5cGljRCBmE9c4WDW4rfUvx+9FEs65rhUaDOLGZPsLHBDm9SD08JCZAmtUFFZ91HX3jS3xUeqxca0ljkr3B5kYAUFruum2aCAtrO7bxs047Onzn1tS2QfDW4pNho3BMZCXE+l+q0qRur8psL3ZNdPCvrDGPV2OX9VgPFGzYinu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=YICi2Gl5; arc=none smtp.client-ip=51.81.61.67
DKIM-Signature: v=1; a=rsa-sha256; bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH
 3JzpQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1780501072; x=1781105872; b=YICi2Gl5iYhscsf53vglN3e1/uy
 47bOrYvxRnFxVBXT+OeCjYp81fx+t3MmqW3+NwGq/yiY+Hrk3OuN4U/oI7IVTOKIaMfm7j3
 2yvczT/p84E+vIiHUH0+MPWMPfqeuMIQXMuh3lVH+dmGbHOKHb6ilMuhMV61AFx7MNIfsWG
 hCL6vjiuRgHFY8dwkFMmLSiRAe1SLMj6YJ2Gjp3huX8TMPZRGcfd6Mn46F3sFKRFVaSYGRn
 HoghF60O8PFLLqBrwm7Tu/JTKgHpzVwVFAgc3k+pV4oeGDIgtyw5SkTQ2X3D2Xq0xOwGyTe
 Lo/4/4uGZOsPXN0j0/SaixuKLDNvttw==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id c590d1c8-18b59c4657ae0029; Wed, 03 Jun 2026 15:37:52 +0000
Message-ID: <620a9c51-604b-4622-a9a3-40f6a54e7aa6@onemain.com>
Date: Wed, 3 Jun 2026 08:37:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: fix netdev leak in i40e_vsi_setup() error paths
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
References: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
 <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[earthlink.net:s=dk12062016];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[onemain.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sln@onemain.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[onemain.com:server fail,vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[earthlink.net:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sln@onemain.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD759639D0B

On 6/2/26 20:28, Dawei Feng wrote:
> Hi Shannon,
>
> Thanks for the suggestion. I took a closer look at the cleanup paths, and
> I think the localized v1 fix is safer here.
>
> In particular, i40e_vsi_reinit_setup() has early failure paths that can
> reach i40e_vsi_clear() before unregister_netdev() is called. Moving
> free_netdev() into i40e_vsi_clear() could therefore free a
> still-registered netdev.
>
> So I plan to keep the current v1 approach for this fix, rather than moving
> free_netdev() into the common VSI teardown path.
>
> Best regards,
> Dawei

That sounds fine, thanks for looking.
sln


