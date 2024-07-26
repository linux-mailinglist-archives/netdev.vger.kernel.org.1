Return-Path: <netdev+bounces-113244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67293D4FB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7997DB209D3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92249C2FC;
	Fri, 26 Jul 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCVqObvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7A4C8C;
	Fri, 26 Jul 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003652; cv=none; b=aXeYZCS+txHh+z0XIXSjYbwXZjQWloF6oUYrD0CP7ZZcdJpf2Ka90c3GOxKDYawyaqML30x51fvViuZmfg6wpo1SlISTrErX0aVV2KbqU491Pm5rt0Lm98eKgocbxM9/cYzGfDDAY7UhflOwcN3rdDRy8BzKntImWsP0rFC/zBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003652; c=relaxed/simple;
	bh=j2a+bKvAN8Hsa3ZWQBVrijkQlI/LAnkKyXS1QtDKDw4=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec2+nhvonJEZu5+JvNvpNGXDMOtbVtW+llajjuU4Ab437TNxV7Kv3gLzuBmuCeWG6yXacCOfmMVyhvPYooVzWXuhIZpBnSB+akcPeMd8SO4Xs0YU8S1e2ftMYmOhu7fF3bwfh+KekzoOLipho9meUgDH6cf9iVEYW00eswcNr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCVqObvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F6C32782;
	Fri, 26 Jul 2024 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003652;
	bh=j2a+bKvAN8Hsa3ZWQBVrijkQlI/LAnkKyXS1QtDKDw4=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=WCVqObvl+dO1Ys/9rzdct3+l6ZkaUe0xuUR2Vn5WFFosfdeFuiZk4g4MjwZfYeILr
	 0xH88O4lJ1GOu2sRfY1e5Tz9KU+8JjBDlv7/2VpRNiWy9uK7JCT2u1ph41OKAN3q92
	 mJEo5Ro0c8w4r4Ih+H+D253CZIMwzy4aWb3CypbQII3eadDuJexht9AWqINd/lysiv
	 K4iId8QCB7p/5zLXpBLD/k84F5AuMEcbzNAHkx7SHfOGVDMZFVzaCEZzz/mDTJ3rqz
	 aNG50dxux38wnK3t7KINV8WJ/Uj0RJJA8lQZ8M2CP8p3U/WZHqD4jzIw2jxcOM3dNa
	 Mr+UCEw7nNiMw==
Date: Fri, 26 Jul 2024 07:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] Reminder: deadline for LPC and netconf 2024 submission
 approaching
Message-ID: <20240726072050.4824d6d2@kernel.org>
In-Reply-To: <20240725165102.4e1b55cb@kernel.org>
References: <20240725165102.4e1b55cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:51:02 -0700 Jakub Kicinski wrote:
> netconf: https://lore.kernel.org/all/20240410091255.2fd6a373@kernel.org

Someone pointed out off list that we haven't shared when netconf will
take place. Sorry about that! The plan is to hold netconf Mon/Tue
before LPC. Sept 16th and 17th.

