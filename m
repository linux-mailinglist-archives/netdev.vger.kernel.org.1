Return-Path: <netdev+bounces-115547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DAD946F9B
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84779281024
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3DE56766;
	Sun,  4 Aug 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peUNYM64"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFCA95B
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722785694; cv=none; b=nW1NwsCBs9Jr56hLKBzMZJOlKTWB40tkfg6ZpqS0hDBPJFIQPZGgH3JlO1bVUr0wlnOkorfMIshBzy82M2vwouMpKM14GGVzLoGqmGb+8gZJEbfR8yhvYYtW2XAcCHhyykzY3axVIroW+3VCSQYc0tqg786XjZWZD9rQdoNWDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722785694; c=relaxed/simple;
	bh=SXXO83FHXp1Gw9NCa8c/P9bTALIzk80749WB2aNwa9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/9xUHYdVBSmjHh4waA47Zul79BaDgfdFLCBbs76zK9Hj+QrwFyXzvMhJogoC+RlcBDzP+bf7/4mLkY3dsmkYBKn4XPqlzjIFMoEEDesF9M6XRBz1Zxxx+E5u9WLN/5vKfDWFsMaX8snw+kEMCaXSIYXS05Xo8EkzvKhIMJiCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peUNYM64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885A7C32786;
	Sun,  4 Aug 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722785693;
	bh=SXXO83FHXp1Gw9NCa8c/P9bTALIzk80749WB2aNwa9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=peUNYM64JFdjLHgl5my89w6OhhXe5VlRy3X0DKDKZ4z129zSw30aYhPK+OZlvjS5O
	 2isBLDpDAfWQ/mONV8c09FPLgRix1DnjMSB39ALmfmUFBBXZnciz0DJFgbkku/+XBs
	 ar2morbhRn3DrsNGBpknpcVR6sFCsPS5V8h5MVy7s0y5fJUUlQZ5oDPD2FIHK4b40z
	 xRuiFvbCHrNosSFAktyvuUWk+n3kXvER3sc5Sz7IVMbPAM5sxYF+O4fRkzgv9i88YJ
	 F7AZtFWUgHerRXeO6n/BhBm4oQX0XxGZSlXAedRqrlXHJ2UAl23Tox80zn4zBOWOLn
	 jg3eAAzMlAfFw==
Message-ID: <76127456-0d3e-4a44-8a4f-0f0823b4dd66@kernel.org>
Date: Sun, 4 Aug 2024 09:34:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 2/2] tc: f_flower: add support for
 matching on tunnel metadata
Content-Language: en-US
To: Davide Caratti <dcaratti@redhat.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: aclaudi@redhat.com, Ilya Maximets <i.maximets@ovn.org>,
 echaudro@redhat.com, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, stephen@networkplumber.org
References: <cover.1721119088.git.dcaratti@redhat.com>
 <0d692fe05a609beb1b932c2ce0787f01859b5651.1721119088.git.dcaratti@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <0d692fe05a609beb1b932c2ce0787f01859b5651.1721119088.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/24 2:57 AM, Davide Caratti wrote:
> extend TC flower for matching on tunnel metadata.
> 
> Changes since v2:
>  - split uAPI changes and TC code in separate patches, as per David's request [2]
> 
> Changes since v1:
>  - fix incostintent naming in explain() and in tc-flower.8 (Asbjørn)
> 
> Changes since RFC:
>  - update uAPI bits to Asbjørn's most recent code [1]
>  - add 'tun' prefix to all flag names (Asbjørn)
>  - allow parsing 'enc_flags' multiple times, without clearing the match
>    mask every time, like happens for 'ip_flags' (Asbjørn)
>  - don't use "matches()" for parsing argv[]  (Stephen)
>  - (hopefully) improve usage() printout (Asbjørn)
>  - update man page
> 
> [1] https://lore.kernel.org/netdev/20240709163825.1210046-1-ast@fiberby.net/
> [2] https://lore.kernel.org/netdev/cc73004c-9aa8-9cd3-b46e-443c0727c34d@kernel.org/
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  man/man8/tc-flower.8 | 28 ++++++++++++++++++++++++++--
>  tc/f_flower.c        | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 3 deletions(-)
> 

applied to iproute2-next


