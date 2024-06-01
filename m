Return-Path: <netdev+bounces-99949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833088D72A6
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005841C20AC2
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03424446AE;
	Sat,  1 Jun 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H41Tfx7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04484437C;
	Sat,  1 Jun 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283135; cv=none; b=DKADI7k9A5RaOFdjxcw2J+xQAFebUFcpWOG5jJYjtEp6RgIA8V9hKX2RggUrgiBB4nQFtN6qVcRLrF4T5TWlULwh1mviYh+Pb7TLn1qf8Cjn3P3W6ntpz6P92iSkeREzFdqN6MW0qyYhcTUoLljaX+1ZYqNZZEvaKOaMmLLj9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283135; c=relaxed/simple;
	bh=vXRysHJ7OeR347JX0djOMnBBqz7wH9yNpRItiF160IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuvkbTmx7MRQnx0crqSExmWchqqjo32c0kMW74YdWABn3uyaSDB3Vn2O5KbvvxkVNXiXwNN4cpnVCaFolVDM9g+nI75ym/s1A3+1KU5ETVkmdTq/bOSDKMbmVY9af3VVYriXkS4iHCiRXxLETtxroCb66u8oGooS//5Ym9EVVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H41Tfx7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870CC32786;
	Sat,  1 Jun 2024 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717283135;
	bh=vXRysHJ7OeR347JX0djOMnBBqz7wH9yNpRItiF160IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H41Tfx7iKRNU2t0Qkcr2oG7OsGBkl10nagtBXQ24nOD5kbr1K6oLb05gQP1Z+R+uq
	 OEUPbKH1w8STff1izqVMVuoxJjqgWpCzsRjEkW4EHPVAobl83ld8mGONP0GZRHDw0h
	 s0966ARJDNjBBwE42z2quFtY+OI3MljcbbxpG6Dn8kRQOxPcT71sgcygfRX73LYT0o
	 wmRI9xyp7SKfJ+snBowXEDsM3IzYszUEOKleil5ZUTmV0OqZQXjWbJ1heugscFx8cJ
	 pHfixadXDo4kcRhmh1lJBo6M1FBuuz2V2z/Lh1/bjPWde/9oudK7veiJybFom32PMS
	 5Eb+y8U/eTCeQ==
Date: Sat, 1 Jun 2024 16:05:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: <netdev@vger.kernel.org>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/4] vmxnet3: upgrade to version 9
Message-ID: <20240601160534.5478fa47@kernel.org>
In-Reply-To: <20240531193050.4132-1-ronak.doshi@broadcom.com>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 12:30:45 -0700 Ronak Doshi wrote:
> vmxnet3 emulation has recently added timestamping feature which allows the
> hypervisor (ESXi) to calculate latency from guest virtual NIC driver to all
> the way up to the physical NIC. This patch series extends vmxnet3 driver
> to leverage these new feature.
> 
> Compatibility is maintained using existing vmxnet3 versioning mechanism as
> follows:
> - new features added to vmxnet3 emulation are associated with new vmxnet3
>    version viz. vmxnet3 version 9.
> - emulation advertises all the versions it supports to the driver.
> - during initialization, vmxnet3 driver picks the highest version number
> supported by both the emulation and the driver and configures emulation
> to run at that version.

Please review:
https://lore.kernel.org/all/20240531103711.101961-1-mstocker@barracuda.com/

It may be worth reading:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

