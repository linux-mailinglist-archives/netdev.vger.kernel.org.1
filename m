Return-Path: <netdev+bounces-282437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /KQWL0828mkNpAEAu9opvQ
	(envelope-from <netdev+bounces-282437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:48:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE2497CA1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF11F3011771
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5442C1584;
	Wed, 29 Apr 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuL8FUPP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A923E330
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481287; cv=none; b=otAwNaP9KsHohfDaU/YlAKCM/Tu4VCE3aRgkMLmq9653bEwG2kFC1g3AboDMm0JHRnZls8V1aqr7wEVTN9CuoK8auzgIzMzxhadwGvmFbORBx8CyH6NzxSy5OeA6PA8zSST1fW10kol8S1VpcNn2SCRYnycYomX86zythWETn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481287; c=relaxed/simple;
	bh=yEdebhvqHifQ4u/jIQowQkWinH6P2UsSOMy7SnxCGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bo5Kb6S3P2CmIaJ628TgQeCuqIwYycj0RIVAWFrNwmXnrNdvMy7dP6kkL63an/ZooV4pv2a6WjkOfXlE/h1gPQdTpqXnnfAVQHL4a4rmYbj1IwVvzbqknDxmGrz+xQ1ScLYfskS9b7cOEN4xH2w2c+Tol228QjFnebNpVXhsMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuL8FUPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B7EC19425;
	Wed, 29 Apr 2026 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777481286;
	bh=yEdebhvqHifQ4u/jIQowQkWinH6P2UsSOMy7SnxCGjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuL8FUPPgzgD1nqjVS2OS2lODMxvlm2yb3/A3/UCjZQGOXrvOHq/dQgW9v7CLSSWF
	 VdUdiZECK/P7K6ubYgsMVDetUSMpTnZ6UVOM+xHE4u4Sy7ipqvl2zzwEIY1I5M/KN4
	 TJUoNWDz2lENP29/7L3BHVEwJob+WB66QCaxeW4m0/6wGASLboFoml+hMVt6cPjGTh
	 Uve6pzY4vtCX0IOP+f2kz9ZYItkTYEFdAnan7PkBfL/Rthi4U2U5i1+RBckcVUgVkW
	 KM3lq8EurmJp7Mk5k8jq2SvqchV07Fbz+QxMKXMRKFkPhjxYXRIjOCyRMd/NuiaFEY
	 FEUSamNbQTBiQ==
Date: Wed, 29 Apr 2026 09:48:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add
 tcp_syncookies_ip6_9k
Message-ID: <20260429094805.1aa6bf3c@kernel.org>
In-Reply-To: <20260429080036.1528533-1-edumazet@google.com>
References: <20260429080036.1528533-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3CDE2497CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 08:00:36 +0000 Eric Dumazet wrote:
> This test checks syncookie mode is able to reconstruct some
> client options when TCP TS are used:
> 
> - wscale option.
> - sackOK.
> - MSS (in a limited way).
> - ECN (not tested, because of limited value).

We're getting:

# TAP version 13
# 1..1
#   File "/tmp/code_oyWax9", line 223
#     assert tcpi_snd_wscale = 10, tcpi_snd_wscale
#                            ^
# SyntaxError: invalid syntax
# tcp_syncookies_ip6_9k.pkt: error executing code: 'python3' returned non-zero status 1

do we need to update packetdrill ?

