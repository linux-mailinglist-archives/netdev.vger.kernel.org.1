Return-Path: <netdev+bounces-141302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2369BA695
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5091A1F21D87
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E45186E5F;
	Sun,  3 Nov 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHgAGuU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEA176251;
	Sun,  3 Nov 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650385; cv=none; b=bkoXpb/2jGnflpoJEi21qhwzNoIkHhXWSvYacaxuXY0C/0Lt/bDrDz3LoUqtK51BrwMAlaewMYDuQf2RBQKrgMMwjv7hJLeOoRHRgVAnQNhiF3opr7qh9jxTBt/Yrm2eshT6akcgCDtLgH1qP/PBy5l4H0WhYzKC2h2G1S+dDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650385; c=relaxed/simple;
	bh=b1yLmR8yF/0iv3UG0VPJlMsP2oyXx2Kd9hwFkxotTdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaxtlMRahLcb3PB+efz6BzAXRvGksE0H8C9x1RfKZH6I4IHcfDRblqKT5uN916H7m5SF4IcBN2xvQjfM+XpvTl4JE0emqEkL/vG6xCWiBo+QKG+BH41KkCUYHTGXSlR6HVQDBDewZdGvXrYjUsjvbpoT7J6wH3/xZf3vOEpPlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHgAGuU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFEC4CECD;
	Sun,  3 Nov 2024 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730650385;
	bh=b1yLmR8yF/0iv3UG0VPJlMsP2oyXx2Kd9hwFkxotTdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lHgAGuU/C2sjpc40OrNir1kSMrtWtusvqomxVY17ZeJfPQfvY2WqahCNl2YRHXYsp
	 OM8sC/4E/Oqw7z8IHrwF+7/70LbtDFi5XhGEXEVtAgk6rA0zhWmY4O3Og/gPyxnnVK
	 Glg9dpSrYD6rA3WCt4bBivlRSdAg/Qj2YnJpCRIuntKJwCtpKC6F6VWShJQgFs+C+J
	 WG2YHAsf79GvBntphzFDo2EE7xgwECvV0PsB0zTi8d+THUNguGApxvvVd3Sz3llpae
	 XN5g3sna16Lo8nc85r7De8Lk+QfL3yLw6Kj02HUuHniKdyeFcQBkSFhK/jgOvgoiQJ
	 pHLPfEHBfAgcQ==
Date: Sun, 3 Nov 2024 08:13:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gan Jie <ganjie182@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org, ganjie163@hust.edu.cn
Subject: Re: [PATCH] Driver:net:fddi: Fix typo 'adderss'
Message-ID: <20241103081303.492aca4b@kernel.org>
In-Reply-To: <20241101074551.943-1-ganjie182@gmail.com>
References: <20241101074551.943-1-ganjie182@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 15:45:51 +0800 Gan Jie wrote:
> Subject: [PATCH] Driver:net:fddi: Fix typo 'adderss'

The improve the subject prefix.

$ git log --grep="Driver:net:"
$

just "fddi: " would be best.
-- 
pw-bot: cr

