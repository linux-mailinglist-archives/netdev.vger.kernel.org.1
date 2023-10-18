Return-Path: <netdev+bounces-42279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B062A7CE071
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9E1C20C26
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7667237170;
	Wed, 18 Oct 2023 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leamzhtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DC36AFD
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D71C433C8;
	Wed, 18 Oct 2023 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697640945;
	bh=oP7fTCFlMRrcd/x0Q2hhflCiMNLLkunsvaQEJjeLFJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=leamzhtNqSxHtnclv/c5u/BKFtmZsg0BKV8ihjZyxu3nfkcOvOGiMIu7ZQhQ9RXD6
	 FuGMjYnOP251aYV4U2EH1GYsVblqQend5OWRLBUD/Rng5bdOsES2caZsnbpdWy2q6l
	 Ld9mKNbgBtrvGt9gUipLAhgrjINUYD4wFjJbSU3dUmNvMRVvWTOqdIuK+0msy27R5F
	 glXHqowhRUIbnAJQzhzRL1MNWtkgBPLHN52dXPdQ1dcLcJ1pMENF0dhErUiPHsPtis
	 kSIyl0j4Uxc+Fj1bzmOjKb2XJ36Mds0zKNvJR7IJbWe+I9GySppHJPcPIZMx0rdrQs
	 t3X0LeH+9Vqeg==
Message-ID: <0e826d9b-cdb6-b0a3-195e-25ead1faf484@kernel.org>
Date: Wed, 18 Oct 2023 08:55:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com>
 <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
 <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com>
 <353dcd1e-a191-488c-8802-fede2a644453@lunn.ch>
 <CANn89iKfXxaLr0b-rp0_+X7QY82pK21zeLCVjqxNipfKkwOnDg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKfXxaLr0b-rp0_+X7QY82pK21zeLCVjqxNipfKkwOnDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/23 1:15 PM, Eric Dumazet wrote:
> Perhaps add a big comment in the file itself, instead of repeating it
> on future commit changelogs ?

I think a comment in the file would be better. I spent a fair amount of
time reviewing code double checking the impact of the moves; a comment
in that header file would have been helpful.

