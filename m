Return-Path: <netdev+bounces-64848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C78374AA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C51C281A3
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E847A5D;
	Mon, 22 Jan 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBQO4paG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1F3FB3D;
	Mon, 22 Jan 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956883; cv=none; b=JVeMiIqp42N/etEqSTmq5pgCl1wrWs+zzcdDSGf8qytzw57IzwmterNgySw4jfYLZgH8WzlaW73JNqVjC+jEeqfQqfUSPSZwQ6ZNzf/q3WK0rN+iNVDDeHyPQShefdSfpW0iKrq4sEbzKZ4FdjJPocyNvZqmKZzbPmzm8Hy6Tnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956883; c=relaxed/simple;
	bh=KEX41Z4GRimqE32SG++boCA0zNkine8aAS5Yw0qR+A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5X3AU8mZoR2zmYQv+GWv1joObJ2ATyADTnZX6IV3lbMxLHcilmwTTa9ZeNceYOu6dFJDEAHDfiIjtjJeDrvSJlid5lMSvTFswSP5Dn5yUtOObgLhYE4dr3U7gvV04S8BEeKSTyJToxh8M3mFdKrxqtCK0IhxtLmXA8MdyHax7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBQO4paG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3A2C433C7;
	Mon, 22 Jan 2024 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956883;
	bh=KEX41Z4GRimqE32SG++boCA0zNkine8aAS5Yw0qR+A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBQO4paG9koX3vIjlW9iQWAqOGWjjUxV2KYVyhj3vtOVahAUl5Knia4Oz4WBlIzP9
	 VWofbRLhCV/89mY7ctYttJ5USrI7m1FxxWVbq+8CduQ4+c+O5BvtHn732VUVMYPpSr
	 PYPmtw7d7ILDIVgxkk9iozy3vkp5DFRFB8X/nULHO9MgdoQjKr1ODwz+8vAnda0tz+
	 X1n7wN+GTrwdnw5xG5RPmAEg6b/xRq8+GveyE4TLnv72dQUPG0H5iWzRlqdKcyHZ+k
	 IfiyKDVm8fG9zYJ4KkrcYFc++Pdu0ngzfssD40ZiNJVpoQUkyDSvZrzwp0pDjfExb4
	 YzGR8GDJSbELQ==
Date: Mon, 22 Jan 2024 20:54:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240122205440.GI126470@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122091612.3f1a3e3d@kernel.org>

On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:
> Hi,
> 
> net-next is open again, and accepting changes for v6.9.
> 
> Over the merge window I spent some time stringing together selftest
> runner for netdev: https://netdev.bots.linux.dev/status.html
> It is now connected to patchwork, meaning there should be a check
> posted to each patch indicating whether selftests have passed or not.

Excellent, I'm really pleased to see this.

> If you authored any net or drivers/net selftests, please look around
> and see if they are passing. If not - send patches or LMK what I need
> to do to make them pass on the runner.. Make sure to scroll down to 
> the "Not reporting to patchwork" section.

