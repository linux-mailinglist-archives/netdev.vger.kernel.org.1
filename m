Return-Path: <netdev+bounces-226965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E382BBA6799
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 06:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9563BE55E
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1548283C93;
	Sun, 28 Sep 2025 04:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C355259CA7
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759032853; cv=none; b=OLKV+x7mAZrUFlqSFydMcqf3Saam81HPMryQd3ex7VYi21+S9HD4vxi1JqLowkUkcSnn9NRbiCl5mo+KDwaP4t53pd4SkAIEWgzAovyTT2GhArYPm9fpUPOjJOFIavofA/jPZw2e9gfigbxl5qnh5BgkGVqzG0JD5KBcnMrrRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759032853; c=relaxed/simple;
	bh=y9XPrygVkvrvj5jc2G1ohBjEg9VObB8Uku9bZzZeT1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MdglVgt8Q2EkZSazmVt/3CAawBYG6LIRy7zemlmytfXpeCA3VXYKqeG0QiPmUJjq3k/lFa8vTYCEgCU/irUAnZqFZo03vORaUVLJU7L6B6xnuh4wsSbt0wveuXq+kFGjc/NRECU9hu8s0I/yCB3MErYyHj6sPK644NQPz1nlW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1759032722t95dc91ec
X-QQ-Originating-IP: wtgkOpjai5lM4bsLynqd4CfmHnJQxRlu4V99vGM4cj4=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 12:11:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14202726352972744390
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [net-next v8 0/3] add broadcast_neighbor for no-stacking
 networking arch
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aNNWDcvO6aCG94Qe@fedora>
Date: Sun, 28 Sep 2025 12:11:49 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>,
 Liang Li <liali@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9409D921-76FA-4A49-9E39-7F47DCB2B486@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <aNNWDcvO6aCG94Qe@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OWhN4QRntHSGV91MZYOaiPenNSWX3d23xMFbwWpv5gCxJNZrDpTw7TsW
	6/iNEqEy974I+nb6nEo7BjKdPDSFF5hLEyQAS/6GBM/WjO7QY+7dt2vgFntCNCL1LOpJu0U
	6zellHZVjSrQE7yzWvwx2V3yqHHnJp9NhkM/oosyGxif1xhEtHouEB0Fc2u9X78qqK7/+hs
	6LDQzmaRpl8UVK/OysibK+xAYNn7LOEB77ktz717xxhgLsxaWm6arO3I4sZFmi+qQASkT+s
	d5yfLuxI6DgIyHuBsUmY2ZDEccS9Pc266BbdA5Kww7a08iJxrKr2XYTlmeABm2atn8Bkavl
	u0NpGvq89tcZ0lCPSlNLkG+WCBhW6XT1TTovprJDzWPp07uChCpc4oXQcuSy/QOznqcva8F
	XueNJd3NVrblWHY3l/TJ3SxVC2nEAvk+DOcwWFPBGAj2uS7soabD251h+EcWW/9wki2cDaP
	kIb6jr1KjPvVj9vW8qGVbmMBV0JXY/E17cF6PfShegdNDCrWOWfZcO12cw2ra/mQ01HmGue
	6NxDmywmZr48hGwXCQHnQQNvw6FPYv+GMEkE0WEg8CwPyGs+5yh9LiagC6TJZy2tBQ9kAwl
	Ga3uNtfUIX/v3jqzXINaSWZHtHaLzyWfz4seQE7eZ3IcgSokWnwZz+7AcYy0cm5AD5uN+hl
	+Y9S0uqxmB7I0zq1AX5jF4e5Ak7NevgPJFxK/YgUXymcaqkj8uU7EGGDz0iHn5cme8BEC4F
	Vk9P9kHcv+QN6ikhTJR01AZxir8qxdzMNU3CeqzQkV+qctV+lwyGOn4d0XLBBTgBU/1MEjw
	lbRkBoozqHRVdZxE9tKrndeb5/+mUtRmA+/i6aYtIdsqYMJUWEr0gcO6l+E/Af+k9/7+xyz
	0d6k4Hz+E7o/YHkSTArZId7eoMYQbex8PsIxN0dBDUaG9qsQxj8hEZaCJ+9VD5zyGDMe40g
	TOSPV2ylLaCj+mis7Zgr0W36bMiuVLfQtRsi8fLDcD6OCvJtZmhuTqprP
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> On Sep 24, 2025, at 10:23, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> On Fri, Jun 27, 2025 at 09:49:27PM +0800, Tonghao Zhang wrote:
>> For no-stacking networking arch, and enable the bond mode 4(lacp) in
>> datacenter, the switch require arp/nd packets as session =
synchronization.
>> More details please see patch.
>=20
> Hi Tonghao,
>=20
> Our engineer has a question about this feature. Since the switch =
requires
> ARP/ND packets for session synchronization, do we also need to send =
IGMP
> join/leave messages to the switch for synchronization?
Hello, I'm very sorry for replying to your question so late. In fact, =
the non-stacking network architecture disables the multicast function to =
prevent the server from learning other server real mac addresses. This =
architecture uses the arp proxy. To better answer your question, I post =
a blog:
=
https://huatuo.tech/blog/2025-09-26-some-thoughts-on-non-stacking-network-=
architecture/
>=20
> Thanks
> Hangbin
>=20


