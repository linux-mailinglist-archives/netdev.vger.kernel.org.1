Return-Path: <netdev+bounces-22527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B77767E7B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047A91C20A9B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEF14296;
	Sat, 29 Jul 2023 11:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C31427A
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A4EC433C8;
	Sat, 29 Jul 2023 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690629148;
	bh=lTthzoEyUOXzvHutnWnSZNBWcT8IxT18IUyk7haJ2kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbBhtsaNRu3c3jtBsT81O6sWjV+xTmbqQr9YuV3oX2207YjrdAtTFG2qacTJof/70
	 XAhsk+ypUj4IBHdNG/Yc2HP+k61TfXy3s5XB/OtjXRVsmxWaed4g2/pnQFzaxUg+PA
	 BZ5RpzGXCX0+eLiIDSCrrZctGINjhndnqcnzlS60ZY8U/hhPXrV85Ak1TbhOfenWlb
	 vW3fdXCVyZofxRyoWMbU3W+RDSthBokukNpGGa4euK/JEnrhfclr3UqFHrX21aO32Y
	 1lMwJOP3XHYo6SUtXzJgF9dIT2wR79aKfqxgYxlxi2FX8h7ENLtT8HLuKOV8BXFIPn
	 gxmuQZAMXQsjw==
Date: Sat, 29 Jul 2023 13:12:25 +0200
From: Simon Horman <horms@kernel.org>
To: Mat Kowalski <mko@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] bonding: support balance-alb with openvswitch
Message-ID: <ZMT0GTGCv89P5m26@kernel.org>
References: <19d45fbf-2d02-02e9-2906-69bf570e9c7f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d45fbf-2d02-02e9-2906-69bf570e9c7f@redhat.com>

On Fri, Jul 28, 2023 at 02:24:32PM +0200, Mat Kowalski wrote:
> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
> vlan to bridge") introduced a support for balance-alb mode for
> interfaces connected to the linux bridge by fixing missing matching of
> MAC entry in FDB. In our testing we discovered that it still does not
> work when the bond is connected to the OVS bridge as show in diagram
> below:
> 
> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>                        |
>                      bond0.150(mac:eth0_mac)
>                                |
>                      ovs_bridge(ip:bridge_ip,mac:eth0_mac)
> 
> This patch fixes it by checking not only if the device is a bridge but
> also if it is an openvswitch.
> 
> Signed-off-by: Mateusz Kowalski <mko@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


