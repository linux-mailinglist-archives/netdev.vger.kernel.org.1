Return-Path: <netdev+bounces-20205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8275E420
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B181C209D4
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB446A2;
	Sun, 23 Jul 2023 18:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953001870
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 18:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EDC433C7;
	Sun, 23 Jul 2023 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690135922;
	bh=z9fwCDLVqEZLhDZ6M7kG674CcSknVTlUQ8OY4587WZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7EKzAn8p4FSQwCBmg6whEu3NVS5loCHf0tsQq5uN4cEhIMBHhdmnljXyG8ijQCIo
	 tUvCTK6BzKYw0qFBPPyu8GPwp2ez+ES9flVuqcoeI0aNoRsHw8ADp3kDEcUjwUyrLt
	 rleiV7S0Q0gHmNVY8abW3hbJ1cCz33MCbsNqps0rZ4QTxmeLDeB07bBgGG0PkC1alv
	 BV8iVcv9misXSyjNKsSsCT3mZVeIm/FN6txnDm0/EMKsj3R26Hv3BqwxW5aBEbvMbe
	 MBuMCnkDQeg2ZsdD6zAIAJ5kLvCE/QwmCtgkCAISve6RnrsykcChm63eNSSeAq6+50
	 4mAJTixccoQOQ==
Message-ID: <8c8ba9bd-875f-fe2c-caf1-6621f1ecbb92@kernel.org>
Date: Sun, 23 Jul 2023 12:12:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder> <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1> <ZLzhMDIayD2z4szG@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZLzhMDIayD2z4szG@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/23 2:13 AM, Ido Schimmel wrote:
> 
> I don't know, but when I checked the code and tested it I noticed that
> the kernel doesn't care on which interface the address is configured.
> Therefore, in order for deletion to be consistent with addition and with
> IPv4, the preferred source address shouldn't be removed from routes in
> the VRF table as long as the address is configured on one of the
> interfaces in the VRF.
> 

Deleting routes associated with device 2 when an address is deleted from
device 1 is going to introduce as many problems as it solves. The VRF
use case is one example.

