Return-Path: <netdev+bounces-226567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847FBA22CB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D1B7A6090
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766B22156C;
	Fri, 26 Sep 2025 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIYcc9jV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610A221DAD
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852015; cv=none; b=tSW53R8A4rBvyBKaSNSbzxFofkuuhh84iNKJUee8z0LjPdQyqIwGBX5Ad9hFN4xtafPEW8ymt++VaiCde3dm/uWEsgI1fgevsSaC7AJeEpdyh+TelVg06F12TrFqWtAdAwo+zSg/RZ0s+Dru8ArANasXte0xR9piqT6kfeTm438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852015; c=relaxed/simple;
	bh=c0AjAa4UbhcAiqd5Ooj9+Es4YVPslcJD9CzAighG7cY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ0k8VYBUIOm8qf2WL970JqhzJOYvYNR/GJJuWGrmyXs/eWXtXpvbhr3vOqgECiM4uUiOC+ZBhL4szB6aq2juc3rkwZ8vrU2znqtq0sh2g14I8dYSm8yzFUoabX4ARywTzxK9HTfvV7fzH7OOsoatw+X75VHGbI2VxNLh0dkAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIYcc9jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D9C4CEF0;
	Fri, 26 Sep 2025 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758852014;
	bh=c0AjAa4UbhcAiqd5Ooj9+Es4YVPslcJD9CzAighG7cY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIYcc9jVmqYxUJah9bJBh/cHoipP/3e/Odx+s4/ra/kk/N/hAcjZBDs/SNxKG8CIX
	 rBcmugsNMX6RhkOLF3E/DMxj39ACacRrR8qnbf0UKUMj3ivfWcdOWf4nwB29gh0nkY
	 BRzQ2+niSpaIocvNaB6hxoo7MMyhLEyybzg3VGy9G4Pi5HwbAgk8BTBfNiRfqS3pr3
	 bFpkv5OBpi0jXPSi5/26HLYGhnHXdE7NMPQ4myvsvTWZSn75AO6+QV1b2Qewt5pPxK
	 XcPufBws1QWCta53cSe2m6xRc+qOB0Uv4k+rNKBP3AV0oYRl7wrhr1QVXyFCi3+wHW
	 2ac6giWJmsxbQ==
Date: Thu, 25 Sep 2025 19:00:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: =?UTF-8?B?SsOhbiBWw6FjbGF2?= <jvaclav@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <20250925190012.58e1b3b1@kernel.org>
In-Reply-To: <c39e6626-02db-4a83-9f77-3d661f63ac0e@suse.de>
References: <20250922093743.1347351-3-jvaclav@redhat.com>
	<20250923170604.6c629d90@kernel.org>
	<CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
	<20250924164041.3f938cab@kernel.org>
	<c39e6626-02db-4a83-9f77-3d661f63ac0e@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 10:37:38 +0200 Fernando Fernandez Mancera wrote:
> > I'm not very familiar with HSR or PRP. But The PRP_V1 which has value
> > of 3 looks like a kernel-internal hack. Or does the protocol actually
> > specify value 3 to mean PRP?
> > 
> > I don't think there's anything particularly wrong with the code.
> > The version is for HSR because PRP only has one version, there's no
> > ambiguity.
> > 
> > But again, I'm just glancing at the code I could be wrong..
> >   
> 
> No you are right, this is a hack made to integrate PRP with HSR driver. 
> PRP does not have a version other than PRP_V1 therefore it does not make 
> much sense to configure it. Having said that, I think it's weird to 
> report HSR_VERSION 3 but fail when configuring it.
> 
> IMHO HSR_VERSION should be hidden for PRP or it should be possible to 
> configure it to "3" (which now that you say it, it looks weird).

I think we're in agreement then? i was suggesting:

--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -166,6 +166,8 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
+	else if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
+		goto nla_put_failure;
 	if (nla_put_u8(skb, IFLA_HSR_PROTOCOL, proto))
 		goto nla_put_failure;

This will not report the HSR version if prot is PRP

