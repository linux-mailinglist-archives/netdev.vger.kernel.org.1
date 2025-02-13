Return-Path: <netdev+bounces-165814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD2A336C6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4171886A3D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DD2054E1;
	Thu, 13 Feb 2025 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAH5t+hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CB78F29
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420296; cv=none; b=lC/dlb+7v6eThidUcecGS2QG1csf3Yw4NJDvwnzsyyxDrPL/nl9D1GtTX9n1elH3eLAOVzOAMHOiQVfz5UbYkTFqnBcXkx0fDE+2ATWyR7uQQKBYhOsrmb1PZID9WuDck0Mnc/LlH6IWTxn2YD2JYwrN7QGX/A6jfQ9hBf6NMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420296; c=relaxed/simple;
	bh=tryq4PXSjb8x/88a44RaEFQbhJLzK4Mly63mcyonQYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suZ0fl7+S/P+14AHlA47ZO/ChyhvWCEHmRvAXvC82z348/oqeUEfGxNL1CQAfLUN6d/X1MR0+cHPNMWbn084tIGfyakbFWhoZNnFZoqOiK46iYs3LRM3Kn9ErJ5cwQUDLXuLR5ijMYvv5IG5B/XHR3e4KyhJQUOEktoxPkTguYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAH5t+hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A6C4CED1;
	Thu, 13 Feb 2025 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739420295;
	bh=tryq4PXSjb8x/88a44RaEFQbhJLzK4Mly63mcyonQYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAH5t+hxwaDxqTZUxXHQrTWwr0pYS22o7Fl6QE8ZfU24/p/s2XZjJW9jlompOQuqo
	 NLBvTpSA/thdIn1DfCE/znlpN+Tdar5xOI+2+x/+o48+WlwTvfgllk6OY6TwrrDthr
	 Ug7uM2sRFQZ78gxB6Ye4nO1rbh+lJx0mOAhcbVMZfS83TKDD+qfsXokIpAfAeGzZ75
	 qsr3y0/kmpJl8D0rfGOeD9n89nrdgjQp8QyKdOWNam9/ImGevc25sUZXSOd1p/tVUM
	 fxvKcHROnwlf+sMRNQsKk+SV/1hAvS1C/shht5wdKCxvO4gpBuhEyOnoFvepcL6gCK
	 kfbH1K2iMCktw==
Date: Wed, 12 Feb 2025 20:18:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
Message-ID: <20250212201814.168bd1fb@kernel.org>
In-Reply-To: <Z61dwqIp7PD_-m0B@mini-arch>
References: <20250213003454.1333711-1-kuba@kernel.org>
	<20250213003454.1333711-4-kuba@kernel.org>
	<Z61dwqIp7PD_-m0B@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:49:38 -0800 Stanislav Fomichev wrote:
> > +            if cfg.have_stat_super_count:
> > +                ksft_lt(qstat_new['tx-hw-gso-packets'] -
> > +                        qstat_old['tx-hw-gso-packets'],
> > +                        100, comment="Number of LSO super-packets with LSO disabled")
> > +            if cfg.have_stat_wire_count:
> > +                ksft_lt(qstat_new['tx-hw-gso-wire-packets'] -
> > +                        qstat_old['tx-hw-gso-wire-packets'],
> > +                        1000, comment="Number of LSO wire-packets with LSO disabled")  
> 
> Why do you expect there to be some noise (100/1000) with the feature
> disabled?

We disable flag by flag. We may be disabling tunnel lso while some
background daemon is sending stuff with normal lso.

Looking at those numbers now, tho, I think I went a bit high.
100 * 64k = 6MB. We should probably set the noise to 10 super, 500 wire.
-- 
pw-bot: cr

