Return-Path: <netdev+bounces-24026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8C76E7E9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5DE282131
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE341EA9B;
	Thu,  3 Aug 2023 12:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDA18B17;
	Thu,  3 Aug 2023 12:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B80C433C8;
	Thu,  3 Aug 2023 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691064517;
	bh=jMfkuSljeC1MmRBLH3M+5Zxeay+VmMKCSTJBTFXNkLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG2Se5Pbifb4P8fUNKQGqTGXzR2qHyEf/HPRqORf99evMR6MnBLebJ4Yag4MIkQ68
	 pbyEgUkQIM/V92t5I4emcTwyKI9+Zf1sOFWnmuHS1dIFQcngGa7yBpWnowtueFQXGr
	 tPvfbdnc6LV3wKQqQo5mgSHjJc9F92mE6GQAnApIzijqhcKUBkL6yc9HdTkVZdVUPY
	 yKhZpo1Op/W/vLggkgZE5JMhVhalf8urx+8OHGnlu+nKh+8zASLkHz6PYNUUUa3Ycy
	 Jg05gjrpRCPe6M5lJV46hAPZoDLOH7oAua0bqoot7AiAn0uNmh9+IvI3ilyA5E/K7W
	 Aib4ZRWdwTTXw==
Date: Thu, 3 Aug 2023 14:08:32 +0200
From: Simon Horman <horms@kernel.org>
To: Li kunyu <kunyu@nfschina.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: bpf_struct_ops: Remove unnecessary
 initial values of variables
Message-ID: <ZMuYwD4JojLx0D7M@kernel.org>
References: <20230804175929.2867-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804175929.2867-1-kunyu@nfschina.com>

On Sat, Aug 05, 2023 at 01:59:29AM +0800, Li kunyu wrote:
> err and tlinks is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Reviewed-by: Simon Horman <horms@kernel.org>


