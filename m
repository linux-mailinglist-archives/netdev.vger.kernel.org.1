Return-Path: <netdev+bounces-77338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088F8714FF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3278A1C21019
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7445953;
	Tue,  5 Mar 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZX5xkZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239B45945
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614355; cv=none; b=b7NTB3JmM9kjOuW90g/QEiWgBrcFEfHE3zlXI1/ZgCQQ3SRyQrUYF2HdNlBuNyWgj9ngr543Ui6KNX5lhe921aGDfHm44vpdlneQsSZFUTtpOtSf1v4FfUvH00VZLDlTZR2qkISyqUhmU6IwiE8J3SYq9rnliesIwMYciZAaLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614355; c=relaxed/simple;
	bh=WZmHaReCW/S55iSL30M2BM01ovRoAf5M2HZOagWsdpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxrgJmoZt5hAVfHRV/SZTRE47KQnIXorznl4qeUNIFoR4iMe3k1Iy/mGwBhL0KU5PpMOpV/44yEpVlyKrk4cUp+dMiRw1z99IUrDhRjS2bgA63r7ZwgzqG8n7UUZbP+IIKfIdizqNapNI0KaArZJDInbadSz7HwaTTHBA+aZ3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZX5xkZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33E3C433C7;
	Tue,  5 Mar 2024 04:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709614355;
	bh=WZmHaReCW/S55iSL30M2BM01ovRoAf5M2HZOagWsdpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZX5xkZDOpY/FB1a/rnVICrtJ+EHy1aFXd4YQDT34bpMFSTWixL8a2zuMczp5YOxa
	 SKEIeHVu9U6MN6GkjcUG+JQS5ekuY84e9NTWvW3lAkRbKCd7u+y6hUOZh4kUggDjJ8
	 q6B8qcfwwszB52i1yQ0ARINSykcOn5Kd+2418RHH4HGbJcqvaB0GXYfX0SqC7egzey
	 AyHEihbslEJzvhmWtc4+ekjSqwhe3zZJKySj5KLONkOkvkXeABN9ZwU10h4GirT2qM
	 TZjoh+hUAhDjL/JypRXXdDVwrqDLnx6tjR2nSCgN2iphEqTBNrN1q2jlarWQmSX3ga
	 F7ZgvowJfkhPQ==
Date: Mon, 4 Mar 2024 20:52:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver
 Updates 2024-02-28 (ixgbe, igc, igb, e1000e, e100)
Message-ID: <20240304205234.7f3809f1@kernel.org>
In-Reply-To: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Mar 2024 10:48:01 -0800 Tony Nguyen wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Branch is empty, applying form the list.

