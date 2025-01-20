Return-Path: <netdev+bounces-159660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC148A16496
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E911885225
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836F184;
	Mon, 20 Jan 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3LBXizc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8B1C27
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737332613; cv=none; b=WwXpzzl28BeuTj+fp/1s9oDy2+Bcx50BoL6n+Ujs+xB909n/zrHgCMQna4tOtR4UU5oTKCfK51faygloH7W73ZrCwA8ryFtw/IJzw7Dco2HIHTvQspGsh212FJ6hH4LGYsUhs429Yx60y1m/lHZQKhwdBZLjAWDvgsCpE7ETTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737332613; c=relaxed/simple;
	bh=VaUK6RxvxicnjzkAcJKbOlLdx710X7tJzVIhKgHGwFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhIIStmKRcUv335HkYz+O6YijtK3jhJegZIF4I0BKjwEBwVkl6FSFa6KlM+uYxtMiRN6N5Fw20EGNRU6M9kAzpC+twy8FJZ+SgrWzoaTe+5BEzcflZ+RQ0ltJU66f7jYeHzG8909QV6poN47J8JK889KqPoo9iI8cdCbaTuLkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3LBXizc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C62C4CED6;
	Mon, 20 Jan 2025 00:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737332613;
	bh=VaUK6RxvxicnjzkAcJKbOlLdx710X7tJzVIhKgHGwFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t3LBXizcmmFC9es9RiJsb2Oip3pPYfh2Sb36T9t318PV6WhlEdN3TmKtEVW7j/yQ7
	 8mNCz+Ph9bzLyT37GBDSHZzNJcGmlMpW6igOaRpt0WiihvnvSRO5Z2PK9vR0RDh8rI
	 kb0Y0qmpFPQEyYpzqu5QlFLOLrEHXgPkFuXJs3qNKf7+mjnAqEdN3Z9xwwoGdCHD9Q
	 ivPSx+UG51Cq08sOS8lqiHc2e9LB9mMnqw3VnM8DT0InwOcMtxz90weAMgIYn1Yvlo
	 dpE9zUtc77tMgxttkFam+xn4WvzfHQpxTfUFy1wkePgh6k2O0zC2WdTpdwUvOuWsoR
	 IuiaQm8IdX4pQ==
Message-ID: <2d33a34b-9bc9-46ab-ac23-e5bd311b65c3@kernel.org>
Date: Sun, 19 Jan 2025 17:23:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND iproute2-next 2/2] iproute2: add 'ip monitor
 acaddress' support
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250117032041.28124-1-yuyanghuang@google.com>
 <20250117032041.28124-3-yuyanghuang@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250117032041.28124-3-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 8:20 PM, Yuyang Huang wrote:
> @@ -210,6 +213,8 @@ int do_ipmonitor(int argc, char **argv)
>  			lmask |= IPMON_LADDR;
>  		} else if (matches(*argv, "maddress") == 0) {
>  			lmask |= IPMON_LMADDR;
> +		} else if (matches(*argv, "acaddress") == 0) {

changed that to strcmp (not taking any more matches) and applied to
iproute2-next.



