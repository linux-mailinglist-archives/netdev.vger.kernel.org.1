Return-Path: <netdev+bounces-44042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90717D5EB6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EE7B2108C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC36450C5;
	Tue, 24 Oct 2023 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLd5nee3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C944499;
	Tue, 24 Oct 2023 23:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDBBC433C8;
	Tue, 24 Oct 2023 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698190234;
	bh=+uOkDdmyMJIj51QA/+tV5jfiOrKRbpENgeu/vk57cl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=vLd5nee3gUNmqJKYs7FZTziRAwI+Yg786bC+YFoHpXkcSUThar0nJiBOZznKsiRis
	 +GAqVKGE8SdcfiBen+h5Yv7bkr/f0ctOooOIBV4r4nM8xLBVeQMm8pYZWPeXciWc1r
	 wG8M08ZC3q1jHsriLBrW80uRN3orjYFXNoI53dLOKIsHcWwgU3TVY+V8W2ZFnxrk0f
	 jtvI7vNrsqe7KJ00v170aJY/euYRwzUa+ERoxyVf9ZgOcdJF57d7Q6TZlwYljtUlnF
	 oWteEO5VQEneebbs6hL7TGA+GDjd0epOZ29TdRYtAXRNjNeTOrK7y46eINvO79mM4D
	 B7828a16Q+nZg==
Date: Tue, 24 Oct 2023 16:30:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
    Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
In-Reply-To: <20231024125956.341ef4ef@kernel.org>
Message-ID: <a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org> <20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org> <20231024125956.341ef4ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 24 Oct 2023, Jakub Kicinski wrote:

> On Mon, 23 Oct 2023 11:17:09 -0700 Mat Martineau wrote:
>> +/* for backward compatibility */
>> +#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
>> +#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX
>
> Do you want to intentionally move to the normal naming or would you
> prefer to keep the old names?
>
> We have attr-cnt-name / attr-max-name for migrating existing families.
> We can add similar properties for cmd if you prefer, I think that they
> were not needed before.

I'm not sure if you're offering to add the feature or are asking us (well, 
Davide) to implement it :)

It would be nice to not have to carry these backward compatibility 
definitions forever, expecially since they're fairly obscure "__*" 
names. Low stakes for MPTCP alone, but it might be good to have as other 
netlink interfaces are migrated.

Davide & Paolo, what do you think?


- Mat

