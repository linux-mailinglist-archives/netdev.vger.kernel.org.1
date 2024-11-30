Return-Path: <netdev+bounces-147939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A28E9DF37D
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F555161CD6
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D41AB513;
	Sat, 30 Nov 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHuW2TnP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A8130E27
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004421; cv=none; b=OOS3XHdJVtrqCJDQGrU0lMdihFkFQHmHTMsABXkJAav9fGuvEROS3ocCJnMPd0UacGw42b95wXPnF2z0w9hC0g3maZo8i68Nx78WtK36GzB6pcPv6qYZQFTO4rDB7/gR6LTe+UhZfnWiwW+nCKCi4ZJJuVLabPY15sf77J5Ucns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004421; c=relaxed/simple;
	bh=Llmq08qDukmnYT17+FSKOQeavDrO4FfChC1lxF0e560=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7nj42RsBxEy4WEcY+sm8/IbeclmonaXatxEmN5hraJ5e9JAPI9jxP5AOh4nSb+H6ytsbLqeNEZxJJBgTnZeXBDE+CABDgRtJVpxjg9b9yB8sz7S7Jm6fMuqr5WHjI3QsPz0qFq+yOCBnEpLb7JhP/YyOfRenPFX8sxfHEhSUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHuW2TnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEB4C4CECC;
	Sat, 30 Nov 2024 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733004420;
	bh=Llmq08qDukmnYT17+FSKOQeavDrO4FfChC1lxF0e560=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oHuW2TnP1Tk2FUhi7kmKcItmv8apRPTp4zKirIywn0oGu4uVHYEYwlZBoKFDa/96e
	 nbeN0ubs4sERwc2Q/gbgPxw6B/2dLXgxysbx0qD07CrIAJ4XlpWEupXuZuP7Z0GIXh
	 dB0JL262VjI0odKWGW6YHY/u5shV3dqg7KS28BILrKDZrJahWzAXVQT4ehY4FchBJ5
	 tKO+gLAumXFcOpKNiZp6y3Kv/2KVEfjGZRfer+AQy3z2HmODN6JCuVXsGoyfP9nm8g
	 04n0YTSZu1qovgL+e07biyZEFH9ZT8xbmBg3tsmQBEvXyx+5MuAN2W3xda98WDuS1i
	 Id8iPHCcsoDqA==
Date: Sat, 30 Nov 2024 14:06:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com, Jesse Van
 Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment
 to 32 bit boundaries
Message-ID: <20241130140659.4518f4a3@kernel.org>
In-Reply-To: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
References: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 23:11:29 +0100 Jesse Van Gavere wrote:
> Commit (SHA1: 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee) fixed this issue
> for the KSZ9477 by adjusting the regmap ranges.

The correct format for referring to other commits in Linux kernel is:
 %h (\"%s\")
IOW:

 Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap
 alignment to 32 bit boundaries") fixed this issue...

> The same issue presents itself on the KSZ9896 regs and is fixed with 
> the same regmap range modification.

Could you explain the impact? What will not work / break without this
change? Please add a Fixes tag indicating where buggy code was added
to make sure backporters know how far to backport.
-- 
pw-bot: cr

