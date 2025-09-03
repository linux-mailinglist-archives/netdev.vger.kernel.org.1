Return-Path: <netdev+bounces-219708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8DB42BF9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336E1582CC4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37F2EB861;
	Wed,  3 Sep 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj5yqZHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3712EB5DE
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935176; cv=none; b=CG4ttBmQpaSOmj/xZMQ7cXGx+TUNUBXh0vww9OrKynUplc0ekSuE2IqpfBoyiR3KlBhqBuxbqeANJjsZS6LfJIVwfQvKnewX8WkkbVUGgZnM+y3fyVtBCHpl5eW3aeYF7H0THKVxjkmBWEyojfW80a0ciyuH/KoNwr73aUIvegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935176; c=relaxed/simple;
	bh=j2o5KXYiJOXfui7jP2vVLip2six+IEHS/jsxeIypr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+6Ti0b2/5Wjh+GbDrI82kmivR9Xgd+kTr9X9Ffm5CIAZz01tCt+szzMQuEbx2vfWSqi8d3A+UMNPytme2xLGOZ8B9k6Ek4W0oi3QICHdxrw6I9qKVq4HnO/96jzS2PhBdgakZoJ7LIdVUmZarNgFQdegTNWVIiSdLMczdOFHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj5yqZHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30FEC4CEE7;
	Wed,  3 Sep 2025 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756935176;
	bh=j2o5KXYiJOXfui7jP2vVLip2six+IEHS/jsxeIypr8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qj5yqZHaEMM33e7BtHluhlOblyz5148eN920wwltfjCSs+WBTECPDEmPOBc0ckNTD
	 iRaF0KP2CAfhk3DAWCqn4+zj6PIcs1XNcRP4T0Q1cZLfLXZJbapzfePNLNTXULeTgX
	 GRrczGPO0MIlUM2DDxFwr+7XfCwt8sSmNuFZaVh1OhHbq+1/RoOWvOvoezgf8vzHZV
	 hYfRpd6Xlbh8iPST22p4jKKz18O04lJ00WnDom8YaREXKXiK993VGpbs1FK8Cw9k2J
	 0vh9BQ/iZOuvLDR2XA2botbVje2EQy+FDHd6eaZrlDFalBBnhR7LlyW4M9PMcPvAPr
	 rWsUFPbfKrKBg==
Date: Wed, 3 Sep 2025 14:32:55 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic
 device param
Message-ID: <aLi0B9KQsGgjGF67@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-2-saeed@kernel.org>
 <20250709195331.197b1305@kernel.org>
 <aG9RuB2hJNaOTV3e@x130>
 <5056c692-7478-4f38-8859-7cc7c823bbf5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5056c692-7478-4f38-8859-7cc7c823bbf5@intel.com>

On 02 Sep 14:24, Jacob Keller wrote:
>
>
>On 7/9/2025 10:38 PM, Saeed Mahameed wrote:
>> On 09 Jul 19:53, Jakub Kicinski wrote:
>>> On Tue,  8 Jul 2025 20:04:43 -0700 Saeed Mahameed wrote:
>>>> +   * - ``total_vfs``
>>>> +     - u32
>>>> +     - The total number of Virtual Functions (VFs) supported by the PF.
>>>
>>> "supported" is not the right word for a tunable..
>>
>>  From kernel Doc:
>>
>> int pci_sriov_get_totalvfs(struct pci_dev *dev)
>> get total VFs _supported_ on this device
>>
>> Anyway:
>> "supported" => "exposed" ?
>>
>>
>
>The parameter relates to the maximum number of VFs you could create. It
>sounds like this hardware by default sets to 0, and you can change that
>in the NVM with external tools. This adds a devlink parameter to allow
>setting to be changed from the kernel tools.
>
>exposed seems reasonable to me. You could also have language that
>explains this is about a maximum, since this changes the value reported
>by pci_sriov_get_totalvfs. You still have the usual means to
>enable/disable VFs via the standard PCI interfaces.

Sounds good, will change to "exposed" and add the language about 'maximum'.



