Return-Path: <netdev+bounces-64503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271E83573D
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 19:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B24281C24
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF13838B;
	Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwbO0iKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9238380
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861283; cv=none; b=oyrMzos6h1aa6JjzQbwxNtRfN6g46JGvBGQdhbxEpdJk72JYqySM4als8re1rSnYrde8fFM5CVlKntB9TTe+FMtw/Qxn2cszQNIzUNZA3ppGtAg/oO/3JwsDa3/5QO+wuyoRXxw3/jDH/ptffrQ5qBPSy2sf5fIaHmXdCOGf9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861283; c=relaxed/simple;
	bh=pMjLSdDvZNyvUwDM5dr+/k9ky+gpYkg2n+u1mNpEqVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rPGTKOIkTTqiHGEjebsgA7mloUcJDTViKIZSP4hIJV8U5ULgmHIYOtfhMZkqs7oRlnUwJt4KEsWPOaJs5k5Cr6S/EgLdS1LKt1rYnomywv+tgOyCPZyDUIi2Wr4Z+5qKtgA2HFZxoDXOHx+uygPuvVH2loPcFPeufJB9b0aGrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwbO0iKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4092EC433F1;
	Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705861283;
	bh=pMjLSdDvZNyvUwDM5dr+/k9ky+gpYkg2n+u1mNpEqVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwbO0iKhyHW8lMiJSNEHidMfMpJax+5THX5OeP721g5YRwFTfCFDTKL6RETn9NYUr
	 BKS3lcXfGVLYzeedlDAoVks3tVEVtQycltd5K19VC9kNzsfUP6FpoKZGLsJST9SXL3
	 ySjJ/NbmRfCe4NIEKEOY+NQHf+nC1Vd5513TPbUwquK7Lb7LldfIuGt6OSq3ZWIM0F
	 grUkH1UEYz6gU/+BbDm38Kk33ihXVEQcUVA5ipuEDciOfXcXbyCbqN2ydMSRclV1M/
	 wXUi1TzaDs+CEnnftaGANSixLnEAR4H8jpPmB6U6Qb4Swwq7diaI/Lzi6whB8+dvz3
	 OhAkJLvUdTDTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F804D8C978;
	Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: distinguish vports by the dev_port attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170586128319.13193.14696779543743835984.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jan 2024 18:21:23 +0000
References: <20240118205040.346632-1-mschmidt@redhat.com>
In-Reply-To: <20240118205040.346632-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, alan.brady@intel.com,
 pavan.kumar.linga@intel.com, sridhar.samudrala@intel.com,
 shailendra.bhatnagar@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 21:50:40 +0100 you wrote:
> idpf registers multiple netdevs (virtual ports) for one PCI function,
> but it does not provide a way for userspace to distinguish them with
> sysfs attributes. Per Documentation/ABI/testing/sysfs-class-net, it is
> a bug not to set dev_port for independent ports on the same PCI bus,
> device and function.
> 
> Without dev_port set, systemd-udevd's default naming policy attempts
> to assign the same name ("ens2f0") to all four idpf netdevs on my test
> system and obviously fails, leaving three of them with the initial
> eth<N> name.
> 
> [...]

Here is the summary with links:
  - [net] idpf: distinguish vports by the dev_port attribute
    https://git.kernel.org/netdev/net/c/359724fa3ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



