Return-Path: <netdev+bounces-139583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF329B359B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9331C21FE8
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0491DE8A2;
	Mon, 28 Oct 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYROZHaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F9188917;
	Mon, 28 Oct 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131308; cv=none; b=UsU1WgbQspq8xY9B9dypwBx4HH0NMZ1v7HTZAWJcqBuhmsYvTJyX0Vu6Pf4DN0ls51rFXL+5NYZ8LryipXF+OVKEGScBaHG07AhNLdkDF4bjc5nJqysLgtuLscJIJY85Rgg8kjoH4b1emKtkNx4nUuIHqqmQdsf5UPgyHUEJQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131308; c=relaxed/simple;
	bh=rjZJA0DpjSaQmEw3j0pwYxmajl8jy9m8/Lv6TPOpUyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHIxRhHqNJr8+yGJNRfEX8r1/qmkg9i+1WPoMmsn49ns66yYbfdjW7o2pP6mQVnrwm75MBx2WD52xz80ghDWvK4Gce2onIGW5BZBwF8wF+WcT5DwdVXBp90qGu8hIDAxhVfZ4Rmvrw7tOtQczHR7OTuc+TI42jHBRBLWdrnDXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYROZHaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C96C4CEC3;
	Mon, 28 Oct 2024 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730131307;
	bh=rjZJA0DpjSaQmEw3j0pwYxmajl8jy9m8/Lv6TPOpUyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYROZHaTOM5KJzmdmFicnkUXQLifAO+ctLsv7MjwohcQk//RhOHIhS+vDM0ogT5p4
	 zNHpgrlXJ+s1qyd2eoCAkxEl1sYUo3ivoyfZrMunJ2e5spZ4qXBPn03MMr7l6A/JxQ
	 V/3rwqdQzjULW18NLgDe51PcEQv/WN4VzozpZeXHxNBcgzHnaxn/SCpxeUtYk8GsUN
	 xb5N3sMbBLqlT6CvaiVDc4pmEwQN/8MRDxy2NSafQ66BLr5Y1ZDJOky31b+N8EdkTn
	 NKtGRTxjXk8ZHHxNSLVkbdGVHfDz1V/9gZPTfHsRc/t1utxCluooU1e/fqjSvK9YnA
	 F7EyRLN3bnI/Q==
Date: Mon, 28 Oct 2024 12:01:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kees@kernel.org, mpe@ellerman.id.au,
	broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
Message-ID: <Zx-1aWlO1AzYvFkw@sashalap>
References: <20241024140101.24610-1-pabeni@redhat.com>
 <ZxpZcz3jZv2wokh8@sashalap>
 <Zx9_yOLrWzFS_DoC@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zx9_yOLrWzFS_DoC@infradead.org>

On Mon, Oct 28, 2024 at 05:12:56AM -0700, Christoph Hellwig wrote:
>On Thu, Oct 24, 2024 at 10:28:03AM -0400, Sasha Levin wrote:
>> Days in linux-next:
>> ----------------------------------------
>>  0 | █████████████████████████████████████████████████ (14)
>>  1 | ███████ (2)
>>  2 | █████████████████████ (6)
>>  3 | ██████████████████████████████████████████ (12)
>>  4 |
>
>Can you replace the full block filling "characters" with a say "+"
>characters as in diff statistics to make this hurt the eyes a little
>less?

Yup!

-- 
Thanks,
Sasha

