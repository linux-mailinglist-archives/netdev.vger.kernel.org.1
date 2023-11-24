Return-Path: <netdev+bounces-50689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CA7F6B2C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 05:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C960BB20CB3
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207AA139D;
	Fri, 24 Nov 2023 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6UXOvvq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038711391
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE5EC433C8;
	Fri, 24 Nov 2023 04:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700799233;
	bh=g5EHex6q8Gl6ERooziGEvSGMZ2rl/0rPfVYo9kAuHl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E6UXOvvqCEZH1eG/5zXP2MjVZw06nlrr8nu4nVjLo8KfZAs2CBUXL5uPRYvepfXxY
	 TZDaTlFTMrRGPRI+xb8cFgl92JA6vLOM8rAfoLL6Fjn9cdwnXQD6c4cJhvLtiQxmSY
	 mXQJwd4wSwlifWwy/oCMeDa2flUkiJygKND4vGdcGVVgxwGEcRnlRxVW2SMuO6OAyH
	 4FwaPKrFN96SGHZgmLjjamW3P7lzkXnuD0TQWHNelPYSKx5EN4eSgkTMu/LWeBxnEi
	 jPsMq4ONCDrEwQbbFaGazAAEEtDXMUmQNQFWPyV25DAsV6AkI87jlWiMJQNKzd1LAz
	 Nhjw21w/dlgRg==
Message-ID: <2e6b5354-f07a-4ba3-b56a-4c875321c28f@kernel.org>
Date: Fri, 24 Nov 2023 14:13:51 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20231122132116.2180473-1-gerg@kernel.org>
 <7d36c0e2-0d0d-4704-8d3b-2d902e29e664@lunn.ch>
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <7d36c0e2-0d0d-4704-8d3b-2d902e29e664@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/11/23 05:40, Andrew Lunn wrote:
>> @@ -3892,7 +3892,8 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>>   	struct mv88e6xxx_chip *chip = ds->priv;
>>   	int err;
>>   
>> -	if (chip->info->ops->pcs_ops->pcs_init) {
>> +	if (chip->info->ops->pcs_ops &&
>> +	    chip->info->ops->pcs_ops->pcs_init) {
>>   		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
>>   		if (err)
>>   			return err;
> 
> mv88e6xxx_port_teardown() seems to have the same problem. Could you
> fix that as well?

Yep, will do.

Regards
Greg


