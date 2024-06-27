Return-Path: <netdev+bounces-107433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF791AF67
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E0F1C22427
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4C19AD55;
	Thu, 27 Jun 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz3Gn79Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9919AA69
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515029; cv=none; b=LHQR2/RGFuv9QXHO7VWlOWY2VSBiYTUnlkxy7jzcg2TFbd0kxrZwE9ki4qcZZbsvc/1m2l3Y2TUVaMrCNwroMaQfzuDmbBbCgQv29+Zp4HnxHlNAf3I3MfX7qQAMSplBgrV/regq4g7PUfj/tL0aH/FV1OwlN9HrfS6RDZUCc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515029; c=relaxed/simple;
	bh=It71+8zExw06AHJjm3k24hGVnxHu5iCR7annE0l98x8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdMqFRm8BaDwSmWZ8R6VOy8ArWV0imUmEounJUyN/obn5LNV8qEBOo3k3arqTgwLII7e4VSohlqxL1pqoGcUuEWOYWQ1MVbtLMsH17aXlKcQet1IbdEF6zFvCbEb7KH6+b7d/jJoeFjoIQOE5XKskt2lrIJ48KgGHc5bzDu5uJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz3Gn79Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A6C2BBFC;
	Thu, 27 Jun 2024 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515029;
	bh=It71+8zExw06AHJjm3k24hGVnxHu5iCR7annE0l98x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kz3Gn79Yo0NHyMtlDcDlVIlcos6I5WZP7MpxScJ3eACoafhSG25wL1yhJFVRHZ8wo
	 q5cKEGqSPTZD60MLOBkuvsdmCSvP2uGT0zTYVt3G4vSYBPxBx7K6AmrflXT3jhGMEr
	 FMW4IgwPeGRkragaN1E7MVYErxDM91rWEaVD/VGsl2nvEOxXDrC9FDVujhV6RHq7Rb
	 HVJduGOLEVPKfsCY8GXXwRlzLECNLRzWk9NUvDg39mBeF/KWd9EWNpdp6gw3nsrSUK
	 vKvM8eoBKEUhhgMRAxjOn+Mk0G3rjAcj7hWD+d4f4D6QJA6DTJiu8vlfbLumC8uCp2
	 sr1+kWq/LI0Qw==
Date: Thu, 27 Jun 2024 12:03:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] tcp_metrics: add netlink protocol spec in YAML
Message-ID: <20240627120347.3864cb62@kernel.org>
In-Reply-To: <m2o77md9o0.fsf@gmail.com>
References: <20240626201133.2572487-1-kuba@kernel.org>
	<m2o77md9o0.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 10:20:15 +0100 Donald Hunter wrote:
> I had to add tcp_metrics.h to Makefile.deps to get the generated code to
> complile.
> 
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index f4e8eb79c1b8..2f05f8ec2324 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -25,3 +25,4 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
>  CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> +CFLAGS_tcp_metrics:=$(call get_hdr_inc,__LINUX_TCP_METRICS_H,tcp_metrics.h)

Indeed, and I think we need to add _UAPI to the guard. Or just include
the file without calling get_hdr_inc. I'll send v2 as a (tiny) series.

