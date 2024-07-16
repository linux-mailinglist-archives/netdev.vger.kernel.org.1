Return-Path: <netdev+bounces-111825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBE93342A
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA26A1F21424
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 22:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177DE1411E6;
	Tue, 16 Jul 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Zt8BYmj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EB143725
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721168109; cv=none; b=OYbemK901BgyiI42OyihEVsLPbJO5QVQQFSWmVSoGK8lEIBq1u3K6D0IA+s6gu/oEv2HIr3ce3yHfChc8xXnbKTF3hdALImxY77eJshYupdPLNR540ayrUBe6Dncf6n5o0cCo3/RELhPSkRQRWuNdo/udrvwrRbl7/tfWXQ3KmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721168109; c=relaxed/simple;
	bh=jeHlu6xwflzxpYXAWqnolQYfp2fv6yETlfm0APt1h2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl8kyQPYN3gC1fCMm3c0uQ27/SKZELjD4j3zZTXx4ashE2sI4cNWnoFMJaip7atHtqfO9Tel7lweXRe4TCkR2cn5Vsf+yTCl4Bse2oI9vuU4ZmtVljhy3BPk1Hk1TCCEE5pc+MAIwCyLqOxK2NXXjjlLej6g5dsT8l996ZOa+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Zt8BYmj9; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1721168101;
	bh=jeHlu6xwflzxpYXAWqnolQYfp2fv6yETlfm0APt1h2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zt8BYmj9hDzE/ut6SMTI9q+eQwliWUFy+PXlJTCrDKff2ygmtEh7jsUfUJ3ErC01T
	 UpFMqbMhx0dyKVJgT3eA/u48ia/FBqxzRgftlVbpvQQCZ47X4dnrBfrjWmh9m8AxXK
	 xx61a66Y6fC3i837XbOLc+zi8JtVhzRF3m0v5l0Xfysu9YjiIO2kBGruR7KurKBiFL
	 z25ehpS40Z5zeu7MGBlrFoqitjgKH9DMhqeDhwC9Y1jKXy0VUF717TPCgDouJiN+pe
	 6nvUSbC04iaOgaCJyQ3Ma7Mti2SzTRpk5YMGAJ83D4qu8L6Qmemti91O2S3kDM8hBH
	 oxbZZ8G6IJEUg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CEE0260078;
	Tue, 16 Jul 2024 22:15:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id A8BA6200B89;
	Tue, 16 Jul 2024 22:14:54 +0000 (UTC)
Message-ID: <3a5437fa-28fb-4f31-8be2-e20f2c1ccfdc@fiberby.net>
Date: Tue, 16 Jul 2024 22:14:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 2/2] tc: f_flower: add support for
 matching on tunnel metadata
To: Davide Caratti <dcaratti@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, aclaudi@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, echaudro@redhat.com,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 stephen@networkplumber.org
References: <cover.1721119088.git.dcaratti@redhat.com>
 <0d692fe05a609beb1b932c2ce0787f01859b5651.1721119088.git.dcaratti@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <0d692fe05a609beb1b932c2ce0787f01859b5651.1721119088.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 7/16/24 8:57 AM, Davide Caratti wrote:
> extend TC flower for matching on tunnel metadata.
> 
> Changes since v2:
>   - split uAPI changes and TC code in separate patches, as per David's request [2]
> 
> Changes since v1:
>   - fix incostintent naming in explain() and in tc-flower.8 (Asbjørn)
> 
> Changes since RFC:
>   - update uAPI bits to Asbjørn's most recent code [1]
>   - add 'tun' prefix to all flag names (Asbjørn)
>   - allow parsing 'enc_flags' multiple times, without clearing the match
>     mask every time, like happens for 'ip_flags' (Asbjørn)
>   - don't use "matches()" for parsing argv[]  (Stephen)
>   - (hopefully) improve usage() printout (Asbjørn)
>   - update man page
> 
> [1] https://lore.kernel.org/netdev/20240709163825.1210046-1-ast@fiberby.net/
> [2] https://lore.kernel.org/netdev/cc73004c-9aa8-9cd3-b46e-443c0727c34d@kernel.org/
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com
Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

