Return-Path: <netdev+bounces-147926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03F9DF2B0
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 19:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F5EB20EDF
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5319E7D1;
	Sat, 30 Nov 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMROiCmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5217BD3
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992848; cv=none; b=LNGsMWcPcqKx/2F/wpvgTNri8RZ90zc/cfJzEfS6XshdUzCkIQmiaGjv4xwKEwOd7AC8rbOnLETuXIsaoUTTlnSra4bZGpQ2czbhf/KdfFEUnJAI0PY8i17mcq2/d7fB15A3hM22/tP/6TEjUcSU6piRocrTiOTF8EiAPXxPfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992848; c=relaxed/simple;
	bh=O/APMUDtAFezuu2Dwa14cIPbkzz2eccdyGy8DVt+8to=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUX2sMKMhAJzgaccjCHkDj8L12tdPEU8G2lJX5/xRa0LsMb9Tg6JM8jrJNZ7dPLX25Dkv2lWPLB7Go3LiR6eGcvT7aKiC6TY3BswB6kbbZ/flygir43ftXYnZ3VYc07h86N0bckk+2PZAj3FtCDCnCsTOnLU4SjTVeeldFOtkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMROiCmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19AC4CECC;
	Sat, 30 Nov 2024 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732992847;
	bh=O/APMUDtAFezuu2Dwa14cIPbkzz2eccdyGy8DVt+8to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMROiCmdueP52DiO7RCEi8UV4wn8mwnRCxKIGoMdcWquUkbt96z1Bh0wERAhUZe+N
	 yUzY+jUB2juLER8D94YSOgyOqZQfKLM97zIFtSdZZqcK502fXIi40zir3FgLPYeWBU
	 XkwCsneTNfJB31TxEisWBIolJvCVo21oi31wyqMj9NqSWOJnHiNedIQK1Xa/0Z6uqd
	 C2IOkTs6XqNvBXGUJJVW3+Y4XnVTURhdCf+qxgBx25pnBs7of927O/VHYOYcH3lKkE
	 Q020h0pfQ4RjUOWsLFAdzrxSUzqvpxOgMFD43VTzpccPi/tetiKWCy+RcOmvU6ld2l
	 dKNToRoLoLekg==
Date: Sat, 30 Nov 2024 10:54:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: kernel Oops: net-next-6.9 breaks stuff on Alpha?
Message-ID: <20241130105406.54ef7c7c@kernel.org>
In-Reply-To: <CA+=Fv5Tf=3HLhkDqRoxSgp0p6kpn7F62qiRXOXMSyR2KzQNUDQ@mail.gmail.com>
References: <CA+=Fv5Tf=3HLhkDqRoxSgp0p6kpn7F62qiRXOXMSyR2KzQNUDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 14:50:54 +0100 Magnus Lindholm wrote:
> -       synchronize_net();
> +       synchronize_rcu();

This basically translates to switching from sychronize_rcu_expedited()
to synchronize_rcu(). The problem is likely in RCU support for Alpha,
we're not doing anything special.

