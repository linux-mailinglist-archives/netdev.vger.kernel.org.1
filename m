Return-Path: <netdev+bounces-287769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JLHFsgiBWpySwIAu9opvQ
	(envelope-from <netdev+bounces-287769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD853CA51
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60451300C3A7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA125392A;
	Thu, 14 May 2026 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8lC/VFr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE099199FAB
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721475; cv=none; b=TBE6VAP0aUEzovqjczfHi3SpqyGrGjMH8yztpKQWvJ0J9fdy60oAlL9VlPNbcIHHYL+Vjhc+ggu82gRtJI10CJdKrmMiuyXNZvjxKwtLDgcdF2KcuR40s6qcfl+X4BJNiPL7LM6g9Jsgm2SbffR0JqveF7K9aumP7ee8JErGsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721475; c=relaxed/simple;
	bh=f/JEA+gvAL6RsKE4k0VQGSoZzDc9Bv1KBRJTUSNnzqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnTdV6KDUm+Hlc0BhdrsSyaXNes1FGDSPATyq0PXbt9NwtvOjQVz4ytjMeLmkVwzMIppJhguZSnM8ECMFZJKQeglsPnPbTNmWIWAGABlh/TEhE72r3ko7WaIDo0zQwPKm0baiam8Dp7jBR0+K4uKr5m25tEsgKGJ0u10oYTerKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8lC/VFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD41C19425;
	Thu, 14 May 2026 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721474;
	bh=f/JEA+gvAL6RsKE4k0VQGSoZzDc9Bv1KBRJTUSNnzqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L8lC/VFr8a5m507MMQ/6dlEpIEq4JzHr8EUm/qaEfe7NqkDSmZW2G20dyusVUlbDa
	 RZ548D0f0fGh+cG4E/5LgHePlDu9rcdfD9R/8Cv/YVIM8SzvVvWvWz4eXx6SzNIPV2
	 7jcvzafqpdckSz5ke/AFmN/jxkzM60vJbsTvWcOppW4OtYpQKxPQLi437JngBkiTc3
	 S50Hl/cm+4J+cJEXDd5Wi8C69vI9CoZId7lXoLpCCaArKyTvObu3YBSYbuYpMvYkaM
	 2IoCvru1NrM9gXx/JWu2ubu8IM3/sPnE1GpYmYDWzeCdG3dHcMEJZfeGHxYfHA+c+z
	 1u89su2ZnXf4w==
Message-ID: <89e9f18f-2fc9-4453-bcdd-96fe31c0a3aa@kernel.org>
Date: Wed, 13 May 2026 19:17:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/6] seg6: SRv6 Mobile User Plane (RFC
 9433)
Content-Language: en-US
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ADBD853CA51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-287769-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/4/26 10:10 AM, Yuya Kusakabe wrote:
>  include/uapi/linux/seg6_local.h |  17 +++++
>  ip/iproute.c                    |   9 ++-
>  ip/iproute_lwtunnel.c           | 149 +++++++++++++++++++++++++++++++++++++-
>  man/man8/ip-route.8.in          | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 326 insertions(+), 3 deletions(-)
> ---

I am not cc'ed on the netdev patches, so I have no idea the current status.

Future iproute2 patch sets need to have all uapi changes as a standalone
patch that I can drop when applying the rest. Headers are synced from
the kernel.


