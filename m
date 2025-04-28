Return-Path: <netdev+bounces-186423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437AA9F132
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA011A82E21
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189526E154;
	Mon, 28 Apr 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FOH+ZdKC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFB269D13;
	Mon, 28 Apr 2025 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844114; cv=none; b=kF1aGvFGuOBMTmITP8qimBnxVT6PqiJ8BIJr7KUu60SctKb6Fl34xAXMWtuut374V4N5GRll3dEnifXvjVvqwrRme4aBVyQlAtW4IcePuZySYHqHFyILPzxk7jpoVhw1bHvUiHxHD31kZjqVLyZo1PuTW8pZo1IoCdiXQZ4fRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844114; c=relaxed/simple;
	bh=fG9PGWdg0B+9vnOam/QT4Vm8XL31KFEpwMdoC0jSNVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI0iYh9wzRmwf8QdSo7d1x4+/9gMwFzeJSe9mJpTonQ02qVrjMsFX+e6unPKfD5PXMOE33An6INzNL7yk6tEOj3CgTiwR+BuO1Qncvxl1AEp+EjDlLDL1Xjk5/ZiPiSfvztaVWcIvBfJ20ur1RV45FVR0+AbP1XAjDLPkHitayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FOH+ZdKC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6IT4CRu7szLgApWWo4521Q5za6MZcWaGmmtSs+5pkOo=; b=FOH+ZdKC4QrpIvSRtVkcZj7UVH
	ZHE+CijRqzjg5YdTR+FDQ3BWgnN7Iclwi4UaHby/lAq0B0KmavFHf0q2JyPSZQWaVibP9BazuV2Oh
	lxHk6batO6EE8Nt5yTXb7Sj5f0gcU0MxtsYgLS4Xe43120VdgXH1RjuynpllOkbTMR10=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9Nnt-00Apu8-4w; Mon, 28 Apr 2025 14:41:45 +0200
Date: Mon, 28 Apr 2025 14:41:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v0] net: phy: aquantia: fix commenting format
Message-ID: <b8fa57e1-3c61-4c70-9aaf-2753ae880a88@lunn.ch>
References: <20250428003249.2333650-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428003249.2333650-1-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Apr 28, 2025 at 12:32:48PM +1200, Aryan Srivastava wrote:
> Comment was erroneously added with /**, amend this to use /* as it is
> not a kernel-doc.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504262247.1UBrDBVN-lkp@intel.com/
> Fixes: 7e5b547cac7a ("net: phy: aquantia: poll status register")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

The Fixes tag somewhat implies this should be backported in
stable. But a comment does not really bother anybody, so does not meet
the stable criteria.

Please drop the tag and submit for net-next.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

