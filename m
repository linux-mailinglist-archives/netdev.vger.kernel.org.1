Return-Path: <netdev+bounces-190475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F960AB6E48
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA1E1B667E7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE01B3957;
	Wed, 14 May 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRmmRIyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A071B3927
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233724; cv=none; b=Q1W5P+6zDXNa8/epmcDrwtQR80wM6IdSvZkOzg9uO6fIHwHCWStijaBMuzWYgSoHgLirIhHjVdBpHQ4YbH7phstgjAZoxPXbB6a99FDtRgoyJXD/8OABJUWLw4DrgbfAWh7XtfHRdZgJmjSINUq822dv943ziOk2lDOSNlJ3NTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233724; c=relaxed/simple;
	bh=i+ia4gaPsI8QQxDosTtCTCynWN4Gq0MlrEQrMMs1Z5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTHJ6yWMXyqieAnKMn4fJp4WAE/ESNRZT/4j1a/zG/DRM8oillBf2zZGxsgzIog0vTsspRnddIaoQ+PHOgJruNPMvizKy+yCg026Hcc9MCjHrhKBEZEnnC9AN+v6cLB96M5eQxrejooEB6oqJHLbV+KyvDbeQ4Vnytlb1H91W8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRmmRIyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9E5C4CEE9;
	Wed, 14 May 2025 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747233724;
	bh=i+ia4gaPsI8QQxDosTtCTCynWN4Gq0MlrEQrMMs1Z5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRmmRIyrEdzrV6ToRUeo9D+FVuOjkB3mL1SKxSgY9/Gzh/WFCjFVGby5tYXhArFti
	 I/z8ujYyAOHmDoQkDNRz0ghpBrTFL3c+6cIbvowDK3UoqWdkleiX4BDhnweWESIfRY
	 oztH6AT//AwZE4nLMMZ+dicI4dw8WAGIyTL8TqqWkjsZ8tZlUGVRQisu+Qtzrflwpj
	 t64Ozq/IgimXppLA69g/TaKlwUzN7CAwp4cg+K/ffz8qxF2zQjXKHcgdwAVXoIlgEo
	 V5ZxJNjPolDTJpO+cD+CKd/vaX619K3UU49TRAjzE7zwcOLkTuCDZ4Zgx5vzWt/jsI
	 NKX1YDgj0A4tA==
Date: Wed, 14 May 2025 07:42:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 0/2] Add link_down_events counters to ixgbe
 and ice drivers
Message-ID: <20250514074203.31b07788@kernel.org>
In-Reply-To: <3b333c97-4bdd-4238-bfab-b0f137e5b869@linux.intel.com>
References: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
	<20250512172146.2f06e09f@kernel.org>
	<3b333c97-4bdd-4238-bfab-b0f137e5b869@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 15:44:49 +0200 Szapar-Mudlaw, Martyna wrote:
> The link-down events counter increments upon actual physical link-down 
> events, doesn't increment when user performs a simple down/up of the 
> interface.
> 
> However there is indeed link down event from firmware - as 
> part of interface reinitialization eg. when attaching XDP program, 
> reconfiguring channels and setting interface priv-flags.

Maybe I'm misunderstanding, but are you saying that the link-down
counter doesn't increment on ifdown+ifup but it does increment
when attaching an XDP prog?

The definition of link_down_events is pretty simple - (plus minus
the quantum world of signals) the link_down_events is physical link
downs which the switch / remote end will also see. Unlike software
carrier off which may just configure the MAC or the NIC pipeline to
drop but the PHY stays connected / trained / synchronized.

