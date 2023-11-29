Return-Path: <netdev+bounces-52149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEB7FD96C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4465F28240F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52621C68E;
	Wed, 29 Nov 2023 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV3k5IPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2132C74
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85FAC433C8;
	Wed, 29 Nov 2023 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701268249;
	bh=SW8qPr0976zLa443kybvzfq3cWRZpQQz2JlXpQs0isE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aV3k5IPSdNISlpQLQvRNF2ivyufuHpY55piAINqAHoaEeFkgtXIzFr/NKhcGMoMro
	 7MwJX1HqMnCqbaH3xFGi/CCgLu5lG3OzHjSLE+RAKcr6e1+dLc28wG/s9ZlzPsvoAA
	 NShE3ukn639BUlo5ViLqS/aDYXHYKOjhLQp8LEPILJKX97B3Z2ttmn0fCaekmKvtwX
	 MR60mpfvwGHCOVgieVUUej6M1uCO/TgkCrxSOv4646wrtB6HkyVRKcp1KRawZbdGJ6
	 JL87pqdSat3JxSK4COeQboSPjHih+Ntvcf4633y38vBfYEgRcZoQM9Hr6Hc5ivrqNT
	 iuvBv0aUf4dqA==
Date: Wed, 29 Nov 2023 06:30:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
 <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
Message-ID: <20231129063048.3337bded@kernel.org>
In-Reply-To: <87il5kc0je.fsf@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
	<20231128200252.41da0f15@kernel.org>
	<87il5kc0je.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 11:30:27 +0100 Petr Machata wrote:
> > Is there a reason not to split this series into two?  
> 
> I can do 5 + 12. I'll resend.

It's okay this time, just keep that in mind going forward.

