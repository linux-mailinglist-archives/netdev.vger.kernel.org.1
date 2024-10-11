Return-Path: <netdev+bounces-134623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D499A853
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30191C22EFA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DD198826;
	Fri, 11 Oct 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUuXPfRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE7195FEA
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661902; cv=none; b=JAviyZRycWdyYgAU1Lm64G3bbX/bAKU2BJf7wGuB+lKuvzCyHe9K/gtlK1d5Sw7f7bxLmABR2Guj0gYxTHoLk9D+bUgpTMbtx2bXo8lrURmUzoSizXkZVmLTb2PZobCuIjqiwru2lAeVYaFjzJz8sI7oq+Am7NUV5fB2VZZrF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661902; c=relaxed/simple;
	bh=//7KxIoM3+SrKAjzxPod9EOedqUu5RGSszLQxDK0Ecs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDCcgz2d4xO8BSFIM/ylHKSwzX1zZi8WaSzX4+NEI/ZOTVTN9+x+MpzQEcDjmcB6RwPQvAgGa1ImPyI1YmJ6bXvQh4b430aSfUOsIDpwP5vKGQNLbFbu835xvBIkGjwHmz6dm2x4u5kLiBjy/0hOaH+W2JDiLN2IYGVwo5sGBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUuXPfRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBCC4CEC3;
	Fri, 11 Oct 2024 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661900;
	bh=//7KxIoM3+SrKAjzxPod9EOedqUu5RGSszLQxDK0Ecs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TUuXPfRzXY8b27c71LOx9sSz+1pesEuT/Vbrsp3ANhDyNyXJFCpA/s/5ljSe8bQLk
	 QTl+plLidKMqaJyf/H2vTOeGStD5oNR2u7kxc34YKJe0I/QkCqivnoCJIT2NoQUxvS
	 tsn/FYQ/3CBUv6gTh6uNykjaPjTBqdAFsqkDiIRoaQktirpvRoDRrqtOVOqW9RoWAP
	 dy2DtDsi46xMXxoeEkx/eX4IjRv3BsGP1t36WrJdbRDgMF5dGoTOC3Xc66XoFdh3DF
	 k6M+RLnuPGtf5pRDaoLmZH+w1+IGI8fMANm4xymw0DpPdTXRXtWB2g6gSKABfuB+vP
	 Z24b+b2ifOkGQ==
Date: Fri, 11 Oct 2024 08:51:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: donald.hunter@gmail.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com
Subject: Re: [PATCH net-next] tools: ynl-gen: use names of constants in
 generated limits
Message-ID: <20241011085139.1dd3c9d7@kernel.org>
In-Reply-To: <20241010151248.2049755-1-kuba@kernel.org>
References: <20241010151248.2049755-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 08:12:48 -0700 Jakub Kicinski wrote:
> YNL specs can use string expressions for limits, like s32-min
> or u16-max. We convert all of those into their numeric values
> when generating the code, which isn't always helpful. Try to
> retain the string representations in the output. Any sort of
> calculations still need the integers.

Missed CCing Donald, sorry! Link to full patch:
https://lore.kernel.org/all/20241010151248.2049755-1-kuba@kernel.org/

