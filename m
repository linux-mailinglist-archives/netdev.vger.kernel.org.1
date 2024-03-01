Return-Path: <netdev+bounces-76573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C113E86E45E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8671F267F8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787C3A8F8;
	Fri,  1 Mar 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAbSTR2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B7368
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307087; cv=none; b=ojM/44o/bbhkk0XIjlWSDVwrZhes1S/ZyffJOx7IEFvoK2yL848BWfP3Xn13lDBwwdEgm1yey+1kjL0IhyJ/TFBFNCS9gjTuWiBNWnCL7uIz5cFrKFPO6fAeoX2ThQGrTEEfva/1kQnm1p6fs+8lQG1ppW5fEGC9/MKIKktOCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307087; c=relaxed/simple;
	bh=viezeGugz2LJgldOnHz+wogHTf5L9GjPJZBdofrGTls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvngS2r92/ouH44fffMqc2heiW58uFh8lgHkpp3np2//hF4j0yoPL9C6L38wrmCsi7i7ULe2q8LIqEEwKi5ozqnWz2ohVfF5nkPTRoMr8EplQnLsmTlII4WXwHazmVupkwy+ts+02dMBeufXB7UcmIlDaUMx7SKxU8G+U8xO5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAbSTR2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124FFC433C7;
	Fri,  1 Mar 2024 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709307086;
	bh=viezeGugz2LJgldOnHz+wogHTf5L9GjPJZBdofrGTls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAbSTR2ZFzwHrtKR8sEkPHI7bvgQe0wSnv70y/fT6GOCngChDiX2myJIBwgLYIVuX
	 +nUY+KhC4a8QY6ffgvUTXKXm6wdj425NO2Lv4K5hZIo6tIse7RJ+CA2QGzy3t3nCRI
	 0x5APC++W1I3gqOSlJB+2WCsmsDTrXfy4NN352qo9bqDYGMMOqDVw7h+b60PIRW6Ae
	 qsXOJtFln1zydHsGAm8cUybgvJRunGHe6R9CBY0Mr0DN7IWZD2/FJkz3TkX0EEHeNh
	 AxfGnLyYKn9Atmxa5jjEg19CWjNIOYwvH9YJI89emJ7bb3EgPrNmphea9Ppe0Xcgiy
	 Po8QqYGUDcviA==
Message-ID: <ab3af787-d44f-43b8-b90a-5520d4df3686@kernel.org>
Date: Fri, 1 Mar 2024 08:31:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: nexthop: Adjust netlink policy
 parsing for a new attribute
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <410a56b273484e34ece228e9aec0008ece6b96b3.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <410a56b273484e34ece228e9aec0008ece6b96b3.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> A following patch will introduce a new attribute, op-specific flags to
> adjust the behavior of an operation. Different operations will recognize
> different flags.
> 
> - To make the differentiation possible, stop sharing the policies for get
>   and del operations.
> 
> - To allow querying for presence of the attribute, have all the attribute
>   arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>   pass the corresponding value to nlmsg_parse() as well.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 58 ++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



