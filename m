Return-Path: <netdev+bounces-23416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9476BE99
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB287281B21
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B0235BE;
	Tue,  1 Aug 2023 20:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7D4DC94
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:41:13 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBE218D;
	Tue,  1 Aug 2023 13:41:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 728386017C;
	Tue,  1 Aug 2023 22:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1690922469; bh=z9QrJe0NTsnt2YmhHUDR0wCLO20TMhRAH8M43NnpZLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOefIBFJ1LpokaYJd2vgFIZzQF+01yX3iquh7NkEbTF8ximdNISmPk+KDD0RhoQQ/
	 nTv2nfGlW1CRtSvqjT/aPq4RbrV6fjflrxxa285pENnl7G5U/uWwSK7bCrW79EFZAn
	 vaFpKSb/C9TzlPGsx5YPn5t0FWEz3apBQx/Pe8MTliH+U4Wknl8SOGty2ssmsViiea
	 1vQmaGkTWSM5KEjGTDgeOP74RYV9gHZM/U5V/87BshsjSL8PwlrVxooQkNO3x0pAvs
	 frPMyMzE9q862jiCDN5ZXG3HgMxIebrNZjAVKdy3mbJIw2viRjTcVLxZD1ExJB6MIg
	 ekR1zWgwGuF3g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rxM1YqdY52zd; Tue,  1 Aug 2023 22:41:07 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 6DA066015F;
	Tue,  1 Aug 2023 22:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1690922467; bh=z9QrJe0NTsnt2YmhHUDR0wCLO20TMhRAH8M43NnpZLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZfEwU4wQpk4ge+sFPf5EJtFwYbaWrsOiIkupkUtL0cDChri6yZETaSpa3apKb+seq
	 rYVwK0x9UC/sLGlitKkDfiLkAxZBWKp0wJoYJ9+OEKauVK+8E6K51Dw1EGIRyncbUe
	 QbbXhGgAnnUKwlsBOQIgnU7dq4Lf/CI2ilNrAEAD2STbAGQjZjgM0Sma8Ix72gpvGo
	 Vaqg1rfV4rQIJw5oSYvuawDJ5uoN++P0JW4H5QWev9a6S+TMCc5txAqk2PFlHk71qF
	 abdo9DD6h/80vWYJv/IE6Dgy8H4dMfb3IU331Oq4SYFVm2g/kHACoLBPkg82Eey0Yx
	 hdFkVS4RjMs9w==
Message-ID: <778cbcdc-24b2-12f4-aebc-d62d5bdaf2de@alu.unizg.hr>
Date: Tue, 1 Aug 2023 22:41:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>
Cc: petrm@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
 <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
 <ZMdouQRypZCGZhV0@shredder>
 <2f203995-5ae0-13bc-d1a6-997c2b36a2b8@alu.unizg.hr>
 <ZMei0VMIH/l1GzVM@shredder>
 <cadad022-b241-398d-c79d-187596356a72@alu.unizg.hr>
 <ZMfXsVAfpizMKH/U@shredder>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMfXsVAfpizMKH/U@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 17:48, Ido Schimmel wrote:
> On Mon, Jul 31, 2023 at 05:13:37PM +0200, Mirsad Todorovac wrote:
>> You can add:
>>
>> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Added your tags to all 17 patches. Available here:
> https://github.com/idosch/linux/tree/submit/selftests_fix_v2

Yes, thanks!

It is good to be known that I am available for testing patches on the available
equipment.

> Will submit later this week (most likely on Wednesday) after I verify
> they don't cause other regressions.
> 
> Thanks for testing and reporting.

Not at all.

I am most pleased that we nailed the errors and fails.

It was a great exercise for my little grey cells in a great environment of quality
professionals.

Much obliged.

Still, maybe you should add to README about the forwarding.config.sample opportunity?

I think what we all want as the community is greater test coverage, to discover the most
bugs on the most platforms ...

Kind regards,
Mirsad Todorovac

