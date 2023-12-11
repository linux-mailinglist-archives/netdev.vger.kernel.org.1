Return-Path: <netdev+bounces-55892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E23080CB4D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB481C20F6C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE333FE2E;
	Mon, 11 Dec 2023 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AriWX0iH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279A3D97E
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D307C433C7;
	Mon, 11 Dec 2023 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302317;
	bh=VvIH4ZYMBYZb7GOf40/uW38wshvq5Z4eZKrLVedN16s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AriWX0iH/O+lkkrp0npP2ZLTMQvusGjbp2AkyKk0VMtv9b0JcVW3/1d3fvTRnt+uJ
	 w8Wv2RJBD/OCEHVDFrB69UlWZ/T7tj5Mul+TGd4jlgMoe/mXGA+TMles6peA15SlYu
	 SGMVfOXlScJS+DmxNbRpMYHACY+qK9KC7CsULCnNBH5a7CounWPkqouJ++ZSym6YXa
	 eV/MmaLwS6RIDvuw6upOvPaUeW7oW2+BeLKpWn3D8W0d10H7iVXrKslT+qu65231Pl
	 G/odkLqsUISV/fIGmzXPE98coPJAujLlkyUWuPihfWZLqbwPtuZx8ZkZhC4aCK/6sj
	 G1tb2E/yNEoXQ==
Message-ID: <a5e53cfe-9b62-41b5-aa7e-44b1de9a2cf6@kernel.org>
Date: Mon, 11 Dec 2023 06:45:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftest fib_nexthop_multiprefix failed due to route mismatch
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
References: <ZVxQ42hk1dC4qffy@Laptop-X1>
 <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>
 <ZW_u7VWTpWAuub4L@Laptop-X1>
 <02ef5de4-d57f-4037-8968-d9bf791bd903@kernel.org>
 <ZXbUzpDGErm-JXSC@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZXbUzpDGErm-JXSC@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/23 2:22 AM, Hangbin Liu wrote:
> OK, I got the reason. The "from ::1" is put in rt6_fill_node() when
> CONFIG_IPV6_SUBTREES is enabled. I will fix this grep issue in my next
> selftests namespace conversion patch set. Thanks Hangbin

thank you for the persistence in tracking this down.

