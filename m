Return-Path: <netdev+bounces-44618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2847D8C9E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559AA2821FC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E081A;
	Fri, 27 Oct 2023 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7sO9/C9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC9816
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813AEC433C7;
	Fri, 27 Oct 2023 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698367451;
	bh=vHxJUUbyizZ7x0b9dOX7eSNYvtmx9De37C/Ap7cffpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7sO9/C9mZjQDyx+TlC4WYGesDKA2GhcjwjAsntLQ7OMFnyVZ3AOm6uXnu5mhJwkW
	 VGKhj7Xwb3zS6YqNH4KWRWtEHkBmaXZ3u+h73w4Oeoj7na+Hljk45ortzMp5BZRILg
	 hrovadpdVH9hltJKPAZNHCRN+t4KFxKL0AbIyZFG6TYwe9/5Yo94HSuTqeQiccTqHv
	 4nCk651e+jAcfK0ONeCDJVh+dF2GvXtoJmXu20ywxh0JQZmF+3RQBK0YtWBYgN/RnK
	 /2H9EbOlHBdpfjWFVONW1U13EQTmZluhx6AeB0h8MND06IgztvogaAmF5LH5Gxm4cQ
	 4cxYI0/Q4cfDQ==
Date: Thu, 26 Oct 2023 17:44:10 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <ZTsH2n4k0kd+nChv@x130>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
 <ZTrneUfjgEW7hgNh@x130>
 <20231026154632.250414b0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231026154632.250414b0@kernel.org>

On 26 Oct 15:46, Jakub Kicinski wrote:
>On Thu, 26 Oct 2023 15:26:01 -0700 Saeed Mahameed wrote:
>> When I sent V1 I stripped the fixes tags given that I know this is not an
>> actual bug fix but rather a missing feature, You asked me to add Fixes
>> tags when you know this is targeting net-next, and I complied in V2.
>>
>> About Fixes tags strict policy in net-next, it was always a controversy,
>> I thought you changed your mind, since you explicitly asked me to add the
>> Fixes tags to a series targeting net-next.
>
>Sorry, I should have been clearer, obviously the policy did not change.
>I thought you'd know what to do.
>
>> I will submit V3, with Fixes tags removed, Please accept it since Leon
>> and I agree that this is not a high priority bug fix that needs to be
>> addressed in -rc7 as Leon already explained.
>
>Patches 3 / 4 are fairly trivial. Patch 7 sounds pretty scary,
>you're not performing replay validation at all, IIUC.
>Let me remind you that this is an offload of a security protocol.
>
>BTW I have no idea what "ASO syndrome" is, please put more effort
>into commit messages.

ASO stands for (Advanced Steering Operations), it handles the reply
protection and in case of failure it provides the syndrome, yes I agree the
commit message needed some work.

Now given the series is focused on reworking the whole reply protection
implementation and aligning it with user expectation, and the complexity of
the patches, I did agree to push it to net-next as the cover letter
claimed, I am not sure what the severity of this issue in terms of
security, so I will let Leon decide.


