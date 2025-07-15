Return-Path: <netdev+bounces-207133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD06B05DE8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A7B7B5B4B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1B2EA467;
	Tue, 15 Jul 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyLPpWKY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103222EA17E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586812; cv=none; b=u/9CcUwFmeBfr0hUFp0Y6juca4zVw0tFIYc6qHrYZZPX92UZzF9ngVzaO8q60D+IupWqJQpTJI+v5scIbiPaXdnP0j4J9gsMIO5F5/OmcwqtOiQNRAUHZR74INyC1rqwgIYlHvqMc1jPB1ME8M8DqcZqWahjFSsfV8mxaP1PDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586812; c=relaxed/simple;
	bh=8qHWMROmjQAxsp//m+1FVvKUulXVDCzVnw7cihitXfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX/yR06IQfxpao0S5+LgsmwQmeXGdAY5Vs+9fQwKYFg/oTR//Xf7LQVGnSlrTnqadxg+Jxcn9QbAvwdsKRDzchd+O152kjg5SpWek2w+a1W2R1f1gd7Z9cDm6W+A3LgST0z0Z98j0jqzFytHvEuAw1oxCTfs4h1+TLRPYvp/ZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyLPpWKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D58C4CEE3;
	Tue, 15 Jul 2025 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586811;
	bh=8qHWMROmjQAxsp//m+1FVvKUulXVDCzVnw7cihitXfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YyLPpWKYtqvbNelDAK5nMSrgKbXtujpcDA/Hw1hJrbrnZ6ZibcjXisV0P5U5ETSHj
	 Van+QqI4lFY5SmTJOVcn7IEY45GjEh6YE/hmggGy3vSdu52qUXk153lFqaLaz76nRh
	 vITi8lrKWnARt/PXmHs8JqITKRmPauZ7zwOVglHAKWNT9/x9/n1FOppwQXV5Dm/W2A
	 OnYJyiPmkJQTGu87IizTrXX1hLDSRcOzSyBezC3xh7VFnkX1VCtRWabEQ6CCqycKuW
	 FE6mPzn7ZaOgqVmFjh+l3TNeDKI8NCwsSLmlbl53BSatZuU7i+S2jtOeOE/4IPo+Hf
	 CSTE2Wn6pOk7w==
Date: Tue, 15 Jul 2025 06:40:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org, ant.v.moryakov@gmail.com
Subject: Re: [PATCH ethtool] netlink: fix missing headers in text output
Message-ID: <20250715064010.164c1c4b@kernel.org>
In-Reply-To: <20250712145105.4066308-1-kuba@kernel.org>
References: <20250712145105.4066308-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 07:51:05 -0700 Jakub Kicinski wrote:
> The commit under fixes added a NULL-check which prevents us from
> printing text headers. Conversions to add JSON support often use:

Hi Michal! 
Would you be able to apply this ASAP and cut a release?
AFAICT this bug has made its way to Fedora, at least.
And some scripts try to match on the section text..

