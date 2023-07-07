Return-Path: <netdev+bounces-16059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67F74B378
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 17:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1911C20FFE
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46FED2F2;
	Fri,  7 Jul 2023 15:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39136C8F6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70778C433C7;
	Fri,  7 Jul 2023 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688742026;
	bh=L4IqKd3lr0lSrHIljFba1vlx8uRdvshoxs3E6tmWO74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UotZmOybOJlsTHFyy1Ffhe9MB2FU/sWQcu6++/W+AYRot/ckUkH2iEa6+iJVgq5h8
	 VjNGvVHBuRW64xdnrgGrOIFParNFdqovpS6iVkYhluFL0bd+renXBzAs7IIQENezMM
	 4leABVeDsuABVcc3lGaG6a3FEoG+AwFDweip/J1x2ujHQokneSpTlh2W2wpSHr95Rd
	 jC+ZInNIFqp+/9hyYENws40y78/oRVNCR7bspkP/aFoRe5xb9UCT8MUmsAiBT7QxcW
	 WzoGRadZ4dIcXoE9fvpVR72eKlh+pIxMVo7JCPjLkXQVHZfar01FCQFK59EWtc64z8
	 0O77xxS/kjN7w==
Date: Fri, 7 Jul 2023 08:00:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Garver <eric@garver.life>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop
 action
Message-ID: <20230707080025.7739e499@kernel.org>
In-Reply-To: <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
References: <20230629203005.2137107-1-eric@garver.life>
	<20230629203005.2137107-3-eric@garver.life>
	<f7tr0plgpzb.fsf@redhat.com>
	<ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
	<6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 12:30:38 +0200 Ilya Maximets wrote:
> A wild idea:  How about we do not define actual reasons?  i.e. define a
> subsystem and just call kfree_skb_reason(skb, SUBSYSTEM | value), where
> 'value' is whatever userspace gives as long as it is within a subsystem
> range?

That already exists, right? Johannes added it in the last release for WiFi.

