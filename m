Return-Path: <netdev+bounces-24553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0D770938
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DED31C218F2
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54931BF17;
	Fri,  4 Aug 2023 19:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F651BF0B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 19:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0CC433C7;
	Fri,  4 Aug 2023 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691179097;
	bh=NBKkxNU4GpZxAQEsV3wWw5H4lAbIywIT5WFr1ofAlKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hqtf5tA82FWnjqB49fg/LjrXIUy2QJ8efJNV3GlvyFcl+uKUvGMHn7Wn+YaZ/Q9sI
	 QsKp/Zf2Cm3e5mMbxTtNHlKr9T4bb+ROOnyBlViJyVsv9Bj52ZDcNvAbczrSt/cTId
	 ii1XcARb83/l9i2rLIs8tyHSCWHRBlQvbfakqeA5WuCdMM1/okjWllPKrknnz3pFkl
	 3vIZJa8+F6D9LCm58wirKW1O04WzWeD3KJY9ktWaKWEFhgXfJ6URdkRl6OuKhh+raO
	 GJRdgwzGcvajaComS8ao+sRCOqTZv58mHUl+YQr3+muz0SRfsXtFn2Ceiv4hwJkPth
	 /3ZBxNFzObJ1g==
Date: Fri, 4 Aug 2023 12:58:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple
 cmds
Message-ID: <20230804125816.11431885@kernel.org>
In-Reply-To: <ZM01ezEkJw4D27Xl@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Aug 2023 19:29:31 +0200 Jiri Pirko wrote:
> I need to have one nested attribute but according to what cmd it is used
> with, there will be different nested policy.
> 
> If I'm looking at the codes correctly, that is not currenly supported,
> correct?
> 
> If not, why idea how to format this in yaml file?

I'm not sure if you'll like it but my first choice would be to skip
the selector attribute. Put the attributes directly into the message.
There is no functional purpose the wrapping serves, right?

