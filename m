Return-Path: <netdev+bounces-185290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2AA99B0D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B05D4639E7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CA1FC7D2;
	Wed, 23 Apr 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5PfqtLI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAE2701CA
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445585; cv=none; b=Jz9JCfOOQ/ZbplvCq/3NCo6MZtlEgKMGj7BDyUJTRDAwO3kYp7bNJGH30XtJmkiYhjFoWEVDBDOmrHWFPoa6Uz8D/2ev7PRoI3SU/jaeD53FEUvvfJEil838fW5M4iTVz0UdXSH1JS5tXtTFudcKlsxOwLeOysjP3bps00ucBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445585; c=relaxed/simple;
	bh=V1HrTHprutT6ngF8oUxxcI45yRbI41X/+RA6EZ9Cwd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdIo4f1Al+1zTizrv69uU0puQooqwrfixh9uCHaj/zZEnih42c5bp9ADC0xOFDLzCiKX9jlP+Yo1JtmLCiXrV+lMh3zae7LyGHBv9gwQFUp5h+UqM/yD9/pnzsRmmgkireyXXY0i9AH4ECpnRMjqY8TrbteBlHheW92bsq6qDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5PfqtLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D126C4CEE2;
	Wed, 23 Apr 2025 21:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745445584;
	bh=V1HrTHprutT6ngF8oUxxcI45yRbI41X/+RA6EZ9Cwd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5PfqtLIUBZFCuFBQWiSPKtnucDZsOpCo8eYZvg/BV/33HURlvSj8eIl2vPmanXXT
	 3wt+1zbYgF8vofb6u9LJvISd7PnZlKJnQ7HQk4jGoS5L9vOwpMsgbx/RV5n9f0oEQB
	 8A236s5eveOGm+93wvxmqldHAy1lIcnqAoSK5KFujk9N8CCyVeNJsiv0iMi5EEClGs
	 EmWe8hwyuie5TvYE4Um07hw4Sjstrlx2ULIUPFizSaTHBsMZsp9zFvfVqHa47nHtlH
	 iGyi5CXv90mlMEtew2vfDZ6cxArnc11u3kjkzRsMBSwCL2Ctan8T5lqwRzYVC+8DPa
	 kkblOs085zKew==
Date: Wed, 23 Apr 2025 14:59:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Kory Maincent
 <kory.maincent@bootlin.com>, donald.hunter@gmail.com,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] tools: ynl: add missing header deps
Message-ID: <20250423145943.55479e70@kernel.org>
In-Reply-To: <59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info>
References: <20250418234942.2344036-1-kuba@kernel.org>
	<59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:28:07 +0200 Thorsten Leemhuis wrote:
> Does anyone know why this problem occurs? 

I typo'ed the inclusion guard :( Will send this shortly:

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 8b7bf673b686..a5e6093903fb 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -27,7 +27,7 @@ CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
 CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
+CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)

