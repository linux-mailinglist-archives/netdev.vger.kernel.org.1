Return-Path: <netdev+bounces-199659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A2AE12D4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 07:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C147317E81A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8C20ADF8;
	Fri, 20 Jun 2025 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HklS9UjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7C2080C8;
	Fri, 20 Jun 2025 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396404; cv=none; b=jgOhRnvNXT97JEK/WJyUi7dhWKRn0MxgKpU6OY2bOhiRFTmUFlcaGuVMsFpCEH2KQE+7gVK463yvBEUY62E/Y3fa3/2Kxy4c24Zv28j49lMl60H9lqR50tqgP/+QyZy52+4KrZBepgtkS4KuojK3eRbfanhXedywAknGY0rDeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396404; c=relaxed/simple;
	bh=oQJ+HgZ1HzTQr6gaOz+14ObNdfbXRI6qb0MFsR9E0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th9g16rPqN5DHW6XQRqQ9xoESb93rkxZ3/dLdwCkEwno+TvGxqTaod4aI5wYhSvRYhjNq9uAQ6wVVYLkXFEQt/yZR9+K4ZMMy0riNTQsHwpENgzhD2nvho+KvDlrGexUSAj92jMAbwUtr/TRWVduk+RBQo2M7/+B3uu1HZygnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HklS9UjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C1C4CEE3;
	Fri, 20 Jun 2025 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750396404;
	bh=oQJ+HgZ1HzTQr6gaOz+14ObNdfbXRI6qb0MFsR9E0yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HklS9UjTgmwvOGKiAz7K5E9rk3tmtU4a4dp9E+A/bgh1w98Jx3VM6YKfr7dGQyrb/
	 YgCodfOwUOqW5A5tvIFUKavikr3UYAU1wPc6XbHdKnQBXoCw8eek6rd/vTDjuI6qQW
	 P2aMLXcIOyac+Bh3k88xVesQOg5xbLP4cj9Om7Wg=
Date: Fri, 20 Jun 2025 07:13:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
Message-ID: <2025062004-essay-pecan-d5be@gregkh>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619200537.260017-2-sean.anderson@linux.dev>

On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
> Support creating auxiliary devices with the id included as part of the
> name. This allows for non-decimal ids, which may be more appropriate for
> auxiliary devices created as children of memory-mapped devices. For
> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.

I don't see the justification for this, sorry.  An id is just an id, it
doesn't matter what is is and nothing should be relying on it to be the
same across reboots or anywhere else.  The only requirement is that it
be unique at this point in time in the system.

We're having this same discussion on a different thread for a different
bus as well.  This isn't something new, it's been hashed out and
resolved 20+ years ago...

So no, this change isn't ok to make at this point in time, sorry.

greg k-h

