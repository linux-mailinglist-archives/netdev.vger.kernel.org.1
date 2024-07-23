Return-Path: <netdev+bounces-112658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919593A75C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86915B2099C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29113C838;
	Tue, 23 Jul 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wbolrxaj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4862E83F;
	Tue, 23 Jul 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760321; cv=none; b=oLk2WvfRpNJ9EYJxRyn6Dxn/jn4cl158CMTT2g6lySShShom1iZafgqBb/XU5hGlO5uj9aIOzDh7PeTO4hEWpuEMUGbAGYPkzFD2qhlyaBrwieeGgbk3l5FRhZOLUZVefU+bRtFdqhFZCP0QGhPINpnYlMDFFsTVZ1uD3wY3Y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760321; c=relaxed/simple;
	bh=jnOBruHviiMeh3pNnPGssWCltycJrT40IYLXoFFlhlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTX1Bs0I1Sjbq0MamquJndPXRAQ9Rw8tXNVgmorskqh1u//Q4hwZIBf+VBnV4aaEIP7VbZznyvEAxDjdgcm1IUl7I9+EepvFVqagyMcGY+2n2NutldD7RtdIjgZJNXD88pGRT2Yz+vYdrc42njhZpuS50KWDUxi+sBV6Huyemyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wbolrxaj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=olTVMxjXOsU8mUVMWV8+A1UMYa9QIDnG8q/CEGjAZw8=; b=Wbolrxaj2GFm7onLCwu2ynt2th
	1wAHNlOmz85RQQApeumtJ9mX3dQt11FeraN0x9Tbw65kVFBcdrE/Uau24+4krpDw4+oHmfpnlETyd
	8dDUTj7RLzdqmApTsOenP+GZ4mkTiTidGt7Ltj6bQyq2u85YOrFsk32FefV81ZEFzPP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKVd-0035J8-6w; Tue, 23 Jul 2024 20:45:13 +0200
Date: Tue, 23 Jul 2024 20:45:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
Message-ID: <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
References: <20240723054047.1059994-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723054047.1059994-1-lulu@redhat.com>

On Tue, Jul 23, 2024 at 01:39:19PM +0800, Cindy Lu wrote:
> Add support for setting the MAC address using the VDPA tool.
> This feature will allow setting the MAC address using the VDPA tool.
> For example, in vdpa_sim_net, the implementation sets the MAC address
> to the config space. However, for other drivers, they can implement their
> own function, not limited to the config space.
> 
> Changelog v2
>  - Changed the function name to prevent misunderstanding
>  - Added check for blk device
>  - Addressed the comments
> Changelog v3
>  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
>  - Add a lock for the network device's dev_set_attr operation
>  - Address the comments
> Changelog v4
>  - Address the comments
>  - Add a lock for the vdap_sim?_net device's dev_set_attr operation
> Changelog v5
>  - Address the comments

This history is to help reviewers of previous versions know if there
comments have been addressed. Just saying 'Address the comments' is
not useful. Please give a one line summary of each of the comment
which has been addressed, maybe including how it was addressed.

      Andrew


