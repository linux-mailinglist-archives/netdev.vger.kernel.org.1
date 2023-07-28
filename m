Return-Path: <netdev+bounces-22269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A329766C77
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4341C218D4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243112B7E;
	Fri, 28 Jul 2023 12:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2ED125BE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E8C433C7;
	Fri, 28 Jul 2023 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690545848;
	bh=dsn428ujJoBI6ZIIo68V0hihVbry+AnTgTxOcPfR3yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYKCQT3XHBaLePPVJP2wwz28DXuJPX2dd8mqHnjaxgk4PCmZ4q13fCEJu9yZ1shZX
	 Lsm/ir0xfj+HONJuLKzMVLqtuG7QLLoUdgRlpCy558BDgtUO6XPHoChgTWwOz4t/5v
	 BQ3/QNgeSoIXpogqibha1fGjB+Qr5u9IySFRk6gpSHmzIvMXyYVQpEJi9kB3HqDQko
	 vLbI7KEvOU60S9eVNwFH3XKfmuemvcRyaiRmeLUGnuqKogMBQXul6WqdaEPfx8LSrW
	 +eStItGtZ6sCVOAFIyIU4Yxc90qiOarNNkygQC3GHQIC1fxsbDh7IPvv7ra/L7YICK
	 O7wY8MF37kSag==
Date: Fri, 28 Jul 2023 14:04:00 +0200
From: Simon Horman <horms@kernel.org>
To: Mat Kowalski <mko@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net:bonding:support balance-alb with openvswitch
Message-ID: <ZMOusD1BnLXqiUEE@kernel.org>
References: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>

Hi Mat,

+ Jay Vosburgh <j.vosburgh@gmail.com>
  Andy Gospodarek <andy@greyhouse.net>
  "David S. Miller" <davem@davemloft.net>
  Eric Dumazet <edumazet@google.com>
  Jakub Kicinski <kuba@kernel.org>
  Paolo Abeni <pabeni@redhat.com>
  netdev@vger.kernel.org

  As per the output of
  ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
  which is the preferred method to determine the CC list for
  Networking patches. LKML can, in general, be excluded.

> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
> vlan to bridge") introduced a support for balance-alb mode for
> interfaces connected to the linux bridge by fixing missing matching of
> MAC entry in FDB. In our testing we discovered that it still does not
> work when the bond is connected to the OVS bridge as show in diagram
> below:
> 
> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>                       |
>                     bond0.150(mac:eth0_mac)
>                               |
>                     ovs_bridge(ip:bridge_ip,mac:eth0_mac)
> 
> This patch fixes it by checking not only if the device is a bridge but
> also if it is an openvswitch.
> 
> Signed-off-by: Mateusz Kowalski <mko@redhat.com>

Hi,

unfortunately this does not seem to apply to net-next.
Perhaps it needs to be rebased.

Also.

1. For Networking patches, please include the target tree, in this case
   net-next, as opposed to net, which is for fixes, in the subject.

	Subject: [PATCH net-next] ...

2. Perhaps 'bonding; ' is a more appropriate prefix.

	Subject: [PATCH net-next] bonding: ...

...

