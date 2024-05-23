Return-Path: <netdev+bounces-97817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FF8CD5AD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8F81C214FB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367914B95F;
	Thu, 23 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="i7z8REZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF361DFF7
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474370; cv=none; b=ji4HJ5fdnt+0fQY62dRwoLXSMZDgqxoULDMaOgCJ8BJ6jCAKjdQ3kmqhZ4UY8fMxW7aZCkvYk3ESiJR5ufHzcKeRD00zdEwidr/A/KtXWqDhsRXa4CMM3kSxhPj1NEJMTx/sHNyRe8Np6BYYz+mv/crrrniHDJIQalEwLlp/Uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474370; c=relaxed/simple;
	bh=INmD5faKe5Zvy7/LCLOWRYRZ59brbTJUCsYdg7UUGeM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VBpvt4BraBoJ3atyJWkNuxfg6B4LDZ79ERuo1o+oKF6Qh6qLaAIYXiq23AHYqHBQc191+t0IcE4EyQhxnWhzozPzQh4N0TAvWZXZPmyZhN0sl51hBwv93sOH/F7WFpMtifSvmwwq/9ZUKtnSkO40leqVCzdkdes6Z7VLlxVUXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=i7z8REZL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716474366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGHGKqCM52AIo8JloAhWqvaRhoE0s+5gnlTNqlCp8cI=;
	b=i7z8REZL282tPAM9w6+HpYPypiq/ZqJmeKX+0818V6d+VS78Yt/DZc5Uxyxpk1tIa0vs+3
	UeTNmMucaRQoScM14LSyvVzdpgyP/SHcrLPoKdeEous4gsWqwOJDLbJ9fF0jhaEc0h6ROW
	S8Ui8TU6yFArstUyU55SKCKM4MQoXg0M7qgsVoi2IhQOGayIQBu/iLq40m9bGElvMHg4eW
	/GRnbPnaImrhr/T0IcUJSBEdW7CLPgXt6z9cAGRTGtD8xeO9xA2sZTIs+ZYS33zaV/5OG2
	MDET0EVyngmmBmEhOziupmAUlimBcMgYHztiKzgGXgsI2RZ5pgDWv860+umfRQ==
Date: Thu, 23 May 2024 16:26:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <1b404d0c-d807-4410-b028-f606d7182789@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
 <ef4f8fdb9f941be1213382d6aea35a46@manjaro.org>
 <1b404d0c-d807-4410-b028-f606d7182789@gedalya.net>
Message-ID: <db3e76a601cec0a42cf814d870206bd4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 16:13, Gedalya wrote:
> On 5/23/24 10:07 PM, Dragan Simic wrote:
>> I think it would be best to start a gargantuan quest for having 
>> COLORFGBG
>> set properly for all kinds of different terminal emulators. Including 
>> the
>> Linux virtual console, which may come last.
> 
> And you'll still need a default and the default will at all times be
> _something_, and it being that something would be justified by..
> well.. something?

As you proposed a bit earlier, no COLORFGBG set would mean no coloring,
regardless of what the user requested.

