Return-Path: <netdev+bounces-199538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A959CAE0A69
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549611794DB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED76230BF6;
	Thu, 19 Jun 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks/Twyxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B32264AF;
	Thu, 19 Jun 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346957; cv=none; b=Cn+pZnW3NKApmY/CIhHL0v/0LtXRtBimrKRaVSmIzDO5W3exJzjwU/ON68tCSN0hoasBDGyJ0p/1ruUzV1UwLMrkkIFDX3aZw7TAk6HlEJEx6Z7/5aIO4aW/7wLGJN+xWlInmpVqNWDQ6L9uBtXha2hAsw3WqrYRK1mp/zTTM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346957; c=relaxed/simple;
	bh=YEsLB9hr2F9ko9BSS705ht6z9JsSxvAwe0I5APde5Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPdkW7ODGb9nDkROFtnYPdoyRYpXQ49KWZp/63ZtxS0pxS73r28TJ9ZpuaVWWi5p1txuc2PJnJgg+q0SeqFDq8SuTiez2J/vaLGGI50jko6UDr7cb6E9O9zbP0arfu5G109JEhUne7kirg+9/cvFlDM3y0hWLSYuCGh10VXdcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks/Twyxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52736C4CEEA;
	Thu, 19 Jun 2025 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346956;
	bh=YEsLB9hr2F9ko9BSS705ht6z9JsSxvAwe0I5APde5Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ks/TwyxuJTiuiOanlmmFp4mC4WM+TPeZQ42xbObD+QRkbIfGtLYX8/8GKIvI7d25y
	 LbkZZFT5SCDnbt7SJXId1f8OiwBD02mnXP8CdK1GYgmYO2b5bPlrKk3wY1SoEdGqAV
	 4i57qBlWgmwWvWofooKV2bv7lcKHHKFo6ZNHlXt6gA9UdC1BSrJJNgiMVvB5lpiCJh
	 m8+U2jaq2PSUtqiJRhkS590ECJhiwHJVTVA9M9exfgJZgxjsKudAo/PMHtyLWS5Sny
	 00jIBOWbIoq8Sfd8CWLvM95320hPyYSEU1u/9Lwy0rkyQmDk/++8D2Wh9FCQcOlfO8
	 hNYBj1D+9dOZQ==
Date: Thu, 19 Jun 2025 08:29:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <sln@onemain.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mailmap: Update shannon.nelson emails
Message-ID: <20250619082915.08a79e6b@kernel.org>
In-Reply-To: <20250619010603.1173141-1-sln@onemain.com>
References: <20250619010603.1173141-1-sln@onemain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 18:06:03 -0700 Shannon Nelson wrote:
> Retiring, so redirect things to a non-corporate account.

I just so happened to be applying your MAITNAINERS update and this
patch one after another, so I'm just gonna squash them. Hope you don't
mind.

