Return-Path: <netdev+bounces-215581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4BB2F59E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E067FAA46BE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F769307AF0;
	Thu, 21 Aug 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="crQ4EIRc"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55C307AE9
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773361; cv=none; b=Se40XNelJKl5wkIPgV9SLJP8JaGRulN8AkDX3BBnUT4MGQrtM6EUvos9E6nnbSPaZrEMZKPIWcLGYXUOQ6Xt9IioX/ScfkroHIj8YxDnvSkVWxlxa5CfK4I1DgTgGgZw88uLPBvdkgoTK+m/vdJDxu+l2Wr7c4L5EgoCRMYSpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773361; c=relaxed/simple;
	bh=mHovhbLTWLYoPaxIg+CbZRb0RTjtLUq3VW1T2Y2zUMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC5++g8oGf1r3SrdDB+dXZdnIh0jeQC1sIwS+PIn0sD1O7nyJwEE01L5oELBZVys8W5pEWtPbCw5JDfKsSJWLQ+ZvhajHwQe2qCncsF1wKh/EbL47TEsQUSnHhc5DLJ6vXtU6TVTr9IjJMrYVmtlOHm5m4VK1iOHktYtlmvo5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=crQ4EIRc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C514C2015BAB; Thu, 21 Aug 2025 03:49:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C514C2015BAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755773359;
	bh=DgBxOo3L84aHolSUzBikp831SFK29zxHFUYUpL/eCWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crQ4EIRctCUOllAQ2V0j3wtVE9yXR36pvBhG0ZwfZnV3E2jGGw+WtvbFSvb5noIcp
	 elMAQWaFJP09pqWHEELFAMK86TSQdkNwmVKi5mdvyUCwpvPTFLf3niQx10SgxwmI/G
	 OgZmJy621HOB1WtHris1SqJv+Zue+R/kjxzUykEc=
Date: Thu, 21 Aug 2025 03:49:19 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250821104919.GB7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816155510.03a99223@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 16, 2025 at 03:55:10PM -0700, Stephen Hemminger wrote:
> On Mon, 11 Aug 2025 00:05:02 -0700
> Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> 
> > Add support for the netshaper Generic Netlink
> > family to iproute2. Introduce a new subcommand to `ip link` for
> > configuring netshaper parameters directly from userspace.
> > 
> > This interface allows users to set shaping attributes (such as speed)
> > which are passed to the kernel to perform the corresponding netshaper
> > operation.
> > 
> > Example usage:
> > $ip link netshaper { set | get | delete } dev DEVNAME \
> >                    handle scope SCOPE id ID \
> >                    [ speed SPEED ]
> 
> 
> The choice of ip link is awkward and doesn't match other options.
> I can think of some better other choices:
> 
>   1. netshaper could be a property of the device. But the choice of using genetlink
>      instead of regular ip netlink attributes makes this hard.
>   2. netshaper could be part of devlink. Since it is more targeted at hardware
>      device attributes.
>   3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.
> 
> What ever choice the command line options need to follow similar syntax to other iproute commands.

Thankyou for the suggestions.
After internal discussions, I have decided to proceed with
implementing netshaper as a standalone command.

