Return-Path: <netdev+bounces-37718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66227B6BCE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9E63D280F67
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562C2AB2F;
	Tue,  3 Oct 2023 14:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54066FD2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67BC433C8;
	Tue,  3 Oct 2023 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696343764;
	bh=fb8a79U9B7XiFGw1+vbay0NRlK6p/9nWvlZtpmw7MlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NdDeyY7BHO+mEUNz0GYNIU8Rto9yROJTyEKxUw0h75/nUs5a5iOBxzyJ5hzDnYZLU
	 WY53IslJKvCOWQdiPUNmJ2hitDpgTMoBqZTUwseuWBD2rSC03CNcLGQig/omx8VWoQ
	 X+3Vqdxs5/evYrep6M6lG8gICprTEXUwLX/+IdaNLXdw/Wks758YVeRcXVArqVIY9K
	 9IwZGsbqWVfOujtu0QVJ5OFGbcr9G42OiUKYn1PMdoAHe5EKMEXy7IJtC0Cnx1oEqG
	 pgHjWBq+rX/QNFOx+AQbRhRn89Adnkck0Pri+Iv0ZC9FAyV+Q5uRLlHRv8Nk0PvW0n
	 XBcAs6OikO7kA==
Message-ID: <0f91b58c-84bc-902c-0141-53fb8914590f@kernel.org>
Date: Tue, 3 Oct 2023 08:36:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20230925214711.959704-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230925214711.959704-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/23 3:47 PM, Patrick Rohr wrote:
> This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
> lifetime derivation mechanism.
> 
> RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
> Advertisement PIO shall be ignored if it less than 2 hours and to reset
> the lifetime of the corresponding address to 2 hours. An in-progress
> 6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
> looking to remove this mechanism. While this draft has not been moving
> particularly quickly for other reasons, there is widespread consensus on
> section 4.2 which updates RFC4862 section 5.5.3e.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Jen Linkova <furry@google.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 11 ++++++++
>  include/linux/ipv6.h                   |  1 +
>  net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
>  3 files changed, 37 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



