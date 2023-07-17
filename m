Return-Path: <netdev+bounces-18304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12922756640
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7E92812D8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA74BA4A;
	Mon, 17 Jul 2023 14:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5CBA33
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:23:43 +0000 (UTC)
Received: from smtp206-pc.aruba.it (smtp206-pc.aruba.it [62.149.157.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C97A1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:23:40 -0700 (PDT)
Received: from [192.168.99.113] ([185.58.134.212])
	by Aruba Outgoing Smtp  with ESMTPA
	id LP8Tqhl5hrZAnLP8Tq4PHJ; Mon, 17 Jul 2023 16:23:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1689603818; bh=J2ar+gczEb30KInA+Y0w9UrdNrmICqtHBqyYqCR0Mx4=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=X+9bq1Jjb5YBGCZINatlugqRP0Kv8zjmF1azhHvFDqtFa1MPJLDQwwQawOcZ/XXfU
	 fS2cVc6xj3wRtdyPbWzOfaaBSsJYyiPCbSYpERGtwlcgiEM+SHenntzogkVdnZHraO
	 MtDE479U91Px/vUBX5ESY7Vb6GFefNQtyleCucOIPcM3TJ816EN9MSIMpiEw3lfrmn
	 xeHyj7brSIxUsjg96pNc1iJHrK+ekfjAihedb9Hv0Km+8tb14J6fjTGnfrB0g7vHTM
	 hKFdg7BDVFlqvitOoWxOoKRhuCkeH11eCaHSYneCOp60McMLNkco2FlKpRXQCSWnHl
	 3/AsBOghVhQCw==
Message-ID: <ec7e5d41-f1ba-5211-7637-9ff728599348@leaff.it>
Date: Mon, 17 Jul 2023 16:23:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question on IGMP snooping on switch managment port
Content-Language: en-US, it-IT
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
References: <a9d86e8e-2e7e-fe03-731c-ad4c372d4048@leaff.it>
 <db7508ce-6e92-a199-584b-0a729cd767b9@leaff.it>
 <793efa88-2a97-4cc3-9f84-101eef51962d@lunn.ch>
From: Riccardo Laiolo <laiolo@leaff.it>
In-Reply-To: <793efa88-2a97-4cc3-9f84-101eef51962d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMJEMER4Q2MDlELMEo05vpnBh354hpkC5EAkgb5eG1i5+c+X2jMgf35LZzVYN4aIgCiVS21dwNRLHEPiAQET+k5CjMKjoJ6eFLnR1/mY+MrGRiQem7nq
 yCDZtdya8O/Ik4/NceFujJxEDr+9mF+I45/pOcomFDyh8MadvkPQ1hQujsxRETCFqQkyMSXq3hKhgqW5b2dsVFD/JlHeh9ljO+NPczE/AkFBOf1HsuyFMcDx
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> I would be interested in knowing if:
>
> commit 7bcad0f0e6fbc1d613e49e0ee35c8e5f2e685bb0
> Author: Steffen Bätz <steffen@innosonix.de>
> Date:   Wed Mar 29 12:01:40 2023 -0300
>
>      net: dsa: mv88e6xxx: Enable IGMP snooping on user ports only
>      
>      Do not set the MV88E6XXX_PORT_CTL0_IGMP_MLD_SNOOP bit on CPU or DSA ports.
>      
>      This allows the host CPU port to be a regular IGMP listener by sending out
>      IGMP Membership Reports, which would otherwise not be forwarded by the
>      mv88exxx chip, but directly looped back to the CPU port itself.
>
>
> helps.
>
> 	Andrew

I've already applied the patch you quoted. Without it there are no IGMP packets
at all originating from my board.

With the patch applied I see just the first Membership Report when i open
the rx socket. Then, when the querier send the Membership Query packet, there is
no answer from my board, but i see its own MDB entry timeout gets refreshed...
but I can see the Group Leave packet when I close the rx socket.

I think when the MV88E6XXX_PORT_CTL0_IGMP_MLD_SNOOP bit is reset the switch is not
parsing the payload looking for the IGMP header, which is fine. But when the system
tries to answer to the querier its packet get trapped in his own port rule since the
Membership Report destination address is the multicast group address.

-- 
Riccardo Laiolo


