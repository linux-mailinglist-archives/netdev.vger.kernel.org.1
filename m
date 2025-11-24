Return-Path: <netdev+bounces-241288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD59C825AA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D4543425CD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F832C94D;
	Mon, 24 Nov 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkLYKsw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2832C931
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014032; cv=none; b=K/eP5jP4kJj5vzQbxUqseS9+03aywsnIYKtPhFUOLK4gibBuk3edy/BFX94dAImM0+e/wv3/dovineNI+p0o99XY2LsdCS6NaumaA1C2J4gL0petI8uqYDz+YTWvtO30QxOLr2btETMWY4AJ8sOqQkEVdoGBrik6YQ6bJ4RP64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014032; c=relaxed/simple;
	bh=ygjCoJlzKYjnUIquD2gE26CzK05w0Am2PCQxK4dgOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV/SN0zppmcZnObqN0uUcZAc4Yd2IJ4t5HIr4AKoadJNW9CfAXQmGfnlSMa0K3lW5EtG4lb/JxHyFUcappVpvTZwIRZ+OmiHvygUG/b9dWFh1EcpLM8jg1uRRQCWU0yUug/q7vFRvxcs2ibdenewxER9HQVme7uA66WE+D33hpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkLYKsw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A094C4CEF1;
	Mon, 24 Nov 2025 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764014032;
	bh=ygjCoJlzKYjnUIquD2gE26CzK05w0Am2PCQxK4dgOJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MkLYKsw/cs8bJqxQu7rbZ0JQ4TLioK/iC8CjQwdHnbvqWBwYbf9GYMVRKu58DgBmb
	 6dot+6qLjIDsG7E79rkZ4ZcfK3AbOdnjeycxdITubCoaS/3kpDu1pdybjg+FiJtI5c
	 KHLqOFFTM9GxSrYPvvMzwmnqRoUY5XjNh3LDSqtRswO3YxgVrvw6XyVQ1PNQYQyx/2
	 S2bKQcvtCnSZ3sOltPgnT/YPWV83LMNtYZAtIssi56QYfAcx4om67kUeUTzFUWUJJS
	 sOy/0Zm3zYD4Nz687Eyln8eB3cgBF1p8AjD+nVzg7oqYTmCbTZ7zUmWQ8s8LZgZKGf
	 e/GapcEXWgOwQ==
Date: Mon, 24 Nov 2025 11:53:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] so_peek_off flakes on new NIPA systems
Message-ID: <20251124115351.4af1f596@kernel.org>
In-Reply-To: <CAAVpQUC85zujcLMFKFh_+FtvFWcuPLqJQm=Gv0-4HuXkZWjQwQ@mail.gmail.com>
References: <20251124070722.1e828c53@kernel.org>
	<CAAVpQUC85zujcLMFKFh_+FtvFWcuPLqJQm=Gv0-4HuXkZWjQwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 11:04:02 -0800 Kuniyuki Iwashima wrote:
> > So effectively we're been running some old copy of af_unix tests since
> > this flag was added.  
> 
> Yeah, apparently I no longer run tests on AL :p

:)

> and this is not a problem now on Fedora, right ?

Right, not a problem for us any more.
I was just explaining why we're hitting it now.

