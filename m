Return-Path: <netdev+bounces-78830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1477876B43
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB60281AAE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF556B8A;
	Fri,  8 Mar 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXpgUoDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4F2BD0F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926700; cv=none; b=GxRZnBwCtRCVYsjzTbPnuquZA1PGDckzjRnooi6FqYAdpOD3aCiF3SmYrvi0gnYMeN5sZv6CU7bO1un7OFNaB0SBz0cblZ3iOsoIt6zPDcYrT+S3adqfnP3pWsXrS2wT9b4VSMUOVPu9ysNn+ZgIt/TBqMvaetbewpXy1WiI4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926700; c=relaxed/simple;
	bh=gLNvX1I65DO8gm+wBlcLt/nC4E52j3f9IIQwX7c91bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQIhrMLqfrmPWyc0UQsltySLFnT8bU9dPYpdtQu1j8bk//MM0DLzVe80C5aYOFadfWEb2F3ZSNSe5W1cB+7NpNcQP5XeaXEXwZFfP/DrX88fVfRrJUynqIu7ytF4usRrYGbpYey262RJNdpAiNXP12Ol+OvfHmCXAR67BCH16Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXpgUoDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992F1C433C7;
	Fri,  8 Mar 2024 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709926699;
	bh=gLNvX1I65DO8gm+wBlcLt/nC4E52j3f9IIQwX7c91bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OXpgUoDD5k9+8gJel/XJHplmCk3AFJa0/FNe2q6zSA1uLvQMkHaJLc2axTKUFZaWS
	 EJhQkfX3800GLW8FMo6OYH2slcVZs9e231VMEwgeichs99GG9h3B8VnNcAMY3JPY4v
	 G4+IW6J2VblWnT8VoncGX6agOsM/cu5xF+vY0R6lkyQ9CN+PckCWVgRx3n5WLciDzR
	 CBhukfZGdnQtYYNCQGVRit50lZMQWIbPMUzidM3oTlc0NyBajHNTbi9HTLVKoyeZei
	 390GIuYQ4CguBfMQjb3Kz1QJqqU8c7U5qg06xGdRsnPu0O0zYsRwSoxYI3o4VeUwU6
	 oY3e6cwvF2OXA==
Date: Fri, 8 Mar 2024 11:38:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCHv2 net-next] tools: ynl-gen: support using pre-defined
 values in attr checks
Message-ID: <20240308113818.6743abe1@kernel.org>
In-Reply-To: <20240307092357.1919830-1-liuhangbin@gmail.com>
References: <20240307092357.1919830-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 17:23:57 +0800 Hangbin Liu wrote:
> +        for const in self.family['definitions']:

Looks like this breaks the build, the 'definitions' attribute 
is optional. Try iterating over self.family.consts instead.
It should be initialized by nlspec.py to either the definitions
or an empty list, always.
-- 
pw-bot: cr

