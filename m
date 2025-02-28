Return-Path: <netdev+bounces-170881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2507A4A634
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C70A7A478E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75861DE8AB;
	Fri, 28 Feb 2025 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TETVAECS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75E1D7E4F;
	Fri, 28 Feb 2025 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783167; cv=none; b=EEipWO/fanbN4/U/80k0E1uWRSR6R5YgL4ZjCsHcdG3bcxyUzKJfGDJsUNsRLKDFdlvIe1wtV+TRy649oW8CcclvjOCU1ef9Fb/JTx7NUWM2jd4sy0tR9KvvPZtYq3X507MwujOhEFlIDXbUxWxIi4KOjYQAURh2jciAFuPSl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783167; c=relaxed/simple;
	bh=6SzRhSCbjGbVI+NUNAaY0KBy0yV5C+ZbJLfnaaZgbaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0K0b1Wnecmm76osFAf/EcRLsbLrEWoqftrz4bg8XrvzxH5cF7ox+yZZFdgpVvUjdXnnujwlITexkXD592ix7hw8v5pwdPI1YIaPoHKKupZSiaZwNM0j12OWcD3cjs+kdTiLbexmKRoNPZlXO2M/afE7uFJN60OfjXvdTc6ESRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TETVAECS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF472C4CED6;
	Fri, 28 Feb 2025 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740783167;
	bh=6SzRhSCbjGbVI+NUNAaY0KBy0yV5C+ZbJLfnaaZgbaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TETVAECSg5+p+NGbW9sKKNJk5gvH3peKgHMm1GgmGTf++FgsSaLnWQ3LHnpxkzGYf
	 eV3eOqasf2lIyZI/40kY49cn7LXhpmQzcif7gEU+KZpQR9qYQVVJlyW7ivApfrFdpN
	 JcCNicWf/ijhUJwk+WpxCFMMZf6msOpGMI8RbXaIpLjtQgQw1Cgl6akKj5MxsdChKA
	 RfzgpZ7cNI8stCpbo/FcVxd3BJ47QBGjwU0vHz56euM7rRqYpoBNQA7jeN7jaJdft8
	 TtcuDhqQphZLeb9qgdpFKPcfG9+EDejuK8RCu18408VKRZSPhIWH1AK9ImrKAU5jn6
	 I/oxy9k1u7Awg==
Date: Fri, 28 Feb 2025 14:52:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Elder <elder@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 phone-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixes for IPA v4.7
Message-ID: <20250228145246.7b24987e@kernel.org>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 11:33:39 +0100 Luca Weiss wrote:
> couldn't be tested much back then due to missing features in tqftpserv
> which caused the modem to not enable correctly.
> 
> Especially the last commit is important since it makes mobile data
> actually functional on SoCs with IPA v4.7 like SM6350 - used on the
> Fairphone 4. Before that, you'd get an IP address on the interface but
> then e.g. ping never got any response back.

Hi Alex, would you be able to review this?

