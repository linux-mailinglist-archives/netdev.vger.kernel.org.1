Return-Path: <netdev+bounces-131198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A598D335
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D401F210E6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570611D0798;
	Wed,  2 Oct 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpu+qaLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDB1CF7AD;
	Wed,  2 Oct 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871873; cv=none; b=o/tMXsuaGstWSm3hNs2ZmbB+tuji7gGerEPqFEfk52GRxHaTZFp3nVkCx8MjfZctw629PNYdJC/0eRji0NUZUwlpI4Ci3kuICMCQkfWz2ubNSe6nz8gzcSEFpQ9CZhc8CqiYjOrjS4N+EQ/xiHD9tI7st+4m9rf7OucoRLO9LQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871873; c=relaxed/simple;
	bh=J4yXn1XWnwW323VdrKw6Nt4cVDOFkgGgpEBsIie+JcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGflZQTRKlIlF55zTngB6sJoLkjC15bVgW+F2Whx/WuG+VksVK0MTfvYR5rP20xNSa4CADE+pZgFxR7WOJEtSDNDH32UNnex1WWA3ERIh19u3CgBntFl64RS84smG5YxCoHQnAoX8deRWC5JI7JGHmKN4ILDA45fNSUrUbVi0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpu+qaLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB7C4CED4;
	Wed,  2 Oct 2024 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727871872;
	bh=J4yXn1XWnwW323VdrKw6Nt4cVDOFkgGgpEBsIie+JcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dpu+qaLWoew5rISjCJovC7i4v8D5OdevB9pLALQBOvzHhtt/8nhB+nX7hUdB6ovfB
	 6v35KO6IoaJ2i1L8nHS98ZqLECDdVWk6cpbJeqt1nhK8JJRZ56n/emJ0MBEct1b7DM
	 FF+CbrjD94lKqXimwlv5cBQJCgV6oht11TWYRBDT1GPzo8hmA6ABBeIlpn/+LHMQiw
	 zZGk2XF/8oGvdxaWvzlhRUy4MThmHQcvskntxstfbxmGZu+8Qi56D1dLWB2E2AtukQ
	 a+YzJGIO+52eb6Kyn5o9LwYSmGS1EQunZGree7jcHdkRMM2NVUDYRsV09rj3St+A0d
	 7zBG8qvSahhAg==
Date: Wed, 2 Oct 2024 05:24:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002052431.77df5c0c@kernel.org>
In-Reply-To: <20241002102340.233424-1-kory.maincent@bootlin.com>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 12:23:40 +0200 Kory Maincent wrote:
> In the case of 4-pair PoE, this led to incorrect enabled and
> delivering status values.

Could you elaborate? The patch looks like a noop I must be missing some
key aspect..

