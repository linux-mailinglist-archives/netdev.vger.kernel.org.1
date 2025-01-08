Return-Path: <netdev+bounces-156121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD072A05069
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F247A0478
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAC197A6C;
	Wed,  8 Jan 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfe8jRuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFD15B0EF
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302402; cv=none; b=JGV4sQWeaSHh8zxqKkVpGMGCmG7+LUGlWdkQUI0fKfTznReXL5NzMY2HCMNCfB13UF0u006abadBAedZhEz5gQ/OMIetMAjwlPLbwCyRtZH6zy+vwrneOfyZHMj/dvbnBUUKcPqCFV/wT0a0Z7hFaG+hxms+//n5/OAwHUAL5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302402; c=relaxed/simple;
	bh=qZkzGI3nm9XE7nKbSy/TFIDf+xgcmnHPd6NigLqTb70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtjUlca7ao2GB1lGawYyoP6oIfl6eS5/hpsevqrSJsxMXve54+a+PjyNsIO4c97WU5wQUOAm2nQY2ya57n21Pxm7fbDiRaPWJPubmsyaqqfuPLYm7uJZ8EGrt8pZVg1czcCbaFnWjeoO5nv5mkIGLv2PwcSC7PNTwcKRKnLNSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfe8jRuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36658C4CEDF;
	Wed,  8 Jan 2025 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302401;
	bh=qZkzGI3nm9XE7nKbSy/TFIDf+xgcmnHPd6NigLqTb70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfe8jRuy1jTbIzG1qk/WHQajYhGi+/oRy28zpf1z71LjdtRvivpMi0ityPomDrJ6s
	 wUfwJOJh9vj5Box4frjjPHTaJ5vKTAOOCRhtsb1hF3x1faTq5RK+bXzlI7QSL77Hm6
	 iUfXaojB7L45XC/xTBSz/Ef8xj8z/dbj/LaYk0It7kZ4GlWsaxR7Zd0Ndjs3TzHory
	 Pn58IYn3rD9D6226cbUj1l40W6dD67E409TzB9nlIx+2cwcBg0drI3IKaKzy2w00FX
	 ukh0qG0S6vy9XpYqOKebu4KnHVd4Vl2gzLfwDq6R/Iv0NtXdPbzISzu9vTrNqTBv/P
	 iALD5XmTVeHrQ==
Date: Tue, 7 Jan 2025 18:13:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates 2025-01-06 (igb, igc, ixgbe, ixgbevf, i40e, fm10k)
Message-ID: <20250107181320.1e006718@kernel.org>
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 14:19:08 -0800 Tony Nguyen wrote:
> Yue Haibing (4):
>   igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
>   igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
>   ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
>   ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

I'm going to apply from the list, these don't need a fixes tag.

