Return-Path: <netdev+bounces-13471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099273BBA2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A9281C35
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BCCC2C4;
	Fri, 23 Jun 2023 15:28:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B8F4A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D086C433C8;
	Fri, 23 Jun 2023 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687534099;
	bh=H65SMytSySQ8LpC9dZmWdzvH6UfW6x2f72l3Esdzkmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eLK99QNZKRHuJ8vRn+4aFkDMhxnlv4opYXJ94Y3dl3tyLs4YsnFP2UN+lVKhTp+k5
	 Wr24dqNi/0eNojVj28272XXUzizEavBHJjnhGu/C7W5/HTl68t8S9Ko1dn8s6ZCROh
	 JJrCao+U9V3WUpHAo5qoT6CzqMhin3GIxvjt5vPiaf/kKiE+p5T4kvOyV47hIdPms2
	 hZQ4I7QRHLvW4sKl5CObm2BuY6Fee4AHRKLQxoPrFHwg1JT3ACJGKNqzfpEvuHbB4G
	 0G/LHtfbqwes25J9HU4xLmKMvL7Js5ZdstcFvRrlztcj0VyXA6XajIIxF54v5jlix2
	 P0Ydpnt8ZxNSA==
Date: Fri, 23 Jun 2023 08:28:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [RFC net-next v1] tools: ynl: Add an strace rendering mode to
 ynl-gen
Message-ID: <20230623082818.4e815793@kernel.org>
In-Reply-To: <m2mt0q9ygf.fsf@gmail.com>
References: <20230615151336.77589-1-donald.hunter@gmail.com>
	<20230615200036.393179ae@kernel.org>
	<m2o7lfhft6.fsf@gmail.com>
	<20230616111129.311dfd2d@kernel.org>
	<m2v8fjahus.fsf@gmail.com>
	<20230619120025.74c33a5d@kernel.org>
	<m2mt0q9ygf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 13:04:32 +0100 Donald Hunter wrote:
> > Fair point. Our own names would be easier to understand -- OTOH I like
> > how the print formats almost forcefully drive the point that these are
> > supposed to be used exclusively for printing. 
> >
> > If someone needs to interpret the data they should add a struct.
> >
> > But I guess a big fat warning above the documentation and calling the
> > attribute "print-format" / "print-hint" could work as well? Up to you.
> >
> > Hope this makes sense.  
> 
> Does "display-hint" sound okay? Maybe me being a bit fussy vs
> "print-hint" but it feels more appropriate to me.

Sounds good.

> > If we're only talking about printing we will want to extend the support
> > to new families as well.  
> 
> Yep, makes sense. Is there any magic/scripted way of keeping the
> different schemas in sync or do they just get modified independently?

Nope :(


