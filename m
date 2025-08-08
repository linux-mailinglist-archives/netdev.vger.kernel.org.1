Return-Path: <netdev+bounces-212293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C70EB1EF81
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B121AA8451
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DC234984;
	Fri,  8 Aug 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AooxCf4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7F198A2F;
	Fri,  8 Aug 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684956; cv=none; b=DmcP3SyHlRnIl9do3Tob7YIpq247lDWIUq6ECRdr7srxlB7teQtRiMsx9Rlduq/5dlvT4sTFmn+/PdaUCGh8Xtt0olfIHV7d8aTL0JZtAn49gxbUVhfobKc9fRq3yb6f7Mroy3ztDAtUAbaXQ4auA67EUosbbm2QQk05NVWkyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684956; c=relaxed/simple;
	bh=Xnm3rnH/Ucfpzy5oweZcqEx+Cgus6O6NVcWh+skp++U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pga7E9M6qd6Cy+ZJoUeATRz/EzVY03xdgXB0J7NEmSssWv9Y6VwSUrCpXSlvQ2dXVysYvMssznPOBaCnp6CzlUCnZBvwfrIQoLze8KdHE8dsKl49LzWXkKScAMAcZNMkigzGfbhgyFrKtit0NAgS8Ak0978e5coevI1X8hOVBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AooxCf4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E3C4CEED;
	Fri,  8 Aug 2025 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684956;
	bh=Xnm3rnH/Ucfpzy5oweZcqEx+Cgus6O6NVcWh+skp++U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AooxCf4nWDY4lBHRzT+xwCKNlCPQcCzSOU/A5UOz+LpamVdN4vWL8k83VI717nMlz
	 KVUFo7jDNDBMgLyxB09UJU64NsUxdqMeGSV98EuWAJKDVICE6AQjeLUWyXwEyFElEF
	 ZyH7nzZ3CMh4fOmVa3DED+EZurviAS/9HtbOqHGV5K5/yaXnnWwVWfmejK2kw5mMKY
	 Zu3Ob0exyLBlm3p8J+l137aziAngLaGlYmuIx8DLviwa8FuTNDmtww9xztgjk2iHfY
	 S7aFZJpIlUie/ZBQzBN57xpi+KSVOSsl5cEEq1h7JDF4GRlE3Wt3XHY2PV/+3LglhL
	 oP4LJP0s5QJ+w==
Date: Fri, 8 Aug 2025 13:29:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: Lion Ackermann <nnamrec@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ovs-discuss@openvswitch.org"
 <ovs-discuss@openvswitch.org>
Subject: Re: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
Message-ID: <20250808132915.7f6c8678@kernel.org>
In-Reply-To: <CO6PR11MB5586DF80BE9D06569A79ECB2CD2DA@CO6PR11MB5586.namprd11.prod.outlook.com>
References: <CO6PR11MB5586DF80BE9D06569A79ECB2CD2DA@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 08:29:34 +0000 He, Guocai (CN) wrote:
> ### Environment
> - Kernel version: 5.15.189-rt76-yocto-preempt-rt
> - Open vSwitch version: 2.17.9
    
> ### Issue
> After applying the QoS configuration, the following warning appears in dmesg:
> [73591.168117] WARNING: CPU: 6 PID: 61296 at net/sched/sch_htb.c:609 htb_qlen_notify+0x3a/0x40 [sch_htb]

Is the issue easily reproducible ?
Could you try your reproducer on the latest upstream kernel ?

