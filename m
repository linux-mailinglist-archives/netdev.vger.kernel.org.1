Return-Path: <netdev+bounces-140599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303719B723D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE001F2455F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757D42AA5;
	Thu, 31 Oct 2024 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZqBCkTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39A442C;
	Thu, 31 Oct 2024 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339371; cv=none; b=mNhCK2zCQx2HrapwGINE9+ht4DQbHuYQ6Cg0RSgpErySEjvH/4laUCEYzU77m5HPJZULF4VrLAVrru8dOyWpnVGVMBMVCPj1ZkCHMgxOg6P42JNhqshnIynQZRRPXfQOslPR4QLKVearynzs2hnRygF1WxVYEVo5p9co/+qbC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339371; c=relaxed/simple;
	bh=8ahn1VB1Hn10WaMpYW3c0BOhGixbKAjaO+u0J+wFEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNQ24c3tEpt8P5xJTjLkXvQh5tR2j/ExZb2xE/WfFn00KzZgKULcHqrBN/D1GmNu8EvZRAqPshMsNT3DhR1tO86CShltg26AEupU0DwiJhwXRlYs5oF1jq+gNbH73H8mnMWDKKHz4LCLx8ld4X0soKIpxUe12VuJG/5wTzRhon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZqBCkTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF6BC4CECE;
	Thu, 31 Oct 2024 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730339370;
	bh=8ahn1VB1Hn10WaMpYW3c0BOhGixbKAjaO+u0J+wFEyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jZqBCkTKLpX6jmE0RBkwsbEf8gMS5FTsDpm5YrG/el+CnUgd6w4frtFfcDgBOnVO7
	 FDZ3eGHoPPH1E2NdZ11P8MuY6xRccnNUIKr3jwTE5XipHInJ/vraWvHAO8OZjEem7b
	 8ZPUq9dppIWiTIRRrkIoWTFmi6GoiWfBWkQSMHT53TvpW47jlGAT9TE0O3o0QTd3Cj
	 U3O/Fn7qlzS5L18eOLPyw1XAORUFaJG1Nq2DGznA2pjSyYuoKlkkTXuEuRFRf3cRgo
	 OGGF2EX8BT3j7GvfBwQw0r+DdKg4PvvcNRXWSEmRoyfwD7zDhjx3s3FQNu7xR8LodK
	 OtCy8mv4WoUFw==
Date: Wed, 30 Oct 2024 18:49:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] netcons: Add udp send fail statistics
 to netconsole
Message-ID: <20241030184928.3273f76d@kernel.org>
In-Reply-To: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
	<20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 12:59:42 -0700 Maksym Kutsevol wrote:
> +struct netconsole_target_stats  {
> +	u64_stats_t xmit_drop_count;
> +	u64_stats_t enomem_count;
> +	struct u64_stats_sync syncp;
> +} __aligned(2 * sizeof(u64));

Why the alignment?

> +static void netpoll_send_udp_count_errs(struct netconsole_target *nt,
> +					const char *msg, int len)

This is defined in the netconsole driver, it should not use the
netpoll_ prefix for the function name.

