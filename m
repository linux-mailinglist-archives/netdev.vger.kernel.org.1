Return-Path: <netdev+bounces-70735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EE8502BD
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 07:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9C0B22E7D
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AB12E7B;
	Sat, 10 Feb 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER/SL6vi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CE6AB7;
	Sat, 10 Feb 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707546313; cv=none; b=LkAm6iE/EzT8P/0eehNiDj10Z3NCg9N3fn7x9ZoFBHvjw0Wm7ejR1J5kI5oP0qgHerKcfmpD59LJi1tU2+viY3d49u2vfpq91yre5/UHgUQw/mEri+MbvdKp+CflVd+joUKk2ztcxbScjV1Ql1b3W4XQre4sSP5MhS3a9Dsp5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707546313; c=relaxed/simple;
	bh=Nzu/ZgyMawcFEr8BAtgEG1bRxe5yibFVGSLa+kOFCB8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pz8vijgoZAa2YkWrH4BAKcsl7ac2WCQXeBGGBD/yLqJYFHTjZVM7Xxt7N0H+QEl+dcqBHAuzi3YAWMzhPcpuZJt0Fn3+CmQPcLHivRMJMls1iAdOF/hNpTwWOrn+xI1Cpo4yxv0fls0vTosps/MUU2QCDZNd7gHRkJUc1hMDKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER/SL6vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4FEC433F1;
	Sat, 10 Feb 2024 06:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707546312;
	bh=Nzu/ZgyMawcFEr8BAtgEG1bRxe5yibFVGSLa+kOFCB8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ER/SL6vij/mW7yh9J9bbogLp6k8ZRC8R7gVW3TIs4WAEzwdC4AGdyFP5yibbaPyu1
	 E7s//3Ft+WwoCUUtwGVgRXFLH6eXexWHfDNPS/6zffgCZ/mniuAOLWCZwW80TVOECQ
	 F+oHE6u6qVY5RbMO9ApcydGgohtRWMXDgdvnS1SPgLqEiD3GFDK12zjlGYiB/h6TeC
	 k/+ZTR3Gvmiy90ornRe7MqpJ+7d+26nNzWlwtiEvzKh71DzSKcYEQRtP38ecnX9DEq
	 RfDNNUiCc1L2SFTaxFBXs01apenz75xPoy748oZHPq7QhDVZBGvVWUOTXx1ePyvT4c
	 bRgIHZO6m8xRA==
Date: Fri, 09 Feb 2024 22:25:11 -0800
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>, Matthieu Baerts <matttbe@kernel.org>
CC: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KFENCE: included in x86 defconfig?
User-Agent: K-9 Mail for Android
In-Reply-To: <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org> <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
Message-ID: <79B9A832-B3DE-4229-9D87-748B2CFB7D12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 7, 2024 10:05:31 AM PST, Marco Elver <elver@google=2Ecom> wrot=
e:
>On Wed, 7 Feb 2024 at 17:16, Matthieu Baerts <matttbe@kernel=2Eorg> wrote=
:
>[=2E=2E=2E]
>> When talking to Jakub about the kernel config used by the new CI for th=
e
>> net tree [1], Jakub suggested [2] to check if KFENCE could not be
>> enabled by default for x86 architecture=2E
>
>I think this would belong into some "hardening" config - while KFENCE
>is not a mitigation (due to sampling) it has the performance
>characteristics of unintrusive hardening techniques, so I think it
>would be a good fit=2E I think that'd be
>"kernel/configs/hardening=2Econfig"=2E

I would be happy to see it added to the hardening fragment! Send me a patc=
h and I'll put it in my tree=2E :)

-Kees

--=20
Kees Cook

