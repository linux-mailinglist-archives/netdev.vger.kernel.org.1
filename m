Return-Path: <netdev+bounces-267736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Gn2M2pztWmi0gAAu9opvQ
	(envelope-from <netdev+bounces-267736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:40:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659628D878
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDAB43037478
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF55378D83;
	Sat, 14 Mar 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe4C0h2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09B336885;
	Sat, 14 Mar 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499161; cv=none; b=h55nsdTkAqxWRCOV0/9u/fshNp70FDztCl0+ruUHwklG7U/Jzlz8nzcwij4XYUAgZ1NNuXa0+Cb+RhlUP5HvQetS6/7j2Li3EC6ATSp28E8z865txFHRKzmTQ5qOYDwAVIDrwzfEqJYaV94AtsAqAzerLMWhKXFp+hkBM/G+CQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499161; c=relaxed/simple;
	bh=aQt3yN9oC3u1DOXjtnYQ5HIfBnNmVUHhH7ZmHIhVroA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9R3L+gh/R+6urQcMg7KdaJvtYMAFWoV1LSlwJomLLnx1PlYA1Cp2w12jR8S3oX5y6kQDkcmQLELNlaYQ/t6rZHOpL2ho3a6kjxHlS5AjU8lNmZwkj82kYEIQ7upJlH8znPwIEOmluP8EFT+dy8v11WmkcNb83ARvxAcxDbGvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe4C0h2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB1CC116C6;
	Sat, 14 Mar 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773499161;
	bh=aQt3yN9oC3u1DOXjtnYQ5HIfBnNmVUHhH7ZmHIhVroA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fe4C0h2lchpICgSlw+ppLPYHruXnZ693hXcbr8PGWUJynuH/xCXsqBNBNqTKYBBWU
	 JFGaF9Eg/7Bpq0U3Ii/Syh1OiXBYkh1/1j6EbLo4xk4YR9wLYR/68Z1QU2QhLPD4VN
	 GM9m3fod9gbqSiJ9GCNhUepzy/clCbd6FhRxbdNpdZ6JFglAqHLyHkxFEugI4Dy5lD
	 plly/5Hxhknq/WaxaK/jbOaflkCpMoMTr4EYxdnGtxyFHdJ1pgIrQBmOlJNNxs6GSC
	 ZgIYskqHCxZWE7pyWy26Psu0o/XTgbEIpJQeZCp78ifF44GX/1+QmiFrjBUhFBNao8
	 yUxs22wZp2ryA==
Date: Sat, 14 Mar 2026 07:39:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, John Fastabend
 <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alistair Francis
 <alistair.francis@wdc.com>, Damien Le'Moal <dlemoal@kernel.org>, Wilfred
 Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Message-ID: <20260314073919.2f92b966@kernel.org>
In-Reply-To: <abQOGm6BqAE5eEln@krikkit>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
	<20260309054837.2299732-3-wilfred.opensource@gmail.com>
	<abQOGm6BqAE5eEln@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[queasysnail.net,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3659628D878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 14:16:10 +0100 Sabrina Dubroca wrote:
> 2026-03-09, 15:48:36 +1000, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > 
> > Currently, for TLS 1.3, ktls does not support record zero padding [1].
> > Record zero padding is used to allow the sender to hide the size of the
> > traffic patterns from an observer. TLS is susceptible to a variety of traffic
> > analysis attacks based on observing the length and timing of encrypted
> > packets [2]. Upcoming Western Digital NVMe-TCP hardware controllers
> > implement TLS 1.3. Which from a security perspective, can benefit from having
> > record zero padding enabled to mitigate against traffic analysis attacks [2].
> > 
> > Thus, for TX, add support to appending a randomized number of zero padding
> > bytes to end-of-record (EOR) records that are not full. The number of zero  
> 
> I don't think this is the right behavior. I expect that a user that
> enables zero-padding would want _every_ record they send to be padded,
> and their payload is going to be split into however many records that
> requires. This could mean that data that would just fit in a record
> will get split into one full + one very small record.
> 
> As it is, if I repeatedly call send with MSG_MORE to let ktls chunk
> this for me, zero-padding has no effect. That doesn't seem right.
> 
> Does that make sense?

Or maybe you could refer to existing implementations of this feature
in user space libs? The padding feature seems slightly nebulous, 
I wasn't aware of anyone actually using it. Maybe I should ask...
are you actually planning to use it, or are you checking a box?

Second question - do we also need to support zero-byte records (entire
record is padding) to prevent timing attacks?

