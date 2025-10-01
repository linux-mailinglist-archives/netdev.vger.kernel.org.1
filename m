Return-Path: <netdev+bounces-227418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D92BAEE3D
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D91884771
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025B1A76BC;
	Wed,  1 Oct 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWO98+OG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BE19CC3E
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278862; cv=none; b=m5aZLCx3lrKaoTR2EgO+Iucg17WP1XfLUWq2IzxGzuLAV00aoEDpWpZTVzFJwL/6KTBoGgToNxpTVuufxqM/OA/WiX6xrDSvD70atcY1CZFc0DCb8tH6Y0n8ru/EpeYs595yvzKrbMH1A5l5dOdqpYZav70+AVR4UMI7UiG3d68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278862; c=relaxed/simple;
	bh=8KMYC+aqD38IQHhaB3PrP42uGO7mpBLEdJrJNawB9s4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVMv81oFztnKzk5X4ziJnrb1tOv7lROVvE+rZH39Fzm+OouQOb15b8hI2Th8wAysbqJIqw0FH5aYRkav00vUZBzpcA/0gq9MzyphOtBb+uH9cuHGShfchejGKAmgA1CMMEh7+PCHnrHUGdDS96NAmMl2ke65wefxH5zLBpTz1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWO98+OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51258C113D0;
	Wed,  1 Oct 2025 00:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759278861;
	bh=8KMYC+aqD38IQHhaB3PrP42uGO7mpBLEdJrJNawB9s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWO98+OGkrzGoAVU6ZBjkH7qmpM9RpTOmn20sI8HvvFfy3ggeY04ThaTt25lGq1Uo
	 hC1osn2hISi0l2N1z4JmgJU3rpT5teWt3fOPKUW9/CKrA9Ip+9FmhMMs5a/r9i6m03
	 Azs5wZkaAUEpABVX2ZvkjWgpFmitzHtn5hTujdIdZmA5slQ+K8m4/v71XJnJ/Yy2ol
	 dzl60PT/GBC6OTr/tp6rvPIF/XGFE/yrUFodEmONe/O8ZnhY6VesV6FNmvb3+XxWE9
	 nFjHQap3D/2Kx0PhhndqtbVNnmcAcvjXs6nLYf3Ko96jZC+R5hFg9lpppIIzmxwfHL
	 wVouTkzvLfEpg==
Date: Tue, 30 Sep 2025 17:34:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v12 0/7] bonding: Extend arp_ip_target format
 to allow for a list of vlan tags.
Message-ID: <20250930173420.24fcc12c@kernel.org>
In-Reply-To: <20250930233849.2871027-1-wilder@us.ibm.com>
References: <20250930233849.2871027-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 16:38:00 -0700 David Wilder wrote:
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See bond_verify_device_path().
> Unfortunately, with some configurations, this is not possible. One example is
> when an ovs switch is configured above the bond.
> 
> This change extends the "arp_ip_target" parameter format to allow for a list of
> vlan tags to be included for each arp target. This new list of tags is optional
> and may be omitted to preserve the current format and process of discovering
> vlans.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

You're reposting this too soon in more than one way - there should be
at least 24h between postings. What's more net-next is closed right now
and Paolo told you this in his reply on v11.
-- 
pw-bot: defer

