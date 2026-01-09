Return-Path: <netdev+bounces-248583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8BD0BE41
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D56304355E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15AA2C326B;
	Fri,  9 Jan 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WBc4xdB8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE32C08D0;
	Fri,  9 Jan 2026 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984049; cv=none; b=ogSDcTj/YaBUIMKIzomDo86U/+pxmrL/V98CQjKZQTS4Znw4TO4YfbHEf763sJI4hXWFW+FvXiX1sLdc+PMgr7WVf6QkzQTe6lGezijjWFH8OIdkUeAPWC9Eq6EbGpbmoY1HTWKdqJ4Jw7o6awMVYD8TSf9WFFvfqtFDBuHZwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984049; c=relaxed/simple;
	bh=z6qFFozwLTauN55COL8D7QiC32jJ7aY8HOl4VKIbb/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgw+rrQbtuzpf2nt1LgOHA4YIhpwxLj1XDALgQkxjAZxUnvH+1Vb96D4ZiTFFXYh0PnrbQqIDYptzwupn40a8n/BbKYAHRSEYhzOMlZJiVqTlaKPb8CKhmTq5eTsPN6iSfeJLeFYSd4I72C1YuRk1MnRAKaj1URNKH31oVSZulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WBc4xdB8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tMjh5cg1wU0gE9aNbQhIuk1lHgKP2s/YmyVrE6dIiwY=; b=WBc4xdB8vyXakV+ouDUvLiDx8G
	eWB9LG41WRzQfELkxGem1E9diQIT5zTcGr9tOg288Mjy7BAo9ooBKwmMTneuo3PH3ux/rfkUkMP5a
	ZdS+5z4AQbtJMRLPofGMvs510JrLsD3ZLOgznMkRiAXM8syiU7L84UJCwy7z5Ul+gskE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veHPT-0029eH-OG; Fri, 09 Jan 2026 19:40:31 +0100
Date: Fri, 9 Jan 2026 19:40:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 15/15] net/nebula-matrix: add st_sysfs and vf
 name sysfs
Message-ID: <fad2bb37-d764-4c5a-a589-2b071aceb8cb@lunn.ch>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
 <20260109100146.63569-16-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109100146.63569-16-illusion.wang@nebula-matrix.com>

On Fri, Jan 09, 2026 at 06:01:33PM +0800, illusion.wang wrote:
> Add st_sysfs to support our private nblconfig tool.

Private tools are unlikely to be accepted. I suggest you drop this
patch for the moment. Once you get the rest of the driver merged, we
can discuss how to do something acceptable.

    Andrew

