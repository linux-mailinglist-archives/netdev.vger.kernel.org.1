Return-Path: <netdev+bounces-195446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0BAD0345
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EA1889190
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A6288531;
	Fri,  6 Jun 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox17lfIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E63288523
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216809; cv=none; b=rSa7VhhxQXF3yxQPh9VZN1Re1rjYOXcIlZm3TZ+ZudoJ2DjQxU4rMARdV0GOH64qIup4FoUKGta0c/fZ8+tRzqK6bzNnn/IgE1jPifANzN2iGgxkhPaGiEBsQzhnM3VRJUthWadUycGZnikV42WhLd1wCXLvQXTYgc/LRbr6kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216809; c=relaxed/simple;
	bh=TOm4Hx37KXxANEelVuooBPoZIBg8bwf7Asd/HdeMkV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyTYlqqjlOUaS/9wkEpoLbdcxMkbdHDq4TmjB/WCUVumfsyKFNdQiKIIdiYFuShVakeY9L4tampw+jUV0neDyNtfnKAD7jz/DZAmjzc9XnKpYO/hxZjSWrPPovkusWg1I+MSnZJJ7mH85v8oAux6eVizdldZJStNxrvfjJBKha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox17lfIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348CC4CEEB;
	Fri,  6 Jun 2025 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749216809;
	bh=TOm4Hx37KXxANEelVuooBPoZIBg8bwf7Asd/HdeMkV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ox17lfIFtnOcWcQL5aKhUApI91x0oYHtW68sNuNXijuMayflY3PV3WLHTOPAuFDyE
	 gE2HKGFRaw5xtBwG3xxG7VUKHxO5hpqeyOmjhQSkGlzWzQQ7uWONOrL2enbjRjpy1Z
	 neNVO658UobzNSwI25+JAsMZDayIYfH53Wt3b3lFmHWDQDkvU1osKLXWu8QxTbcz/z
	 WqL985c0uvSUrfufJzhBa/HJf+FymMWhRrfS+2g8hq2xARdTHgwGAk6hsiVxqD5r/7
	 hUIHuZJxxyU6AfinkTRaLenEDtG+5TKqbjuxDGuh2NrNopIkaHcarcRWfKtjKNv4iC
	 IXrPPjzAcOTdg==
Date: Fri, 6 Jun 2025 06:33:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
Message-ID: <20250606063327.186ee244@kernel.org>
In-Reply-To: <m2tt4tt3wv.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org>
	<m2ldq7vo79.fsf@gmail.com>
	<20250604164343.0b71d1ed@kernel.org>
	<m24iwuv9wt.fsf@gmail.com>
	<20250605072638.57c56f95@kernel.org>
	<m2tt4tt3wv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Jun 2025 14:06:56 +0100 Donald Hunter wrote:
> I could have patches ready for the merge window opening. What's best, a
> patch per type of error, or some other split?

Maybe, say, patch per error type for those that have > 2 hits,
and for the less common ones.. improvise? :)

