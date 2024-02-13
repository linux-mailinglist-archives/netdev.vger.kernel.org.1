Return-Path: <netdev+bounces-71486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FD853943
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B8A285FBA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C060BB1;
	Tue, 13 Feb 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9qpr5yA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BD60B8D;
	Tue, 13 Feb 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847034; cv=none; b=do0lrz7F7xcFmexXUZt4NkTYKBj6AuP8lz1oArWNoxEeLYRnWAMHlVOCfXzTnEzl1vcnFBFsrwSOuT8ldBGRBspRwLTfnopcKxI5avs/4R2uP/sWP7pkbEJsnJKjiUREh2q+LhVLqNDJI1yRaCLFf46N38ybjwJzheQ25y36EAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847034; c=relaxed/simple;
	bh=p7AJL54cuY4KYFS3by/F6D9R0dVFNRUSwqrLJRuSMQg=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yc7btLNCRuAiTWhTeAeuvXM+koXDOKq7C4i8h1PTqwc6E/TwPOS6mYFzsoeJc79fa4PfyZFiD5HJqbzg1hHZcHBJh6+CgHx93q0soei+LuMlhRdRdYzlA7pt2lJlInTGF976BlJNoclQAS+qBwJDKx7MjPWU/ndnFFfD2+ZaJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9qpr5yA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77FDC433C7;
	Tue, 13 Feb 2024 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847032;
	bh=p7AJL54cuY4KYFS3by/F6D9R0dVFNRUSwqrLJRuSMQg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=a9qpr5yAVKFfSHQUSnkydRdJJeDugjyVfUSW6Er929ZiveppEeL7XzqiNpNYI2Wo/
	 d2l3Sciefc701FpzPMwMcfK8BgpVdwlUZxVaiypduJz1aAOGlC4bCX+dCh8tG13d/4
	 VfXadmuVPJ9MIIblPwC4GsvXXhNdB0iYX6VYhSVkFAOdG51J1G/5mpsVM273yb5YuZ
	 YghwvzK7P5GvgS0wJDh3ab2pNr9lo0OaWwi4qzMs4Cftd+cHQOQjGHGTGHMRSVgYbe
	 LfihD87CIxNw5uaP8p8L4CVGK04/hzR8y4bCNrXDmn87RBtAT299fWPXhgNRP2q3Zv
	 Bhgmy238mfuTQ==
Date: Tue, 13 Feb 2024 09:57:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Feb 13th
Message-ID: <20240213095711.0e6efa2d@kernel.org>
In-Reply-To: <20240212213736.07d3d651@kernel.org>
References: <20240212213736.07d3d651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 21:37:36 -0800 Jakub Kicinski wrote:
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> 
> The CI is stabilizing, few updates to go over.

Notes:

CI update
 * good progress on stability and rooting out flakes
 * Mat reports that breaking out subtests from KTAP is now supported by
   the runner
 * remaining flakes:
   https://netdev.bots.linux.dev/flakes.html?br-cnt=84&min-flip=0&pw-y=0
 * Aaron reports OvS tests are almost ready for the runner
 * Paolo to reach out to Justin about ioam6 test failures
 * Patches to improve XFAIL support in selftest_harness posted, to be
   able to switch expected failures from SKIP to XFAIL
 * HW tests still need to be moved out

Queue rate configuration
 * devlink rate API matches HW perfectly, duplicating it buys us very
   little
 * Paolo to set up a separate meeting with Jiri

Thanks!

