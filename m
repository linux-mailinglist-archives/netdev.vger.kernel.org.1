Return-Path: <netdev+bounces-33870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82B7A085F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46941281D86
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21C18E03;
	Thu, 14 Sep 2023 14:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961B28E11
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99734C433C7;
	Thu, 14 Sep 2023 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702590;
	bh=3pqLWiiPUDPfILLrll593nzDnDuukq6YmKiyR5hQotY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tLD1O2ITFkjXLno9Lz6Vvmx4EFHfVgMQCxoEILxcDyZtF6kN+WMK7a6Ml4+W8aKTW
	 sP/PRNMtFLg21r2hOfurqGnWId5ND8vMJyTB/ACmTc3oF3C+O+/vBmEIMOAGoR9ogt
	 6fHNagyPaVu7foc0g7B582ki8I0bpWF3g5LzDwYywyjsbKDaylsjITJdZn6ifCH1Qv
	 PwztyDtsZuIN8iinPs/1b1Tg9nXlthpEchdyysOA88yCiF4PCYAR/m6bzvzlBsaxV7
	 5mU9vqLZxnBrJ2CosZjv6f4weF2GEYpzI1aCSJG/rf8S9sm1dXdEWEUcVgLi4VUKBB
	 48Hd5bTvOAtOw==
Message-ID: <c737bd4c-7cd4-11f0-3906-3a9018170888@kernel.org>
Date: Thu, 14 Sep 2023 08:43:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: IPv6 address scope not set to operator-configured value
Content-Language: en-US
To: Tj <linux@iam.tj>, netdev@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>
References: <ab9737bc-cc91-6ccd-e104-4a94899e69e8@iam.tj>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ab9737bc-cc91-6ccd-e104-4a94899e69e8@iam.tj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/23 7:51 AM, Tj wrote:
> Apologies if this doesn't thread - I've had to manually add the
> In-Reply-To header because I did not receive Guillaume's reply and only
> discovered it via the email archive.
> 
> Not being able to set the scope causes a problem. The scenario in which
> I need to use it is interfaces with multiple global and ULA addresses
> where a multicast-DNS responder needs to choose the correct address to
> send in reply to queries. This affects both avahi and systemd-resolved
> which currently seem to chose almost - but not quite - at random; but
> enough so that it often breaks.
> 
> E.g: if the query originates from a ULA address the response should give
> a ULA address; if the query originates from a global then a global
> address, etc. In fact, being able to simply set scopes and enable the
> responder to be configured to use a specific scope would be helpful.
> It'd certainly avoid having to hard-code logic to determine what address
> ranges represent a particular logical zone.

We cannot change the behavior of an existing API. We have tried that
many times in the past, and inevitably most changes are reverted.

