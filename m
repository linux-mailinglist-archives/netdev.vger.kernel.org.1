Return-Path: <netdev+bounces-28690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9B78042B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277C91C21406
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850986AA0;
	Fri, 18 Aug 2023 03:07:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A4647
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD10FC433C7;
	Fri, 18 Aug 2023 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692328047;
	bh=XtpCOzAGlGBG+ijzXnOGop7l8rBn+bP0MyROKMkYCTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sg1oQ0phrq1PXOVattZ1mHbzAIz4baJGjMVdSWwziu9meTuQ5b2nkDHiMSYvHQJKN
	 BSljlziJ96r/PNP9IsHqJjmrCS0L9jeMN5cbf/zZVXpfNMSRtgZ34VLOqwqRGwU+lW
	 ePL3brJp8uHJcBoGOQyIFr/ZMcUxYzx9DMMMUlA1G54IG0zTjOqPVIn2baCVDjjaMi
	 wUXwQLbMDttcl8HoFUdap6fC/KgmoEjKJBJWEISymIoO9s5PhusRVzxaNKwhYvBIHJ
	 H+UvZq67vQZ/GE4fsWcG8WQQYvPavgPs9XTNTqk9PE34dGuZ6RwEmiiqa0h+j9A+X9
	 Nuo+H7fENei0A==
Date: Thu, 17 Aug 2023 20:07:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky
 <leonro@nvidia.com>, Dima Chumak <dchumak@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, Simon
 Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 0/8] devlink: Add port function attributes
Message-ID: <20230817200725.20589529@kernel.org>
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 12:11:22 +0300 Leon Romanovsky wrote:
> Introduce hypervisor-level control knobs to set the functionality of PCI
> VF devices passed through to guests. The administrator of a hypervisor
> host may choose to change the settings of a port function from the
> defaults configured by the device firmware.
> 
> The software stack has two types of IPsec offload - crypto and packet.
> Specifically, the ip xfrm command has sub-commands for "state" and
> "policy" that have an "offload" parameter. With ip xfrm state, both
> crypto and packet offload types are supported, while ip xfrm policy can
> only be offloaded in packet mode.
> 
> The series introduces two new boolean attributes of a port function:
> ipsec_crypto and ipsec_packet. The goal is to provide a similar level of
> granularity for controlling VF IPsec offload capabilities, which would
> be aligned with the software model. This will allow users to decide if
> they want both types of offload enabled for a VF, just one of them, or
> none at all (which is the default).
> 
> At a high level, the difference between the two knobs is that with
> ipsec_crypto, only XFRM state can be offloaded. Specifically, only the
> crypto operation (Encrypt/Decrypt) is offloaded. With ipsec_packet, both
> XFRM state and policy can be offloaded. Furthermore, in addition to
> crypto operation offload, IPsec encapsulation is also offloaded. For
> XFRM state, choosing between crypto and packet offload types is
> possible. From the HW perspective, different resources may be required
> for each offload type.

What's going on with all the outstanding nVidia patches?!
The expectation is 1 series per vendor / driver. Let's say
2 if there are core changes. You had 5 outstanding today.

I'm tossing this out.
-- 
pw-bot: defer

