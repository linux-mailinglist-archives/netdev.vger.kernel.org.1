Return-Path: <netdev+bounces-71163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CA85283F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863F8B23B41
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 05:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80C11C83;
	Tue, 13 Feb 2024 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unaT+RSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD1EEAA;
	Tue, 13 Feb 2024 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802658; cv=none; b=sItNIpLKsEhQ/rEJFh6sk8+INpMRphNaNrTrgnuOaAh5a/QeGjTmr1d5Au2tRQKdPhoPQX5ABozn9iKkM2GeVd1pyZ7VSyzhBoOwrST3Q3SfEiRTvJ0rHK07r2KwGzi9fNO7hAWOvLqSTtsrBZ3CODM2vefF9pNziajfsvcAzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802658; c=relaxed/simple;
	bh=bKgAGEsZ6pprC3GHA+4zGE96jtYyl01EEJO9mh0w+yc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=UyDqJVWtrsjIVRFB9c3Ileo5aeRlTFaSHdZC5v2Le2VmBCfPexFmpkaE8VbRlCtppdLxRKJkPVsQYrAJdVopb5uqWpV1wTEq31Ia8s8U1TkpEjEgSSUXPrVcGGHMLYIpkRWNNWxK1VaB54eSUXSieR7fZdsISWq1Ag++OLp0jeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unaT+RSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643BBC433C7;
	Tue, 13 Feb 2024 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707802657;
	bh=bKgAGEsZ6pprC3GHA+4zGE96jtYyl01EEJO9mh0w+yc=;
	h=Date:From:To:Subject:From;
	b=unaT+RSMW+JYvwl+uGLIjrv7hFRPb1Z4NE/mW5DgNd1ueNuuGp41k+ZLA6PwLoqc0
	 rOPkEMK7FKNKr8zfI1MuulQ9s6ZsweVKbpyks4x9jTZTWIaCPgpNbFolU2wCp5gSI5
	 KhqOX03rSVNSnE3Lba53qmBmaN2bj+XqQM7Q2VCdq32RLVAtSUt23Pzi0hCNUS9Dfg
	 5gITTZRhCyOYdUtf47rPSAeGjqgPr8tpTQNgzeIqKBI39oOH9XVkSs56QKZfm87HDp
	 IB52jobLRaiUbjGK4Yur53f68lG9FoE3wXHx6V49AO4b8NSN1oFlu+EtcHC0Aw/w1d
	 XiejDcPcWap+Q==
Date: Mon, 12 Feb 2024 21:37:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Feb 13th
Message-ID: <20240212213736.07d3d651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

The CI is stabilizing, few updates to go over.

Other topics welcome!

