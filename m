Return-Path: <netdev+bounces-132131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7D9908E2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB45B27712
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D01AA798;
	Fri,  4 Oct 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXQ3KUUm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645027452
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057970; cv=none; b=T1C7BcR3UGAqwPFlF7UIw5n2QEfA2YFKEctYI/K3T43eqw4ED1KrkcBmAaCXsJo50R/aT/b97M6PY+8ZHoTjmCBDlserhg3/RC7dCO7lnpUoljA7vRTFSQjyKzH0jQXxqUrxWiXYkh5pacwHmK3QdfOysVulPqZXgJ/G/o2ct/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057970; c=relaxed/simple;
	bh=OC2sAmWgBVX+482Js2kgTUyI50Yv/LE8IgGq1LqUAT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSyAoVwGHqKCeGAtMOAth4Qck+OeIkUGW4kkFuXheZDXAqWQDQqyEeRsx26YqOUYxCstUUUc0zX6bpSKjHI+57MW2+bHepHqV2jr9MraTPzrP+DWgJX7QYqyzRV7jgQYYQZjPXR8CNNKzhv4JY83RdpfePQiU/GFcBdp6rOd67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXQ3KUUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FDBC4CECF;
	Fri,  4 Oct 2024 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728057969;
	bh=OC2sAmWgBVX+482Js2kgTUyI50Yv/LE8IgGq1LqUAT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXQ3KUUmFqVwVlYYbVq/g2HuKBRT8d2Ej/xywNEkdLyMVYXHzZcr/SLzV1H8psX0m
	 kqpk0VhxVEgmh4A3jr3qBiDwHuU6WTZdtpGj+TbFCtvShQCUeOCycX+Ql+qKgY7c0K
	 ADsukCct+k9WXHDoMcHex0mDLlbXwBtyekqCnuhJ7mMCZMVq6XoSVeZXFPElizwbCc
	 Uol9U0OSXd7n7PmQx6sQU2dzYIAFlPYLb1Xikh5B+dSSkuMsN7jIQEa3V4PLOE/G7u
	 vgmA1EE1LaIijcv5NZg6ThkpHUaZgKDE5NZUcXWkbDQ6oUmPlxniJx26wiJUd8WbiP
	 a07vcPBhuJoEw==
Date: Fri, 4 Oct 2024 09:06:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <jk@codeconstruct.com.au>,
 <kuni1840@gmail.com>, <matt@codeconstruct.com.au>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 4/6] mctp: Handle error of
 rtnl_register_module().
Message-ID: <20241004090608.50f9f765@kernel.org>
In-Reply-To: <20241004010048.30542-1-kuniyu@amazon.com>
References: <20241003173928.55b74641@kernel.org>
	<20241004010048.30542-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 18:00:48 -0700 Kuniyuki Iwashima wrote:
> BTW what option is needed to reproduce it ?
> I tried W=1 C=1 but didn't see that warning.

Are you doing allmodconfig?
I think it may be a Kconfig option. DEBUG_SECTION_MISMATCH ?

