Return-Path: <netdev+bounces-86290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD189E52A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF94D1C20C8C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927C158A2F;
	Tue,  9 Apr 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOAZ+GTD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A864156F40
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699310; cv=none; b=VSR+X9EwAgluNA6ReodFGkQRZirn010U3Od5Q5lOMHcn8FJLdcNvEnGWqYx0WJ3j3QhpifeeqOugR/M5VY4pb5aO8ON9mxwSpGJ/9IClfVk4GCn4pt1yAyIGeT7bkpVx5gF7he643zB4Ct4YBJUSSm2NlGSejoiFYh6BNQG/gNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699310; c=relaxed/simple;
	bh=gAmCCUFVi77D0kNi1hX8tT7H1YpE8cIF/BcJD7IYhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiThwmbaygVKO1FVz95yrncvxt/cvIpzcM1hpUHVPP3hxw3zoQD8HoMsWUELK5h3a4CmAN8DU0/eZCLaIRXeNNKYAj97RjJBF31kqlH5ufqee/tdMDDC1it7Te+76yqjaQHmm/Shxp2MxOEmhZ+BNw8uBWUgDxUx1E97twdtN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOAZ+GTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241C6C433C7;
	Tue,  9 Apr 2024 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712699309;
	bh=gAmCCUFVi77D0kNi1hX8tT7H1YpE8cIF/BcJD7IYhe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOAZ+GTDumb8IwzkSKBCUu7+mNFX9rvXkXULkciJ91noShnyEDqO12WXMvQ7WDGpS
	 SPpPY2VC3jpCL0XdpRkf3Gw0gO/w9uORNnMgk+NfonGVx9js1vV8dloz9rDR5pXeof
	 I1XDfuC4av67fVp5Liysm3L+wGvbNf5wj8+pVPniidA9MHVmdYDWPCOIp55t2rivo6
	 I7nRNzKskM4vFjZjMurAZ3D9WyjisUoSs9ZGoj0epk3Ks/E4+F5QvGN2L0LtRbHV0v
	 mEXwTGbtTC8f0yZxVmk1ajKvdmSTQhg+PmJzHT+6d8lP8bm46oxZrgepSCQfSQxetC
	 OyTOlZnuwiU1A==
Date: Tue, 9 Apr 2024 14:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 cmi@nvidia.com, yotam.gi@gmail.com, i.maximets@ovn.org, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org
Subject: Re: [RFC net-next v2 1/5] net: netlink: export genl private pointer
 getters
Message-ID: <20240409144828.0af53b8f@kernel.org>
In-Reply-To: <20240408125753.470419-2-amorenoz@redhat.com>
References: <20240408125753.470419-1-amorenoz@redhat.com>
	<20240408125753.470419-2-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 14:57:40 +0200 Adrian Moreno wrote:
> Both "__genl_sk_priv_get" and "genl_sk_priv_get" are useful functions to
> handle private pointers attached to genetlink sockets.
> Export them so they can be used in modules.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

