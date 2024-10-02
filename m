Return-Path: <netdev+bounces-131220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867D98D534
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27362286AD6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D21D014A;
	Wed,  2 Oct 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRdiG4YR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048916F84F;
	Wed,  2 Oct 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875672; cv=none; b=QT1Flw0n6BF/tQcfJ9f0o5RTZWG1ngPDAiVlPSefyReh0OAVbIdc5ETWKmiZKCxAioD9ZlQCFr1vwPAMg1BTqlDdcfkq0KirQUSTeJWbS4wC0x+PudIC/jhdZjkX52j2r8lvFgZVqhbjga4ddDe1ZlmU8tOra5e5Nd5zjkQyVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875672; c=relaxed/simple;
	bh=0KZqVgfkTSUqEqE58vuiL59oDQnxjwoKPqDNvPlC9Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNwCEzw8ATjJtmr5/hwObCc4CqS1fpjftXLneeOCWZb/eOfqUqjTltpLys1JYzg4jSUD7kFDGvcz46+Xy1XCiJWm85ijRvigBnBykwDj7riqBxL6UtF+viqWl+hIO8jFYDTTvhTbIKnVGMkEjZJ5S5lTM8atpvd8v+v91XRsXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRdiG4YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E257CC4CECE;
	Wed,  2 Oct 2024 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727875672;
	bh=0KZqVgfkTSUqEqE58vuiL59oDQnxjwoKPqDNvPlC9Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRdiG4YRUdJi/RqUjXvLROlNi/0g7lsYjgJUgThTE6/jEsowp9DywtSMWj9FzAMjF
	 DbX4XY5O4IFmxU0U0tIyfS0VPAF1WlzKA1EckB3yAGts7dmDIYh7+/RyptA7S8kZQm
	 PWTGD3u11oyowzO37uvuIPqAVoiRWOeJ6Yj9Y7yWDtjd8BEIjkwAdU1fvT6jmUF7yU
	 Nn3qv6mN/zwlHmeXJ6Dmu/xMxyJ4+R60szUYZbG5mOtlZutrpljm+sDtRXEFsxM/NF
	 J6Z9aJnONhsM9YLEMFpFXUddJ+fUvI4c1lXigNUhGpguWMF3/qDQ7Egu4eD2Y4OFFI
	 m7zG6BlbltCPA==
Date: Wed, 2 Oct 2024 06:27:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Okan Tumuklu
 <okantumukluu@gmail.com>, shuah@kernel.org, linux-kernel@vger.kernel.org,
 krzk@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Update core.c
Message-ID: <20241002062751.1b08e89a@kernel.org>
In-Reply-To: <20240930-plant-brim-b8178db46885@spud>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
	<7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
	<20240930-plant-brim-b8178db46885@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 23:20:45 +0100 Conor Dooley wrote:
> (do netdev folks even want scoped cleanup?),

Since I have it handy... :)

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

