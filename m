Return-Path: <netdev+bounces-76812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56186EF29
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085C228661E
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F9C2E6;
	Sat,  2 Mar 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W91It+lY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6513FFA
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364700; cv=none; b=RWQ1tMO49LAUN2qfp8nK6eoNbEHIfdn2NBwjWOSrYTWW2XHGpxkVFZsEtvcYUEGGhq37QaUsNIi85JXtgFJK3yKeSedl650f6MtBWVNPLZW3Zm+I3FqHOWeDVMmUiHzcsqcDBiOK8AghK+GmbRT3FlIJcruHn7xdMlbyi58/85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364700; c=relaxed/simple;
	bh=/KQEDQX00ejozObwsLavACXQxNmmPnqp6duLlmaR8z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni8JO8WIYuE6nNcUBosdzn8zRV32nbU0h2nz9019AaPhB5ZwMkc/dcNg1MVHuV7ZVcarNInyJzlQ0jSk4V/t51bzVXtSkh3UXZpeFmnFaSRwuyOEKzinSWaDFJgzMjdA7hz8zeWwZvlNjQENIvP0c/5k1QCEBlogezyzy6jkpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W91It+lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984C9C433C7;
	Sat,  2 Mar 2024 07:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364699;
	bh=/KQEDQX00ejozObwsLavACXQxNmmPnqp6duLlmaR8z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W91It+lYu37tbGlR1p76L4s3Wy1EouDNMZ6k0naFH/2e5EsykYMhlHeHLH5+P+mQz
	 64Ouqq+p1GG2SEucj+FniB9uG0lZ2644VU8aDstA92uNP6/8D810roDrd0gEv8co0R
	 egXMNhaXWg8qo1nHCu+G+mKlW8I3r2I6qXRv2+NgXzY/BPIQ/debEvd0BYe0rQoKPg
	 V2fh3x789zhhHLtlbMhaxhp1I4tiBtjDhkT4NPIxVo/ethkYvh/6tggkse7vLEphTT
	 Fo4AP1sxVtEU168hI1AP7R/PC63baON9x9TlopA44An9K3CVY3mbiaIVdltvCNStLL
	 qV2SVDe4BmGLA==
Date: Fri, 1 Mar 2024 23:31:38 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZeLV2s_nU8DZ-4WG@x130>
References: <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
 <ZdhnGeYVB00pLIhO@nanopsycho>
 <20240227180619.7e908ac4@kernel.org>
 <Zd7rRTSSLO9-DM2t@nanopsycho>
 <20240228090604.66c17088@kernel.org>
 <20240228094312.75dde221@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240228094312.75dde221@kernel.org>

On 28 Feb 09:43, Jakub Kicinski wrote:
>On Wed, 28 Feb 2024 09:06:04 -0800 Jakub Kicinski wrote:
>> > >Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.
>> >
>> > Not really. It's just needed to consider all usecases, not only netdev.
>>
>> All use cases or lowest common denominator, depends on priorities.
>
>To be clear, I'm not trying to shut down this proposal, I think both
>have disadvantages. This one is better for RDMA and iperf, the explicit
>netdevs are better for more advanced TCP apps. All I want is clear docs
>so users are not confused, and vendors don't diverge pointlessly.

Just posted v4 with updated documentation that should cover the basic
feature which we believe is the most basic that all vendors should
implement, mlx5 implementation won't change much if we decide later to move
to some sort of a "generic netdev" interface, we don't agree it should be a
new kind of bond, as bond was meant for actual link aggregation of
multi-port devices, but again the mlx5 implementation will remain the same
regardless of any future extension of the feature, the defaults are well
documented and carefully selected for best user expectations.

