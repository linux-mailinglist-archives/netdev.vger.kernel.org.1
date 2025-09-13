Return-Path: <netdev+bounces-222750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADFB55A9B
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D982168260
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7CE11CA9;
	Sat, 13 Sep 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKSJFn0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500FD531;
	Sat, 13 Sep 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722886; cv=none; b=SxpQMwYflOx6ELaeHl/qjPmHFIcSKuOl7brqyacyKt44+igTjbl6XEr2Z46t+mexthUQbveewEyXRoPfmNpqjObytF6aKkoBP51EowJguOFr2geBLMXcLcwXVxstfouNDfXnxpgFQdj1PqJElvNKJbxc4T869aKArMeo8fbJaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722886; c=relaxed/simple;
	bh=44+bvxQZB0frdS1awUgublYIg+3EChaFU/AwKeK70vY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2htQ9pj4xQYUA9djcQ8elo/n/qqUN9ntPuubLEaxEiV9gN+I4XcJg6VCwdOVit5D5TzrufRNBZOfSITxq/x7CerRkFgAUvI1yQPob1n/HNwA7et0ZO+ShLwK4Ej7nPYOmN7BDg6HuRBkKvjDkz3txA4V5EHVjdjZeAh/5hbgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKSJFn0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C0C4CEF1;
	Sat, 13 Sep 2025 00:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757722886;
	bh=44+bvxQZB0frdS1awUgublYIg+3EChaFU/AwKeK70vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKSJFn0oU67oIYXzTkyQx4+GQnv74K0Rk7ReW4CONh6TXoQKtp35uN8k6dDjkqwL6
	 aDf4dTyfTQgAehSdPYktGLwVxN/xatGGSqzhBiJls5oCRlzQXaY41mW/7zqQf4If0E
	 uq2TuScdvwBZGZ02RGEeIvKRpPSRBi+VEPgqLlPNYdABeVNBROp3jMVtMvfyrV+hJM
	 HGZZYSOE1uijuYMXFH+eVPJv2heaydHNuj79gNkcSdKrSXZLH4hRuL0+XRKf6rbvVA
	 QsQe88zf8gg5cfa+kuY8tXdfGPh7cQ3gnxjgAJTtIMXWheIruzYL7LB0YqlAwaG2yz
	 8ObCtZAlG3mRg==
Date: Fri, 12 Sep 2025 17:21:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] tools: ynl-gen: add
 CodeWriter.p_lines() helper
Message-ID: <20250912172124.57f96054@kernel.org>
In-Reply-To: <20250911200508.79341-6-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-6-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 20:04:58 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Add a helper for writing an array of lines, and convert
> all the existing loops doing that, to use the new helper.
>=20
> This is a trivial patch with no behavioural changes intended,
> there are no changes to the generated code.

I don't see the need for this.

