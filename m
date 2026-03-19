Return-Path: <netdev+bounces-269456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHLLF1gGvGmurAIAu9opvQ
	(envelope-from <netdev+bounces-269456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:21:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F19712CCA41
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B0032BCDF4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384A314A79;
	Thu, 19 Mar 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5MqYvtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93C30E0ED;
	Thu, 19 Mar 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929694; cv=none; b=lo+VgPLxUEbMa0DoghaI2vPZro61p1gVInN0cD/160nleH0qsamv5VrHvdnI/nh5xgxlNgpqdzwDFXI1tQgdN8RPIGDbPwlPHFxfeJiOXpxI3MtV3b+ahuL07k27zL3TClIfrWr0NBfxu8KJ/jXYmHU+DCOoRQuMgfkRH7Hg7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929694; c=relaxed/simple;
	bh=SqniqHh5Ik1ps7BNGsywr1yt7QD7NKi1YUt1MM6i934=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ9xX47BWvAZRL2C/PPziepGEEqbkt+lWP//zvAB8zPGkAhExgJ0DOMOVM5Ry/1Kt/OD534B2m/K2WrZWiHctlTXNetom1qT2uFfGZg1QwsAAsYUa0jyP9+7kKc/VHoqoNLdNieeaZhFl4/HSFoFJ3enT1FFg0T1izSOvoKoR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5MqYvtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1DEC2BC9E;
	Thu, 19 Mar 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929694;
	bh=SqniqHh5Ik1ps7BNGsywr1yt7QD7NKi1YUt1MM6i934=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T5MqYvtCT7ObTwXgR2p+nw2yf5V+jHNx77N9Wa8V/HkcqW6Ha2FeMimqYGgMUhCBU
	 6kBq1xNyjH5uH7SKalLKYpssfHb3SSF6+gzYfEG/LJOHLe1MjexccHfUYty2tfOdTn
	 hYc8acTfS4OCrpG/JHMYAM1s+BEJc1vBWkObG8dsJyzfl/H3m8hRGwi3d8McjzCLQI
	 7xnLdjdyAbqPuHB+Fc8r+eyGKsqf8SLwkIbETw6je/4AIV/7KbicJGLGhjvMd6hh8D
	 yyiEj3ayn8EHYJbNR3h2lro6llMjx5mkizS9rfGYwTYB3UyFCdm4hXzFdyfsgjFN4P
	 i6617eR58Z0dg==
Message-ID: <e35fb1b7-266e-48b6-a7cb-3ebe2319605c@kernel.org>
Date: Thu, 19 Mar 2026 15:14:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Tamir Duberstein <tamird@kernel.org>, Yury Norov <ynorov@nvidia.com>,
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, netdev@vger.kernel.org
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269456-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F19712CCA41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 1:16 PM, Gary Guo wrote:
>  drivers/gpu/nova-core/bitfield.rs    |  4 ++--
>  drivers/gpu/nova-core/num.rs         |  2 +-
>  rust/kernel/dma.rs                   |  5 +++--
>  rust/kernel/io/register.rs           | 19 ++++++++++++-------
>  rust/kernel/io/resource.rs           |  2 +-

Acked-by: Danilo Krummrich <dakr@kernel.org>

