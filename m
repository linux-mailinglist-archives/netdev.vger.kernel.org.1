Return-Path: <netdev+bounces-196436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0829AD4C33
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B218989A9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860322ACFA;
	Wed, 11 Jun 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HgqPZYA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlKqFsox"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFE22D78F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625197; cv=none; b=pMfEYfvjPCnItKDZtWNQ9sCk3HY/mdmZtGVwuakqRWvDYi1PjGTk01/7bGILSjUMJOZfu0jUN4x1ooPAsvHcFd8P0HcLhvczicthy1eao5WIHG/zZ9w26a8tu5DUIkF6h9c4ZVQpAARFVMaNhPRnU5MyT+s9SoVw2tVTnxH/yrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625197; c=relaxed/simple;
	bh=rXSMFDpMWfqBnRLKEwPhEanlP7AIKC5g2XlG4JLM/kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8KEuKj+SlFKF1yuAszodfDw2JS92JfWrpxeAm+g3mh19JmAB+sT+KrIxvaHInPQ9AGGb2pEUAHGQn2NJJ8N8Ni6HSD7s5T78xu7A230KNRV+qDR+rDdPTbOkv9DZK0Ac4I/hj3qPl6VndFVVGs5TCgxQCH8AIiWkbgEZEK1r5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HgqPZYA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlKqFsox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 08:59:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749625194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEIG5BHuNqIaU7zfMOqXE6QEfmFQYwLJ+Gabc9OvVOg=;
	b=3HgqPZYABGLE2xU6bkbdLD/4eBaSJ3dZOBID6AS7VF01gKjObJS9cVmVv7r7RCq/rHQO5J
	ALupHJ2o6LzVhMHlEF/cr1rftoUSS4IQQF9GwKRIH++O+eeU0zKqqKa6LvxydR6AZY/o32
	Hvd/5WcGkpNBaKWg3ZTs3pu9WDIbPhXzUoJIUIIuaUkcheCc/luc3qKtiUBtwrGhR/CGAu
	q+6MTkOWbm3KR46WYKsTNBILViXmybTqK+aQ+ivtIUQxCauAPBDaS9qIKlPQSrdYo9Ei/v
	CIkML2VWQyQ9QXUBnryYzEl7xWIwKYa85CVGw4NOIyJvD8uU8rY7X22eUJ4Oxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749625194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEIG5BHuNqIaU7zfMOqXE6QEfmFQYwLJ+Gabc9OvVOg=;
	b=MlKqFsoxhCqKUQQUNt4QL4evAuNnXYiuiLxOt/6guTLO6HCPFcpv+tuJESL9YS+x5+hEwn
	quwBVh2s9H+NW1Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, dev@openvswitch.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/3] Revert openvswitch per-CPU storage
Message-ID: <20250611065952.ap1kUHpf@linutronix.de>
References: <20250610062631.1645885-1-gal@nvidia.com>
 <20250610064316.JbrCJTuL@linutronix.de>
 <63dcf1ff-7690-4300-8f76-30595c14fec1@nvidia.com>
 <20250610070629.0ShU8LLr@linutronix.de>
 <66a64c37-19f6-4252-a5c2-f810ba6d3d0a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66a64c37-19f6-4252-a5c2-f810ba6d3d0a@nvidia.com>

On 2025-06-10 10:08:13 [+0300], Gal Pressman wrote:
> >>>> This results in allocation of struct ovs_pcpu_storage (6488 bytes)
> >>>> failure on ARM.
=E2=80=A6
> Thanks Sebastian, looking forward to your patches.

Do you have a .config, dmesg output or anything? I have here
| Linux =E2=80=A6 6.16.0-rc1 #3 SMP PREEMPT Wed Jun 11 08:44:22 CEST 2025 a=
rmv7l GNU/Linux
| # lsmod=20
| Module                  Size  Used by
| openvswitch           131072  0
| nsh                    12288  1 openvswitch

I have here 2GiB of memory but it also works if I reduce it to 256MiB.

Sebastian

