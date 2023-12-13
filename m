Return-Path: <netdev+bounces-57060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177C811DCD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4528F1F21D97
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B996168F;
	Wed, 13 Dec 2023 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMXRGRws"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA65FEF7
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28985C433C8;
	Wed, 13 Dec 2023 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702494009;
	bh=sLLLyT07B7/hiZsTdkiXCcmYldYAzuh+nFhvappGfSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMXRGRwsaDARO3j2Gh2ztQRMbyq2ZscQ//5YfVGAU/kIcJvpb9vvwihTEXIw1kVKC
	 ndEQnCHlU9ca29RpaQgTJkrDUV8RJiyl11kte81UFt6g5Aucsy1svF4s601qmXy9bv
	 97CNLELWxcRrpzDe4kNSkhw0Boqx68ICmh5wT8Bv8WSNDVefSqA0+4RH7hOd19ETYL
	 oSnnxPiLukIdeqbHFmAB2kU+OYBeSmhdV4ZsTeuq8YYycd3HSvrgaVEoGe6gPcDv5R
	 j+s8mEvWKOQ5gnwTj+A15s2MsaG3IKX0BYRZhZ2dutdE3MUKX8gWnszkoLDXNYw+Xq
	 M1pqDKNjpDNhg==
Date: Wed, 13 Dec 2023 11:00:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Salvatore Dipietro
 <dipiets@amazon.com>, davem@davemloft.net, dsahern@kernel.org,
 netdev@vger.kernel.org, blakgeof@amazon.com, alisaidi@amazon.com,
 benh@amazon.com, dipietro.salvatore@gmail.com
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when
 TCP_NODELAY flag is set
Message-ID: <20231213110008.2e723723@kernel.org>
In-Reply-To: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
References: <20231208182049.33775-1-dipiets@amazon.com>
	<0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com>
	<CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 15:10:00 +0100 Eric Dumazet wrote:
> > It looks like the above disables autocorking even after the userspace
> > sets TCP_CORK. Am I reading it correctly?Sal Is that expected?
> 
> Yes, it seems the patch went too far.

Reverted to avoid it getting to Linus in the meantime, FWIW.

