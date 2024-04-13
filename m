Return-Path: <netdev+bounces-87565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBC8A3A07
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31141F229B1
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7C442C;
	Sat, 13 Apr 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0lOaZIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFE4A33;
	Sat, 13 Apr 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970271; cv=none; b=LlTIVIK6J6P28d5tvVsc4Ydnpyl5pvj1wjCwcARqCLU5YnsywO0htt0kNQukHsE/cMi5sk1+VYNvNkchx2D1tU9d5Uf6v6QdnhrJk4aMQ2MUZ6wO4ikgGgbqoDkDarVyGamNkP+5dpN1Ww0VAwAM9u+RWJ0d0EVpbbV4Q3SI9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970271; c=relaxed/simple;
	bh=t/hrfk8gw6w+H7AWvzCmqfaACl/d0GovfCMX+QoZ1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHw80Eb+iPDbOL+D5/0nNUZHWjOz5GkYNlK7qWH+27cJW5ZuesOkrZbKkUKP16XHMtNUFnqzI1oFX2HajkE8+kaxblMMOaJGo8V2p+6Y7bsnqfszVTpXUhcre7U2840R3ddZrX3dWx6llbvbRT22re5b6L6/tb9ipvh/BJLbyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0lOaZIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5546C113CC;
	Sat, 13 Apr 2024 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712970270;
	bh=t/hrfk8gw6w+H7AWvzCmqfaACl/d0GovfCMX+QoZ1Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0lOaZIJFoVMIew2xMUuyqo2awhKqEWrttNdWm6aHDqX0pussogZ4tZDHRjjImMo3
	 ubJvIrpJ/KH/uIW/ilgotDPgqavb0FpYa8dKXin+p4+cD7neyi1z3FybXUELX8hIXe
	 t7lC71U6JNkvqCYhQOJPBXwtOiT+gPRwJqW/5RMHhGYPjf/7T0R2bvh506LaobSLiZ
	 xwfg8wT1TtjDd2zzxDhhfvhxPhj/7bEJ87cxauOd4/zm+SwdXYvEkDAIxGkm4nZUfx
	 V5d1UoEFUourIOXOFGnwgNaRV/9qx9+9aYWGdDkk4J2JqMuSZ695Xq2K0yk0KpfRJ1
	 35i16ivOd3Amg==
Date: Fri, 12 Apr 2024 18:04:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, parav@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com,
 liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com,
 idosch@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <20240412180428.35b83923@kernel.org>
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 17:13:08 +0200 Jiri Pirko wrote:
> This patchset aims at introducing very basic initial infrastructure
> for virtio_net testing, namely it focuses on virtio feature testing.
> 
> The first patch adds support for debugfs for virtio devices, allowing
> user to filter features to pretend to be driver that is not capable
> of the filtered feature.

Two trivial points: MAINTAINERS should probably be updated to bestow
the responsibility over these to virtio folks; there should probably
be a config file. Admittedly anyone testing in a VM should have VIRTIO
and anyone not in a VM won't test this... but it's a good practice.

Did you investigate how hard it would be to make virtme-ng pop out
two virtio interfaces?  It's a pretty hackable Python code base and
Andrea is very responsive so would be nice to get that done. And then
its trivial to run those in our CI.

