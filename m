Return-Path: <netdev+bounces-96363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74E8C574E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBB81C2190C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D2144D0E;
	Tue, 14 May 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIlB4YsJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDC13E030
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694231; cv=none; b=B0ACIzJaz6PMWQN02cSxDGt3LzQii3zfENq5qyee5BZZyezXnJDlVBLs/QolGTJGcGCO9KLLVy0PujGdBFFgfUCQijn5uggJCKqObHki+lCik8FlMvIHgj8ATt9jgnRkJUZk2ZqKZfZ3k9xHkU6KYL+W/T3NQJ2F3YSsbvHla8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694231; c=relaxed/simple;
	bh=SZfpWtVKtz8L1iJq4FseAQG+Wa0A54B99TXCVBu0y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=comf1fILqeA7tnrkXW4XPtLEaXjprz2bN02uVsmc9Pi6nfNLAgPN0OnHWnWggcfv6ZFMtnZdGwEqZcN2rKK4fJl3jiLVagPuBv6BAWacltxb5hs/JqD5fesh1/NBUibs4Ahzpydadj9iHH/ztd/TQnBgRauqckwhiYwtpw2Hqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIlB4YsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8ABC2BD10;
	Tue, 14 May 2024 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715694231;
	bh=SZfpWtVKtz8L1iJq4FseAQG+Wa0A54B99TXCVBu0y8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIlB4YsJhHYTTMPdBnSrqudfvZwVcKhPM0f2qcf8w3+rplkNvE4P+WZTankrxCnyr
	 NI/iDW3R9pZyaa01bEGEAzr4gWao+CZ6NwEDCe0vitXeOiVLy2sCg2QwdWOrI5sCDk
	 UKNu7H6jW1i6THdk6cDAJLzQpWpei8csteCUe3QkbhXMrBZI9zmvwCdD6B577g5yOM
	 AF9hsfmM0Nz3QxQZ7yhXbmrg2w1VQSLdvNPrro1sewkgEIDnkkSRVVf+KJ/aEcMl0H
	 etLA4P8p+m/eBejmpxQNdVhGiaeFRmjBEhZuP5UBv77fXNCcoqgkEc1pt0yNVwIfgC
	 EQoWDrtPJghaw==
Date: Tue, 14 May 2024 06:43:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
 "Hangbin Liu" <liuhangbin@gmail.com>, Jaehee Park <jhpark1013@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [TEST] Flake report
Message-ID: <20240514064349.399ffcd7@kernel.org>
In-Reply-To: <87a5kslqk4.fsf@nvidia.com>
References: <20240509160958.2987ef50@kernel.org>
	<87a5kslqk4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 18:52:25 +0200 Petr Machata wrote:
> > sch-tbf-ets-sh, sch-tbf-prio-sh
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > To: Petr Machata <petrm@nvidia.com>
> >
> > These fail way too often on non-debug kernels :(
> > Perhaps we can extend the lower bound?  
> 
> Hm, it sometimes goes even below -10%. It looks like we'd need to go as
> low as -15%.

A more crazy idea would be to run a low prio stress program while 
the test is running. I'm guessing that perf is low because VM gets
scheduled out and doesn't get scheduled in in time. Or we can try
to increase the burst size in TBF?

